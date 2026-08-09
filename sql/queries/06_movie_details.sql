-- ============================================
-- QUERY 6: Movie Details for ID=1
-- ============================================
-- Shape: ID, Title, Release date, Duration, Description,
--        Poster (JSON), Director (JSON with photo),
--        Actors (array of JSON with photos), Genres (array of JSON)
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
        d.last_name,
        'photo',
        jsonb_build_object (
            'id',
            pf.id,
            'file_name',
            pf.file_name,
            'mime_type',
            pf.mime_type,
            'public_url',
            pf.public_url
        )
    ) AS "Director",
    COALESCE(
        (
            SELECT
                jsonb_agg (
                    jsonb_build_object (
                        'id',
                        a.id,
                        'first_name',
                        a.first_name,
                        'last_name',
                        a.last_name,
                        'photo',
                        jsonb_build_object (
                            'id',
                            af.id,
                            'file_name',
                            af.file_name,
                            'mime_type',
                            af.mime_type,
                            'public_url',
                            af.public_url
                        )
                    )
                )
            FROM
                (
                    SELECT DISTINCT
                        p.id,
                        p.first_name,
                        p.last_name,
                        p.primary_photo_id
                    FROM
                        persons p
                        LEFT JOIN movie_characters mc ON p.id = mc.actor_id
                        LEFT JOIN movie_appearances ma ON p.id = ma.actor_id
                    WHERE
                        (
                            mc.movie_id = m.id
                            OR ma.movie_id = m.id
                        )
                        AND p.id IS NOT NULL
                ) a
                LEFT JOIN files af ON a.primary_photo_id = af.id
        ),
        CAST('[]' AS JSONB)
    ) AS "Actors",
    COALESCE(
        (
            SELECT
                jsonb_agg (jsonb_build_object ('id', g.id, 'name', g.name))
            FROM
                movie_genres mg
                JOIN genres g ON mg.genre_id = g.id
            WHERE
                mg.movie_id = m.id
        ),
        CAST('[]' AS JSONB)
    ) AS "Genres"
FROM
    movies m
    JOIN persons d ON m.director_id = d.id
    LEFT JOIN files f ON m.poster_file_id = f.id
    LEFT JOIN files pf ON d.primary_photo_id = pf.id
WHERE
    m.id = 1
GROUP BY
    m.id,
    f.id,
    d.id,
    pf.id;