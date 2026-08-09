-- ============================================
-- QUERY 1: Actors with Total Movie Budget
-- ============================================
-- Shape: ID, First name, Last name, Total movies budget
-- Purpose: List all actors with the total budget of movies they've appeared in
-- Includes actors with no appearances (budget = 0)
-- Combines both character roles AND background appearances
-- ============================================
SELECT
    p.id AS "ID",
    p.first_name AS "First name",
    p.last_name AS "Last name",
    COALESCE(SUM(m.budget), 0) AS "Total movies budget"
FROM
    persons p
    LEFT JOIN movie_characters mc ON p.id = mc.actor_id
    LEFT JOIN movie_appearances ma ON p.id = ma.actor_id
    LEFT JOIN movies m ON (
        mc.movie_id = m.id
        OR ma.movie_id = m.id
    )
GROUP BY
    p.id,
    p.first_name,
    p.last_name
ORDER BY
    "Total movies budget" DESC;