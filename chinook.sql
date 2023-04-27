/*Chinook Data*/

/*Show Customers (their full names, customer ID, and country) who are not in the US.*/
SELECT FirstName ||" "|| LastName AS FullName, CustomerID, country
FROM chinook.customers
WHERE country <> 'USA'
ORDER BY country;

/*Show only the Customers from Brazil.*/
SELECT FirstName ||" "|| LastName AS FullName, CustomerID, country
FROM chinook.customers
WHERE country = 'Brazil'
ORDER BY country;

/*Find the Invoices of customers who are from Brazil. The resulting table should show the customer's full name, Invoice ID, Date of the invoice, and billing country.*/
SELECT  custo.FirstName ||" "|| custo.LastName AS FullName,
invo.InvoiceID, DATE(invo.InvoiceDate) AS InvoiceDate, invo.BillingCountry
FROM chinook.customers custo
JOIN chinook.invoices invo
ON custo.CustomerID = invo.CustomerID
WHERE country = 'Brazil'
ORDER BY country;

/*Show the Employees who are Sales Agents.*/
SELECT LastName, FirstName, Title 
FROM chinook.employees
WHERE Title like '%Sales%'

/*Find a unique/distinct list of billing countries from the Invoice table.*/
SELECT DISTINCT(BillingCountry) FROM chinook.invoices
ORDER BY BillingCountry;

/*Provide a query that shows the invoices associated with each sales agent. The resulting table should include the Sales Agent's full name.*/
SELECT invo.InvoiceID, emp.LastName emp.FirstName
FROM chinook.invoices invo
JOIN chinook.customers custo 
ON invo.CustomerID = custo.CustomerID
JOIN  chinook.employees emp
ON custo.SupportRepID = emp.EmployeeID;

/*Show the Invoice Total, Customer name, Country, and Sales Agent name for all invoices and customers.*/
SELECT invo.Total AS InvoiceTotal,
custo.LastName ||" "|| custo.FirstName AS CustomerFullName,
custo.Country,
emp.LastName ||" "|| emp.FirstName AS employeeFullName
FROM chinook.invoices invo
JOIN chinook.customers custo 
ON invo.CustomerID = custo.CustomerID
JOIN  chinook.employees emp
ON custo.SupportRepID = emp.EmployeeID;

/*How many Invoices were there in 2009?*/
SELECT COUNT(*)
FROM chinook.Invoices
WHERE InvoiceDate BETWEEN '2009-01-01' AND '2009-12-31';

/*What are the total sales for 2009?*/
SELECT SUM(Total)
FROM chinook.Invoices
WHERE InvoiceDate BETWEEN '2009-01-01' AND '2009-12-31';

/*Write a query that includes the purchased track name with each invoice line ID.*/
SELECT tr.Name, invo_item.InvoiceLineId FROM chinook.tracks tr
JOIN chinook.invoice_items invo_item
ON  tr.TrackId = invo_item.TrackId;

/*Write a query that includes the purchased track name AND artist name with each invoice line ID.*/
SELECT tr.Name AS Track, art.Name AS Artist, invo_item.InvoiceLineId  FROM chinook.tracks tr
JOIN chinook.invoice_items invo_item
ON  tr.TrackId = invo_item.TrackId
JOIN chinook.albums alb
ON tr.TrackID = alb.AlbumId
JOIN chinook.artists art
ON alb.AlbumID = art.ArtistID ;

/*Provide a query that shows all the Tracks, and include the Album name, Media type, and Genre.*/

SELECT tr.Name AS 'Track Name' , alb.Title AS 'Album Title',  med.Name AS 'Media Type', gen.Name AS 'Genre'
FROM chinook.tracks tr
JOIN chinook.albums alb 
ON tr.AlbumId = alb.AlbumId
JOIN chinook.media_types med
ON tr.MediaTypeId = med.MediaTypeId
JOIN chinook.genres gen
ON tr.GenreId = gen.GenreId;

/*Show the total sales made by each sales agent.*/
SELECT  emp.LastName ||" "|| emp.FirstName AS employeeFullName,
ROUND(SUM(invo.Total),2) AS 'Total Sales' 
FROM chinook.invoices invo
JOIN chinook.customers custo 
ON invo.CustomerID = custo.CustomerID
JOIN  chinook.employees emp
ON custo.SupportRepID = emp.EmployeeID
WHERE emp.Title = 'Sales Support Agent'
GROUP BY employeeFullName;

/*Which sales agent made the most dollars in sales in 2009?*/
SELECT  emp.LastName ||" "|| emp.FirstName AS employeeFullName,
ROUND(SUM(invo.Total),2) AS 'Total Sales' 
FROM chinook.invoices invo
JOIN chinook.customers custo 
ON invo.CustomerID = custo.CustomerID
JOIN  chinook.employees emp
ON custo.SupportRepID = emp.EmployeeID
WHERE emp.Title = 'Sales Support Agent'
AND invo.InvoiceDate BETWEEN '2009-01-01' AND '2009-12-31'
GROUP BY employeeFullName LIMIT 1;


