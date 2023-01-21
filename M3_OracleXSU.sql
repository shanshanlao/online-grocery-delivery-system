-- 1. Find customers who have orders and their loyaltyDays.
OracleXML getXML -user "grp3/here4grp3" \
-conn "jdbc:oracle:thin:@sit.itec.yorku.ca:1521:studb10g" \
-rowsetTag "OrderCountByCustomer" \
-rowTag "customer" \
"SELECT  o.customerOid.accountID AS customerID, o.customerOid.cPerson.fullname() AS customerName, \
COUNT(*) AS orderCount, treat((o.customerOid) AS REF customers_t).calcLoyaltyDays() AS loyalDays \
FROM Orders o WHERE treat(o.customerOid AS REF customers_t).calcLoyaltyDays() > 365 \
GROUP BY o.customerOid"

-- 2. List all products that have been ordered from each store and sort them by quantity ordered.
OracleXML getXML -user "grp3/here4grp3" \
-conn "jdbc:oracle:thin:@sit.itec.yorku.ca:1521:studb10g" \
-rowsetTag "OrderedProductsList" -rowTag "Product" \
"select oi.productOid.productId AS ProductId, oi.productOid.name AS ProductName, \
oi.productOid.brand AS ProductBrand, sum(oi.quantity) AS SumOfOrders, \
treat(oi.productOid.categoryOid.catalogOid.storeOid AS REF stores_t).accountId AS StoreId, \
oi.productOid.categoryOid.catalogOid.storeOid.name AS storeName \
FROM order_item oi GROUP BY oi.productOid ORDER BY sum(oi.quantity) desc"

-- 3. Find out the total sales for each store. 
OracleXML getXML -user "grp3/here4grp3" \
-conn "jdbc:oracle:thin:@sit.itec.yorku.ca:1521:studb10g" \
-rowsetTag "StoreSalesList" \
-rowTag "store" \
"SELECT oi.orderOid.storeOid.accountID AS storeID, \
oi.orderOid.storeOid.name AS storeName, \
SUM(oi.calcPrice(oi.productOid.price)) AS totalSales \
FROM order_item oi \
GROUP BY oi.orderOid.storeOid"

-- 4. Calculate the total price of the orders whose order total is greater than $50.
OracleXML getXML -user "grp3/here4grp3" \
-conn "jdbc:oracle:thin:@sit.itec.yorku.ca:1521:studb10g" \
-rowsetTag "OrderList" \
-rowTag "order" \
"SELECT OrderID, totalPrice, cName from (SELECT oi.orderOid.orderID AS OrderID, \
SUM(oi.calcPrice(oi.productOid.price)) AS totalPrice, \
oi.orderOid.customerOid.cPerson.fullname() AS cName \
FROM order_item oi \
GROUP BY oi.orderoid \
ORDER BY OrderID)where totalPrice>50"
