--What is the undiscounted subtotal for each Order (identified by OrderID).
select OrderID, sum(UnitPrice * Quantity) as subtotal
	from [Order Details] od
	group by OrderId


--What products are currently for sale (not discontinued)?
select ProductID,ProductName,Discontinued
from Products
where Discontinued = 0



--What is the cost after discount for each order?  Discounts should be applied as a percentage off.
select OrderID,
	sum(UnitPrice * Quantity) as GrossAmt,
	round(sum((UnitPrice * Quantity) * Discount),2) as DiscountAmt,
	round(sum((UnitPrice * Quantity) * (1 - Discount)),2) as NetAmt
from [Order Details] od
group by OrderId
