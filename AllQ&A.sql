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



--5. What are our 10 most expensive products?
select top(10)ProductId,
	UnitPrice
from Products
order by UnitPrice desc



--6. In which quarter in 1997 did we have the most revenue?
select
	format(sum(case
		when OrderDate between '01/01/1997' and '3/31/1997'
		then UnitPrice * Quantity
		else 0
		end),'c') as Qtr1,
	format(sum(case
		when OrderDate between '04/01/1997' and '06/30/1997'
		then UnitPrice * Quantity
		else 0
		end),'c') as Qtr2,
	format(sum(case
		when OrderDate between '07/01/1997' and '09/30/1997'
		then UnitPrice * Quantity
		else 0
		end),'c') as Qtr3,
	format(sum(case
		when OrderDate between '10/01/1997' and '12/31/1997'
		then UnitPrice * Quantity
		else 0
		end),'c') as Qtr4
from Orders o
	join [Order Details] od on od.OrderID = o.OrderId



--7. Which products have a price that is higher than average?
select 
	--count(ProductID) as TotalProducts,
	--sum(UnitPrice) as SumOfPrices,
	ProductId,
	UnitPrice
from Products
where UnitPrice > (select avg(UnitPrice) from Products)
order by UnitPrice