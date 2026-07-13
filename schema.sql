
--Users
CREATE TABLE IF NOT EXISTS users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT UNIQUE NOT NULL,
            email TEXT UNIQUE NOT NULL,
            password_hash TEXT NOT NULL,
            created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
--Movies
CREATE TABLE IF NOT EXISTS movies(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            release_year INTEGER NOT NULL CHECK(release_year >= 1888),
            runtime INTEGER NOT NULL CHECK(runtime > 0),
            description TEXT,
            language TEXT,
            poster_url TEXT,
            created_by_user_id INTEGER,
            created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
            UNIQUE(title, release_year),

            FOREIGN KEY(created_by_user_id) REFERENCES users(id) ON DELETE SET NULL
);      

--People   
CREATE TABLE IF NOT EXISTS people(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            birth_date DATE,
            country TEXT,
            photo_url TEXT,
            bio TEXT
);

--Genres
CREATE TABLE IF NOT EXISTS genres(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT UNIQUE NOT NULL
);

--Roles
CREATE TABLE IF NOT EXISTS roles(
            id INTEGER PRIMARY KEY,
            name TEXT UNIQUE NOT NULL 
);

--Movie People
CREATE TABLE IF NOT EXISTS movie_people(
            movie_id INTEGER NOT NULL,
            person_id INTEGER NOT NULL,
            role_id INTEGER NOT NULL,
            character_name TEXT,
            billing_order INTEGER,
            PRIMARY KEY(movie_id, person_id, role_id),
            FOREIGN KEY(movie_id) REFERENCES movies(id) ON DELETE CASCADE,
            FOREIGN KEY(person_id) REFERENCES people(id) ON DELETE CASCADE,
            FOREIGN KEY(role_id) REFERENCES roles(id)
);

--Movie Genres
CREATE TABLE IF NOT EXISTS movie_genres(
        movie_id INTEGER NOT NULL,
        genre_id INTEGER NOT NULL,
        PRIMARY KEY(movie_id, genre_id),
        FOREIGN KEY(movie_id) REFERENCES movies(id) ON DELETE CASCADE,
        FOREIGN KEY(genre_id) REFERENCES genres(id) ON DELETE CASCADE  
);
--Ratings
CREATE TABLE IF NOT EXISTS ratings(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        movie_id INTEGER NOT NULL,
        user_id INTEGER NOT NULL,
        rating INTEGER NOT NULL CHECK(rating BETWEEN 1 AND 10),
        rated_at DATETIME DEFAULT CURRENT_TIMESTAMP,

        FOREIGN KEY(movie_id) REFERENCES movies(id) ON DELETE CASCADE,
        FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
        UNIQUE(user_id, movie_id)
);

--Reviews
CREATE TABLE IF NOT EXISTS reviews (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        movie_id INTEGER NOT NULL,
        user_id INTEGER NOT NULL,
        title TEXT,
        body TEXT,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY(movie_id) REFERENCES movies(id) ON DELETE CASCADE,
        FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
        UNIQUE(user_id, movie_id)
);

--Collection status
CREATE TABLE IF NOT EXISTS collection_status(
        id INTEGER PRIMARY KEY,
        name TEXT UNIQUE NOT NULL
);

--Personal Collection
CREATE TABLE IF NOT EXISTS collections(
        user_id INTEGER NOT NULL,
        movie_id INTEGER NOT NULL,
        status_id INTEGER NOT NULL,
        is_favorite BOOLEAN NOT NULL DEFAULT 0,
        date_added DATETIME DEFAULT CURRENT_TIMESTAMP,

        PRIMARY KEY(user_id, movie_id),

        FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
        FOREIGN KEY(movie_id) REFERENCES movies(id) ON DELETE CASCADE,
        FOREIGN KEY(status_id) REFERENCES collection_status(id)
);


INSERT OR IGNORE INTO roles(id, name) VALUES
        (1,'Actor'),
        (2,'Director'),
        (3,'Writer'),
        (4,'Producer'),
        (5,'Composer'),
        (6,'Editor'),
        (7,'Cinematographer');

INSERT OR IGNORE INTO collection_status(id, name) VALUES
        (1,'Plan to Watch'),
        (2,'Watching'),
        (3,'Completed'),
        (4,'Dropped');  