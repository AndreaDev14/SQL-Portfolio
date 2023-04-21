/* Project: Data dig
Pick one of those data sets or create a data set like that, and use advanced SELECT queries to discover things about the data. What sort of questions might one have about that data, like if they were using it for an app or a business idea? Here are some ideas:
- What are average, max, and min values in the data?
- What about those numbers per category in the data (using HAVING)?
- What ways are there to group the data values that don’t exist yet (using CASE)?
- What interesting ways are there to filter the data (using AND/OR)?
*/

/*Pokemon db*/
SELECT * FROM pokemon LIMIT 50;

SELECT * FROM pokemon WHERE Legendary = 'True';

/*What are average, max, and min values in the data?*/
SELECT Type_1 AS Type, COUNT(*) AS Quantity,ROUND(AVG(Attack)) AS AVG_Attack, MAX(Attack) AS Max_Attack, MIN(Attack) AS Min_Attack FROM pokemon GROUP BY Type_1;

/*What about those numbers per category in the data (using HAVING)?*/
SELECT Type_1 AS Type,ROUND(AVG(Defense)) AS AVG_Defense  FROM pokemon GROUP BY Type_1 HAVING ROUND(AVG(Defense)) BETWEEN 50 AND 80 

/* What ways are there to group the data values that don’t exist yet (using CASE)*/
SELECT name,Speed,
    CASE
        WHEN Attack AND Defense> 100  THEN 'STRONG'
        WHEN Attack AND Defense> 80 THEN 'MEDIUM'
        WHEN Attack AND Defense> 30 THEN 'NORMAL'
    ELSE 'LOW'
    END as Power
FROM pokemon
GROUP BY name LIMIT 100;

/*What interesting ways are there to filter the data (using AND/OR)?*/

SELECT name, Attack, Defense, Speed FROM pokemon WHERE name LIKE 'P%' AND Speed > 100;

SELECT * FROM pokemon WHERE Type_1 = 'Fire' OR Type_2 = 'Water';