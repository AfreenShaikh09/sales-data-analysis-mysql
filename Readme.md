# 📊 Sales Data Analysis using MySQL

## 📌 Project Overview
This project focuses on **real-world sales data analysis using MySQL**, covering **end-to-end SQL concepts**.

The project simulates an **online sales / food delivery platform**, where transactional data is analyzed to derive **business insights, revenue metrics, and customer behavior patterns** using SQL queries.

---

## 🎯 Project Objectives
- Design a relational database with real-world entities
- Write optimized SQL queries for business analysis
- Perform sales, customer, and payment analytics

---

## 🧠 Concepts Covered
- Database design & relationships
- Joins (INNER, LEFT)
- Aggregations & Grouping
- Subqueries
- Window functions
- Views
- Indexes
- Date & time analysis

---

## 🗂️ Database Schema (7 Tables)

| Table Name | Description |
|----------|-------------|
| customers | Customer demographic data |
| restaurants | Restaurant details |
| menu_items | Items offered by restaurants |
| orders | Order-level information |
| order_items | Item-level order details |
| payments | Payment transactions |
| delivery_partners | Delivery agent information |

---

## 🔗 Entity Relationships
- One customer → multiple orders
- One restaurant → multiple orders
- One order → multiple order items
- One order → one payment
- One delivery partner → multiple orders

This schema closely resembles **real production systems**.

---

## 📊 Analysis Performed (46 SQL Queries)

### 🔹 Basic Analysis
- Total number of orders
- Order status distribution
- Available payment modes
- High-value orders
- Cancelled vs delivered orders

### 🔹 Sales & Revenue Analysis
- Total revenue generated
- Revenue by payment mode
- Daily and monthly revenue trends
- Average Order Value (AOV)
- Highest and lowest order values

### 🔹 Customer Analytics
- Orders per customer
- Repeat customers
- High-spending customers
- Customer contribution to revenue
- Customer ordering frequency

### 🔹 Order & Item Analysis
- Total items sold per order
- Orders with bulk items
- Average basket size
- Orders with multiple unique items

### 🔹 Advanced SQL Analytics
- Customer ranking by total spend (Window Functions)
- Restaurant ranking by revenue
- Running total of revenue
- Time gap between consecutive orders
- Revenue contribution percentage

---

