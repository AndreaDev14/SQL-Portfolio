/* Project: Design a store database
- Create your own store! Your store should sell one type of things, like clothing or bikes, whatever you want your store to specialize in. 
- You should have a table for all the items in your store, and at least 5 columns for the kind of data you think you'd need to store. 
- You should sell at least 15 items, and use select statements to order your items by price and show at least one statistic about the items.
*/

CREATE TABLE car (id INTEGER PRIMARY KEY, make TEXT,
model TEXT, 
color TEXT, 
year INTEGER, 
price INTEGER);

CREATE TABLE car (id INTEGER PRIMARY KEY, make TEXT,
model TEXT, 
color TEXT, 
year INTEGER, 
price INTEGER);


INSERT INTO car VALUES(1, "HONDA","ACCORD", "BLUE", 2000, 25918);


INSERT INTO car VALUES(2, "NISSAN","ALTIMA", "WHITE", 2005, 40000);


INSERT INTO car VALUES(3, "CHEV","IMPALA", "BLACK", 2008, 33000);


INSERT INTO car VALUES(4, "TOYOTA","CAMRY", "GREY", 2009, 50000);

INSERT INTO car VALUES(5, "TOYOTA","CAMRY", "GREY", 20010, 40000);

INSERT INTO car VALUES(6, "TOYOTA","COROLLA", "RED", 20017, 60000);

INSERT INTO car VALUES(7, "TOYOTA","CAMRY", "WHITE", 2011, 30000);

INSERT INTO car VALUES(8, "TOYOTA","CAMRY", "GREY", 2009, 50000);

INSERT INTO car VALUES(9, "NISSAN","ALTIMA", "WHITE", 2009, 30000);

INSERT INTO car VALUES(10, "HONDA","ACCORD", "RED", 2018, 30000);

INSERT INTO car VALUES(11, "FORD","EDGE", "BLACK", 2020, 40000);

INSERT INTO car VALUES(12, "FORD","KA", "GREY", 2020, 20000);

INSERT INTO car VALUES(13, "CHEV","CAPTIVA", "RED", 2015, 20000);

INSERT INTO car VALUES(14, "TOYOTA","COROLLA", "WHITE", 2018, 30000);

INSERT INTO car VALUES(15, "FORD","FOCUS", "GREY", 2021, 30000);

SELECT *  FROM car  ORDER BY make ; 
 
SELECT  model, AVG(price) FROM car
WHERE price >= 20000 GROUP BY  model ORDER BY price DESC;
