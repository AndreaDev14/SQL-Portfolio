/*Netflix Data
#In this SQL code, I'm querying a database that's holding Nexflix data to answer questions about the data.
*/

/*JOIN two tables*/
SELECT 
peoples.show_id,
peoples.director,
titles.title,
titles.type
 FROM  "CharlotteChaze/BreakIntoTech"."netflix_people" peoples
LEFT JOIN "CharlotteChaze/BreakIntoTech"."netflix_titles_info" titles
ON  titles.show_id = peoples.show_id 

/*How many movie titles are there in the database?
 (movies only, not tv shows)*/

SELECT count(*) 
FROM "CharlotteChaze/BreakIntoTech"."netflix_titles_info"
WHERE type='Movie';


/*When was the most recent batch of tv shows and/or movies added to the database?*/
SELECT MAX(DATE(date_added)) AS recent_batch
FROM "CharlotteChaze/BreakIntoTech"."netflix_titles_info" 

/* List all the movies and tv shows in alphabetical order.*/
SELECT title
FROM "CharlotteChaze/BreakIntoTech"."netflix_titles_info" 
ORDER BY title 

/*Who was the Director for the movie Bright Star?*/
SELECT director,type,peoples.cast
 FROM  "CharlotteChaze/BreakIntoTech"."netflix_people" peoples
LEFT JOIN "CharlotteChaze/BreakIntoTech"."netflix_titles_info" titles
ON  titles.show_id = peoples.show_id 
WHERE titles.title = 'Bright Star'

/*What is the oldest movie in the database and what year was it made?*/

select title, release_year
FROM "CharlotteChaze/BreakIntoTech"."netflix_titles_info"
WHERE type='Movie'
ORDER BY release_year asc
LIMIT 1;



SELECT title, release_year 
FROM "CharlotteChaze/BreakIntoTech"."netflix_titles_info"
WHERE type = 'Movie'
AND release_year <= 
(SELECT MIN(release_year) 
FROM "CharlotteChaze/BreakIntoTech"."netflix_titles_info"
WHERE type = 'Movie');