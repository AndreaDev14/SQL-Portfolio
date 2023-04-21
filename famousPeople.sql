/*Project: Famous people
In this project, you’re going to make your own table with some small set of “famous people”, 
then make more tables about things they do and join those to create nice human readable lists.
*/

CREATE TABLE singers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    fullname TEXT,
    age INTEGER,
   country TEXT);
    
INSERT INTO singers (fullname, age, country) VALUES ("Aurora Aksnes", 26, "Norway");
INSERT INTO singers (fullname, age, country) VALUES ("Miley Cyrus", 30, "United States");
INSERT INTO singers (fullname, age, country) VALUES ("Lewis Marc Capaldi", 26, "United Kingdom");
INSERT INTO singers (fullname, age, country) VALUES ("Ed Sheeran", 32, "United Kingdom");
INSERT INTO singers (fullname, age, country) VALUES ("Lady Gaga", 36, "United States");

CREATE table popular_song(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    popular_song_id INTEGER,
    famous_song TEXT,
    net_worth TEXT,
    numberOfAlbums INTEGER);
    
INSERT INTO popular_song(popular_song_id, famous_song,net_worth, numberOfAlbums) VALUES (1,"Runaway", "5 million", 6);
INSERT INTO popular_song(popular_song_id, famous_song,net_worth, numberOfAlbums) VALUES (2, "Party In The USA","170 million", 10);
INSERT INTO popular_song(popular_song_id, famous_song,net_worth, numberOfAlbums) VALUES (3, "Someone You Loved","10 million", 3);
INSERT INTO popular_song(popular_song_id, famous_song,net_worth, numberOfAlbums) VALUES (4, "Shape of You","200 million", 5);
INSERT INTO popular_song(popular_song_id, famous_song,net_worth, numberOfAlbums) VALUES (5, "Poker Face","320 million", 9);




SELECT fullname, age, country, famous_song, net_worth,numberOfAlbums FROM singers 
JOIN popular_song ON singers.id = popular_song.popular_song_id 