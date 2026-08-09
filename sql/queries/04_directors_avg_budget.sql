-- ============================================
-- QUERY 4: Directors with Average Budget
-- ============================================
-- Shape: Director ID, Director name (concatenation of first and last names), Average budget
-- Purpose: All directors with average budget of movies they've directed
-- Directors with no movies show average 0
-- ============================================
SELECT
    p.id AS "Director ID",
    CONCAT (p.first_name, ' ', p.last_name) AS "Director name",
    COALESCE(AVG(m.budget), 0) AS "Average budget"
FROM
    persons p
    LEFT JOIN movies m ON p.id = m.director_id
GROUP BY
    p.id,
    p.first_name,
    p.last_name
ORDER BY
    "Average budget" DESC;