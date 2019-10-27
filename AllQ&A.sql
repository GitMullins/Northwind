--What is the undiscounted subtotal for each Order (identified by OrderID).

select OrderID, sum(UnitPrice * Quantity) as subtotal
	from [Order Details] od
	group by OrderId


--What products are currently for sale (not discontinued)?

select ProductID,ProductName,Discontinued
from Products
where Discontinued = 0