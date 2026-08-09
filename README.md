# Movie Database

Database design for a movie application.

## 📋 Overview

This project implements a complete database schema for a movie application, similar to IMDb or Letterboxd. It includes:

- **User management** with profiles and avatars
- **Movie catalog** with details, genres, and posters
- **Person management** for actors and directors with photos
- **Character tracking** with optional actor assignments
- **Background actor appearances** (crowd/extra roles)
- **Favorites system** for users

## ER Diagram

```mermaid
erDiagram
    countries ||--o{ persons : "has"
    countries ||--o{ movies : "produced_in"
    persons ||--o{ movies : "directs"
    persons ||--o{ movie_characters : "plays"
    persons ||--o{ movie_appearances : "appears_in"
    persons |o--|| files : "primary_photo"
    persons ||--o{ person_photos : "has"
    movies ||--o{ movie_genres : "has_genre"
    genres ||--o{ movie_genres : "assigned_to"
    movies ||--o{ movie_characters : "features"
    movies ||--o{ movie_appearances : "has_actor"
    movies |o--|| files : "poster"
    users ||--o{ favorites : "has"
    movies ||--o{ favorites : "favorited_by"
    users |o--|| files : "avatar"

    countries {
        int id PK
        string name
        string code
        timestamp created_at
        timestamp updated_at
    }

    genres {
        int id PK
        string name
        timestamp created_at
        timestamp updated_at
    }

    files {
        int id PK
        string file_name
        string mime_type
        string storage_key
        string public_url
        timestamp created_at
        timestamp updated_at
    }

    persons {
        int id PK
        string first_name
        string last_name
        text biography
        date date_of_birth
        string gender
        int country_id FK
        int primary_photo_id FK
        timestamp created_at
        timestamp updated_at
    }

    person_photos {
        int person_id FK
        int file_id FK
        boolean is_primary
        timestamp created_at
        timestamp updated_at
    }

    movies {
        int id PK
        string title
        text description
        numeric budget
        date release_date
        int duration_minutes
        int country_id FK
        int director_id FK
        int poster_file_id FK
        timestamp created_at
        timestamp updated_at
    }

    movie_genres {
        int movie_id PK, FK
        int genre_id PK, FK
    }

    movie_characters {
        int id PK
        int movie_id FK
        string name
        text description
        string role
        int actor_id FK
        timestamp created_at
        timestamp updated_at
    }

    movie_appearances {
        int id PK
        int movie_id FK
        int actor_id FK
        string role_description
        string character_name
        timestamp created_at
        timestamp updated_at
    }

    users {
        int id PK
        string username
        string first_name
        string last_name
        string email
        string password_hash
        int avatar_file_id FK
        timestamp created_at
        timestamp updated_at
    }

    favorites {
        int user_id PK, FK
        int movie_id PK, FK
        timestamp created_at
        timestamp updated_at
    }
```

## 🗄️ Database Schema

### Tables

| Table | Purpose |
|-------|---------|
| `countries` | Reference table for countries |
| `genres` | Reference table for movie genres |
| `files` | Storage metadata for S3-like file storage |
| `users` | Application users with profiles |
| `persons` | Actors and directors |
| `person_photos` | Multiple photos per person (with primary flag) |
| `movies` | Main movie entity |
| `movie_genres` | Many-to-many: movies ↔ genres |
| `movie_characters` | Characters in movies (optional actor) |
| `movie_appearances` | Background/crowd roles (no character) |
| `favorites` | Many-to-many: users ↔ movies |

### Key Features

#### Character vs Background Actor
- **Characters** (`movie_characters`): Named roles with optional actor
- **Appearances** (`movie_appearances`): Background/crowd roles without character entity

#### Person Photos
- **Primary photo** (`persons.primary_photo_id`): Fast access for thumbnails
- **Additional photos** (`person_photos`): Gallery of all photos

#### File Storage
- **Database stores only metadata** (file_name, mime_type, storage_key, public_url)
- **Actual files stored in external service** (S3 bucket)

## 🔧 Setup Instructions

### Using Docker (Recommended)

```bash
# 1. Start PostgreSQL container
docker run --name movie-db -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=movie_db -d -p 5432:5432 postgres

# 2. Copy SQL files
docker cp sql/ddl/schema.sql movie-db:/sql/schema.sql
docker cp sql/seed/sample_data.sql movie-db:/sql/sample_data.sql

# 3. Run schema
docker exec -it movie-db psql -U postgres -d movie_db -f /sql/schema.sql

# 4. Run test data
docker exec -it movie-db psql -U postgres -d movie_db -f /sql/sample_data.sql
```

### Manual Setup

```bash
# 1. Create database
createdb movie_db

# 2. Run schema
psql -d movie_db -f sql/ddl/schema.sql

# 3. Run test data
psql -d movie_db -f sql/seed/sample_data.sql
```

## 📊 Queries

| # | Query | Description | File |
|---|-------|-------------|------|
| 1 | Actors with Total Budget | List all actors with total budget of movies they appeared in | `sql/queries/01_actors_total_budget.sql` |
| 2 | Recent Movies with Actor Count | Movies released in last 5 years with number of actors | `sql/queries/02_recent_movies_actors.sql` |
| 3 | Users with Favorites | All users with their favorite movies as array of IDs | `sql/queries/03_users_favorites.sql` |
| 4 | Directors with Average Budget | All directors with average budget of movies directed | `sql/queries/04_directors_avg_budget.sql` |
| 5 | Filtered Movies | Movies matching: country=1, release>=2022, duration>135, Action/Drama | `sql/queries/05_filtered_movies.sql` |
| 6 | Movie Details | Complete movie details for ID=1 with JSON structures | `sql/queries/06_movie_details.sql` |

### Query Shapes

#### Query 1: Actors with Total Budget
```
ID | First name | Last name | Total movies budget
```

#### Query 2: Recent Movies with Actor Count
```
ID | Title | Actors count
```

#### Query 3: Users with Favorites
```
ID | Username | Favorite movie IDs
```

#### Query 4: Directors with Average Budget
```
Director ID | Director name | Average budget
```

#### Query 5: Filtered Movies
```
ID | Title | Release date | Duration | Description | Poster (JSON) | Director (JSON)
```

#### Query 6: Movie Details
```
ID | Title | Release date | Duration | Description | Poster (JSON) | Director (JSON with photo) | Actors (JSON array) | Genres (JSON array)
```

## 🛠️ Technologies

- **Database:** PostgreSQL
- **ER Diagram:** Mermaid
- **Container:** Docker
- **Language:** SQL (PL/pgSQL)

## 📁 Project Structure

```
movie-database/
├── README.md                          # Documentation
├── sql/
│   ├── ddl/
│   │   └── schema.sql                 # Complete database schema
│   ├── seed/
│   │   └── sample_data.sql            # Test data
│   └── queries/
│       ├── 01_actors_total_budget.sql
│       ├── 02_recent_movies_actors.sql
│       ├── 03_users_favorites.sql
│       ├── 04_directors_avg_budget.sql
│       ├── 05_filtered_movies.sql
│       └── 06_movie_details.sql
└── .gitignore
```

## 🔑 Key Design Decisions

### 1. Character vs Background Actor
- **Characters:** Named roles with optional actor (`actor_id` can be NULL)
- **Background:** Separate table for crowd/extra roles without character entity

### 2. Person Photos
- **Primary photo:** Direct reference in `persons` table for fast access
- **Additional photos:** Junction table for unlimited photos

### 3. File Storage
- **Database:** Stores only metadata (file_name, mime_type, storage_key, public_url)
- **External:** Actual files stored in S3-like service

### 4. Normalization
- **3NF compliant** with proper relationships
- **No data duplication** through reference tables
- **Proper foreign keys** with appropriate ON DELETE actions

## 📈 Performance Optimizations

- 25+ indexes for fast queries
- Composite indexes for complex filters
- Foreign key indexes for JOIN performance
- Partial unique index for primary photos

## 📝 License

This project was created as a homework assignment for an Binary Studio Academy.