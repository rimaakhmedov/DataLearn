-- ************************************** customer_dim

CREATE TABLE customer_dim
(
 customer_dim_id serial NOT NULL,
 customer_id     varchar(20) NOT NULL,
 customer_name   varchar(30) NOT NULL,
 segment         varchar(30) NOT NULL,
 CONSTRAINT PK_1 PRIMARY KEY ( customer_dim_id )
);


-- ************************************** location_dim

CREATE TABLE location_dim
(
 geo_id      serial NOT NULL,
 country     varchar(30) NOT NULL,
 region      varchar(10) NOT NULL,
 "state"       varchar(30) NOT NULL,
 city        varchar(30) NOT NULL,
 postal_code int NOT NULL,
 CONSTRAINT PK_2 PRIMARY KEY ( geo_id )
);


-- ************************************** order_date_dim

CREATE TABLE order_date_dim
(
 order_date date NOT NULL,
 year       int NOT NULL,
 quarter    varchar(20) NOT NULL,
 month      int NOT NULL,
 week       int NOT NULL,
 week_day   int NOT NULL,
 CONSTRAINT PK_3 PRIMARY KEY ( order_date )
);


-- ************************************** product_dim

CREATE TABLE product_dim
(
 product_dim_id serial NOT NULL,
 category       varchar(30) NOT NULL,
 subcategory    varchar(30) NOT NULL,
 product_name   varchar(135) NOT NULL,
 product_id     varchar(30) NOT NULL,
 CONSTRAINT PK_4 PRIMARY KEY ( product_dim_id )
);


-- ************************************** ship_date_dim

CREATE TABLE ship_date_dim
(
 ship_date date NOT NULL,
 year      int NOT NULL,
 quarter   varchar(20) NOT NULL,
 month     int NOT NULL,
 week      int NOT NULL,
 week_day  int NOT NULL,
 CONSTRAINT PK_5 PRIMARY KEY ( ship_date )
);

-- ************************************** shipping_dim

CREATE TABLE shipping_dim
(
 ship_id   serial NOT NULL,
 ship_mode varchar(20) NOT NULL,
 CONSTRAINT PK_6 PRIMARY KEY ( ship_id )
);

-- ************************************** sales_fact

CREATE TABLE sales_fact
(
 row_id          int NOT NULL,
 order_id        varchar(30) NOT NULL,
 ship_date_dim   date NOT NULL,
 ship_id         int NOT NULL,
 geo_id          int NOT NULL,
 customer_dim_id int NOT NULL,
 product_dim_id  int NOT NULL,
 order_date      date NOT NULL,
 sales           numeric(9,4) NOT NULL,
 profit          numeric(21,16) NOT NULL,
 quantity        int NOT NULL,
 discount        numeric(4,2) NOT NULL,
 CONSTRAINT PK_7 PRIMARY KEY ( row_id ),
 CONSTRAINT FK_1 FOREIGN KEY ( order_date ) REFERENCES order_date_dim ( order_date ),
 CONSTRAINT FK_2 FOREIGN KEY ( product_dim_id ) REFERENCES product_dim ( product_dim_id ),
 CONSTRAINT FK_3 FOREIGN KEY ( customer_dim_id ) REFERENCES customer_dim ( customer_dim_id ),
 CONSTRAINT FK_4 FOREIGN KEY ( geo_id ) REFERENCES location_dim ( geo_id ),
 CONSTRAINT FK_5 FOREIGN KEY ( ship_id ) REFERENCES shipping_dim ( ship_id ),
 CONSTRAINT FK_6 FOREIGN KEY ( ship_date_dim ) REFERENCES ship_date_dim ( ship_date )
);

CREATE INDEX FK_2 ON sales_fact
(
 order_date
);

CREATE INDEX FK_3 ON sales_fact
(
 product_dim_id
);

CREATE INDEX FK_4 ON sales_fact
(
 customer_dim_id
);

CREATE INDEX FK_5 ON sales_fact
(
 geo_id
);

CREATE INDEX FK_6 ON sales_fact
(
 ship_id
);

CREATE INDEX FK_7 ON sales_fact
(
 ship_date_dim
);