CREATE TABLE IF NOT EXISTS artists (
	id SERIAL PRIMARY KEY,
	name VARCHAR(60) NOT NULL,
	alias VARCHAR(60) 
);

CREATE TABLE IF NOT EXISTS albums (
	id SERIAL PRIMARY KEY,
	name VARCHAR(60) NOT NULL,
	year DATE NOT NULL CHECK (year > '1890-01-01')
);

CREATE TABLE IF NOT EXISTS genres (
	id SMALLSERIAL PRIMARY KEY,
	name VARCHAR(40)
);

CREATE TABLE IF NOT EXISTS tracks (
	id SERIAL PRIMARY KEY,
	name VARCHAR(60) NOT NULL,
	duration INTERVAL NOT NULL CHECK (duration BETWEEN '00:00:01' AND '50:00:00'),
	album INTEGER NOT NULL REFERENCES albums(id)
);

CREATE TABLE IF NOT EXISTS genres_artists (
	artist_id INTEGER REFERENCES artists(id),
	genre_id INTEGER REFERENCES genres(id),
	CONSTRAINT pk_artist_genre PRIMARY KEY (artist_id, genre_id)
);


CREATE TABLE IF NOT EXISTS albums_artists (
	artist_id INTEGER REFERENCES artists(id),
	album_id INTEGER REFERENCES albums(id),
	CONSTRAINT pk_artist_album PRIMARY KEY (artist_id, album_id)
);

CREATE TABLE IF NOT EXISTS collections (
    id SERIAL PRIMARY KEY,
    name VARCHAR(60) NOT NULL,
    year DATE NOT NULL CHECK (year > '1890-01-01')
);

CREATE TABLE IF NOT EXISTS collection_tracks (
	collection_id INTEGER REFERENCES collections(id),
	track_id INTEGER REFERENCES tracks(id),
	CONSTRAINT pk_collection_track PRIMARY KEY (collection_id, track_id)
)
