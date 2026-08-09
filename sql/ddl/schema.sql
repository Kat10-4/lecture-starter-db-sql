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
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        CONSTRAINT chk_users_email_format 
        CHECK (email ~* '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]{2,}$'),
        CONSTRAINT chk_users_username_format 
        CHECK (username ~* '^[a-zA-Z0-9_]{3,50}$')
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
        primary_photo_id INTEGER REFERENCES files(id) ON DELETE SET NULL,  
        country_id INTEGER REFERENCES countries (id) ON DELETE SET NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        CONSTRAINT chk_person_birth_date CHECK (date_of_birth <= CURRENT_DATE)
    );

-- ============================================
-- PERSON PHOTOS (Many-to-Many)
-- ============================================
CREATE TABLE
    person_photos (
        person_id INTEGER NOT NULL REFERENCES persons (id) ON DELETE CASCADE,
        file_id INTEGER NOT NULL REFERENCES files (id) ON DELETE CASCADE,
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
        movie_id INTEGER NOT NULL REFERENCES movies (id) ON DELETE CASCADE,
        genre_id INTEGER NOT NULL REFERENCES genres (id) ON DELETE CASCADE,
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
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
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

-- ============================================
-- UPDATED_AT TRIGGER FUNCTION
-- ============================================

CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- ============================================
-- UPDATED_AT TRIGGERS FOR ALL TABLES
-- ============================================
CREATE TRIGGER update_countries_updated_at 
    BEFORE UPDATE ON countries 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_genres_updated_at 
    BEFORE UPDATE ON genres 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_files_updated_at 
    BEFORE UPDATE ON files 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_persons_updated_at 
    BEFORE UPDATE ON persons 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_person_photos_updated_at 
    BEFORE UPDATE ON person_photos 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_movies_updated_at 
    BEFORE UPDATE ON movies 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_movie_genres_updated_at 
    BEFORE UPDATE ON movie_genres 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_movie_characters_updated_at 
    BEFORE UPDATE ON movie_characters 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_movie_appearances_updated_at 
    BEFORE UPDATE ON movie_appearances 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_users_updated_at 
    BEFORE UPDATE ON users 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_favorites_updated_at 
    BEFORE UPDATE ON favorites 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();

-- ============================================
-- INDEXES (Performance Optimization)
-- ============================================
-- 1. FOREIGN KEY INDEXES (10)
CREATE INDEX idx_movies_country_id ON movies(country_id);
CREATE INDEX idx_movies_director_id ON movies(director_id);
CREATE INDEX idx_movie_characters_movie_id ON movie_characters(movie_id);
CREATE INDEX idx_movie_characters_actor_id ON movie_characters(actor_id);
CREATE INDEX idx_movie_appearances_movie_id ON movie_appearances(movie_id);
CREATE INDEX idx_movie_appearances_actor_id ON movie_appearances(actor_id);
CREATE INDEX idx_person_photos_person_id ON person_photos(person_id);
CREATE INDEX idx_person_photos_file_id ON person_photos(file_id);
CREATE INDEX idx_favorites_user_id ON favorites(user_id);
CREATE INDEX idx_favorites_movie_id ON favorites(movie_id);

-- 2. COMPOSITE INDEXES (3)
CREATE INDEX idx_movies_country_release ON movies(country_id, release_date);
CREATE INDEX idx_movie_characters_movie_role ON movie_characters(movie_id, role);
CREATE INDEX idx_persons_country_gender ON persons(country_id, gender);
CREATE INDEX idx_favorites_user_movie ON favorites(user_id, movie_id);

-- 3. SEARCH INDEXES (7)
CREATE INDEX idx_movies_release_date ON movies(release_date);
CREATE INDEX idx_movies_duration_minutes ON movies(duration_minutes);
CREATE INDEX idx_movies_title ON movies(title);
CREATE INDEX idx_persons_last_name ON persons(last_name);
CREATE INDEX idx_persons_first_name ON persons(first_name);
CREATE INDEX idx_users_username ON users(username);
CREATE INDEX idx_users_email ON users(email);

-- 4. QUERY PERFORMANCE INDEXES (3)
CREATE INDEX idx_movie_characters_actor_movie ON movie_characters(actor_id, movie_id);
CREATE INDEX idx_movie_appearances_actor_movie ON movie_appearances(actor_id, movie_id);
CREATE INDEX idx_movie_genres_movie_genre ON movie_genres(movie_id, genre_id);

-- 5. ADDITIONAL INDEXES (2)
CREATE INDEX idx_genres_name ON genres(name);
CREATE INDEX idx_movie_genres_genre_id ON movie_genres(genre_id);
CREATE UNIQUE INDEX idx_person_photos_primary ON person_photos (person_id) WHERE is_primary = TRUE;


