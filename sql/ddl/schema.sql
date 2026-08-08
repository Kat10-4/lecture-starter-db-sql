-- ============================================
-- MOVIE DATABASE SCHEMA
-- ============================================
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