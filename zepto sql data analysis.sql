drop table if exists zepto;

create table zepto(
sku_id SERIAL PRIMARY KEY,
category VARCHAR(120),
name VARCHAR(150) NOT NULL,
mrp NUMERIC(8,2),
discountPercent NUMERIC(5,2),
availableQuantity INTEGER,
discountedSellingPrice NUMERIC(8,2),
weightInGms INTEGER,
outofStock BOOLEAN,
quantity INTEGER
);


-- EDA --
SELECT COUNT(*) from zepto

select * from zepto limit 10

-- null values--
SELECT * from zepto 
where name is null 
or
category is null
or
mrp is null 
or
discountpercent is null
or
availablequantity is null 
or
discountedsellingprice is null
or
weightingms  is null 
or
outofstock is null 
or
quantity is null;

-- different product category--
SELECT DISTINCT category 
from zepto
order by category;

-- products in stocks vs out of stock--
select outofStock , COUNT(sku_id)
from zepto 
group by outofStock;

-- product names present multiple times--
select name, count(sku_id) as "Number of skus"
from zepto
group by name
HAVING COUNT (sku_id) > 1
order by count(sku_id) DESC;

-- data cleaning--

--products with prized 0 --
select * from zepto 
where mrp =0 or discountedSellingPrice = 0;

DELETE FROM zepto 
WHERE mrp = 0;

-- convert to rupees--
UPDATE zepto 
SET mrp = mrp/100.0,
discountedSellingPrice = discountedSellingPrice/100.0

select mrp , discountedSellingPrice from zepto

-- Q1. Find the top 10 best-value products based on the discount percentage.

select DISTINCT name , mrp , discountPercent
FROM zepto
ORDER BY discountPercent DESC
LIMIT 10;

--Q2.What are the Products with High MRP but Out of Stock

select name , mrp, outofStock
FROM zepto
WHERE outOfStock = 'Yes' and mrp > 300
order by mrp DESC;

--Q3.Calculate Estimated Revenue for each category
select category,
ROUND(SUM(discountedSellingPrice * quantity),2) as "revenue"
from zepto
group by category
order by revenue DESC;
-- Q4. Find all products where MRP is greater than ₹500 and discount is less than 10%.
select DISTINCT name, mrp , discountPercent
FROM zepto
WHERE mrp >= 500 and discountPercent < 10;
order by mrp DESC, discountPercent DESC;

-- Q5. Identify the top 5 categories offering the highest average discount percentage.
select category  ,
ROUND(AVG(discountPercent),2) as "average_discount_percentage"
from zepto
group by category
order by average_discount_percentage DESC
LIMIT 5;


-- Q6. Find the price per gram for products above 100g and sort by best value.
select DISTINCT name, weightInGms, discountedSeliingPrice,
ROUND(discountedSeliingPrice/weightInGms,2) as price_per_gram
from zepto
WHERE weightInGms >= 100
ORDER BY price_per_gram



--Q7.Group the products into categories like Low, Medium, Bulk.
SELECT DISTINCT name, weightInGms,
CASE WHEN weightInGms < 1000 THEN 'Low'
     WHEN weightInGms < 5000 THEN 'Medium'
	 ELSE 'Bulk'
	 END AS weight_category
from zepto;


--Q8.What is the Total Inventory Weight Per Category
SELECT category,
SUM(weightInGms * availableQuantity ) as total_weight
from zepto
group by category
order by total_weight;
