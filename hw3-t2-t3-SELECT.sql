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
WHERE name ILIKE '%МОЙ %' 
	OR name ILIKE '% МОЙ%'
	OR name ILIKE '%МОЙ%'
	OR name ILIKE 'МОЙ'
	OR name ILIKE '%my %'
	OR name ILIKE '% my%'
	OR name ILIKE '%my%'
	OR name ILIKE 'my';

-- ЗАДАНИЕ 3
   
-- Количество исполнителей в каждом жанре.
-- (в БД могут быть жанры без единого исполнителя)
SELECT COUNT(DISTINCT artist_id), g.id, name FROM genres_artists ga
RIGHT JOIN genres g ON ga.genre_id = g.id
GROUP BY g.id, name;

-- Количество треков, вошедших в альбомы 2019–2020 годов.
SELECT COUNT(DISTINCT t.id) AS released_between_2019_and_2020 FROM tracks AS t
JOIN albums a ON t.album = a.id
WHERE a.year BETWEEN '2019-01-01' AND '2020-12-31';

-- Средняя продолжительность треков по каждому альбому.
SELECT AVG(t.duration) AS average_duration, a.name, a.id
FROM albums a
JOIN tracks t ON a.id = t.album 
GROUP BY a.id, a.name
ORDER BY a.name;

-- Все исполнители, которые НЕ выпустили альбомы в 2020 году.
SELECT ar.name
FROM artists AS ar
WHERE ar.name NOT IN (
	SELECT ar.name from artists
	JOIN albums_artists AS al_ar ON ar.id = al_ar.artist_id
	JOIN albums AS al ON al_ar.album_id = al.id
	WHERE al.year BETWEEN '2020-01-01' AND '2020-12-31'
);

--Названия сборников, в которых присутствует конкретный исполнитель (выберите его сами).
--(в данном примере - Linkin Park)
SELECT DISTINCT(c.name) from collections AS c
JOIN collection_tracks AS c_t ON c.id = c_t.collection_id
JOIN tracks AS t ON c_t.track_id = t.id
JOIN albums AS al ON t.album = al.id
JOIN albums_artists AS al_ar ON al.id = al_ar.album_id
JOIN artists AS ar ON al_ar.artist_id = ar.id
WHERE ar.name = 'Linkin Park'
