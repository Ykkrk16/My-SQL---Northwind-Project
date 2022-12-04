-- 1. We have a table called Shippers. Return all the fields from all the shippers
select * from shippers;

-- 2. We only want to see two columns,CategoryName and Description.
select * from categories;
select category_name,description from categories;

-- 3. We’d like to see just the FirstName, LastName, and HireDate of all the employees with the Title of Sales Representative. Write a SQL
-- statement that returns only those employees.
select * from employees;
select  first_name,last_name,hire_date,title from employees
where title = 'sales representative';

-- 4. Now we’d like to see the same columns as above, but only for those employees that both have the title of Sales Representative, and also are
-- in the United States.
select  first_name,last_name,hire_date,title from employees
where title = 'sales representative' and country = 'usa';

-- 5. Show all the orders placed by a specific employee. The EmployeeID for this Employee (Steven Buchanan) is 5.
select * from orders
where employee_id = 5;

-- 6. In the Suppliers table, show the SupplierID, ContactName, and ContactTitle for those Suppliers whose ContactTitle is not Marketing Manager.
select * from suppliers;
select supplier_id,contact_name,contact_title from suppliers
where contact_title not like 'marketing manager';

-- 7. In the products table, we’d like to see the ProductID and ProductName for those products where the ProductName includes the string “queso”.
select * from products;
select product_name,product_id from products
where product_name like '%queso%';

-- 8. Looking at the Orders table, there’s a field called ShipCountry. Write a query that shows the OrderID, CustomerID, and ShipCountry for the
-- orders where the ShipCountry is either France or Belgium.
select * from orders;
select order_id,customer_id,ship_country from orders
where ship_country = 'france' or ship_country = 'belgium';

-- 9. Now, instead of just wanting to return all the orders from France or Belgium, we want to show all the orders from any Latin American country. 
-- So, we’re going to just use this list of Latin American countries that happen to be in the Orders table:
-- Brazil, Mexico, Argentina, Venezuela
select * from orders;
select order_id,customer_id,ship_country from orders
where ship_country in ('brazil','mexico','argentina','venezuela');

-- 10. For all the employees in the Employees table, show the FirstName,LastName, Title, and BirthDate. Order the results by BirthDate, so we
-- have the oldest employees first.
select * from employees;
select first_name,last_name,title,birth_date from employees
order by birth_date asc;

-- 11. In the output of the query above, showing the Employees in order of BirthDate, we see the time of the BirthDate field, which we don’t want.
-- Show only the date portion of the BirthDate field.
select first_name,last_name,title,date(birth_date) as date_only from employees
order by birth_date asc;

-- 12. Show the FirstName and LastName columns from the Employees table, and then create a new column called FullName, showing FirstName and
-- LastName joined together in one column, with a space in-between.
select * from employees;
select first_name,last_name, concat(first_name,' ',last_name) as full_name from employees;

-- 13. In the OrderDetails table, we have the fields UnitPrice and Quantity. Create a new field, TotalPrice, that multiplies these two together. We’ll
-- ignore the Discount field for now. In addition, show the OrderID, ProductID, UnitPrice, and Quantity.Order by OrderID and ProductID.
select * from order_details;
select order_id,product_id,unit_price,quantity,unit_price*quantity as total_ptice from order_details
order by order_id,product_id;

-- 14. How many customers do we have in the Customers table? Show one value only, and don’t rely on getting the recordcount at the end of a resultset.
select * from customers;
select count(customer_id) as total_customer from customers;

-- 15. Show the date of the first order ever made in the Orders table.
select * from orders;
select min(order_date) as first_order_date from orders;

-- 16. Show a list of countries where the Northwind company has customers.
select * from customers;
select distinct country from customers;

-- 17. Show a list of all the different values in the Customers table for ContactTitles. Also include a count for each ContactTitle.
-- This is similar in concept to the previous question “Countries where there are customers”, except we now want a count for each ContactTitle.
select * from customers;
select contact_title , count(contact_title) as count from customers
group by contact_title
order by count desc;

-- 18. We’d like to show, for each product, the associated Supplier. Show the ProductID, ProductName, and the CompanyName of the Supplier.
-- Sort by ProductID.
select * from products;
select 
p.product_id,
p.product_name,
s.company_name
from products as p
left join suppliers as s
on p.supplier_id = s.supplier_id
order by product_id asc;

-- 19. We’d like to show a list of the Orders that were made,including the Shipper that was used.Show the OrderID,OrderDate (date only),and CompanyName
-- of the Shipper,and sort by OrderID.In order to not show all the orders(there’s more than 800),show only those rows with an OrderID of less than 10300
select * from orders;
select order_id,order_date,ship_name from orders
where order_id < 10300
order by order_id asc;

--------------- Intermediate level --------------------

-- 20. For this problem, we’d like to see the total number of products in each category. Sort the results by the total number of products, 
-- in descending order.
select * from products;
select * from categories;
select category_name,count(product_id) as count from categories
left join products
on categories.category_id = products.category_id
group by category_name
order by count desc;

-- 21. In the Customers table, show the total number of customers per Country and City.
select * from customers;
select country,city,count(customer_id) as count from customers
group by city,country
order by count desc;

-- 22. What products do we have in our inventory that should be reordered? For now, just use the fields UnitsInStock and ReorderLevel, where
-- UnitsInStock is less than the ReorderLevel, ignoring the fields UnitsOnOrder and Discontinued. Order the results by ProductID.
select* from products;
select product_id,product_name,units_in_stock,reorder_level from products
where units_in_stock < reorder_level
order by product_id asc;

-- 23. Now we need to incorporate these fields—UnitsInStock, UnitsOnOrder,ReorderLevel, Discontinued—into our calculation. We’ll define
-- “products that need reordering” with the following:
-- UnitsInStock plus UnitsOnOrder are less than or equal to ReorderLevel
-- The Discontinued flag is false (0).
select * from products;
select product_id,product_name,units_in_stock,reorder_level,units_on_order,discontinued from products
where (units_in_stock + units_on_order) <= reorder_level and discontinued = 0;

-- 24.Customer list by region A salesperson for Northwind is going on a business trip to visit customers, 
-- and would like to see a list of all customers, sorted by region, alphabetically.
-- However, he wants the customers with no region (null in the Region field) to be at the end, instead of at the top, where you’d normally find
-- the null values. Within the same region, companies should be sorted by CustomerID.
select * from customers;
select 
customer_id,
company_name,
region,
case region 
when region is null then 1
else 0
end as region_order
from customers
order by  
region_order desc, region ,customer_id asc;

-- 25. Some of the countries we ship to have very high freight charges. We'd like to investigate some more shipping options for our customers, to be
-- able to offer them lower freight charges. Return the three ship countries with the highest average freight overall, 
-- in descending order by average freight.
select * from orders;
select ship_country,avg(freight) as avg_freight from orders
group by ship_country
order by avg_freight desc limit 3;

-- 26. We're continuing on the question above on high freight charges. 
-- Now, instead of using all the orders we have, we only want to see orders from the year 2015.
select * from orders;
select ship_country,avg(freight) as avg_freight from orders
where order_date > '1997-01-01'
group by ship_country
order by avg_freight desc limit 3;

-- 27. What is the OrderID of the order that the (incorrect) answer above is missing?

-- 28. We're continuing to work on high freight charges. We now want to get the three ship countries with the highest average freight charges. 
-- But instead of filtering for a particular year, we want to use the last 12 months of order data, using as the end date the last OrderDate in Orders.
select * from orders;
select ship_country,avg(freight) as avg_freight from orders
group by ship_country
order by avg_freight desc,order_date desc limit 12;

-- 29. We're doing inventory, and need to show information like the below ( Emp_id,last_name,first_name,order_id,product_name,quantity)for all orders. 
-- Sort by OrderID and Product ID.
select e.employee_id,
e.last_name,
o.order_id,
p.product_name,
od.quantity
from employees as e
inner join orders as o
on e.employee_id = o.employee_id
inner join order_details as od
on o.order_id = od.order_id
inner join products as p
on od.product_id = p.product_id
order by o.order_id, p.product_id; 

-- 30. There are some customers who have never actually placed an order.Show these customers.
select c.customer_id,o.customer_id
from customers as c
left join orders as o
on c.customer_id = o.customer_id
where o.customer_id is null;

-- 31. One employee (Margaret Peacock, EmployeeID 4) has placed the most orders. However, there are some customers who've never placed an order
-- with her. Show only those customers who have never placed an order with her.
select c.customer_id,o.customer_id
from customers as c
left join orders as o
on c.customer_id = o.customer_id
and o.employee_id = 4
where o.customer_id is null;

------------- Advance Level ----------------

-- 32. We want to send all of our high-value customers a special VIP gift.We're defining high-value customers as those who've made at least 1
-- order with a total value (not including the discount) equal to $10,000 or more. We only want to consider orders made in the year 2016.
select * from customers;
select * from orders;
select * from order_details;

select 
c.customer_id,
c.company_name,
o.order_id,
sum(unit_price*quantity) as total_price
 from customers as c
 left join orders as o
 on c.customer_id = o.customer_id
 left join order_details as od
 on o.order_id = od.order_id
 group by c.customer_id,
c.company_name,
o.order_id
 having total_price > 10000
 order by total_price desc;
 
-- 33. The manager has changed his mind. Instead of requiring that customers have at least one individual orders totaling $10,000 or more, he wants to
-- define high-value customers as those who have orders totaling $15,000 or more in 2016. How would you change the answer to the problem above?
select 
c.customer_id,
c.company_name,
sum(unit_price*quantity) as total_price
 from customers as c
 join orders as o
 on c.customer_id = o.customer_id
 join order_details as od
 on o.order_id = od.order_id
 group by c.customer_id,
 c.company_name
 having total_price > 15000
 order by total_price desc;

-- 34. Change the above query to use the discount when calculating high-value customers. Order by the total amount which includes the discount.
select 
c.customer_id,
c.company_name,
sum(unit_price*quantity) as total_without_dis,
sum(unit_price*quantity*(1-discount)) as total_with_dis
 from customers as c
 join orders as o
 on c.customer_id = o.customer_id
 join order_details as od
 on o.order_id = od.order_id
 group by c.customer_id,
 c.company_name
 having total_with_dis > 10000
 order by total_with_dis desc;

-- 35. At the end of the month, salespeople are likely to try much harder to get orders, to meet their month-end quotas. 
-- Show all orders made on the last day of the month. Order by EmployeeID and OrderID
select * from orders;
select order_id,
employee_id,
order_date 
from orders
where order_date = eomonth(order_date)
order by order_id,employee_id;

-- 36. The Northwind mobile app developers are testing an app that customer will use to show orders. In order to make sure that even the largest
-- orders will show up correctly on the app, they'd like some samples of orders that have lots of individual line items. Show the 10 orders with
-- the most line items, in order of total line items.
select o.order_id,
count(*) as total_order
from orders as o
inner join order_details as od
on o.order_id = od.order_id
group by o.order_id
order by count(*) desc limit 10;

-- 37. The Northwind mobile app developers would now like to just get a random assortment of orders for beta testing on their app. 
-- Show a random set of 2% of all orders.

-- 38. Janet Leverling, one of the salespeople, has come to you with a request. She thinks that she accidentally double-entered a line item on an order,
-- with a different ProductID, but the same quantity. She remembers that the quantity was 60 or more. Show all the OrderIDs with line items that
-- match this, in order of OrderID.
select * from order_details;
select order_id from order_details
where quantity >=60
group by order_id,quantity
having count(*) > 1;

-- 39. Based on the previous question, we now want to show details of the order, for orders that match the above criteria.

-- 40. Here's another way of getting the same results as in the previous problem, using a derived table instead of a CTE

-- 41. Some customers are complaining about their orders arriving late. Which orders are late?

-- 42. Some salespeople have more orders arriving late than others. Maybe they're not following up on the order process, and need more training.
-- Which salespeople have the most orders arriving late?

-- 43. Andrew, the VP of sales, has been doing some more thinking some more about the problem of late orders. He realizes that just looking at the
-- number of orders arriving late for each salesperson isn't a good idea. It needs to be compared against the total number of orders per salesperson.
-- Return results like the following:

-- 44. There's an employee missing in the answer from the problem above. Fix the SQL to show all employees who have taken orders.

-- 45. Continuing on the answer for above query, let's fix the results for row 5- Buchanan. He should have a 0 instead of a Null in LateOrders.

-- 46. Now we want to get the percentage of late orders over total orders.

-- 47. So now for the PercentageLateOrders, we get a decimal value like we should. But to make the output easier to read, let's cut the
-- PercentLateOrders off at 2 digits to the right of the decimal point.

-- 48. Andrew Fuller, the VP of sales at Northwind, would like to do a sales campaign for existing customers. He'd like to categorize customers into
-- groups, based on how much they ordered in 2016. Then, depending on which group the customer is in, 
-- he will target the customer with different sales materials.

-- 49. There's a bug with the answer for the previous question. The CustomerGroup value for one of the rows is null.
-- Fix the SQL so that there are no nulls in the CustomerGroup field.

-- 50. Based on the above query, show all the defined CustomerGroups, and the percentage in each. Sort by the total in each group, in descending order.

-- 51. Andrew, the VP of Sales is still thinking about how best to group customers, and define low, medium, high, and very high value customers. 
-- He now wants complete flexibility in grouping the customers, based on the dollar amount they've ordered. He doesn’t want to have to edit SQL
-- in order to change the boundaries of the customer groups.

-- 52. Some Northwind employees are planning a business trip, and would like to visit as many suppliers and customers as possible. For their planning,
-- they’d like to see a list of all countries where suppliers and/or customers are based.

-- 53. The employees going on the business trip don’t want just a raw list of countries, they want more details. We’d like to see output like the
-- below, in the Expected Results.

-- 54. The output of the above is improved, but it’s still not ideal What we’d really like to see is the country name, the total suppliers, and
-- the total customers.

-- 55. Looking at the Orders table—we’d like to show details for each order that was the first in that particular country, ordered by OrderID.

-- 56. There are some customers for whom freight is a major expense when ordering from Northwind. However, by batching up their orders, 
-- and making one larger order instead of multiple smaller orders in a short period of time, they could reduce their freight costs significantly.
-- Show those customers who have made more than 1 order in a 5 day period. The sales people will use this to help customers reduce their costs.

-- 57. There’s another way of solving the problem above, using Window functions. We would like to see the following results.
