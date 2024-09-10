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
SELECT COUNT(DISTINCT artist_id), genre_id, name FROM genres_artists ga
JOIN genres g ON ga.genre_id = g.id
GROUP BY genre_id, name
-- НЕ ПОКАЗЫВАЕТСЯ ЖАНР БЕЗ ЕДИНОГО ИСПОЛНИТЕЛЯ!-----------------------------------------------

-- Количество треков, вошедших в альбомы 2019–2020 годов.
SELECT COUNT(DISTINCT t.id) AS released_between_2019_and_2020 FROM tracks AS t
JOIN albums a ON t.album = a.id
WHERE a.year BETWEEN '2019-01-01' AND '2020-12-31'

-- Средняя продолжительность треков по каждому альбому.
--SELECT AVG( ... ) AS average_duration FROM tracks AS t
--JOIN albums a ON t.album = a.id
--(...)
--ORDER BY average_duration
