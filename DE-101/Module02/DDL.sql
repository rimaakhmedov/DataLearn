-- ************************************** calendar_dim

CREATE TABLE calendar_dim
(
 order_date date NOT NULL,
 ship_date  date NOT NULL,
 year       int4range NOT NULL,
 quarter    varchar(5) NOT NULL,
 month      int4range NOT NULL,
 week       int4range NOT NULL,
 week_day   int4range NOT NULL,
 CONSTRAINT PK_5 PRIMARY KEY ( order_date, ship_date )
);

-- ************************************** customer_dim

CREATE TABLE customer_dim
(
 customer_id   serial NOT NULL,
 customer_name varchar(30) NOT NULL,
 CONSTRAINT PK_67 PRIMARY KEY ( customer_id )
);

-- ************************************** location_dim

CREATE TABLE location_dim
(
 geo_id      serial NOT NULL,
 country     varchar(15) NOT NULL,
 region      varchar(10) NOT NULL,
 "state"       varchar(20) NOT NULL,
 city        varchar(20) NOT NULL,
 postal_code int4range NOT NULL,
 CONSTRAINT PK_32 PRIMARY KEY ( geo_id )
);

-- ************************************** product_dim

CREATE TABLE product_dim
(
 product_id   serial NOT NULL,
 category     varchar(20) NOT NULL,
 subcategory  varchar(20) NOT NULL,
 segment      varchar(20) NOT NULL,
 product_name varchar(20) NOT NULL,
 CONSTRAINT PK_42 PRIMARY KEY ( product_id )
);


-- ************************************** shipping_dim

CREATE TABLE shipping_dim
(
 ship_id   serial NOT NULL,
 ship_mode varchar(20) NOT NULL,
 CONSTRAINT PK_22 PRIMARY KEY ( ship_id )
);


-- ************************************** sales_fact

CREATE TABLE sales_fact
(
 row_id      int4range NOT NULL,
 order_id    varchar(15) NOT NULL,
 customer_id serial NOT NULL,
 ship_id     serial NOT NULL,
 order_date  date NOT NULL,
 product_id  serial NOT NULL,
 ship_date   date NOT NULL,
 geo_id      serial NOT NULL,
 sales       numeric(9, 4) NOT NULL,
 profit      numeric(21, 16) NOT NULL,
 quantity    int4range NOT NULL,
 discount    numeric(4, 2) NOT NULL,
 CONSTRAINT PK_13 PRIMARY KEY ( row_id ),
 CONSTRAINT FK_52 FOREIGN KEY ( geo_id ) REFERENCES location_dim ( geo_id ),
 CONSTRAINT FK_55 FOREIGN KEY ( product_id ) REFERENCES product_dim ( product_id ),
 CONSTRAINT FK_58 FOREIGN KEY ( order_date, ship_date ) REFERENCES calendar_dim ( order_date, ship_date ),
 CONSTRAINT FK_62 FOREIGN KEY ( ship_id ) REFERENCES shipping_dim ( ship_id ),
 CONSTRAINT FK_69 FOREIGN KEY ( customer_id ) REFERENCES customer_dim ( customer_id )
);

CREATE INDEX FK_54 ON sales_fact
(
 geo_id
);

CREATE INDEX FK_57 ON sales_fact
(
 product_id
);

CREATE INDEX FK_61 ON sales_fact
(
 order_date,
 ship_date
);

CREATE INDEX FK_64 ON sales_fact
(
 ship_id
);

CREATE INDEX FK_71 ON sales_fact
(
 customer_id
);
