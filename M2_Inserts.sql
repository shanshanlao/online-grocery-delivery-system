SET ECHO ON
--Customer Table

insert into Customer values( customers_t('CU0000000', 'joe22', 'j142', '5 Capilano Street ON M4V M5R', '250 555 0199', 'joe@gmail.com', '02-Dec-20', person_literal('Joe', 'Will', '12-Apr-72'), '7253 3256 7695 1245'));

insert into Customer values( customers_t('CU0000001', 'grace22', 'Will', '24 Bluffers Street ON J4V S5R', '645 111 0199', 'grace@gmail.com', '11-Jun-18', person_literal('Grace', 'Brown', '12-Apr-82'), '5332 3256 1245 6677'));

insert into Customer values( customers_t('CU0000002', 'Lily22', 'lil122', '347 Bellcrest Drive ON V4V R5R', '427 555 0199', 'lily@gmail.com', '07-Jan-22', person_literal('Lily', 'Gracia', '31-May-93'), '7253 0001 7695 4002'));

insert into Customer values( customers_t('CU0000003', 'james22', 'jame125s', '11 Forest Hill ON C4V B5R', '772 555 9921', 'miller@gmail.com', '02-Dec-20', person_literal('James', 'Miller', '17-Feb-00'), '7253 3256 0001 1200'));

insert into Customer values( customers_t('CU0000004', 'anastasia_1971', 'iiW0eeth', '3211 Frank Avenue ON L2V 3E2', '413 230 2317', 'melany_marv@yahoo.com', '12-Dec-21', person_literal('Kevin', 'Mitchell', '17-Feb-95'), '4929370154753377'));

insert into Customer values( customers_t('CU0000005', 'Whispored', 'rooLiey2huag', '319 Haaglund Rd Winfield, BC V0H 2C0', '250 766 6421', 'BeatriceBBurks@gmail.com', '25-Jan-15', person_literal('Beatrice', 'Burks', '24-Jun-79'), '5267 2425 6488 3374'));

insert into Customer values( customers_t('CU0000006', 'Majesigh', 'Hi9shailai4', '427 Goyeau Ave Windsor, ON N9A 1H9', '519 919 3975', 'RonaldMFarthing@gmail.com', '23-Jul-17', person_literal('Ronald', 'Farthing', '29-Jun-68'), '4532 0109 7219 0167'));

insert into Customer values( customers_t('CU0000007', 'sand33', 'pswpsw33', '5 Capilano Street ON M4V M5R', '647 555 0199', 'sand@gmail.com', '02-Dec-21', person_literal('Sandra', 'Will', '12-Dec-82'), '7253 3256 3245 3431'));


-- Driver
insert into Driver values( driver_t('D00000000', 'hugh22', 'hugh125s', '11 Forest Hill ON C4V B5R', '772 555 9921', 'grant@gmail.com', '02-Dec-20', person_literal('Hugh', 'Grant', '17-Feb-99'),'25.5', '40', 'W1234', 'B1234-54675-43543', 'ABD-001'));

insert into Driver values( driver_t('D00000001', 'mike2', 'm125s', '141 Bellcrest Drive ON V4V R5R', '702 555 9921', 'mike@icloud.com', '02-Oct-16', person_literal('Mike', 'Henderson', '07-Feb-70'),'20.5', '30', 'W1246', 'A1243-45653-67656', 'CGD-011'));

insert into Driver values( driver_t('D00000002', 'pete2', 'pt125s', '10 Mountain Drive ON V4V B5R', '372 505 9921', 'peter@outlook.com', '02-May-19', person_literal('Peter', 'Karev', '11-Feb-65'),'25.5', '40', 'W1334', 'D5012-32453-23423', 'LJV-001'));

insert into Driver values( driver_t('D00000003', 'cris2', 'c125s', '10 Raindrop ON T4V G5R', '412 555 9924', 'christen@outlook.com', '14-Oct-20', person_literal('Christen', 'Robert', '17-May-80'),'30.5', '40', 'W1004', 'D5212-23453-12342', 'GN4-001'));

insert into Driver values( driver_t('D00000004', 'Awasine49', 'ethee6nuQu9', '1966 Bloor Street Galahad, AB T0B 1R0', '780 583 8188', 'BrianJSmith@gmail.com', '15-Oct-19', person_literal('Brian ', 'Smith', '17-Mar-89'),'27.5', '40', 'W1002', 'D5215-12312-32313', 'LG4-012'));

--Store

insert into Store values( stores_t('S00000001', 'walmartca', 'wal13s', '1000 Gerrard St E, Toronto, ON, M4M 3G6', '416 461 8778', 'cacustrel@wal-mart.com', '02-Jan-18', 'Walmart Canada', 'open'));

insert into Store values( stores_t('S00000002', 'freshco12', 'frsh13s', '559 Sherbourne St, M4X 1W6 Toronto', '416 925 4851', 'info@freshco.ca', '24-Mar-15', 'FreshCo', 'open'));

insert into Store values( stores_t('S00000003', 'loblaw111', 'llaw13s', '5010 Glen Erin Dr, Mississauga, ON L5M 6J3', '(905) 607 0580', 'customerservice@loblaws.ca', '25-Jun-17', 'Loblaw Companies Limited', 'closed'));

insert into Store values( stores_t('S00000004', 'noFrills1', 'noFriller2', '295 Queen St E, Brampton, ON L6W 3R1', '866 987 6453', 'support@nofrills.ca', '24-Oct-18', 'No Frills', 'open'));




-- Catalog

insert into Catalogs values( catalog_t('Cat01', (select ref(s) from Store s where s.accountID='S00000001'), 'Drinks'));

insert into Catalogs values( catalog_t('Cat02', (select ref(s) from Store s where s.accountID='S00000001'), 'Food'));

insert into Catalogs values( catalog_t('Cat03', (select ref(s) from Store s where s.accountID='S00000002'), 'Seafood'));

insert into Catalogs values( catalog_t('Cat04', (select ref(s) from Store s where s.accountID='S00000003'), 'Seasoning and Spices'));

insert into Catalogs values( catalog_t('Cat05', (select ref(s) from Store s where s.accountID='S00000004'), 'Cereals'));

insert into Catalogs values( catalog_t('Cat06', (select ref(s) from Store s where s.accountID='S00000002'), 'Sugars and Sweeteners'));

insert into Catalogs values( catalog_t('Cat07', (select ref(s) from Store s where s.accountID='S00000003'), 'Nuts and Seeds'));

insert into Catalogs values( catalog_t('Cat08', (select ref(s) from Store s where s.accountID='S00000001'), 'Vegetables'));

insert into Catalogs values( catalog_t('Cat09', (select ref(s) from Store s where s.accountID='S00000004'), 'Fruits'));

insert into Catalogs values( catalog_t('Cat10', (select ref(s) from Store s where s.accountID='S00000002'), 'Meats'));



-- Category

insert into Category values(category_t('C001', (select ref(c) from Catalogs c where c.catalogId='Cat01'), 'Dairy'));

insert into Category values(category_t('C002', (select ref(c) from Catalogs c where c.catalogId='Cat02'), 'Snacks'));

insert into Category values(category_t('C003', (select ref(c) from Catalogs c where c.catalogId='Cat08'), 'Raw Vegetables'));

insert into Category values(category_t('C004', (select ref(c) from Catalogs c where c.catalogId='Cat03'), 'Raw Fish'));

insert into Category values(category_t('C005', (select ref(c) from Catalogs c where c.catalogId='Cat09'), 'Jam'));

insert into Category values(category_t('C006', (select ref(c) from Catalogs c where c.catalogId='Cat05'), 'Whole Grain'));

insert into Category values(category_t('C007', (select ref(c) from Catalogs c where c.catalogId='Cat05'), 'Flavoured'));

insert into Category values(category_t('C008', (select ref(c) from Catalogs c where c.catalogId='Cat06'), 'Cube sugars'));

insert into Category values(category_t('C009', (select ref(c) from Catalogs c where c.catalogId='Cat10'), 'Chicken'));

insert into Category values(category_t('C010', (select ref(c) from Catalogs c where c.catalogId='Cat10'), 'Chuck, Lean and Raw'));

insert into Category values(category_t('C011', (select ref(c) from Catalogs c where c.catalogId='Cat01'), 'Juice'));

insert into Category values(category_t('C012', (select ref(c) from Catalogs c where c.catalogId='Cat01'), 'Soda'));

insert into Category values(category_t('C013', (select ref(c) from Catalogs c where c.catalogId='Cat07'), 'Dried'));

insert into Category values(category_t('C014', (select ref(c) from Catalogs c where c.catalogId='Cat07'), 'Salted'));

insert into Category values(category_t('C015', (select ref(c) from Catalogs c where c.catalogId='Cat04'), 'Grounded'));

insert into Category values(category_t('C016', (select ref(c) from Catalogs c where c.catalogId='Cat04'), 'Powder'));


-- Product

insert into Product values (products_t('P00000001', (select ref(c) from Category c where c.categoryId='C001'), '10.99', 'ice cream', 'Chapman', '100', 'chapmans chocolate ice cream', '10-Apr-22'));

insert into Product values (products_t('P00000002', (select ref(c) from Category c where c.categoryId='C001'), '6.99', 'milk', 'FairLife', '300', 'Sealtest 3.25% 4L Milk', '10-Mar-22'));

insert into Product values (products_t('P00000003', (select ref(c) from Category c where c.categoryId='C002'), '3.99', 'popcorn', 'No Name', '20', 'SkinnyPop Original Popcorn', '10-Dec-21'));

insert into Product values (products_t('P00000004', (select ref(c) from Category c where c.categoryId='C003'), '2.5', 'cucumber', 'Sunset', '60', 'large cucumber', '10-May-22'));

insert into Product values (products_t('P00000005', (select ref(c) from Category c where c.categoryId='C003'), '2.97', 'tomatoes', 'First Field', '50', 'Boxed Grape tomato', '09-Apr-22'));

insert into Product values (products_t('P00000006', (select ref(c) from Category c where c.categoryId='C004'), '5.99', 'salmon', 'Patagonia', '200', 'Piece of raw salmon', '23-Jun-22'));

insert into Product values (products_t('P00000007', (select ref(c) from Category c where c.categoryId='C012'), '6.27', 'cola', 'Coca-Cola', '500', 'Coca-Cola 355mL Cans, 12 Pack', '23-Jun-22'));

insert into Product values (products_t('P00000008', (select ref(c) from Category c where c.categoryId='C001'), '4.96', 'yogurt', 'Greek', '100', 'Activia Probiotic Yogurt, 12 Pack', '23-Mar-22'));

insert into Product values (products_t('P00000009', (select ref(c) from Category c where c.categoryId='C011'), '2.97', 'nestea lemon', 'Nestea', '150', 'NESTEA Lemon 200mL Tetra Carton, 10 Pack', '23-Mar-22'));

insert into Product values (products_t('P00000010', (select ref(c) from Category c where c.categoryId='C015'), '0.9', 'Basil', 'No Name', '100', 'Teaspoon of grounded Basil', '12-Jun-23'));

insert into Product values (products_t('P00000011', (select ref(c) from Category c where c.categoryId='C016'), '1', 'Mustard', 'Simply Organic', '100', '1g of powered mustard', '12-Sep-22'));

insert into Product values (products_t('P00000012', (select ref(c) from Category c where c.categoryId='C013'), '1', 'Almond', 'Barney', '50', '100g of salted almonds', '19-Jan-23'));

insert into Product values (products_t('P00000013', (select ref(c) from Category c where c.categoryId='C012'), '6.26', 'pepsi', 'Pepsi', '100', 'Pepsi 355mL Cans, 12 Pack', '23-Jun-23'));

insert into Product values (products_t('P00000014', (select ref(c) from Category c where c.categoryId='C009'), '5', 'chicken nuggets', 'Perdue', '200', '30 piece chicken nugget pack', '12-Jun-24'));

insert into Product values (products_t('P00000015', (select ref(c) from Category c where c.categoryId='C008'), '4', 'Reprocessed sugar', 'Njoy', '250', '100g of Reprocessed sugar', '12-Mar-23'));

insert into Product values (products_t('P00000016', (select ref(c) from Category c where c.categoryId='C010'), '10', 'Beef', 'Sampco', '100', '500g of Beef', '24-Oct-23'));

insert into Product values (products_t('P00000017', (select ref(c) from Category c where c.categoryId='C005'), '6.99', 'Strawberry', 'Smuckers', '100', '250g of Strawberry Jam', '22-Oct-25'));

insert into Product values (products_t('P00000018', (select ref(c) from Category c where c.categoryId='C006'), '5.99', 'Amaranth', 'No Name', '100', 'Small round wheat grains high in fibre', '22-Apr-23'));

insert into Product values (products_t('P00000019', (select ref(c) from Category c where c.categoryId='C007'), '7.99', 'Fruit Loops', 'Kelloggs', '100', 'Small and colour flavoured cereal', '22-Jul-24'));

-- Order
insert into Orders values (orders_t('O00000001', '03-Jan-22', (select ref(c) from Customer c where c.accountID='CU0000000'), '52.52', (select ref(d) from Driver d where d.accountID='D00000000'), (select ref(s) from Store s where s.accountID='S00000002'), '07-Jan-22 10:00', 'delivered', '07-Jan-22 10:30', '07-Jan-22'));

insert into Orders values (orders_t('O00000002', '15-Feb-22', (select ref(c) from Customer c where c.accountID='CU0000001'), '25.64', (select ref(d) from Driver d where d.accountID='D00000000'), (select ref(s) from Store s where s.accountID='S00000001'), '17-Feb-22 02:30', 'delivered', '17-Feb-22 03:40', '17-Feb-22'));

insert into Orders values (orders_t('O00000003', '23-Feb-22', (select ref(c) from Customer c where c.accountID='CU0000002'), '76.52', (select ref(d) from Driver d where d.accountID='D00000001'), (select ref(s) from Store s where s.accountID='S00000001'), '09-Mar-22 05:00', 'on the way', '', '09-Mar-22'));

insert into Orders values (orders_t('O00000004', '02-Mar-22', (select ref(c) from Customer c where c.accountID='CU0000003'), '254.53', Null, (select ref(s) from Store s where s.accountID='S00000003'), '', 'packed', '', '10-Mar-22'));

insert into Orders values (orders_t('O00000005', '15-Mar-22', (select ref(c) from Customer c where c.accountID='CU0000000'), '123.6', Null, (select ref(s) from Store s where s.accountID='S00000003'), '', 'packed', '', '20-Mar-22'));

insert into Orders values (orders_t('O00000006', '02-Dec-21', (select ref(c) from Customer c where c.accountID='CU0000003'), '66.6', (select ref(d) from Driver d where d.accountID='D00000002'), (select ref(s) from Store s where s.accountID='S00000002'), '02-Dec-21 04:00', 'delivered', '02-Dec-21 04:40', '02-Dec-21'));

insert into Orders values (orders_t('O00000007', '02-Jan-22', (select ref(c) from Customer c where c.accountID='CU0000002'), '56.75', (select ref(d) from Driver d where d.accountID='D00000000'), (select ref(s) from Store s where s.accountID='S00000003'), '22-Jan-22 11:00', 'delivered', '22-Jan-22 11:30', '22-Jan-22'));

insert into Orders values (orders_t('O00000008', '02-Feb-22', (select ref(c) from Customer c where c.accountID='CU0000007'), '73.52', (select ref(d) from Driver d where d.accountID='D00000003'), (select ref(s) from Store s where s.accountID='S00000001'), '02-Feb-22 12:00', 'delivered', '02-Feb-22 12:30', '02-Feb-22'));


-- Order_item
INSERT INTO Order_item VALUES(orderItem_t('OI0000000001', (SELECT REF(o) FROM Orders o WHERE o.orderId='O00000003'), (SELECT REF(p) FROM Product p WHERE p.productId='P00000003'), 5));

INSERT INTO Order_item VALUES(orderItem_t('OI0000000002', (SELECT REF(o) FROM Orders o WHERE o.orderId='O00000002'), (SELECT REF(p) FROM Product p WHERE p.productId='P00000004'), 2));

INSERT INTO Order_item VALUES(orderItem_t('OI0000000003', (SELECT REF(o) FROM Orders o WHERE o.orderId='O00000002'), (SELECT REF(p) FROM Product p WHERE p.productId='P00000003'), 10));

INSERT INTO Order_item VALUES(orderItem_t('OI0000000004', (SELECT REF(o) FROM Orders o WHERE o.orderId='O00000002'), (SELECT REF(p) FROM Product p WHERE p.productId='P00000002'), 3));

INSERT INTO Order_item VALUES(orderItem_t('OI0000000005', (SELECT REF(o) FROM Orders o WHERE o.orderId='O00000004'), (SELECT REF(p) FROM Product p WHERE p.productId='P00000012'), 10));

INSERT INTO Order_item VALUES(orderItem_t('OI0000000006', (SELECT REF(o) FROM Orders o WHERE o.orderId='O00000005'), (SELECT REF(p) FROM Product p WHERE p.productId='P00000011'), 1));

INSERT INTO Order_item VALUES(orderItem_t('OI0000000007', (SELECT REF(o) FROM Orders o WHERE o.orderId='O00000008'), (SELECT REF(p) FROM Product p WHERE p.productId='P00000002'), 5));

INSERT INTO Order_item VALUES(orderItem_t('OI0000000008', (SELECT REF(o) FROM Orders o WHERE o.orderId='O00000008'), (SELECT REF(p) FROM Product p WHERE p.productId='P00000007'), 2));

INSERT INTO Order_item VALUES(orderItem_t('OI0000000009', (SELECT REF(o) FROM Orders o WHERE o.orderId='O00000001'), (SELECT REF(p) FROM Product p WHERE p.productId='P00000006'), 5));

INSERT INTO Order_item VALUES(orderItem_t('OI0000000010', (SELECT REF(o) FROM Orders o WHERE o.orderId='O00000001'), (SELECT REF(p) FROM Product p WHERE p.productId='P00000014'), 2));

INSERT INTO Order_item VALUES(orderItem_t('OI0000000011', (SELECT REF(o) FROM Orders o WHERE o.orderId='O00000005'), (SELECT REF(p) FROM Product p WHERE p.productId='P00000010'), 4));

INSERT INTO Order_item VALUES(orderItem_t('OI0000000012', (SELECT REF(o) FROM Orders o WHERE o.orderId='O00000003'), (SELECT REF(p) FROM Product p WHERE p.productId='P00000007'), 2));

INSERT INTO Order_item VALUES(orderItem_t('OI0000000013', (SELECT REF(o) FROM Orders o WHERE o.orderId='O00000005'), (SELECT REF(p) FROM Product p WHERE p.productId='P00000011'), 10));

INSERT INTO Order_item VALUES(orderItem_t('OI0000000014', (SELECT REF(o) FROM Orders o WHERE o.orderId='O00000006'), (SELECT REF(p) FROM Product p WHERE p.productId='P00000016'), 3));

INSERT INTO Order_item VALUES(orderItem_t('OI0000000015', (SELECT REF(o) FROM Orders o WHERE o.orderId='O00000004'), (SELECT REF(p) FROM Product p WHERE p.productId='P00000010'), 23));

INSERT INTO Order_item VALUES(orderItem_t('OI0000000016', (SELECT REF(o) FROM Orders o WHERE o.orderId='O00000003'), (SELECT REF(p) FROM Product p WHERE p.productId='P00000013'), 3));

INSERT INTO Order_item VALUES(orderItem_t('OI0000000017', (SELECT REF(o) FROM Orders o WHERE o.orderId='O00000008'), (SELECT REF(p) FROM Product p WHERE p.productId='P00000004'), 1));

INSERT INTO Order_item VALUES(orderItem_t('OI0000000018', (SELECT REF(o) FROM Orders o WHERE o.orderId='O00000004'), (SELECT REF(p) FROM Product p WHERE p.productId='P00000010'), 4));

INSERT INTO Order_item VALUES(orderItem_t('OI0000000019', (SELECT REF(o) FROM Orders o WHERE o.orderId='O00000008'), (SELECT REF(p) FROM Product p WHERE p.productId='P00000007'), 5));

INSERT INTO Order_item VALUES(orderItem_t('OI0000000020', (SELECT REF(o) FROM Orders o WHERE o.orderId='O00000007'), (SELECT REF(p) FROM Product p WHERE p.productId='P00000011'), 6));

INSERT INTO Order_item VALUES(orderItem_t('OI0000000021', (SELECT REF(o) FROM Orders o WHERE o.orderId='O00000001'), (SELECT REF(p) FROM Product p WHERE p.productId='P00000015'), 6));

INSERT INTO Order_item VALUES(orderItem_t('OI0000000022', (SELECT REF(o) FROM Orders o WHERE o.orderId='O00000007'), (SELECT REF(p) FROM Product p WHERE p.productId='P00000010'), 7));
