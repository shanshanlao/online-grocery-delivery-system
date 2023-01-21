SET ECHO ON
DROP TABLE Order_item;
DROP TABLE Product;
DROP TABLE Category;
DROP TABLE Catalogs;
DROP TABLE Orders;
DROP TABLE Store;
DROP TABLE Driver;
DROP TABLE Customer;
DROP TYPE orderItem_t;
DROP TYPE products_t;
DROP TYPE orders_t;
DROP TYPE category_t;
DROP TYPE catalog_t;
DROP TYPE stores_t;
DROP TYPE driver_t;
DROP TYPE customers_t;
DROP TYPE person_literal;
DROP TYPE user_t;

---- ---- Create OBJECTS ---- ---- 
CREATE TYPE user_t AS OBJECT (accountID CHAR(9), 
                              username VARCHAR2(20), 
                              password VARCHAR2(20), 
                              address VARCHAR2(50), 
                              phone CHAR(14), 
                              email VARCHAR2(30), 
                              dateOfRegistration DATE, 
                              FINAL MEMBER FUNCTION calcLoyaltyDays RETURN INTEGER,
                              NOT INSTANTIABLE MEMBER FUNCTION printPersonalInfo RETURN VARCHAR2) NOT INSTANTIABLE NOT FINAL; 
/

CREATE TYPE BODY user_t AS
  FINAL MEMBER FUNCTION calcLoyaltyDays RETURN INTEGER IS
    BEGIN
      RETURN sysdate - self.dateOfRegistration;
    END;
END;
/

CREATE TYPE person_literal AS OBJECT (firstName VARCHAR2(20),
                                      lastName VARCHAR2(20),
                                      dateOfBirth DATE,
                                      MEMBER FUNCTION fullname RETURN VARCHAR2,
                                      MEMBER FUNCTION calcAge RETURN INTEGER);
/

CREATE TYPE BODY person_literal AS 
MEMBER FUNCTION fullname RETURN VARCHAR2 IS
	BEGIN
		RETURN self.firstName||' '||self.lastName;
	END;
MEMBER FUNCTION calcAge RETURN INTEGER IS
	BEGIN
		RETURN (sysdate - self.dateOfBirth)/365;
	END;
END;
/

CREATE TYPE customers_t UNDER user_t (cPerson person_literal,
					creditCard VARCHAR2(20),
                                    	OVERRIDING MEMBER FUNCTION printPersonalInfo RETURN VARCHAR2);
/

CREATE TYPE BODY customers_t AS
  OVERRIDING MEMBER FUNCTION printPersonalInfo RETURN VARCHAR2 IS
    BEGIN
      RETURN 'Name: '||self.cPerson.fullname()||' | Phone: '||self.phone||' | Address: '||self.address;
    END;
END;
/

CREATE TYPE driver_t UNDER user_t (dPerson person_literal,
                                  hourlyRate NUMBER(4,2),
                                  hoursWorked NUMBER(6),
                                  workPermit CHAR(5),
                                  driverLicense CHAR(17),
                                  licensePlate CHAR(8),
                                  OVERRIDING MEMBER FUNCTION printPersonalInfo RETURN VARCHAR2, 
                                  MEMBER FUNCTION calcSalary RETURN NUMBER);
/

CREATE TYPE BODY driver_t AS
  OVERRIDING MEMBER FUNCTION printPersonalInfo RETURN VARCHAR2 IS
    BEGIN
      RETURN 'Name: '||self.dPerson.fullname()||' | Phone: '||self.phone||' | License Plate: '||self.licensePlate;
    END;

  MEMBER FUNCTION calcSalary RETURN NUMBER IS
    BEGIN
      RETURN self.hourlyRate * self.hoursWorked;
    End;
End;
/

CREATE TYPE stores_t UNDER user_t (name VARCHAR2(50), 
				  openStatus VARCHAR(6),
                                  OVERRIDING MEMBER FUNCTION printPersonalInfo RETURN VARCHAR2);
/

CREATE TYPE BODY stores_t AS
  OVERRIDING MEMBER FUNCTION printPersonalInfo RETURN VARCHAR2 IS
    BEGIN
      RETURN 'Name: '||self.name||' | Phone: '||self.phone||' | Address: '||self.address||' | Status: '||self.openStatus;
    END;
END;
/

CREATE TYPE catalog_t AS OBJECT (catalogId CHAR(5),
                                  storeOid REF stores_t,
                                  catname VARCHAR2(40));
/

CREATE TYPE category_t AS OBJECT (categoryId CHAR(4),
                                  catalogOid REF catalog_t,
                                  categoryName VARCHAR2(30));
/

CREATE OR REPLACE TYPE orders_t AS OBJECT (orderId CHAR(9),
                              dateCreated DATE, 
                              customerOid REF customers_t,
                              totalPrice NUMBER(6,2),
                              driverOid REF driver_t,
                              storeOid REF stores_t,
                              pickUpTime TIMESTAMP,
                              deliveryStatus VARCHAR(20), 
                              deliveryTime TIMESTAMP,
                              deliveryDate DATE,
                              MAP MEMBER FUNCTION sortOrderByDate RETURN DATE,
                              MEMBER FUNCTION deliveryDuration RETURN NUMBER);
/

CREATE OR REPLACE TYPE BODY orders_t AS 
  MAP MEMBER FUNCTION sortOrderByDate RETURN DATE IS
    BEGIN
      RETURN self.deliveryDate;
    END;

  MEMBER FUNCTION deliveryDuration RETURN NUMBER IS
    BEGIN
        IF(self.deliveryTime IS NULL OR self.pickUpTime IS NULL) THEN
            RETURN 0;
        ELSE
          RETURN round((extract(hour from self.deliveryTime - self.pickUpTime) * 60 
                      + extract(minute from self.deliveryTime - self.pickUpTime) 
                      + extract(second from self.deliveryTime - self.pickUpTime) / 60), 2);
	END IF;
    END;
END;
/
    
  
CREATE TYPE products_t AS OBJECT (productId CHAR(9),
                                categoryOid REF category_t,
                                price NUMBER(4,2),
                                name VARCHAR2(30),
			        brand VARCHAR2(20),
                                quantity NUMBER(4),
                                description VARCHAR2(100),
                                bestBefore DATE,
                                MEMBER PROCEDURE apply_discount (percent IN NUMBER),
                                MEMBER FUNCTION stockStatus RETURN VARCHAR2,
                                MEMBER FUNCTION checkExpiration RETURN VARCHAR2,
                                ORDER MEMBER FUNCTION sortProductsByPrice (product products_t) RETURN INTEGER);
/

CREATE TYPE BODY products_t AS
  MEMBER PROCEDURE apply_discount (percent IN NUMBER) IS
    BEGIN
      self.price := self.price - (self.price * percent);
    END;

  MEMBER FUNCTION stockStatus RETURN VARCHAR2 IS
    result VARCHAR2(6) := ''; 
    BEGIN

      if self.quantity < 50 then
        result := 'low';
      elsif self.quantity >= 50 AND self.quantity <= 100 then
        result := 'medium';
      else 
        result := 'high';
      end if;

      RETURN result;
    END;

  MEMBER FUNCTION checkExpiration RETURN VARCHAR2 IS
    isExpired VARCHAR2(3) := 'no';
    BEGIN 
      if sysdate > self.bestBefore then
        isExpired := 'yes';
      END IF;

      RETURN isExpired; 
    END;

  ORDER MEMBER FUNCTION sortProductsByPrice (product IN products_t) RETURN INTEGER IS
    result INTEGER := 0;
    BEGIN 
      if self.price > product.price then
        result := 1;
      elsif self.price < product.price then
        result := -1;
      end if; 

    RETURN result;
    END;
END;
/


CREATE TYPE orderItem_t AS OBJECT (orderItemId CHAR(12),
                                  orderOid REF orders_t,
                                  productOid REF products_t,
                                  quantity NUMBER,
                                  MEMBER FUNCTION calcPrice(price IN NUMBER) RETURN NUMBER); 
/

CREATE TYPE BODY orderItem_t AS 
  MEMBER FUNCTION calcPrice(price IN NUMBER) RETURN NUMBER IS
    BEGIN
      RETURN self.quantity * price;
    END;
END;
/


---- ---- Create TABLES ---- ----
CREATE TABLE Customer OF customers_t (accountID PRIMARY KEY);
CREATE TABLE Driver OF driver_t (accountID PRIMARY KEY);
CREATE TABLE Store OF stores_t (accountID PRIMARY KEY);
CREATE TABLE Orders OF orders_t (orderId PRIMARY KEY);
CREATE TABLE Catalogs OF catalog_t (catalogId PRIMARY KEY);
CREATE TABLE Category OF category_t (categoryId PRIMARY KEY);
CREATE TABLE Product OF products_t (productId PRIMARY KEY);
CREATE TABLE Order_item OF orderItem_t (orderItemId PRIMARY KEY);
