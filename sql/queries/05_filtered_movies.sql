-- ============================================
-- QUERY 5: Filtered Movies with Details
-- ============================================
-- Criteria: 
--   - country_id = 1 (United States)
--   - release_date >= 2022
--   - duration > 135 minutes (2 hours 15 minutes)
--   - genre Action OR Drama
-- Shape: ID, Title, Release date, Duration, Description, 
--        Poster (JSON), Director (JSON with ID, First name, Last name)
-- ============================================
SELECT
    m.id AS "ID",
    m.title AS "Title",
    m.release_date AS "Release date",
    m.duration_minutes AS "Duration",
    m.description AS "Description",
    jsonb_build_object (
        'id',
        f.id,
        'file_name',
        f.file_name,
        'mime_type',
        f.mime_type,
        'public_url',
        f.public_url
    ) AS "Poster",
    jsonb_build_object (
        'id',
        d.id,
        'first_name',
        d.first_name,
        'last_name',
        d.last_name
    ) AS "Director"
FROM
    movies m
    JOIN countries c ON m.country_id = c.id
    JOIN persons d ON m.director_id = d.id
    LEFT JOIN files f ON m.poster_file_id = f.id
WHERE
    c.id = 1
    AND m.release_date >= '2022-01-01'
    AND m.duration_minutes > 135
    AND EXISTS (
        SELECT
            1
        FROM
            movie_genres mg
            JOIN genres g ON mg.genre_id = g.id
        WHERE
            mg.movie_id = m.id
            AND g.name IN ('Action', 'Drama')
    )
ORDER BY
    m.release_date DESC;