-- ************************************** Calendar

CREATE TABLE Calendar
(
 order_date date NOT NULL,
 ship_date  date NOT NULL,
 year       int NOT NULL,
 quarter    varchar(10) NOT NULL,
 month      int NOT NULL,
 week       int NOT NULL,
 week_day   int NOT NULL,
 CONSTRAINT PK_128 PRIMARY KEY ( order_date, ship_date )
);

-- ************************************** Customer

CREATE TABLE Customer
(
 customer_key  int NOT NULL,
 customer_name varchar(25) NOT NULL,
 customer_id   varchar(8) NOT NULL,
 segment       varchar(17) NOT NULL,
 CONSTRAINT PK_144 PRIMARY KEY ( customer_key )
);


-- ************************************** Product

CREATE TABLE Product
(
 product_key  int NOT NULL,
 product_id   varchar(15) NOT NULL,
 category     varchar(15) NOT NULL,
 subcategory  varchar(15) NOT NULL,
 product_name varchar(150) NOT NULL,
 CONSTRAINT PK_151 PRIMARY KEY ( product_key )
);



-- ************************************** Region

CREATE TABLE Region
(
 geo_id      int NOT NULL,
 country     varchar(13) NOT NULL,
 region      varchar(7) NOT NULL,
 "state"       varchar(20) NOT NULL,
 city        varchar(17) NOT NULL,
 postal_code int NOT NULL,
 CONSTRAINT PK_119 PRIMARY KEY ( geo_id )
);


-- ************************************** Shipping

CREATE TABLE Shipping
(
 ship_id   int NOT NULL,
 ship_mode varchar(15) NOT NULL,
 CONSTRAINT PK_139 PRIMARY KEY ( ship_id )
);


-- ************************************** Sales

CREATE TABLE Sales
(
 row_id       int NOT NULL,
 order_id     varchar(15) NOT NULL,
 sales_amount numeric(9,4) NOT NULL,
 profit       numeric(21,16) NOT NULL,
 geo_id       int NOT NULL,
 order_date   date NOT NULL,
 ship_date    date NOT NULL,
 ship_id      int NOT NULL,
 customer_key int NOT NULL,
 product_key  int NOT NULL,
 CONSTRAINT PK_13 PRIMARY KEY ( row_id ),
 CONSTRAINT FK_109 FOREIGN KEY ( geo_id ) REFERENCES Region ( geo_id ),
 CONSTRAINT FK_117 FOREIGN KEY ( order_date, ship_date ) REFERENCES Calendar ( order_date, ship_date ),
 CONSTRAINT FK_103 FOREIGN KEY ( ship_id ) REFERENCES Shipping ( ship_id ),
 CONSTRAINT FK_105 FOREIGN KEY ( customer_key ) REFERENCES Customer ( customer_key ),
 CONSTRAINT FK_104 FOREIGN KEY ( product_key ) REFERENCES Product ( product_key )
);

CREATE INDEX FK_120 ON Sales
(
 geo_id
);

CREATE INDEX FK_129 ON Sales
(
 order_date,
 ship_date
);

CREATE INDEX FK_140 ON Sales
(
 ship_id
);

CREATE INDEX FK_145 ON Sales
(
 customer_key
);

CREATE INDEX FK_152 ON Sales
(
 product_key
);
