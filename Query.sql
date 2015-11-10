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

create procedure `getOrderByCusomer` (IN paramCustomer varchar(10))
MODIFIES SQL DATA
BEGIN
select * from customer c, ordertable o WHERE (c.id=o.Customer_id) AND (c.Name = paramCustomer);
END //


