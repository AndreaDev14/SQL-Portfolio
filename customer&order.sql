/*#In this SQL, I'm querying a database with multiple tables in it to quantify statistics about customer and order data.*/

/*Deleting id greater than 6 digits and strings*/
SELECT * FROM BIT_DB.customers
WHERE length(order_id) = 6
AND order_id <> 'Order ID';

/*How many orders were placed in January?*/
SELECT COUNT(orderID)
 FROM BIT_DB.JanSales
WHERE length(orderId) = 6
AND orderId <> 'Order ID';

/*How many of those orders were for an iPhone?*/
SELECT COUNT(orderID) 
FROM BIT_DB.JanSales
WHERE product = 'iPhone';

/*Select the customer account numbers for all the orders that were placed in February.*/
SELECT  DISTINCT acctnum
FROM BIT_DB.customers cust

INNER JOIN BIT_DB.FebSales Feb
ON cust.order_id=FEB.orderid
WHERE length(orderid) = 6 
AND orderid <> 'Order ID';

/*Which product was the cheapest one sold in January, and what was the price?*/

SELECT DISTINCT Product, price 
FROM BIT_DB.JanSales 
WHERE price =  (SELECT MIN(price)  FROM BIT_DB.JanSales );

/*What is the total revenue for each product sold in January? (Revenue can be calculated using the number of products sold and the price of the products).*/
SELECT product, SUM(quantity)*price AS  revenue
FROM BIT_DB.JanSales
GROUP BY product;

/*Which products were sold in February at 548 Lincoln St, Seattle, WA 98101, how many of each were sold, and what was the total revenue?*/

SELECT 
SUM(Quantity), 
product, 
SUM(quantity)*price AS revenue
FROM BIT_DB.FebSales 
WHERE location = '548 Lincoln St, Seattle, WA 98101'
GROUP BY product;

/*How many customers ordered more than 2 products at a time in February, and what was the average amount spent for those customers?*/
SELECT
COUNT(DISTINCT cust.acctnum) AS total_customer_ordered, 
AVG(quantity*price)
FROM BIT_DB.FebSales Feb
LEFT JOIN BIT_DB.customers cust
ON FEB.orderid=cust.order_id
WHERE Feb.Quantity>2
AND length(orderid) = 6 
AND orderid <> 'Order ID';


/*List all the products sold in Los Angeles in February, and include how many of each were sold.*/
SELECT  product, SUM(quantity) AS total_sold,location
FROM BIT_DB.FebSales 
WHERE location like '%Los Angeles%'
group by product;

/*Which locations in New York received at least 3 orders in January, and how many orders did they each receive? */
SELECT DISTINCT location, COUNT(orderID) as total_orders FROM BIT_DB.JanSales
WHERE location like '%New York City%'
AND length(orderid) = 6 
AND orderid <> 'Order ID'
GROUP BY location 
HAVING total_orders >= 3;

/*How many of each type of headphone were sold in February?*/
SELECT SUM(Quantity) as Quantity,
Product
FROM BIT_DB.FebSales 
WHERE Product like '%Headphones%'
GROUP BY Product;

/*What was the average amount spent per account in February?*/
SELECT AVG(quantity*price)
FROM BIT_DB.FebSales Feb

LEFT JOIN BIT_DB.customers cust
ON FEB.orderid=cust.order_id

WHERE length(orderid) = 6 
AND orderid <> 'Order ID';

/*What was the average quantity of products purchased per account in February? */ 
SELECT SUM(quantity)/count(cust.acctnum)
FROM BIT_DB.FebSales Feb

LEFT JOIN BIT_DB.customers cust
ON FEB.orderid=cust.order_id

WHERE length(orderid) = 6 
AND orderid <> 'Order ID';

/*Which product brought in the most revenue in January and how much revenue did it bring in total? */ 
SELECT product, SUM(quantity*price)
FROM BIT_DB.JanSales 
GROUP BY product
ORDER BY sum(quantity*price) DESC
LIMIT 1;