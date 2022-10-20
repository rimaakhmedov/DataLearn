-- insert into customer
insert into customer_dim
select row_number() over (), customer_id, customer_name, segment
from orders a
group by customer_id, customer_name, segment
order by customer_id;

-- insert into location
insert into location_dim
select row_number() over (), country, region, state, city, postal_code
from orders a
group by country, region, state, city, postal_code
order by state;


--insert into product
insert into product_dim
select row_number() over (), category, subcategory, product_name, product_id
from orders a
group by category, subcategory, product_name, product_id
order by product_id;

--insert into shipping
insert into shipping_dim
select row_number() over(), ship_mode from (select distinct ship_mode from orders) a;

--insert into order date
insert into order_date_dim (order_date, year, quarter, month, week, week_day)
select order_date, extract (year from order_date) as year, 
                   extract (quarter from order_date) as quarter, 
                   extract (month from order_date) as month,
                   extract (week from order_date) as week,
                   extract (day from order_date) as week_day              
from orders
group by 1
order by 1;


--insert into ship date
insert into ship_date_dim (ship_date, year, quarter, month, week, week_day)
select ship_date , extract (year from ship_date) as year, 
                   extract (quarter from ship_date) as quarter, 
                   extract (month from ship_date) as month,
                   extract (week from ship_date) as week,
                   extract (day from ship_date) as week_day              
from orders
group by 1
order by 1;


--insert into sales_fact
insert into sales_fact
select 
ROW_NUMBER() over() as row_id,
order_id, 
sdd.ship_date, 
sd.ship_id, 
gd.geo_id, 
cd.customer_dim_id, 
pd.product_dim_id, 
od.order_date, 
sales, 
profit, 
quantity, 
discount
from orders o
inner join ship_date_dim sdd on o.ship_date = sdd.ship_date
inner join shipping_dim sd on o.ship_mode = sd.ship_mode
inner join location_dim gd on (o.city = gd.city and o.postal_code = gd.postal_code)
inner join customer_dim cd on o.customer_id = cd.customer_id
inner join product_dim pd on o.product_id = pd.product_id
inner join order_date_dim od on o.order_date = od.order_date; 


