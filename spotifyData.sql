/* Spotify Data 
- For this project, I downloaded Spotify data from Kaggle.
- Then I created a table to insert Spotify data into.
- Finally, I performed analytics on the data using SQL. 
*/


CREATE TABLE BIT_DB.Spotifydata (
id integer PRIMARY KEY,
artist_name varchar NOT NULL,
track_name varchar NOT NULL,
track_id varchar NOT NULL,
popularity integer NOT NULL,
danceability decimal(4,3) NOT NULL,
energy decimal(4,3) NOT NULL,
song_key integer NOT NULL,
loudness decimal(5,3) NOT NULL,
song_mode integer NOT NULL,
speechiness decimal(5,4) NOT NULL,
acousticness decimal(6,5) NOT NULL,
instrumentalness decimal(8,7) NOT NULL,
liveness decimal(5,4) NOT NULL,
valence decimal(4,3) NOT NULL,
tempo decimal(6,3) NOT NULL,
duration_ms integer NOT NULL,
time_signature integer NOT NULL );


/*What is the average popularity, danceability, and energy by artist and track. by artist and track?*/
SELECT
artist_name
,track_name
,AVG(popularity) AS Avg_popularity
,AVG(danceability) AS Avg_danceability
,AVG(energy) AS Avg_energy
FROM BIT_DB.spotifydata
GROUP BY artist_name, track_name
ORDER BY AVG(popularity) DESC;

/*What artist released the longest song? */
SELECT artist_name, track_name, MAX(duration_ms) AS longest_song_ms FROM BIT_DB.Spotifydata;

/*Who are the top 10 artists based on popularity?*/
SELECT artist_name, popularity FROM BIT_DB.Spotifydata
GROUP BY artist_name
ORDER BY popularity DESC  LIMIT 10;

/*What artist(s) have landed the most songs in this top 50 list?*/
SELECT artist_name, COUNT(artist_name) number_song FROM BIT_DB.Spotifydata
GROUP BY artist_name
HAVING number_song  > 1 
ORDER BY number_song DESC LIMIT 2;


/*Calculate the average popularity for the artists in the Spotify data table. Then, for every artist with an average popularity of 90 or above, show their name, their average popularity, and label them as a “Top Star"
Using CTE */

WITH average_CTE AS (
SELECT spo.artist_name,
AVG(spo.popularity) AS average_popularity
FROM SpotifyData spo
GROUP BY spo.artist_name
)
 
SELECT  artist_name,
        average_popularity,
        'Top Star' AS tag
FROM average_CTE
WHERE average_popularity >= 90 
ORDER BY average_popularity DESC ;
