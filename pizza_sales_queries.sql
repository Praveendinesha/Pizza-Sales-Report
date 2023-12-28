--- CREATING A TABLE 'pizza_sales'
create table pizza_sales(pizza_id int,	order_id int, pizza_name_id varchar(50), 
			  quantity int,	order_date date not null, order_time time,	
			  unit_price float,	total_price float,	pizza_size varchar(50), 
			  pizza_category varchar(50),pizza_ingredients	varchar(100),pizza_name varchar(50))


--- VIEWING THE SAMPLE TOP 10 RECORDS  
select * from pizza_sales limit 10

--- KPI : Key Performance Indicators

---1 TOTAL REVENUE
select sum(total_price) Total_Revenue from pizza_sales;
"total_revenue"
817860.049999993


---2 AVERAGE ORDER VALUE
select sum(total_price)/count(distinct(order_id)) avg_order_value  from pizza_sales
"avg_order_value"
38.307262295081635


---3 TOTAL PIZZA SOLD
select sum(quantity) total_pizza_sold from pizza_sales
"total_pizza_sold"
49574


---4 TOTAL ORDERS
select count(distinct(order_id)) total_orders  from pizza_sales
"total_orders"
21350



---5 AVERAGE PIZZAS PER ORDER
select cast(
cast(sum(quantity) as decimal(10,2))/
cast(count(distinct(order_id))as decimal(10,2)) as decimal(10,2)) avg_pizzas_per_order
from pizza_sales;
"avg_pizzas_per_order"
2.32



--- CHART 

---1 Daily Trend for Total Orders
select to_char(order_date, 'Day') as order_day,
count(distinct(order_id)) as total_orders
from pizza_sales
group by to_char(order_date, 'Day');

"order_day"	"total_orders"
"Friday   "	3538
"Monday   "	2794
"Saturday "	3158
"Sunday   "	2624
"Thursday "	3239
"Tuesday  "	2973
"Wednesday"	3024


---2 Monthly Trend For Total Orders
select to_char(order_date, 'Month') as Month_Name,
count(distinct(order_id)) as total_orders
from pizza_sales
group by to_char(order_date, 'Month')
order by total_orders desc;

"month_name"	"total_orders"
"July     "	1935
"May      "	1853
"January  "	1845
"August   "	1841
"March    "	1840
"April    "	1799
"November "	1792
"June     "	1773
"February "	1685
"December "	1680
"September"	1661
"October  "	1646

---3 PTC of Sales by Category
select pizza_category, cast(
sum(total_price)*100 / (select sum(total_price)from pizza_sales where extract('month' from order_date) = 1 ) as decimal(10,2))as PCT_of_sales
from pizza_sales 
where extract('month' from order_date) = 1
group by pizza_category
order by PCT_of_sales desc;

"pizza_category"	"pct_of_sales"
"Classic"	26.68
"Supreme"	25.69
"Veggie"	24.44
"Chicken"	23.20

---4 PTC of Sales by Pizza Size

select pizza_size, cast(
sum(total_price)*100 / (select sum(total_price)from pizza_sales ) as decimal(10,2))as PCT_of_sales
from pizza_sales 
group by pizza_size
order by PCT_of_sales desc;

"pizza_size"	"pct_of_sales"
"L"	45.89
"M"	30.49
"S"	21.77
"XL"	1.72
"XXL"	0.12

---5 Top 5 Best Sellers by Total Revenue .
select pizza_name,sum(total_price)as total_revenue from pizza_sales group by pizza_name
order by total_revenue desc
limit 5;

"pizza_name"	"total_revenue"
"The Thai Chicken Pizza"	43434.25
"The Barbecue Chicken Pizza"	42768
"The California Chicken Pizza"	41409.5
"The Classic Deluxe Pizza"	38180.5
"The Spicy Italian Pizza"	34831.25


---Top 5 Best Sellers by Total Quantity .
select pizza_name,sum(quantity)as total_quantity
from pizza_sales group by pizza_name
order by total_quantity desc
limit 5;

"pizza_name"	"total_quantity"
"The Classic Deluxe Pizza"	2453
"The Barbecue Chicken Pizza"	2432
"The Hawaiian Pizza"	2422
"The Pepperoni Pizza"	2418
"The Thai Chicken Pizza"	2371

---Top 5 Best Sellers by Order_id .
select pizza_name, count(distinct order_id) as total_quantity
from pizza_sales group by pizza_name
order by total_quantity desc
limit 5;

"pizza_name"	"total_quantity"
"The Classic Deluxe Pizza"	2329
"The Hawaiian Pizza"	2280
"The Pepperoni Pizza"	2278
"The Barbecue Chicken Pizza"	2273
"The Thai Chicken Pizza"	2225





























'''
In SQL, various functions are available to extract different components from date and time values. Some common ones include:

YEAR: Extracts the year from a date.

SQL Server: DATEPART(year, order_date)
PostgreSQL: EXTRACT(year FROM order_date)
MONTH: Extracts the month from a date.

SQL Server: DATEPART(month, order_date)
PostgreSQL: EXTRACT(month FROM order_date)
DAY: Extracts the day of the month from a date.

SQL Server: DATEPART(day, order_date)
PostgreSQL: EXTRACT(day FROM order_date)
QUARTER: Extracts the quarter from a date.

SQL Server: DATEPART(quarter, order_date)
PostgreSQL: EXTRACT(quarter FROM order_date)
WEEKDAY: Extracts the day of the week as an integer (Sunday = 1, Monday = 2, etc.).

SQL Server: DATEPART(weekday, order_date)
PostgreSQL: EXTRACT(dow FROM order_date)
WEEK: Extracts the week number within the year.

SQL Server: DATEPART(week, order_date)
PostgreSQL: EXTRACT(week FROM order_date)
HOUR, MINUTE, SECOND: Extracts the hour, minute, or second from a timestamp or time value.

SQL Server: DATEPART(hour, order_date), DATEPART(minute, order_date), DATEPART(second, order_date)
PostgreSQL: EXTRACT(hour FROM order_date), EXTRACT(minute FROM order_date), EXTRACT(second FROM order_date)
'''