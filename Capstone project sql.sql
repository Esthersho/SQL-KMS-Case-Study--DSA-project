create database DSA_Capstone_Project

select * from [dbo].[KMS Sql Case Study - Copy]

-- CASE SENARIO 1

-- 1. Which product category had the highest sales? 
select product_Category, Sales from [dbo].[KMS Sql Case Study - Copy]
where Sales = (select max (Sales) from[dbo].[KMS Sql Case Study - Copy])

Answer Technology- 89061.05

-- 2. What are the Top 3 and Bottom 3 regions in terms of sales? 

select top 3 region, sum(sales) as totalsales from [dbo].[KMS Sql Case Study - Copy]
group by region
order by totalsales desc

region	totalsales
West	3597549.41
Ontario	3063212.60
Prarie	2837304.60

select top 3 region, sum(sales) as totalsales from [dbo].[KMS Sql Case Study - Copy]
group by region
order by totalsales asc

region	totalsales
Nunavut	116376.47
Northwest Territories	800847.35
Yukon	975867.39

-- 3. What were the total sales of appliances in Ontario? 

select sum (sales) as Totalsales from [dbo].[KMS Sql Case Study - Copy]
where region = 'Ontario'

Totalsales= 3063212.60

-- 4. Advise the management of KMS on what to do to increase the revenue from the bottom 10 customers 
select top 10 * from [dbo].[KMS Sql Case Study - Copy]
order by profit desc


select top 10 * from [dbo].[KMS Sql Case Study - Copy]
order by profit asc

--- My advise to the management of KMS to increase the revenue from the bottom 10 customers is that
--they should reduce the unit price of the goods being sold in these customer segments.

-- 5. KMS incurred the most shipping cost using which shipping method? 

select max (shipping_cost), ship_mode from [dbo].[KMS Sql Case Study - Copy]
group by ship_mode

--OR

select shipping_cost, ship_mode from [dbo].[KMS Sql Case Study - Copy]
where shipping_cost = (select max (shipping_cost) as max_shippin_cost from [dbo].[KMS Sql Case Study - Copy])

shipping_cost	ship_mode
164.729995727539	Delivery Truck

--OR

Select Top 1 [Ship_Mode], SUM([Shipping_Cost]) as [Total Shipping Cost]
from [dbo].[KMS Sql Case Study - Copy]
group by Ship_Mode
order by [Total Shipping Cost] desc


--CASE SENARIO 2
-- 6. Who are the most valuable customers, and what products or services do they typically purchase? 

select [Customer_Name],Product_Name, SUM(sales) as [Total Sales]
from [dbo].[KMS Sql Case Study - Copy]
Group by Customer_Name,Product_Name
order by [Total Sales] desc

--OR


select top 5 Customer_Name,Product_Name,Sales
from [dbo].[KMS Sql Case Study - Copy]
order by Sales desc

-- 7. Which small business customer had the highest sales? 
select top 1 Customer_Name,Customer_Segment, SUM([Sales]) as [Total Sales]
from [dbo].[KMS Sql Case Study - Copy]
where Customer_Segment ='small Business'
group by Customer_Name,Customer_Segment
order by [Total Sales] desc

--OR

select top 1 Customer_Name, SUM([Sales]) as [Total Sales]
from [dbo].[KMS Sql Case Study - Copy]
where Customer_Segment ='small Business'
group by Customer_Name
order by [Total Sales] desc

Customer_Name	Customer_Segment	Total Sales
Dennis Kane	Small Business	75967.59



-- 8. Which Corporate Customer placed the most number of orders in 2009 – 2012? 

select top 1  Customer_Name,Customer_Segment, count([Order_ID]) as [Total order]
from [dbo].[KMS Sql Case Study - Copy]
where Customer_Segment ='corporate' and Order_Date between '2009' and '2012'
group by Customer_Name,Customer_Segment
order by [Total order] desc

Customer_Name	Customer_Segment	Total order
Adam Hart	Corporate	19

-- 9. Which consumer customer was the most profitable one?

select top 1 Customer_Name,Customer_Segment, sum([Profit]) as [Total profit]
from [dbo].[KMS Sql Case Study - Copy]
where Customer_Segment ='Consumer'
group by Customer_Name,Customer_Segment
order by [Total profit] desc

Customer_Name	Customer_Segment	Total profit
Emily Phan	Consumer	34005.44

Customer_Name	Customer_Segment	Total profit
Emily Phan	Consumer	34005.44

--10. Which customer returned items, and what segment do they belong to? 

select Customer_Name,Customer_Segment,[Status]
from [dbo].[KMS Sql Case Study - Copy]
join [dbo].[Order_Status]
on [dbo].[KMS Sql Case Study - Copy].Order_ID = [dbo].[Order_Status].[Order_ID]

-- 11. If the delivery truck is the most economical but the slowest shipping method and 
--Express Air is the fastest but the most expensive one, do you think the company 
--appropriately spent shipping costs based on the Order Priority? Explain your answer.

Select Order_Priority, Ship_Mode,
    COUNT([Order_ID]) AS [order count],
    SUM(sales - profit) AS [Estimated shipping cost],
    AVG(DATEDIFF(DAY, [Order_Date], [Ship_Date])) AS [Avg ship date]
from   [dbo].[KMS Sql Case Study - Copy]
group by Order_Priority,Ship_Mode
order by  Order_Priority,Ship_Mode desc  

--No, the company did not appropriately spend shipping cost based on order priority.
--This is because express air, which should be for citical order priority, requiring urgency, is used for low order priority in some cases.
--Delivery truck is also used for critical order priority in some cases. This shows a disalignment between order priority, the ship mode and even the order count.
-- Delivery truck is also good for bulk orders, but it was used for small quantity orders in some cases.



