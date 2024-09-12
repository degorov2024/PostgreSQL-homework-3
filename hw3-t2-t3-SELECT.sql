--ЗАДАНИЕ 2

-- Название и продолжительность самого длительного трека.
SELECT name, duration FROM tracks
WHERE duration = (SELECT MAX(duration) FROM tracks);
-- Название треков, продолжительность которых не менее 3,5 минут.
SELECT name, duration FROM tracks
WHERE duration >= '00:03:30'
ORDER BY duration DESC;
-- Названия сборников, вышедших в период с 2018 по 2020 год включительно.
SELECT name, year FROM collections
WHERE year BETWEEN '2018-01-01' AND '2020-12-31'
ORDER BY year;
-- Исполнители, чьё имя состоит из одного слова.
SELECT name FROM artists
WHERE name NOT LIKE '% %';
-- Название треков, которые содержат слово «мой» или «my».
SELECT name FROM tracks
WHERE name LIKE '%Мой%' 
	OR name LIKE '%мой%' 
	OR name LIKE '%My%' 
	OR name LIKE '%my%';

-- ЗАДАНИЕ 3
   
-- Количество исполнителей в каждом жанре.
-- (в БД могут быть жанры без единого исполнителя)
SELECT COUNT(DISTINCT artist_id), g.id, name FROM genres_artists ga
RIGHT JOIN genres g ON ga.genre_id = g.id
GROUP BY g.id, name;

-- Количество треков, вошедших в альбомы 2019–2020 годов.
-- (по каждому из таких альбомов)
SELECT COUNT(DISTINCT t.id) AS amount, a.name, a.year FROM tracks AS t
JOIN albums AS a ON t.album = a.id
WHERE a.year BETWEEN '2019-01-01' AND '2020-12-31'
GROUP BY a.name, a.year;
/* 
-- (если подразумевается поиск общего количества таких треков, т.е. на выходе просто "одно число") 
SELECT COUNT(DISTINCT t.id) AS released_between_2019_and_2020 FROM tracks AS t
JOIN albums a ON t.album = a.id
WHERE a.year BETWEEN '2019-01-01' AND '2020-12-31' 
*/

-- Средняя продолжительность треков по каждому альбому.
SELECT AVG(t.duration) AS average_duration, a.name, a.id
FROM albums a
JOIN tracks t ON a.id = t.album 
GROUP BY a.id, a.name
ORDER BY a.name;

-- Все исполнители, которые НЕ выпустили альбомы в 2020 году.
SELECT ar.name, al.name from artists AS ar
JOIN albums_artists AS al_ar ON ar.id = al_ar.artist_id
JOIN albums AS al ON al_ar.album_id = al.id
WHERE al.year NOT BETWEEN '2020-01-01' AND '2020-12-31';

--Названия сборников, в которых присутствует конкретный исполнитель (выберите его сами).
--(в данном примере - Linkin Park)
SELECT DISTINCT(c.name) from collections AS c
JOIN collection_tracks AS c_t ON c.id = c_t.collection_id
JOIN tracks AS t ON c_t.track_id = t.id
JOIN albums AS al ON t.album = al.id
JOIN albums_artists AS al_ar ON al.id = al_ar.album_id
JOIN artists AS ar ON al_ar.artist_id = ar.id
WHERE ar.name = 'Linkin Park'
