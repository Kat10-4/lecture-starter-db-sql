-- ============================================
-- MOVIE DATABASE SCHEMA
-- ============================================
-- ============================================
-- ENUM TYPES
-- ============================================
CREATE TYPE person_gender AS ENUM ('Male', 'Female', 'Other');

CREATE TYPE character_role AS ENUM ('leading', 'supporting', 'background');

-- ============================================
-- FILES (Storage Metadata)
-- ============================================
CREATE TABLE
    files (
        id SERIAL PRIMARY KEY,
        file_name VARCHAR(255) NOT NULL,
        mime_type VARCHAR(100) NOT NULL,
        storage_key VARCHAR(255) NOT NULL UNIQUE,
        public_url TEXT NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

-- ============================================
-- COUNTRIES (Reference Table)
-- ============================================
CREATE TABLE
    countries (
        id SERIAL PRIMARY KEY,
        name VARCHAR(100) NOT NULL UNIQUE,
        code CHAR(2) UNIQUE,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

-- ============================================
-- GENRES (Reference Table)
-- ============================================
CREATE TABLE
    genres (
        id SERIAL PRIMARY KEY,
        name VARCHAR(50) NOT NULL UNIQUE,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

-- ============================================
-- USERS
-- ============================================
CREATE TABLE
    users (
        id SERIAL PRIMARY KEY,
        username VARCHAR(50) NOT NULL UNIQUE,
        first_name VARCHAR(100) NOT NULL,
        last_name VARCHAR(100) NOT NULL,
        email VARCHAR(255) NOT NULL UNIQUE,
        password_hash VARCHAR(255) NOT NULL,
        avatar_file_id INTEGER REFERENCES files (id) ON DELETE SET NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

-- ============================================
-- PERSONS (Actors & Directors)
-- ============================================
CREATE TABLE
    persons (
        id SERIAL PRIMARY KEY,
        first_name VARCHAR(100) NOT NULL,
        last_name VARCHAR(100) NOT NULL,
        biography TEXT,
        date_of_birth DATE,
        gender person_gender,
        country_id INTEGER REFERENCES countries (id) ON DELETE SET NULL,
        primary_photo_id INTEGER REFERENCES files (id) ON DELETE SET NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        CONSTRAINT chk_person_birth_date CHECK (date_of_birth <= CURRENT_DATE)
    );

-- ============================================
-- PERSON PHOTOS (Many-to-Many)
-- ============================================
CREATE TABLE
    person_photos (
        person_id INTEGER REFERENCES persons (id) ON DELETE CASCADE,
        file_id INTEGER REFERENCES files (id) ON DELETE CASCADE,
        is_primary BOOLEAN DEFAULT FALSE,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (person_id, file_id)
    );

-- ============================================
-- MOVIES
-- ============================================
CREATE TABLE
    movies (
        id SERIAL PRIMARY KEY,
        title VARCHAR(255) NOT NULL,
        description TEXT NOT NULL,
        budget NUMERIC(15, 2),
        release_date DATE,
        duration_minutes INTEGER,
        country_id INTEGER NOT NULL REFERENCES countries (id),
        director_id INTEGER NOT NULL REFERENCES persons (id),
        poster_file_id INTEGER REFERENCES files (id) ON DELETE SET NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        CONSTRAINT chk_movie_release_date CHECK (release_date <= CURRENT_DATE),
        CONSTRAINT chk_movie_duration CHECK (duration_minutes BETWEEN 1 AND 600)
    );

-- ============================================
-- MOVIE GENRES (Many-to-Many)
-- ============================================
CREATE TABLE
    movie_genres (
        movie_id INTEGER REFERENCES movies (id) ON DELETE CASCADE,
        genre_id INTEGER REFERENCES genres (id) ON DELETE CASCADE,
        PRIMARY KEY (movie_id, genre_id)
    );

-- ============================================
-- MOVIE CHARACTERS
-- ============================================
CREATE TABLE
    movie_characters (
        id SERIAL PRIMARY KEY,
        movie_id INTEGER NOT NULL REFERENCES movies (id) ON DELETE CASCADE,
        name VARCHAR(255) NOT NULL,
        description TEXT,
        role character_role NOT NULL,
        actor_id INTEGER REFERENCES persons (id) ON DELETE SET NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        UNIQUE (movie_id, name)
    );

-- ============================================
-- MOVIE APPEARANCES (Background/Crowd)
-- ============================================
CREATE TABLE
    movie_appearances (
        id SERIAL PRIMARY KEY,
        movie_id INTEGER NOT NULL REFERENCES movies (id) ON DELETE CASCADE,
        actor_id INTEGER NOT NULL REFERENCES persons (id) ON DELETE CASCADE,
        role_description VARCHAR(255) NOT NULL,
        character_name VARCHAR(255),
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        UNIQUE (movie_id, actor_id)
    );

-- ============================================
-- FAVORITES (Many-to-Many)
-- ============================================
CREATE TABLE
    favorites (
        user_id INTEGER NOT NULL REFERENCES users (id) ON DELETE CASCADE,
        movie_id INTEGER NOT NULL REFERENCES movies (id) ON DELETE CASCADE,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (user_id, movie_id)
    );