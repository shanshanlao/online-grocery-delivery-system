
-- 1. Find all products from Walmart Canada belonging to the category "Raw Vegetables" that are below 100 quantity.

xquery
let $p := doc("/public/grp3_2022/storeProductList.xml")
let $w := $p/ProductInfoByStore/storelist[@NAME='Walmart Canada']
for $prod in $w/product[@CategoryName= 'Raw Vegetables']
where $prod/Quantity <100
return $prod/@ProductId
/

-- 2. Find all orderItems from the order ID-00002.

xquery
let $d:= doc("/public/grp3_2022/orderItemList.xml")
for $o in $d/OrderItemInfoByOrder/order
where $o/@OrderID= 'O00000002'
return $o/OrderItem
/

-- 3. List all the product names within the categoryID 'C001'. 

xquery
let $catDoc := doc("/public/grp3_2022/storeCat2List.xml")
for $category in $catDoc//Category
let $prodDoc := doc("/public/grp3_2022/storeProductList.xml")
for $product in $prodDoc//product
where $category/CategoryName= $product/@CategoryName 
and $category/@categoryId= 'C001'
return $product/ProductName/text()
/

-- 4. List all products from Walmart Canada that are above $5.

xquery
let $p := doc("/public/grp3_2022/storeProductList.xml")  
for $m in $p/ProductInfoByStore/storelist/product
where $m/Price > "5.00"
return $m
/


--5. Display the orderIds from Freshco.

xquery
let $o := doc("/public/grp3_2022/orderList.xml") 
for $i in $o/OrderHistory/Order
where $i/Store/@storeName = 'FreshCo'
return $i/@orderId
/


-- 6. Find all the products ordered by “Joe will”.

xquery
let $o := doc("/public/grp3_2022/orderList.xml")
for $l in $o/OrderHistory/Order
let $ol := doc("/public/grp3_2022/orderItemList.xml")
for $i in $ol/OrderItemInfoByOrder/order
where $l/@orderId = $i/@OrderID and $l/Customer/@CustomerName = "Joe Will"
return <OrderItemsList>
<OrderId>{$l/@orderId}</OrderId>
{$i/OrderItem}
</OrderItemsList>
/



-- 7. Find all orderitems which quantity ordered is greater than 5.

   xquery
   let $c:=doc("/public/grp3_2022/orderItemList.xml")
   for $d in $c//OrderItem
   where $d/QtyOrdered > '5'
   return $d
   /
 
-- 8. Display all the catalog names from Freshco.

   xquery
   let $c:=doc("/public/grp3_2022/storeCat2List.xml")
   for $d in $c//Store
   where $d/StoreName = 'FreshCo'
   return $d/Catalog/CatalogName/text()
   /
 
-- 9. Find the orderItems with unitPrice less than 6.5 and stock greater than 100.

   xquery
   let $c:=doc("/public/grp3_2022/orderItemList.xml")
   for $d in $c//OrderItem
   let $m:=doc("/public/grp3_2022/storeProductList.xml")
   for $n in $m//product
   where $d/ProdId = $n/@ProductId
       and $n/Price < '6.5'
       and $n/Quantity > 100
   order by $d/@OrderItemID
   return $d/@OrderItemID
   /


-- 10. Find all the category names from catalog "Cat01".

xquery
let $catDoc := doc("/public/grp3_2022/storeCat2List.xml")
for $category in $catDoc/StoreList/Store/Catalog
where $category/@catalogId= "Cat01"
return $category/Category/CategoryName/text()
/

-- 11. Find the address of customers who ordered from Loblaws.

xquery
let $c:=doc("/public/grp3_2022/orderList.xml") 
for $d in $c/OrderHistory/Order
where $d/Store/@storeName = "Loblaw Companies Limited"
return $d/Customer/CustomerAddress/text()
/


-- 12. Find the drivers who have delivered from stores that sell salmon.

xquery
let $sp := doc("/public/grp3_2022/storeProductList.xml")
for $p in $sp/ProductInfoByStore/storelist
let $o := doc("/public/grp3_2022/orderList.xml")
for $l in $o/OrderHistory/Order
where $l/Store/@storeName = $p/@NAME and $p/product/ProductName = "salmon"
return $l/Driver/@DriverName
/

