Set echo on

-- 1. Professors query: 
--Find the delivery addresses of orders containing popcorn and delivered by driver Hugh Grant.

SELECT oi.orderOid.customerOid.address 
  FROM Order_item oi 
  WHERE oi.orderOid.driverOid.dPerson.fullname()='Hugh Grant' AND oi.productOid.name='popcorn';


-- 2. Find the latest orders by date which have not been delivered and their customers. (map)

SELECT o.orderId, o.dateCreated, o.customerOid.cPerson.firstName AS CustomerName, o.deliveryDate 
  FROM Orders o 
  WHERE o.deliveryStatus != 'delivered' 
  ORDER BY value(o);
 

-- 3. Sort the price of Dairy products from Walmart Canada (order)

SELECT p.categoryOid.catalogOid.storeOid.name AS store_name, 
       p.categoryOid.categoryName AS category_name, 
       p.name AS Product_Name, p.price, p.checkExpiration() AS isExpired
  FROM Product p
  WHERE p.categoryOid.catalogOid.storeOid.name = 'Walmart Canada' AND p.categoryOid.categoryName = 'Dairy'
  ORDER BY VALUE(p);


-- 4. Find all the orders that need to be delivered Soon from Loblaw Companies Limited

SELECT treat(o.storeOid as REF stores_t).printPersonalInfo() AS Store, 
       treat(o.customerOid AS REF customers_t).printPersonalInfo() AS Customer,
       o.deliveryDate
  FROM Orders o
  WHERE o.deliveryDate > sysdate AND o.storeOid.name = 'Loblaw Companies Limited';
 
-- 5 Find out the customers with orders who have been loyal for more than a year

SELECT  o.customerOid.accountID AS customerID, 
         o.customerOid.cPerson.fullname() AS customerName, 
         COUNT(*) AS orderCount, treat((o.customerOid) AS REF customers_t).calcLoyaltyDays() AS loyalDays
    FROM Orders o
    WHERE treat(o.customerOid AS REF customers_t).calcLoyaltyDays() > 365
    GROUP BY o.customerOid;
         
    

-- 6. List all products ordered from FreshCo from the most ordered to the least

SELECT DISTINCT oi.productOid.productID AS productID, 
                oi.productOid.name AS productName, 
                oi.productOid.brand AS productBrand,
                sum(quantity) AS totalOrderItem
  FROM order_item oi 
  WHERE oi.orderOid.storeOid.name = 'FreshCo'
  GROUP BY oi.productOid
  ORDER BY Value(totalOrderItem) DESC;

-- 7. Find all customers that ordered 'Drinks' AND are undner age 25.

SELECT oi.orderOid.customerOid.accountID AS customerID, 
                oi.orderOid.customerOid.cPerson.fullname() AS customerName,
                oi.productOid.name AS productName
  FROM order_item oi
  WHERE oi.productOid.categoryOid.catalogOid.catName = 'Drinks'
  AND oi.orderOid.customerOid.cPerson.calcAge() < 30;


-- 8. Calculate the total price of the orders.

SELECT oi.orderOid.orderID AS OrderID, 
       SUM(oi.calcPrice(oi.productOid.price)) AS totalPrice,
       oi.orderOid.customerOid.cPerson.fullname() AS cName,
       oi.orderOid.driverOid.dPerson.fullname() AS dName
  FROM order_item oi
  GROUP BY oi.orderoid
  ORDER BY OrderID; 



-- 9. List the average delivery time for all drivers in asecdening order.
       
SELECT o.driverOid.accountID AS driverID,
      o.driverOid.dPerson.firstname AS driverName,
      AVG(o.deliveryDuration()) AS avgDelivery
 FROM Orders o
 WHERE o.deliveryStatus = 'delivered' AND o.driverOid IN (
 SELECT o.driverOid
         FROM Orders o
         GROUP BY o.driverOid
 )
 GROUP BY o.driverOid
 ORDER BY avgDelivery;
