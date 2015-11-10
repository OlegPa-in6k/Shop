create procedure `addCustomer`(IN paramName varchar(10))
 MODIFIES SQL DATA
    BEGIN
   insert into customer (Name) values (paramName);
    END//

create procedure `addCategory` (IN paramTitle varchar(10))
MODIFIES SQL DATA
BEGIN
insert into category (Title) values (paramTitle);
END //

create procedure `addProduct` (IN paramTitle varchar(10), IN paramPrice DECIMAL, IN paramCategory INT)
MODIFIES SQL DATA
BEGIN
insert into product (Title, Price, Category_id) values (paramTitle, paramPrice, paramCategory);
END //

create procedure `addItem` (IN paramProduct INT, IN paramQuantity INT, IN paramOrder INT)
MODIFIES SQL DATA
BEGIN
insert into item(Product_id, Quantity, Order_id) values (paramProduct, paramQuantity, paramOrder);
END//

create procedure `addOrderItem` ( IN paramCustomer INT, IN paramDate DATE)
MODIFIES SQL DATA
BEGIN
insert into ordertable (Customer_id, Date) values (paramCustomer, paramDate);
END //


create procedure `getProductByCategory` (IN paramCategory varchar(10))
MODIFIES SQL DATA
BEGIN
select product.Title FROM category JOIN product where category.id=product.Category_id AND category.Title LIKE paramCategory;
END //

create procedure `getOrderByCustomer` (IN paramCustomer varchar(10))
MODIFIES SQL DATA
BEGIN
select c.Name, o.id, o.Date from customer c, ordertable o WHERE (c.id=o.Customer_id) AND (c.Name = paramCustomer);
END //

create procedure `getItemsByOrder` (IN paramOrderId INT)
MODIFIES SQL DATA
BEGIN
select o.id ,p.Title, i.Quantity  from item i, ordertable o, product p WHERE (o.id = paramOrderId) AND ( o.id=i.Order_id) AND (p.id=i.Product_id);
END //

CREATE PROCEDURE `getTop3Products`()
MODIFIES SQL DATA
BEGIN
SELECT  i.Product_id, p.Title, sum(i.Quantity) as itemCount
FROM item i, product p
where i.Product_id = p.id
GROUP BY i.Product_id
ORDER BY sum(i.Quantity) desc
LIMIT 3;
END//
 

CREATE PROCEDURE `getMonthPopularProduct`(IN paramYear INT, IN paramMonth INT)
    BEGIN
SELECT  i.Product_id, p.Title, sum(i.Quantity) as summary
FROM item i, product p, ordertable o
where (i.Product_id = p.id)and (i.Order_id = o.id) 
and (YEAR(o.date) = paramYear )AND (MONTH(o.date) = paramMonth)
GROUP BY i.Product_id
ORDER BY sum(i.Quantity) desc
LIMIT 1;
 END//

CREATE PROCEDURE `getTotalCostOfOrder` (IN orderId INT)
BEGIN
SELECT o.id, sum(p.Price * i.Quantity*1.1) as summ from product p, item i, ordertable o
where (p.id=i.Product_id) and ( i.Order_id = o.id) and (o.id = orderId);
END //

CREATE PROCEDURE `getTopProductInAllCategory`()
BEGIN
SELECT * FROM (Select c.Title as category, p.Title as product, sum(i.Quantity) as totalQuantity from item i, product p, category c WHERE ( i.Product_id = p.id) AND (c.id=p.Category_id) Group by i.Product_id ORDER BY totalQuantity DESC) A GROUP BY category;
END //






