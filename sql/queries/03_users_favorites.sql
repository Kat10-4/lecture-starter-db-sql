-- ============================================
-- QUERY 3: Users with Favorite Movies as Array (FIXED)
-- ============================================
-- Shape: ID, Username, Favorite movie IDs
-- Purpose: Retrieve all users with their favorite movies as an array of identifiers
-- Users with no favorites get an empty array
-- ============================================
SELECT
    u.id AS "ID",
    u.username AS "Username",
    COALESCE(
        ARRAY_AGG (
            f.movie_id
            ORDER BY
                f.created_at
        ) FILTER (
            WHERE
                f.movie_id IS NOT NULL
        ),
        '{}'
    ) AS "Favorite movie IDs"
FROM
    users u
    LEFT JOIN favorites f ON u.id = f.user_id
GROUP BY
    u.id,
    u.username
ORDER BY
    u.id;