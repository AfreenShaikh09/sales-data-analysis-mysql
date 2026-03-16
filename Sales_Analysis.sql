select * from customers;
select * from restaurants;
select * from delivery_partners;
select * from menu_items;
select * from orders;
select * from order_items;
select * from payments;

-- [1] List all successful payments
select * from payments where payment_status='Success';

-- [2] Count total number of orders
select count(*) as total_order from orders;

-- [3] Show all UPI payments
select * from payments where payment_mthd='UPI';

-- [4] Find distinct payment modes used
select distinct payment_mthd from payments;

-- [5] Display orders placed in January 2024
select * from orders where order_date between 
'2024-01-01' and '2024-01-31';

-- [6] Show orders with status = Cancelled
select * from orders where order_status='Cancelled';

-- [7] Find payments with transaction amount less than 250
-- and payment status is failed.
select * from payments where transaction_amt<250 and
payment_status='Failed';

-- [8] List top 10 latest orders where status is delivered
select * from orders where order_status = 'Delivered'
order by order_date desc limit 10;

-- [9] Count number of customers
select count(*) as total_customer from customers;

-- [10] Find orders above ₹1000
select * from orders
join payments on orders.order_id=payments.order_id 
where transaction_amt>1000;

-- [11] Total revenue generated
select sum(transaction_amt) from payments 
where payment_status = 'Success';

-- [12] Revenue by payment mode
select payment_mthd,
sum(transaction_amt) from payments 
where payment_status = 'Success' group by
payment_mthd;

-- [13] Count orders per order status
select order_status,count(*)
from orders group by order_status;

-- [14] Find average order value (AOV)
select round(avg(transaction_amt),4) as aov 
from payments
where payment_status='success';

-- [15] Number of orders per customer.
select order_id, count(order_id) 
from order_items
group by order_id order by count(order_id) desc;

-- [16] Customers who placed more than 3 orders
select oi.order_id, o.customer_id ,count(oi.order_id) 
from order_items oi
join orders o on o.order_id = oi.order_id
group by oi.order_id
having count(oi.order_id)>3;

-- [17] Orders with payment status
select o.*,payment_status from orders o
join payments p on o.order_id=p.order_id;

-- [18] Total items sold per order
select order_id, sum(quantity) AS total_items
from order_items
group by order_id;

-- [19] Orders with more than 5 items
select order_id
from order_items
group by order_id
having sum(quantity) > 5;

-- [20] Revenue per day
select day(order_date) as day,
sum(transaction_amt) as daily_revenue
from payments p
join orders o on o.order_id=p.order_id
where payment_status='Success' group by
day(order_date);

-- [21] Customers who never cancelled an order
select customer_id
from orders 
group by customer_id
having sum(order_status = 'Cancelled') = 0;

-- [22] Payment failures count
select count(*) 
from payments
where payment_status = 'Failed';

-- [23] Orders without successful payment
select o.order_id,payment_status
from orders o
left join payments p on o.order_id = p.order_id
where p.payment_status <> 'Success' or p.payment_status is null;

-- [24] Highest order amount
select max(transaction_amt)
from payments;

-- [25] Average items per order
select avg(item_cnt) 
from (
select order_id, sum(quantity) as item_cnt
from order_items
group by order_id
) t;

-- [26] Top 5 customers by spend
select o.customer_id,
sum(p.transaction_amt) as total_spent
from orders o
join payments p on o.order_id = p.order_id
where p.payment_status = 'Success'
group by o.customer_id
order by total_spent desc
limit 5;

-- [27] Revenue per customer per day
select o.customer_id,
date(o.order_date),
sum(p.transaction_amt)
from orders o
join payments p on o.order_id = p.order_id
where p.payment_status = 'Success'
group by o.customer_id, date(o.order_date);

-- [28] Percentage of digital payments
select round(
(sum(payment_mthd in ('UPI','Card')) / count(*)) * 100, 2)
as digital_percentage
from payments;

-- [29] Monthly revenue
select monthname(order_date) as month,
sum(transaction_amt)
from payments p
join orders o on o.order_id=p.order_id
where payment_status = 'Success'
group by monthname(order_date);

-- [30] Orders where payment failed but order delivered
select o.order_id
from orders o
join payments p on o.order_id = p.order_id
where o.order_status = 'Delivered'
and p.payment_status = 'Failed';

-- [31] Most used payment mode
select payment_mthd, count(*) as usage_count
from payments
group by payment_mthd
order by usage_count desc
limit 1;

-- [32] Customers with highest average order value
select o.customer_id,
avg(p.transaction_amt) as avg_spend
from orders o
join payments p on o.order_id = p.order_id
where p.payment_status = 'Success'
group by o.customer_id
order by avg_spend desc
limit 10;

-- [33] Orders containing more than 3 unique items
select order_id
from order_items
group by order_id
having count(distinct item_id) > 3;

-- [34] Revenue contribution per customer (%)
select customer_id,	round(
sum(transaction_amt) * 100 /
(select sum(transaction_amt) from payments where payment_status='Success')
,2) as revenue_percent
from orders o
join payments p ON o.order_id = p.order_id
where p.payment_status='Success'
group by customer_id;

-- [35] Orders paid via UPI and delivered
select o.order_id
from orders o
join payments p on o.order_id = p.order_id
where p.payment_mthd='UPI'
and o.order_status='Delivered';

-- [36] Daily order count
select date(order_date), count(*)
from orders
group by date(order_date);

-- [37] Identify repeat customers
select customer_id
from orders
group by customer_id
having count(*) > 1;

-- [38] Top 3 revenue days
select date(order_date),
sum(transaction_amt) as revenue
from payments p
join orders o on o.order_id = p.order_id
where payment_status='Success'
group by date(order_date)
order by revenue desc
limit 3;

-- [39] Rank customers by total spending
select customer_id,
sum(transaction_amt) as total_spent,
rank() over(order by sum(transaction_amt) desc) as spend_rank
from orders o
join payments p on o.order_id = p.order_id
where p.payment_status = 'Success'
group by customer_id;

-- [40] Dense rank restaurants by total revenue
select r.restaurant_name,
sum(p.transaction_amt) as revenue,
dense_rank() over(order by sum(p.transaction_amt) desc) 
as revenue_rank
from restaurants r
join orders o on r.restaurant_id = o.restaurant_id
join payments p on o.order_id = p.order_id
where p.payment_status='Success'
group by r.restaurant_name;

-- [41] Running total of daily revenue
select order_date,
sum(transaction_amt) as daily_revenue,
sum(sum(transaction_amt)) 
over(order by order_Date) as running_revenue
from payments p
join orders o on o.order_id=p.order_id
where payment_status='Success'
group by order_date;

-- [42] Create view of successful_orders
create view successful_orders as
select o.order_id, o.customer_id, o.restaurant_id,
p.transaction_amt, o.order_date
from orders o
join payments p on o.order_id = p.order_id
where p.payment_status='Success';

-- [43] Query total revenue using view
select sum(transaction_amt)
from successful_orders;

-- [44] Revenue per restaurant using view
select restaurant_id,
sum(transaction_amt) as revenue
from successful_orders
group by restaurant_id;

-- [45] Top customers using view
select customer_id,
sum(transaction_amt) as total_spent
from successful_orders
group by customer_id
order by total_spent desc
limit 5;

-- [46] Drop View
drop view successful_orders;

