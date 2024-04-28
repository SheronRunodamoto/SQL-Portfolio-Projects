--DATA LAKE LAYER
CREATE TABLE public.sales
(
    "Sale_ID" numeric NOT NULL,
    "Date" date,
    "Store_ID" numeric,
    "Product_ID" numeric,
    "Units" numeric,
    PRIMARY KEY ("Sale_ID")
);

ALTER TABLE IF EXISTS public.sales
    OWNER to postgres;
	
SELECT *
FROM sales

CREATE TABLE public.products
(
    "Product_ID" numeric NOT NULL,
    "Product_Name" character varying,
    "Product_Category" character varying,
    "Product_Cost" numeric,
    "Product_Price" numeric,
    PRIMARY KEY ("Product_ID")
);

ALTER TABLE IF EXISTS public.products
    OWNER to postgres;

CREATE TABLE public."Inventory"
(
    "Store_ID" numeric NOT NULL,
    "Product_ID" numeric NOT NULL,
    "Stock_On_Hand" numeric NOT NULL,
    PRIMARY KEY ("Store_ID")
);

ALTER TABLE IF EXISTS public."Inventory"
    OWNER to postgres;
	
SELECT *
FROM public."Inventory"

CREATE TABLE public."Stores"
(
    "Store_ID" numeric NOT NULL,
    "Store_Name" character varying NOT NULL,
    "Store_City" character varying,
    "Store_Location" character varying,
    "Store_Open_Date" date
);

ALTER TABLE IF EXISTS public."Stores"
    OWNER to postgres;

---STAGING LAYER

CREATE TABLE "Staging".sales
AS
(
SELECT s."Sale_ID",s."Product_ID",s."Store_ID",s."Date",s."Units", p."Product_Cost",p."Product_Price"
FROM  public.products p
FULL OUTER JOIN public.sales s
ON p."Product_ID" =
s."Product_ID"
);

ALTER TABLE "Staging".sales
ADD Total_Costs money,
ADD Total_Revenue money,
ADD Total_Profits money

UPDATE "Staging".sales
SET total_costs = "Units" *total_costs
   total_revenue = "Product_Price"*"Units"
   total_profits = total_revenue-total_costs
WHERE "Units" IS NOT NULL 


SELECT *
FROM "Staging".sales

CREATE TABLE "Staging".inventory
AS
(
SELECT *
	FROM public."Inventory"
);

CREATE TABLE "Staging".products
AS
(SELECT *
FROM public.products
);

CREATE TABLE "Staging".stores
AS
(SELECT *
FROM public."Stores"
);

ALTER TABLE "Staging".inventory
ADD COLUMN id Serial PRIMARY KEY;

DROP TABLE date_dim;

CREATE TABLE  "Staging".date_dim
(
  date_key              INT NOT NULL,
  date              	DATE NOT NULL,
  weekday               VARCHAR(9) NOT NULL,
  weekday_num           INT NOT NULL,
  day_month             INT NOT NULL,
  day_of_year           INT NOT NULL,
  week_of_year          INT NOT NULL,
  iso_week         		CHAR(10) NOT NULL,
  month_num             INT NOT NULL,
  month_name            VARCHAR(9) NOT NULL,
  month_name_short   	CHAR(3) NOT NULL,
  quarter      			INT NOT NULL,
  year              	INT NOT NULL,
  first_day_of_month    DATE NOT NULL,
  last_day_of_month     DATE NOT NULL,
  yyyymm                CHAR(7) NOT NULL,
  weekend_indr          CHAR(10) NOT NULL
);

ALTER TABLE "Staging".date_dim ADD CONSTRAINT date_dim_pk PRIMARY KEY (date_key);

CREATE INDEX d_date_date_actual_idx
  ON "Staging".date_dim(date);



INSERT INTO "Staging".date_dim
SELECT TO_CHAR(datum, 'yyyymmdd')::INT AS date_key,
       datum AS date,
       TO_CHAR(datum, 'TMDay') AS weekday,
       EXTRACT(ISODOW FROM datum) AS weekday_num,
       EXTRACT(DAY FROM datum) AS day_month,
       EXTRACT(DOY FROM datum) AS day_of_year,
       EXTRACT(WEEK FROM datum) AS week_of_year,
       EXTRACT(ISOYEAR FROM datum) || TO_CHAR(datum, '"-W"IW-') || EXTRACT(ISODOW FROM datum) AS iso_week,
       EXTRACT(MONTH FROM datum) AS month,
       TO_CHAR(datum, 'TMMonth') AS month_name,
       TO_CHAR(datum, 'Mon') AS month_name_short,
       EXTRACT(QUARTER FROM datum) AS quarter,
       EXTRACT(YEAR FROM datum) AS year,
       datum + (1 - EXTRACT(DAY FROM datum))::INT AS first_day_of_month,
       (DATE_TRUNC('MONTH', datum) + INTERVAL '1 MONTH - 1 day')::DATE AS last_day_of_month,
       CONCAT(TO_CHAR(datum, 'yyyy'),'-',TO_CHAR(datum, 'mm')) AS mmyyyy,
       CASE
           WHEN EXTRACT(ISODOW FROM datum) IN (6, 7) THEN 'weekend'
           ELSE 'weekday'
           END AS weekend_indr
FROM (SELECT '2017-01-01'::DATE + SEQUENCE.DAY AS datum
      FROM GENERATE_SERIES(0, 7300) AS SEQUENCE (DAY)
      GROUP BY SEQUENCE.DAY) DQ
ORDER BY 1;


SELECT * FROM "Staging".date_dim


--checking for duplicates
SELECT "Product_ID","Product_Name"
FROM "Staging".products
GROUP BY "Product_ID","Product_Name"
HAVING count(*)>1

SELECT "Store_ID","Store_Name"
FROM "Staging".stores
GROUP BY "Store_ID","Store_Name"
HAVING count(*)>1

SELECT  "Inventory_id","Product_ID"
FROM "Staging".inventory
GROUP BY "Inventory_id","Product_ID"
HAVING count(*)>1

SELECT "Sale_ID","Product_ID"
FROM "Staging".sales
GROUP BY "Sale_ID","Product_ID"
HAVING count(*)>1


---DATA WAREHOUSE LAYER

CREATE TABLE "DWH".fact_sales
AS
(
SELECT *
FROM  Staging.sales
FOREIGN KEY (Store_ID)
FOREIGN KEY (Product_ID)
);

CREATE TABLE "DWH".fact_inventory
AS
(
SELECT *
	FROM Staging."Inventory"
);

CREATE TABLE "DWH".dim_products
AS
(SELECT *
FROM Staging.products
);

CREATE TABLE "DWH".dim_stores
AS
(SELECT *
FROM Staging."Stores"
);

CREATE TABLE "DWH".date_dim
AS
(SELECT *
FROM "Staging".date_dim
);

