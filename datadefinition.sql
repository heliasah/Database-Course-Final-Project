create database dbtest;
use dbtest;

create table user (
    UserID varchar(50) NOT NULL PRIMARY KEY,
    Address varchar(1000),
    Name varchar(50),
    ContactNumber varchar(50),
    Email varchar(100)
);




create table userProfile (
    UserID varchar(50) NOT NULL PRIMARY KEY,
    Username varchar(20),
    Password varchar(20)

);

INSERT INTO userProfile (UserID, Username, Password)
VALUES ('047c9a62-21df-45f9-80db-4efd6dea110c', 'Marbo8', 'f#MFoK');

INSERT INTO userProfile (UserID, Username, Password)
VALUES ('35212f16-1121-488f-8cb1-66d61bfe8246', 'jones837H', '92jf@a');

INSERT INTO userProfile (UserID, Username, Password)
VALUES ('376b1d20-0993-4209-9cff-8013f24cb371', 'J0hnd', '871389');

INSERT INTO userProfile (UserID, Username, Password)
VALUES ('376b1d20-0993-4209-9cff-8013f24cb375', 'John2002DOE', '489KF');



create table admin (
    AdminID varchar(50) NOT NULL PRIMARY KEY,
    Email varchar(100)
);

ALTER TABLE admin RENAME COLUMN Email TO AdminEmail;

create table adminProfile (
    AdminID varchar(50) NOT NULL PRIMARY KEY,
    AdminUsername varchar(20),
    AdminPassword varchar(20)
);

INSERT INTO adminProfile (AdminID, AdminUsername, AdminPassword)
VALUES ('6746237', 'AntonioMor', 'jf8MFK#');

create table category (
    CategoryID int NOT NULL PRIMARY KEY,
    CategoryName varchar(50),
    CategoryDescription text(1000)
);

create table brand (
    BrandID int NOT NULL PRIMARY KEY,
    BrandName varchar(10)
);

create table product (
    ProductID varchar(50) NOT NULL PRIMARY KEY,
    ProductName varchar(1000),
    Description text(1000),
    Price DECIMAL(10, 2),
    StockQuantity boolean,
    BrandID int,
    CategoryID int,
    FOREIGN KEY (BrandID) REFERENCES brand(BrandID),
    FOREIGN KEY (CategoryID) REFERENCES category(CategoryID)
);



create table productCategory (
    ProductCategoryID int NOT NULL PRIMARY KEY,
    ProductID varchar(50),
    CategoryID int,
    FOREIGN KEY (ProductID) REFERENCES product(ProductID),
    FOREIGN KEY (CategoryID) REFERENCES category(CategoryID)
);

INSERT INTO productCategory (ProductCategoryID, ProductID, CategoryID)
VALUES (2000, 'f78bce4e-8cc2-47f9-9c07-5df968b7f5c5', 2);

create table orders(
    OrderID int NOT NULL PRIMARY KEY,
    Status varchar(20),
    TotalCost double(10,3),
    OrderDate DATETIME,
    UserID varchar(50),
    FOREIGN KEY (UserID) REFERENCES user(UserID)
);

INSERT INTO orders (OrderID, Status, TotalCost, OrderDate,UserID)
VALUES (549, 'Pending', 54.5, '2024-07-05 10:30:00', '35212f16-1121-488f-8cb1-66d61bfe8246');


create table orderDetail(
    OrderDetailID int NOT NULL PRIMARY KEY,
    OrderID int,
    FOREIGN KEY (OrderID) REFERENCES orders(OrderID)
);

INSERT INTO orderDetail (OrderDetailID, OrderID)
VALUES (90, 549);


create table orderDetailProducts(
    OrderDetailProductsID int NOT NULL PRIMARY KEY,
    OrderDetailID int,
    FOREIGN KEY (OrderDetailID) REFERENCES orderDetail(OrderDetailID)
);

INSERT INTO orderDetailProducts (OrderDetailProductsID, OrderDetailID)
VALUES (8, 90);


create table orderDetailInfo(
    OrderDetailProductsID int NOT NULL,
    OrderDetailID int NOT NULL,
    Quantity int,
    Price double,
    PRIMARY KEY (OrderDetailID,OrderDetailProductsID),
    FOREIGN KEY (OrderDetailID) REFERENCES orderDetail(OrderDetailID),
    FOREIGN KEY (OrderDetailProductsID) REFERENCES orderDetailProducts(OrderDetailProductsID)
);

INSERT INTO orderDetailInfo (OrderDetailProductsID, OrderDetailID, Quantity, Price)
VALUES (8, 90, 4, 100);

create table shippingInfo(
    ShippingID int NOT NULL PRIMARY KEY ,
    OrderID int,
    FOREIGN KEY (OrderID) REFERENCES orders(OrderID)
);

INSERT INTO shippingInfo (ShippingID, OrderID)
VALUES (783905, 549);

create table shipment(
    TrackingNumber int NOT NULL PRIMARY KEY ,
    ShippingDate date,
    DeliveryDate date,
    Carrier varchar(50),
    ShippingID int,
    FOREIGN KEY (ShippingID) REFERENCES shippingInfo(ShippingID)
);

INSERT INTO shipment (TrackingNumber, ShippingDate, DeliveryDate, Carrier, ShippingID)
VALUES (894908492, '2024-07-03', '2024-07-06', 'DHL', 783905 );

create table shoppingCart(
    ShoppingCartID int NOT NULL PRIMARY KEY,
    CartPrice double,
    UserID varchar(50),
    FOREIGN KEY (UserID) REFERENCES user(UserID)
);

INSERT INTO shoppingCart (ShoppingCartID, CartPrice, UserID)
VALUES ('7', '87.90', '047c9a62-21df-45f9-80db-4efd6dea110c');

create table cartItems(
    CartID int NOT NULL PRIMARY KEY,
    ShoppingCartID int NOT NULL,
    FOREIGN KEY (ShoppingCartID) REFERENCES shoppingCart(ShoppingCartID)
);

INSERT INTO cartItems (CartID, ShoppingCartID)
VALUES (8723, '7');

create table cartItemProducts(
    ProductID varchar(50),
    CartID int,
    FOREIGN KEY (ProductID) REFERENCES product(ProductID),
    FOREIGN KEY (CartID) REFERENCES cartItems(CartID)
);

INSERT INTO cartItemProducts (ProductID, CartID)
VALUES ('f78bce4e-8cc2-47f9-9c07-5df968b7f5c5', 8723);

create table purchaseHistory(
    PurchaseID int NOT NULL PRIMARY KEY,
    UserID varchar(50),
    OrderID int,
    FOREIGN KEY (UserID) REFERENCES user(UserID),
    FOREIGN KEY (OrderID) REFERENCES orders(OrderID)
);

INSERT INTO purchaseHistory (PurchaseID, UserID,OrderID)
VALUES (6, '047c9a62-21df-45f9-80db-4efd6dea110c', 549);

create table discount(
    DiscountID int NOT NULL PRIMARY KEY,
    DiscountDescription text(1000),
    Percentage int,
    StartDate date,
    FinishDate date
);

INSERT INTO discount (DiscountID, DiscountDescription,Percentage,StartDate,FinishDate)
VALUES (1, 'Summer Sale', 15, '2024-07-01', '2024-07-31');


create table discountProduct(
    DiscountProductID int NOT NULL PRIMARY KEY,
    DiscountID int,
    ProductID varchar(50),
    FOREIGN KEY (DiscountID) REFERENCES discount(DiscountID),
    FOREIGN KEY (ProductID) REFERENCES product(ProductID)
);

INSERT INTO discountProduct (DiscountProductID, DiscountID,ProductID)
VALUES (98, 1, 'f78bce4e-8cc2-47f9-9c07-5df968b7f5c5');

create table Review(
    ReviewID int NOT NULL PRIMARY KEY,
    ReviewText text(1000),
    ReviewDate date,
    ReviewRating int(5),
    ProductID varchar(50),
    UserID varchar(50),
    FOREIGN KEY (UserID) REFERENCES user(UserID),
    FOREIGN KEY (ProductID) REFERENCES product(ProductID)

);

INSERT INTO Review (ReviewID, ReviewText,ReviewDate, ReviewRating,ProductID, UserID)
VALUES (5, 'Great product, highly recommended!', '2023-09-12', 4,
        'f78bce4e-8cc2-47f9-9c07-5df968b7f5c5', '047c9a62-21df-45f9-80db-4efd6dea110c');
INSERT INTO Review (ReviewID, ReviewText,ReviewDate, ReviewRating,ProductID, UserID)
VALUES (9, 'Portable and User-friendly but expensive', '2022-10-17', 3,
        'f78bce4e-8cc2-47f9-9c07-5df968b7f5c5', '376b1d20-0993-4209-9cff-8013f24cb375');
INSERT INTO Review (ReviewID, ReviewText,ReviewDate, ReviewRating,ProductID, UserID)
VALUES (6, 'It keeps Crashing all the time!', '2024-11-22', 2,
        '057d6197-54c2-4eaf-9db6-221b1175c80d', '376b1d20-0993-4209-9cff-8013f24cb375');









