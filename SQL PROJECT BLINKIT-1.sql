Create database Blinkit_Dataset;
use Blinkit_Dataset;

Create table customers(
c_id varchar(20) primary key,
cname varchar(50),
cemail varchar(100),
gender varchar(30),
age int, 
city varchar(100), 
state varchar(150),
address text, 
created_date date
);

Create Table products(
p_id varchar(50) primary key,
pname varchar(50),
category varchar(100),
brand varchar(50), 
price decimal(10,2)
);

Create table delivery(
dp_id varchar(20) primary key,
dp_name varchar(50),
dp_rating decimal(3,2),
percent_cut decimal(5,2)
);

Create table orders(
or_id varchar(20) primary key, 
c_id varchar(20),
p_id  varchar(50), 
order_date date, 
order_time time, 
qty int, 
coupon varchar(50), 
coupon_discount decimal(5,2),
dp_id varchar(20),
foreign key (c_id) references customers(c_id),
foreign key (p_id) references products (p_id),
foreign key (dp_id) references delivery(dp_id)
);


Create table transactions(
tr_id varchar(20),
or_id varchar(20),
transaction_mode varchar(50), 
reward varchar(10)
);

Create table Ratings(
rt_id varchar(20),
or_id varchar(20),
prod_rating decimal(3,1),
delivery_service_rating decimal(3,1)
);


SELECT *
FROM customers;

SELECT *
FROM delivery;

SELECT *
FROM orders;

SELECT *
FROM products;

SELECT *
FROM ratings;

SELECT *
FROM transactions;
delete from orders;

delete from customers;

Select count(*) as customers_count
from customers;
Select count(*) as products_count
from products;

Select count(*) as orders_count
from orders;

Select count(*) as transactions_count
from transactions;

Select count(*) as ratings_count
from ratings;

Select count(*) as delivery_count
from delivery;

Select count(*) as total_rows, 
COUNT(CASE WHEN c_id IS NULL THEN 1 END) AS null_c_id,
 COUNT(CASE WHEN cname IS NULL THEN 1 END) AS null_name,
 COUNT(CASE WHEN cemail IS NULL THEN 1 END) AS null_email,
 COUNT(CASE WHEN gender IS NULL THEN 1 END) AS null_gender,
 COUNT(CASE WHEN age IS NULL THEN 1 END) AS null_age,
 COUNT(CASE WHEN city IS NULL THEN 1 END) AS null_city,
 COUNT(CASE WHEN state IS NULL THEN 1 END) AS null_state,
 COUNT(CASE WHEN address IS NULL THEN 1 END) AS null_address,
 COUNT(CASE WHEN created_date IS NULL THEN 1 END) AS null_created_date
 from customers;
 
 Select c_id, count(*) as duplicate_count
 from customers
 group by c_id
 having count(*) > 1;
 
 Select * from products;
 Select count(*) as total_rows, 
 sum(p_id is null) as null_p_id, 
 sum(pname is null) as null_name,
 sum(category is null) as null_category,
 sum(brand is null) as null_brand,
 sum(price is null) as null_price
 from products;
 
 Select p_id, count(*) as duplicate_count
 from products
 group by p_id
 having count(*)>1;
 
 Select * from orders;
 Select count(*) as total_orders,
 sum(or_id is null) as null_order_id,
 sum(c_id is null) as null_customer_id,
 sum(p_id is null) as null_product_id, 
 sum(order_date is null) as null_order_date,
 sum(qty is null) as null_qty,
 sum(dp_id is null) as null_delivery_id
 from orders;
 
 Select or_id, count(*) as duplicate_count
 from orders
 group by or_id
 having count(*)>1;
 
 Select * from products;
 select category, count(*) as product_count
 from products
 group by category
 order by product_count DESC;
 
 Select category, round(avg(price),2) as avg_price
 from products
 group by category
 order by avg_price desc;
 
 Select p_id, pname, category, price
 from products 
 where price>500
 order by price desc;
 
 Select category, count(*) as expensive_product
 from products
 where price>500
 group by category
 having count(*)>10
 order by expensive_product desc;
 
 Select count(*) as total_orders
 from orders;
 
 Select * from orders;
 select sum(qty) as total_quantity_sold
 from orders;
 
 Select coupon, count(*) as total_orders
 from orders
 group by coupon
 order by total_orders desc;
 
 Select coupon, round(avg(coupon_discount),2) as avg_discount
 from orders
 group by coupon
 order by avg_discount desc;
 
 Select coupon, round(avg(coupon_discount),2) as avg_discount
 from orders
 group by coupon
 having avg(coupon_discount) >=10
 order by avg_discount desc
 
 Select coupon, sum(qty) as total_quantity 
 from orders
 group by coupon
 order by total_quantity desc;
 
 Select c_id, count(*) as high_quantity_orders
 from orders
 where qty>5
 group by c_id
 having count(*) >2
 order by high_quantity_orders desc;
 
 
 Select coupon, count(*) as total_orders, sum(qty) as total_quantity, 
 round(avg(coupon_discount),2) as avg_discount
 from orders
 group by coupon
 having sum(qty) >5000
 order by total_quantity desc;
 
 Select category, round(avg(price), 2) as avg_price
 from products
 where price >300
 group by category
 having avg_price >500
 order by avg_price desc;
 
 Select c_id, count(*) as total_orders
 from orders
 group by c_id
 having count(*) >3
 order by total_orders desc;
 
 Select or_id, c_id, p_id, qty, coupon
 from orders
 where order_date = '2025-02-06';
 
 Select * from transactions;
 
 Select transaction_mode, count(*) as total_transactions
 from transactions
 group by transaction_mode
 order by total_transactions desc;
 
 Select reward, count(*) as total_transactions
 from transactions
 group by reward
 order by total_transactions desc;
 Select * from products;
 Select o.or_id, p.p_id, p.pname, p.category, o.qty
 from orders o
 join products p on o.p_id = p.p_id;
 
 Select p.p_id, p.pname, count(o.or_id) as total_orders
 from products p 
 join orders o on p.p_id = o.p_id
 group by p.p_id, p.pname
 order by total_orders desc;
 
 Select p.p_id, p.pname, sum(o.qty) as total_quantity
 from products p 
 join orders o on p.p_id = o.p_id
 group by p.p_id, p.pname
 order by total_quantity desc;
 
 Select p.p_id, p.pname, round(sum(p.price * o.qty),2) as total_revenue
 from products p 
 join orders o on p.p_id = o.p_id
 group by p.p_id, p.pname
 order by total_revenue desc;
 
 Select p.category, round(sum(p.price*o.qty),2) as total_revenue
 from products p
 join orders o on p.p_id = o.p_id
 group by category 
 order by total_revenue desc;
 
 Select c.c_id, c.cname, round(sum(p.price*o.qty),2) as total_revenue
 from customers c
 join orders o on c.c_id = o.c_id
 join products p on o.p_id = p.p_id
 group by c.c_id, c.cname 
 order by total_revenue desc;
 
 Select d.dp_id, d.dp_name, count(o.or_id) as total_orders
 from delivery d 
 join orders o on o.dp_id = d.dp_id
 group by d.dp_id, d.dp_name
 order by total_orders desc;
 
 Select t.transaction_mode,  count(o.or_id) as total_orders, 
 round(sum(p.price*o.qty),2) as total_revenue
 from transactions t
 join orders o on t.or_id = o.or_id
 join products p on o.p_id = p.p_id
 group by t.transaction_mode
 order by total_revenue desc;
 
 Select p.p_id, p.pname, round(avg(r.prod_rating),2) as avg_rating
 from products p 
 join orders o on p.p_id = o.or_id
 join ratings r on o.or_id = r.or_id
 group by p.p_id, p.pname
 having avg(r.prod_rating)>=4
 order by avg_rating desc;
 
 Select o.or_id, c.cname, c.c_id, o.qty
 from orders o
inner join customers c on o.or_id = c.c_id;

Select c.c_id, c.cname, count(o.or_id) as total_orders
from customers c 
left join orders o on o.or_id = c.c_id
group by c.c_id, c.cname
order by total_orders desc;

Select c.c_id, c.cname, count(o.or_id) as total_orders
from customers c 
left join orders o on c.c_id = o.or_id
group by c.c_id, c.cname
having count(o.or_id)>5
order by total_orders desc;

Select c.c_id, c.cname, o.or_id, o.qty
from customers c 
left join orders o on o.or_id = c.c_id
union 
Select c.c_id, c.cname, o.or_id, o.qty
from customers c 
right join orders o on o.or_id = c.c_id;

select pname, price,
case when price <300 then 'low'
when price between 300 and 600 then 'medium'
else 'high'
end as price_category
from products;

Select or_id, coupon_discount, coupon,
case when coupon_discount = 0 then 'no discount'
when coupon_discount between 1 and 10 then 'low discount'
else 'high discount'
end as discount_category
from orders;

Select p_id, pname, price, 
rank() over(order by price desc) as price_rank
from products;

Select p_id, pname, price, 
Dense_rank() over(order by price desc) as price_rank
from products;

Select p_id, pname, price, category,
rank() over(partition by category order by price desc) as category_rank 
from products;

Select p_id, pname, price, category 
from (select p_id, pname, price, category, Row_number() over(partition by category order by price desc) as rn
from products) as ranked_products 
where rn = 1;

Select pname, price, category
from (select pname, price, category, row_number() over(partition by category order by price desc) as rn from products) as ranked_products 
where rn<=3;

Select pname, category, p_id, total_revenue from (select p.pname, p.category, p.p_id, sum(p.price*o.qty) as total_revenue, row_number() over(partition by p.category order by sum(p.price*o.qty) desc) as rn from products p
join orders o on p.p_id = o.or_id
group by p.p_id, p.pname, p.category) as product_revenue
where rn<=2
order by category, total_revenue desc;
Select c_id, cname, city, total_revenue from (select c.c_id, c.cname, c.city, sum(p.price*o.qty) as total_revenue, row_number() over(partition by c.city order by sum(p.price*o.qty)desc) as rn from customers c 
join orders o on c.c_id = o.or_id
join products p on o.or_id = p.p_id
group by c.c_id, c.cname, c.city) as customer_revenue
where rn<=2;

Select c_id, cname, age, NTILE(4) OVER (order by age) as age_groups
from customers;

Select or_id, qty, sum(qty) over(order by or_id) as running_quamtity 
from orders;

Select p_id, price, avg(price) over(), 2 as overall_avg_price
from products;

Select or_id, qty, lag(qty) over(order by or_id) as previous_qty
from orders;

Select or_id, qty, lead(qty) over(order by or_id) as next_qty
from orders;

Select cname, city, total_revenue from (select c.cname, c.city, sum(p.price*o.qty) as total_revenue,  Row_number() over(partition by c.city order by sum(p.price*o.qty) desc) as rn from customers c 
join orders o on c.c_id = o.c_id
join products p on p.p_id = o.p_id
Group by c.cname, c.city ) as customer_revenue
where rn = 1;

Select c.c_id, c.cname, sum(p.price * o.qty) AS total_revenue, 
CASE
WHEN SUM(p.price * o.qty) > 10000
THEN 'High Value Customer'
ELSE 'Regular Customer'
End as customer_type
from customers c 
Join orders o on c.c_id = o.or_id 
Join products p on o.p_id = p.p_id
group by c.c_id, c.cname
HAVING SUM(p.price * o.qty) > 10000
ORDER BY total_revenue DESC;

WITH customer_revenue AS (
    SELECT
        o.c_id,
        SUM(p.price * o.qty) AS total_revenue
    FROM orders o
    JOIN products p
        ON o.p_id = p.p_id
    GROUP BY o.c_id
)
SELECT
    c_id,
    ROUND(total_revenue, 2) AS total_revenue,
    ROUND(
        100 * total_revenue / SUM(total_revenue) OVER (),
        2
    ) AS revenue_percentage
FROM customer_revenue
ORDER BY total_revenue DESC;

SELECT
    COUNT(DISTINCT o.or_id) AS total_orders,
    SUM(o.qty) AS total_quantity,
    ROUND(SUM(p.price * o.qty), 2) AS total_revenue,
    ROUND(
        SUM(p.price * o.qty) / COUNT(DISTINCT o.or_id),
        2
    ) AS average_order_value
FROM orders o
JOIN products p
    ON o.p_id = p.p_id;
    
SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS order_month,
    COUNT(DISTINCT o.or_id) AS total_orders,
    ROUND(SUM(p.price * o.qty), 2) AS total_revenue
FROM orders o
JOIN products p
    ON o.p_id = p.p_id
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY order_month;

WITH category_revenue AS (
    SELECT
        p.category,
        SUM(p.price * o.qty) AS total_revenue
    FROM products p
    JOIN orders o
        ON p.p_id = o.p_id
    GROUP BY p.category
)
SELECT
    category,
    ROUND(total_revenue, 2) AS total_revenue,
    ROUND(
        100 * total_revenue / SUM(total_revenue) OVER (),
        2
    ) AS revenue_percentage
FROM category_revenue
ORDER BY total_revenue DESC;