create database Customer_Order_Product

create table Customer(CustomerID int primary key,Name varchar(50),Email varchar(100))

insert into Customer(CustomerID,Name,Email) values
(1, 'John Doe', 'johndoe@example.com'),
(2, 'Jane Smith', 'janesmith@example.com'),
(3, 'Robert Johnson', 'robertjohnson@example.com'),
(4, 'Emily Brown', 'emilybrown@example.com'),
(5, 'Michael Davis', 'michaeldavis@example.com'),
(6, 'Sarah Wilson', 'sarahwilson@example.com'),
(7, 'David Thompson', 'davidthompson@example.com'),
(8, 'Jessica Lee', 'jessicalee@example.com'),
(9, 'William Turner', 'williamturner@example.com'),
(10, 'Olivia Martinez', 'oliviamartinez@example.com')


create table Orders(OrderID int primary key,CustomerID int,ProductName varchar(50),OrderDate date,Quantity int)

insert into Orders(OrderID,CustomerID,ProductName,OrderDate,Quantity) values
(1, 1, 'Product A', '2023-07-01', 5),
(2, 2, 'Product B', '2023-07-02', 3),
(3, 3, 'Product C', '2023-07-03', 2),
(4, 4, 'Product A', '2023-07-04', 1),
(5, 5, 'Product B', '2023-07-05', 4),
(6, 6, 'Product C', '2023-07-06', 2),
(7, 7, 'Product A', '2023-07-07', 3),
(8, 8, 'Product B', '2023-07-08', 2),
(9, 9, 'Product C', '2023-07-09', 5),
(10, 10, 'Product A', '2023-07-10', 1)


create table Product(ProductID int primary key,ProductName varchar(50),Price decimal(10, 2))

insert into Product(ProductID,ProductName,Price) values
(1, 'Product A', 10.99),
(2, 'Product B', 8.99),
(3, 'Product C', 5.99),
(4, 'Product D', 12.99),
(5, 'Product E', 7.99),
(6, 'Product F', 6.99),
(7, 'Product G', 9.99),
(8, 'Product H', 11.99),
(9, 'Product I', 14.99),
(10, 'Product J', 4.99)

/*Task 1*/

select * from Customer

select Name,Email from Customer where Name like 'J%'

select OrderID,ProductName,Quantity from Orders

select sum (Quantity) from  Orders

select Name from Customer where CustomerID in (select CustomerID from Orders)

select ProductName from Product where Price > 10.00

select Name,OrderDate from Customer join Orders 
on 
Customer.CustomerID = Orders.CustomerID 
where 
Orders.OrderDate >='2023-07-05'

select avg (Price) from Product

select Name,sum (Quantity)'Quantity' from Customer join Orders
on 
Customer.CustomerID = Orders.CustomerID
join Product 
on 
Orders.ProductName = Product.ProductName
group by 
Name

select Product.ProductName from Product left join Orders
on 
Product.ProductName = Orders.ProductName
where orders.productName is null


/*Task 2*/

select top 5 Name, sum(Quantity)'Quantity' from Customer join Orders
on 
Customer.CustomerID = Orders.CustomerID
group by
Name
order by
Quantity desc

select Product.ProductName, avg(Price) from Product join Orders
on 
Product.ProductName = Orders.ProductName
group by
Product.ProductName

select Name from Customer left join Orders
on 
Customer.CustomerID = Orders.CustomerID
where 
Customer.CustomerID is null

select OrderID,ProductName,Quantity from Orders join Customer
on
Orders.CustomerID = Customer.CustomerID
where 
Name like 'M%'

select  sum(Price*Quantity)'Revenue' from Orders join Product
on 
Orders.ProductName = Product.ProductName

select Name,sum(Price*Quantity)'Revenue' from Customer join Orders
on 
Customer.CustomerID = Orders.CustomerID
join Product
on 
Orders.ProductName = Product.ProductName
group by
Name

/*select * from Customer join Orders
on 
Customer.CustomerID = Orders.CustomerID
join Product
on 
Orders.ProductName = Product.ProductName
group by
Customer.CustomerID,Customer.Name
having
COUNT(distinct product.ProductName) = (SELECT COUNT(*) FROM product)*/

/*select Distinct * from Customer join Orders as o
on 
Customer.CustomerID = o.CustomerID
join Orders as od
on 
Customer.CustomerID = od.CustomerID
where
DATEDIFF(day,o.OrderDate,od.OrderDate)=1*/

select top 3 Product.ProductName,avg(Quantity)'Avg_Quantity' from Product join Orders
on 
Product.ProductName = Orders.ProductName
group by 
Product.ProductName
order by
Avg_Quantity desc

/*SELECT
    (COUNT(CASE WHEN OI.quantity > AVG(OI.quantity) THEN 1 END) * 100.0) / COUNT(*) AS percentage_orders_above_average
FROM
    Orders AS OI;

select*from orders*/


/*Task 3*/

/*select * from Customer join Orders
on Customer.CustomerID = Orders.CustomerID
join Product
on Orders.ProductName = Product.ProductName
group by
Customer.CustomerID
having 
COUNT(Distinct Product.ProductName) = (select COUNT(*) from Product)*/

/*select * from Product 
where
Product.ProductName in (select Orders.ProductName from Orders
group by Orders.ProductName
having
COUNT(distinct Customer.Name)=(select COUNT(*) from Customer))*/

select Orders.OrderDate, sum (price*Quantity)'Revenue' from Orders join Product
on Orders.ProductName = Product.ProductName
group by
Orders.OrderDate

select * from Product as p
where
P.ProductName in (select o.ProductName from Orders as o 
join Customer as c
on
o.CustomerID = c.CustomerID
group by
o.ProductName
having
COUNT(c.CustomerID) > (select COUNT(*)*0.5 from Customer))


select top 5 Name,sum(price*quantity)'Spent_Money' from Customer join Orders
on Customer.CustomerID = Orders.CustomerID
join Product
on Orders.ProductName = Product.ProductName
group by
Name
order by Spent_Money desc


select Name,sum(quantity)'Running_Total' from Customer join Orders  
on Customer.CustomerID = Orders.CustomerID
group by Name
order by Running_Total desc


select top 3 Name,Orderdate from Customer join Orders
on Customer.CustomerID = Orders.CustomerID
order by OrderDate desc


select C.name,SUM(P.price * O.quantity) as total_revenue_last_30_days
from customer as C join orders as O
on
C.customerid = O.customerid
join product as P
on
O.ProductName = P.ProductName
where
O.orderdate >= DATEADD(DAY, -30, GETDATE())
group by
C.name


select Name from Customer join Orders
on
Customer.CustomerID = Orders.CustomerID
join Product
on 
Orders.ProductName = Product.ProductName
group by Name
having
COUNT(Product.ProductID)>= 2


select Name,avg(price*quantity)'Avg_Reveneu' from Customer join Orders
on
Customer.CustomerID = Orders.CustomerID
join Product
on 
Orders.ProductName = Product.ProductName
group by Name
order by Avg_Reveneu




select Name from Customer join Orders
on 
Customer.CustomerID = Orders.CustomerID
where
YEAR(Orders.OrderDate)=2023
group by 
Name
having
COUNT(distinct MONTH(orderdate)) = (SELECT COUNT(distinct MONTH(orderdate)) from orders where YEAR(orderdate) = 2023);


select * from Customer join Orders as o1
on
Customer.CustomerID = o1.CustomerID
join Orders as o2
on
Customer.CustomerID =o2.CustomerID
join Product as p1
on 
o1.ProductName = p1.ProductName
join Product p2
on
o2.ProductName = p2.ProductName
where 
p1.ProductID = 5 and p2.ProductID = 5
and DATEADD(MONTH, 1, O1.orderdate) = O2.orderdate


select Product.ProductName from Product join Orders
on 
Orders.ProductName = Product.ProductName
join Customer
on 
Orders.CustomerID = Customer.CustomerID
where 
Orders.CustomerID = 2
group by
Product.ProductName
having
COUNT(*) >=2


