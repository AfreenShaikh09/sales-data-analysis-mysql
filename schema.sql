create database Project_Sales_db;
use Project_Sales_db;

-- Customer table having 200 rows
create table customers(
customer_id char(7) primary key,
customer_name varchar(100),
customer_mob bigint unique,
customer_email varchar(100) unique,
city varchar(50),
signup_date timestamp
);

-- Restaurants table having 30 rows
create table restaurants(
restaurant_id char(5) primary key,
restaurant_name varchar(50),
city varchar(50),
cuisine_type varchar(80),
avg_cost_for_two int,
rating float,
is_veg enum('True','False'),
opened_year year
);

-- Delivery partners table having 25 rows
create table delivery_partners(
partner_id char(5) primary key,
partner_name varchar(100),
city varchar(80),
vehicle_type varchar(80),
joining_year year
);

-- Menu items having 150 rows
create table menu_items(
item_id char(7) primary key,
restaurant_id char(5),
item_name varchar(80),
category varchar(100),
price float,
foreign key(restaurant_id) references restaurants(restaurant_id)
);

-- Orders table having 500 rows
create table orders(
order_id char(7) primary key,
customer_id char(7),
restaurant_id char(5),
partner_id char(5),
order_date date,
order_status varchar(50),
foreign key(customer_id) references customers(customer_id),
foreign key(restaurant_id) references restaurants(restaurant_id),
foreign key(partner_id) references delivery_partners(partner_id)
);

-- Order items table having 1000 rows
create table order_items(
order_item_id char(11) primary key,
order_id char(7),
item_id char(7),
quantity int,
foreign key(order_id) references orders(order_id),
foreign key(item_id) references menu_items(item_id)
);

-- Payments table having 500 rows 1:1 with orders table
create table payments(
payment_id char(7) primary key,
order_id char(7),
payment_mthd varchar(100),
transaction_amt float,
payment_status varchar(100),
foreign key(order_id) references orders(order_id)
);