--1. What is the undiscounted subtotal for each Order (identified by OrderID).
select OrderID, sum(UnitPrice * Quantity) as subtotal
	from [Order Details] od
	group by OrderId


--2. What products are currently for sale (not discontinued)?
select ProductID,ProductName,Discontinued
from Products
where Discontinued = 0



--3. What is the cost after discount for each order?  Discounts should be applied as a percentage off.
select OrderID,
	sum(UnitPrice * Quantity) as GrossAmt,
	round(sum((UnitPrice * Quantity) * Discount),2) as DiscountAmt,
	round(sum((UnitPrice * Quantity) * (1 - Discount)),2) as NetAmt
from [Order Details]
group by OrderId



--4. I need a list of sales figures broken down by category name.
--Include the total amount sold over all time and the total number of items sold.
select c.CategoryName,
	sum(od.Quantity) as QtySold,
	sum(od.Quantity * od.UnitPrice) as TotalSales
from [Order Details] od
	join Products p on p.ProductID = od.ProductID
	join Categories c on p.CategoryID = c.CategoryID
group by c.CategoryName