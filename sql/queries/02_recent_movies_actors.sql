-- ============================================
-- QUERY 2: Movies Released in Last 5 Years with Actor Count
-- ============================================
-- Shape: ID, Title, Actors count
-- Purpose: Movies released in the last 5 years with number of actors appeared
-- Counts both character actors AND background appearances
-- Uses DISTINCT to count each actor only once per movie
-- ============================================
SELECT
    m.id AS "ID",
    m.title AS "Title",
    COUNT(DISTINCT actor_id) AS "Actors count"
FROM
    movies m
    LEFT JOIN (
        SELECT
            movie_id,
            actor_id
        FROM
            movie_characters
        WHERE
            actor_id IS NOT NULL
        UNION
        SELECT
            movie_id,
            actor_id
        FROM
            movie_appearances
    ) actors ON m.id = actors.movie_id
WHERE
    m.release_date >= (CURRENT_DATE - INTERVAL '5 years')
GROUP BY
    m.id,
    m.title
ORDER BY
    m.release_date DESC;