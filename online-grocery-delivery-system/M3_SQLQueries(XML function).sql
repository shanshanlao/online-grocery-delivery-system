-- 1. List all products from each store, and sort them by price.
select xmlroot (
        xmlelement("ProductInfoByStore", 
	        xmlagg(xmlelement("storelist", 
	                xmlattributes(p.CATEGORYOID.CATALOGOID.STOREOID.NAME),
	                xmlagg(xmlelement("product", 
                            xmlattributes(
                                p.PRODUCTID as "ProductId", 
                                p.CATEGORYOID.CATEGORYNAME as "CategoryName", 
                                p.CATEGORYOID.CATALOGOID.CATNAME as "CatalogName"), 
                            xmlelement("ProductName", p.NAME),
                            xmlelement("Price", p.PRICE),
                            xmlelement("Quantity", p.QUANTITY),
                            xmlelement("Description", p.DESCRIPTION)
                        ) order by p.PRICE )))
        ), version '1.0', standalone yes) 
  from product p 
  group by p.CATEGORYOID.CATALOGOID.STOREOID.NAME;

-- 2. List all drivers who delivered orders to each store, display their information and computed salaries.
select xmlroot(
	    xmlelement("DriverDeliveryToStore",
	        xmlagg(xmlelement("store", xmlattributes(o.STOREOID.ACCOUNTID as "StoreId"),
	            xmlagg(xmlelement(
                        "driver", xmlattributes(o.DRIVEROID.ACCOUNTID as "sn"), 
                        xmlforest(
                            o.DRIVEROID.DPERSON.FULLNAME() as "DriverName", 
                            o.DRIVEROID.HOURLYRATE as "HourlyPayRate", 
                            o.DRIVEROID.HOURSWORKED as "HoursWorked", 
                            o.DRIVEROID.EMAIL as "Email", 
                            o.DRIVEROID.ADDRESS as "Address", 
                            o.DRIVEROID.CALCSALARY() as "SalaryCalculated")
              ))
          ))
      ),version '1.0', standalone yes) 
from Orders o 
where o.DRIVEROID IS NOT NULL 
group by o.STOREOID.ACCOUNTID;
 
-- 3. Display each order item from each order.
select xmlroot (
        xmlelement("OrderItemInfoByOrder",
            xmlagg(xmlelement("order",
                    xmlattributes(oi.ORDEROID.ORDERID  as "OrderID"),
                    xmlagg(xmlelement("OrderItem", 
                            xmlattributes(oi.ORDERITEMID  as "OrderItemID"),
                            xmlforest(
                                oi.ORDEROID.ORDERID as "OrderID", 
                                oi.PRODUCTOID.PRODUCTID as "ProdId", 
                                oi.PRODUCTOID.NAME, 
                                oi.QUANTITY as "QtyOrdered")
                    )))
        )),version '1.0', standalone yes) 
from ORDER_ITEM oi 
group by oi.ORDEROID.ORDERID;

-- 4. Display each stores’ catalogs and their categories.
select XMLROOT( 
  XMLElement(
    "StoreList",
    XMLAgg( XMLElement("Store",
      xmlattributes(s.accountId as "storeId"),
      xmlelement("StoreName", s.name),
      (select 
        XMLAgg(
          XMLElement("Catalog",
            xmlattributes(c.catalogId AS "catalogId"),
            xmlelement("CatalogName", c.catname),
            (select XMLAgg(XMLElement("Category",
              xmlattributes(cat.categoryId AS "categoryId"),
              xmlelement("CategoryName", cat.categoryName)
            )) from Category cat where cat.catalogOid.catalogId = c.catalogId
            ) 
        ) 
      ) from Catalogs c where treat(c.storeOid as ref stores_t).accountId = s.accountId
    ))) 
  ),version '1.0',standalone yes) 
from Store s;

-- 5. Find the list of orders made to each store and list the order id, customer name and driver.
select DISTINCT XMLRoot(
  XMLElement("OrderHistory",
    XMLAgg(
      XMLElement("Order", xmlattributes(o.orderId AS "orderId"),
        XMLElement("Store", 
          xmlattributes(
            treat(o.storeOid AS REF stores_t).accountId AS "storeId",
            o.storeOid.name AS "storeName"
          ),
          XMLElement("StoreAddress", treat(o.storeOid AS REF stores_t).address)
        ),
        XMLElement("Customer", 
          xmlattributes(
            treat(o.customerOid AS REF customers_t).accountId AS "customerID",
            o.customerOid.cPerson.fullname() AS "CustomerName"
          ),
          XMLElement("CustomerAddress", treat(o.customerOid AS REF customers_t).address)
        ),
        XMLElement("Driver",
          xmlattributes(
            treat(o.driverOid AS REF driver_t).accountId AS "driverId",
            o.driverOid.dPerson.fullname() AS "DriverName"
        ))
  ))), version '1.0', standalone yes
) from orders o;

-- 6. Print out all the products that are expired along with customers who purchased them and the stores they belong to.
select XMLROOT(
   XMLElement("ExpiredProductsList",
    XMLAgg(
      XMLElement("ExpireProduct", xmlattributes(oi.productOid.productId AS "productId"),
        XMLForest(
          oi.productOid.name AS "ProductName",
          oi.productOid.quantity AS "ProductQuantity",
          oi.productOid.bestBefore AS "ProductDate",
          oi.productOid.stockStatus() AS "ProductStockStatus"),
          XMLElement("Store", 
            XMLElement("StoreId", treat(oi.productOid.categoryOid.catalogOid.storeOid AS REF stores_t).accountid),
            XMLElement("StoreName", oi.productOid.categoryOid.catalogOid.storeOid.name)
          ),
          XMLElement("Customer", 
            XMLElement("CustomerId", treat(oi.orderOid.customerOid AS REF customers_t).accountid),
            XMLElement("CustomerName",oi.orderOid.customerOid.cPerson.fullname())
          )
    ))
  ),version '1.0',standalone yes) 
from order_item oi
where oi.productOid.checkExpiration() = 'yes';



-- 7. List all stores' details and sort by their order count. 
    select xmlroot(
            xmlelement("StoreListWithOrderCount",
                xmlagg(
                    xmlelement(
                        "store",
                        xmlattributes(o.storeOid.accountID AS "storeID"),
                        xmlforest(
                            o.storeOid.name as "name",
                            o.storeOid.address as "address",
                            o.storeOid.openStatus as "openstatus"
                        ),
                        xmlelement("orderCount", COUNT(*))
                    ) order by COUNT(*) desc
                )            
          ), version '1.0', standalone yes)
    from Orders o
    group by o.storeOid;              

-- 8. List the average delivery time for all drivers in ascending order. 
    select xmlroot(
            xmlelement("DriverDeliveryTimeList",
                xmlagg(
                    xmlelement(
                        "driver",
                        xmlattributes(o.driverOid.accountId as "driverID"),
                        xmlelement("driverName", o.driverOid.dPerson.fullname()),
                        xmlelement("avgDelivery",ROUND(AVG(o.deliveryDuration()),2))
                    )  order by AVG(o.deliveryDuration())
                )           
            ),version '1.0' ,standalone yes )
    from orders o 
    where o.deliveryStatus = 'delivered' 
    group by o.driverOid;

-- 9. List the total amount of products each category has.  
    select xmlroot(xmlelement("CategoryProductList",
            xmlagg(
                xmlelement(
                    "category",
                    xmlattributes(p.categoryOid.categoryID as "categoryID"),
                    xmlelement("categoryName", p.categoryOid.categoryName),
                    xmlelement("productCount", COUNT(*)),
                    xmlagg(xmlelement("product",
                            xmlattributes(p.productID as "productID"),
                            xmlforest(name, brand, price)                     
                    ))
                )
            )) ,version '1.0' ,standalone yes)
    from product p
    group by p.categoryOid;

-- 10. For orders which have not been delivered, display their customers and respective stores.
  select xmlroot(
          xmlelement("orderList", 
              xmlagg(xmlelement("order",xmlattributes(o.orderId),
                      xmlelement("dateCreated", o.dateCreated),
                      xmlelement("customerName", o.customerOid.cPerson.firstName),
                      xmlelement("deliveryDate", o.deliveryDate),
                      xmlelement("storeName", o.storeOid.name),
                      xmlelement("deliveryStatus", o.deliveryStatus)
          ))), version '1.0',standalone yes)
  from Orders o
  where o.deliveryStatus != 'delivered';

-- 11. Find the stock status for all products belonging to each store. 

  select xmlroot(xmlelement("StoreList",
              xmlagg(xmlelement("store",
                  xmlattributes(s.name AS "storeName"),
                  (select
                      xmlagg(xmlelement(
                              "product",
                              xmlattributes(p.productID AS "productID"),
                              xmlforest(
                                  p.name as "pName", 
                                  p.quantity as "quantity",
                                  p.stockStatus() as "stockStatus"
                              )
                      ))
                  from product p
                  where p.categoryOid.catalogOid.storeOid.accountID = s.accountID
              ))                        
          )) ,version '1.0',standalone yes)
    FROM store s;

-- 12. Find all items that have not been ordered from each store.
    select xmlroot(xmlelement("itemsNotOrdered",
            xmlagg(xmlelement("store",
                xmlattributes(s.accountID as "storeID"),
                xmlelement("storeName", s.name),
                (select
                    xmlagg(xmlelement("product",
                            xmlattributes(productID),
                            xmlforest(name, brand, price) 
                    ))
                  from product p
                    where p.categoryOid.catalogOid.storeOid.accountID = s.accountID
                    and p.productID not in (
                                select oi.productOid.productID as productID
                                from order_item oi
                    )
                )
          ))),version '1.0' ,standalone yes)
    from store s;





