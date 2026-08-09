-- ============================================
-- SAMPLE DATA FOR MOVIE DATABASE
-- ============================================
-- ============================================
-- 1. COUNTRIES
-- ============================================
INSERT INTO
    countries (name, code)
VALUES
    ('United States', 'US'),
    ('United Kingdom', 'GB'),
    ('France', 'FR'),
    ('Germany', 'DE'),
    ('Japan', 'JP'),
    ('Australia', 'AU'),
    ('Canada', 'CA'),
    ('Italy', 'IT'),
    ('Spain', 'ES'),
    ('Mexico', 'MX');

-- ============================================
-- 2. GENRES
-- ============================================
INSERT INTO
    genres (name)
VALUES
    ('Action'),
    ('Drama'),
    ('Comedy'),
    ('Sci-Fi'),
    ('Thriller'),
    ('Romance'),
    ('Adventure'),
    ('Horror'),
    ('Animation'),
    ('Documentary'),
    ('Fantasy'),
    ('Mystery'),
    ('Crime'),
    ('Biography'),
    ('History');

-- ============================================
-- 3. FILES (Storage Metadata)
-- ============================================
INSERT INTO
    files (file_name, mime_type, storage_key, public_url)
VALUES
    (
        'spielberg_photo.jpg',
        'image/jpeg',
        'persons/spielberg.jpg',
        'https://s3.example.com/persons/spielberg.jpg'
    ),
    (
        'nolan_photo.jpg',
        'image/jpeg',
        'persons/nolan.jpg',
        'https://s3.example.com/persons/nolan.jpg'
    ),
    (
        'dicaprio_photo.jpg',
        'image/jpeg',
        'persons/dicaprio.jpg',
        'https://s3.example.com/persons/dicaprio.jpg'
    ),
    (
        'goldblum_photo.jpg',
        'image/jpeg',
        'persons/goldblum.jpg',
        'https://s3.example.com/persons/goldblum.jpg'
    ),
    (
        'jackson_photo.jpg',
        'image/jpeg',
        'persons/jackson.jpg',
        'https://s3.example.com/persons/jackson.jpg'
    ),
    (
        'hanks_photo.jpg',
        'image/jpeg',
        'persons/hanks.jpg',
        'https://s3.example.com/persons/hanks.jpg'
    ),
    (
        'winslet_photo.jpg',
        'image/jpeg',
        'persons/winslet.jpg',
        'https://s3.example.com/persons/winslet.jpg'
    ),
    (
        'pitt_photo.jpg',
        'image/jpeg',
        'persons/pitt.jpg',
        'https://s3.example.com/persons/pitt.jpg'
    ),
    (
        'freeman_photo.jpg',
        'image/jpeg',
        'persons/freeman.jpg',
        'https://s3.example.com/persons/freeman.jpg'
    ),
    (
        'downey_photo.jpg',
        'image/jpeg',
        'persons/downey.jpg',
        'https://s3.example.com/persons/downey.jpg'
    ),
    (
        'spielberg_additional1.jpg',
        'image/jpeg',
        'persons/spielberg_additional1.jpg',
        'https://s3.example.com/persons/spielberg_additional1.jpg'
    ),
    (
        'dicaprio_additional1.jpg',
        'image/jpeg',
        'persons/dicaprio_additional1.jpg',
        'https://s3.example.com/persons/dicaprio_additional1.jpg'
    ),
    (
        'goldblum_additional1.jpg',
        'image/jpeg',
        'persons/goldblum_additional1.jpg',
        'https://s3.example.com/persons/goldblum_additional1.jpg'
    ),
    (
        'hanks_additional1.jpg',
        'image/jpeg',
        'persons/hanks_additional1.jpg',
        'https://s3.example.com/persons/hanks_additional1.jpg'
    ),
    (
        'pitt_additional1.jpg',
        'image/jpeg',
        'persons/pitt_additional1.jpg',
        'https://s3.example.com/persons/pitt_additional1.jpg'
    ),
    (
        'jurassic_poster.jpg',
        'image/jpeg',
        'posters/jurassic.jpg',
        'https://s3.example.com/posters/jurassic.jpg'
    ),
    (
        'inception_poster.jpg',
        'image/jpeg',
        'posters/inception.jpg',
        'https://s3.example.com/posters/inception.jpg'
    ),
    (
        'darkknight_poster.jpg',
        'image/jpeg',
        'posters/darkknight.jpg',
        'https://s3.example.com/posters/darkknight.jpg'
    ),
    (
        'titanic_poster.jpg',
        'image/jpeg',
        'posters/titanic.jpg',
        'https://s3.example.com/posters/titanic.jpg'
    ),
    (
        'pulpfiction_poster.jpg',
        'image/jpeg',
        'posters/pulpfiction.jpg',
        'https://s3.example.com/posters/pulpfiction.jpg'
    ),
    (
        'avatar_user1.jpg',
        'image/jpeg',
        'avatars/user1.jpg',
        'https://s3.example.com/avatars/user1.jpg'
    ),
    (
        'avatar_user2.jpg',
        'image/jpeg',
        'avatars/user2.jpg',
        'https://s3.example.com/avatars/user2.jpg'
    ),
    (
        'avatar_user3.jpg',
        'image/jpeg',
        'avatars/user3.jpg',
        'https://s3.example.com/avatars/user3.jpg'
    );

-- ============================================
-- 4. PERSONS (Actors & Directors)
-- ============================================
INSERT INTO
    persons (
        first_name,
        last_name,
        biography,
        date_of_birth,
        gender,
        country_id,
        primary_photo_id
    )
VALUES
    (
        'Steven',
        'Spielberg',
        'American filmmaker and director. One of the most influential directors in film history.',
        '1946-12-18',
        'Male',
        1,
        1
    ),
    (
        'Christopher',
        'Nolan',
        'British-American filmmaker known for complex, thought-provoking films.',
        '1970-07-30',
        'Male',
        2,
        2
    ),
    (
        'Leonardo',
        'DiCaprio',
        'American actor and producer.',
        '1974-11-11',
        'Male',
        1,
        3
    ),
    (
        'Jeff',
        'Goldblum',
        'American actor known for roles in Jurassic Park and The Fly.',
        '1952-10-22',
        'Male',
        1,
        4
    ),
    (
        'Samuel L.',
        'Jackson',
        'American actor with numerous roles in film and television.',
        '1948-12-21',
        'Male',
        1,
        5
    ),
    (
        'Tom',
        'Hanks',
        'American actor and filmmaker.',
        '1956-07-09',
        'Male',
        1,
        6
    ),
    (
        'Kate',
        'Winslet',
        'English actress.',
        '1975-10-05',
        'Female',
        2,
        7
    ),
    (
        'Brad',
        'Pitt',
        'American actor and producer.',
        '1963-12-18',
        'Male',
        1,
        8
    ),
    (
        'Morgan',
        'Freeman',
        'American actor and narrator.',
        '1937-06-01',
        'Male',
        1,
        9
    ),
    (
        'Robert',
        'Downey Jr.',
        'American actor.',
        '1965-04-04',
        'Male',
        1,
        10
    ),
    (
        'James',
        'Cameron',
        'Canadian filmmaker.',
        '1954-08-16',
        'Male',
        7,
        NULL
    ),
    (
        'Quentin',
        'Tarantino',
        'American filmmaker and actor.',
        '1963-03-27',
        'Male',
        1,
        NULL
    ),
    (
        'Martin',
        'Scorsese',
        'American filmmaker.',
        '1942-11-17',
        'Male',
        1,
        NULL
    ),
    (
        'Alfred',
        'Hitchcock',
        'English film director and producer.',
        '1899-08-13',
        'Male',
        2,
        NULL
    ),
    (
        'New',
        'Director',
        'A director with no movies yet.',
        '1980-01-01',
        'Male',
        1,
        NULL
    );

-- ============================================
-- 5. PERSON PHOTOS (Primary + Additional)
-- ============================================
INSERT INTO
    person_photos (person_id, file_id, is_primary)
VALUES
    -- Steven Spielberg (id: 1)
    (1, 1, TRUE), -- Primary
    (1, 11, FALSE), -- Additional photo
    -- Christopher Nolan (id: 2)
    (2, 2, TRUE), -- Primary
    -- Leonardo DiCaprio (id: 3)
    (3, 3, TRUE), -- Primary
    (3, 12, FALSE), -- Additional photo
    -- Jeff Goldblum (id: 4)
    (4, 4, TRUE), -- Primary
    (4, 13, FALSE), -- Additional photo
    -- Samuel L. Jackson (id: 5)
    (5, 5, TRUE), -- Primary
    -- Tom Hanks (id: 6)
    (6, 6, TRUE), -- Primary
    (6, 14, FALSE), -- Additional photo
    -- Kate Winslet (id: 7)
    (7, 7, TRUE), -- Primary
    -- Brad Pitt (id: 8)
    (8, 8, TRUE), -- Primary
    (8, 15, FALSE), -- Additional photo
    -- Morgan Freeman (id: 9)
    (9, 9, TRUE), -- Primary
    -- Robert Downey Jr. (id: 10)
    (10, 10, TRUE);

-- Primary
-- ============================================
-- 6. MOVIES
-- ============================================
INSERT INTO
    movies (
        title,
        description,
        budget,
        release_date,
        duration_minutes,
        country_id,
        director_id,
        poster_file_id
    )
VALUES
    (
        'Jurassic Park',
        'A theme park with cloned dinosaurs turns into a nightmare.',
        63000000,
        '1993-06-11',
        127,
        1,
        1,
        16
    ),
    (
        'Inception',
        'A thief who steals corporate secrets through dream-sharing technology.',
        160000000,
        '2010-07-16',
        148,
        2,
        2,
        17
    ),
    (
        'The Dark Knight',
        'When the menace known as the Joker wreaks havoc and chaos on Gotham City.',
        185000000,
        '2008-07-18',
        152,
        1,
        2,
        18
    ),
    (
        'Titanic',
        'A seventeen-year-old aristocrat falls in love with a kind but poor artist.',
        200000000,
        '1997-12-19',
        195,
        1,
        1,
        19
    ),
    (
        'Pulp Fiction',
        'The lives of two mob hitmen, a boxer, a gangster and his wife intertwine.',
        8500000,
        '1994-10-14',
        154,
        1,
        12,
        20
    ),
    (
        'The Avengers',
        'Earth''s mightiest heroes must come together to stop Loki and his alien army.',
        220000000,
        '2012-05-04',
        143,
        1,
        1,
        NULL
    ),
    (
        'The Shawshank Redemption',
        'Two imprisoned men bond over a number of years, finding solace and eventual redemption.',
        25000000,
        '1994-09-23',
        142,
        1,
        13,
        NULL
    ),
    (
        'Forrest Gump',
        'The presidencies of Kennedy and Johnson, the Vietnam War, and other events unfold.',
        55000000,
        '1994-07-06',
        142,
        1,
        1,
        NULL
    ),
    (
        'The Matrix',
        'A computer hacker learns about the true nature of his reality.',
        63000000,
        '1999-03-31',
        136,
        1,
        2,
        NULL
    ),
    (
        'Avatar',
        'A paraplegic Marine dispatched to the moon Pandora on a unique mission.',
        237000000,
        '2009-12-18',
        162,
        7,
        11,
        NULL
    ),
    (
        'The Godfather',
        'The aging patriarch of an organized crime dynasty transfers control to his son.',
        6000000,
        '1972-03-24',
        175,
        1,
        13,
        NULL
    ),
    (
        'Interstellar',
        'A team of explorers travel through a wormhole in space.',
        165000000,
        '2014-11-07',
        169,
        2,
        2,
        NULL
    ),
    (
        'Gladiator',
        'A former Roman General sets out to exact vengeance against the corrupt emperor.',
        103000000,
        '2000-05-05',
        155,
        1,
        1,
        NULL
    ),
    -- Movies for Query 5 (country_id=1, release_date>=2022, duration>135, Action/Drama)
    (
        'Action Movie 2023',
        'An action packed movie from 2023.',
        100000000,
        '2023-06-15',
        140,
        1,
        1,
        NULL
    ),
    (
        'Drama Movie 2023',
        'A dramatic story set in 2023.',
        50000000,
        '2023-08-20',
        150,
        1,
        2,
        NULL
    ),
    -- Movie for Query 6 (id=16 will be used for detailed view)
    (
        'Movie Details Test',
        'This movie has all relationships for testing Query 6.',
        75000000,
        '2022-01-15',
        145,
        1,
        2,
        17
    );

-- ============================================
-- 7. MOVIE GENRES
-- ============================================
INSERT INTO
    movie_genres (movie_id, genre_id)
VALUES
    -- Jurassic Park (1)
    (1, 1),
    (1, 7), -- Action, Adventure
    -- Inception (2)
    (2, 1),
    (2, 5),
    (2, 12), -- Action, Thriller, Mystery
    -- The Dark Knight (3)
    (3, 1),
    (3, 5),
    (3, 13), -- Action, Thriller, Crime
    -- Titanic (4)
    (4, 2),
    (4, 6), -- Drama, Romance
    -- Pulp Fiction (5)
    (5, 2),
    (5, 13), -- Drama, Crime
    -- The Avengers (6)
    (6, 1),
    (6, 7),
    (6, 11), -- Action, Adventure, Fantasy
    -- The Shawshank Redemption (7)
    (7, 2), -- Drama
    -- Forrest Gump (8)
    (8, 2),
    (8, 6), -- Drama, Romance
    -- The Matrix (9)
    (9, 1),
    (9, 3),
    (9, 4), -- Action, Comedy, Sci-Fi
    -- Avatar (10)
    (10, 1),
    (10, 7),
    (10, 4), -- Action, Adventure, Sci-Fi
    -- The Godfather (11)
    (11, 2),
    (11, 13), -- Drama, Crime
    -- Interstellar (12)
    (12, 4),
    (12, 7),
    (12, 2), -- Sci-Fi, Adventure, Drama
    -- Gladiator (13)
    (13, 1),
    (13, 2),
    (13, 7), -- Action, Drama, Adventure
    -- Action Movie 2023 (14) - Query 5
    (14, 1),
    (14, 7), -- Action, Adventure
    -- Drama Movie 2023 (15) - Query 5
    (15, 2), -- Drama
    -- Movie Details Test (16) - Query 6
    (16, 1),
    (16, 2);

-- Action, Drama
-- ============================================
-- 8. MOVIE CHARACTERS
-- ============================================
INSERT INTO
    movie_characters (movie_id, name, description, role, actor_id)
VALUES
    -- Jurassic Park (1)
    (
        1,
        'Dr. Alan Grant',
        'Paleontologist who is initially skeptical of the park.',
        'leading',
        4
    ),
    (
        1,
        'Dr. Ellie Sattler',
        'Paleobotanist and Alan''s girlfriend.',
        'leading',
        7
    ),
    (
        1,
        'Dr. Ian Malcolm',
        'Mathematician who warns of chaos theory implications.',
        'supporting',
        3
    ),
    (
        1,
        'T-Rex',
        'The main dinosaur attraction that escapes.',
        'background',
        NULL
    ),
    -- Inception (2)
    (
        2,
        'Dom Cobb',
        'A thief who steals corporate secrets through dream-sharing.',
        'leading',
        3
    ),
    (
        2,
        'Arthur',
        'Cobb''s right-hand man and point man.',
        'supporting',
        8
    ),
    (
        2,
        'Ariadne',
        'Architecture student who joins the team.',
        'supporting',
        7
    ),
    -- The Dark Knight (3)
    (
        3,
        'Bruce Wayne',
        'Billionaire vigilante who fights crime in Gotham.',
        'leading',
        10
    ),
    (
        3,
        'Joker',
        'Anarchist who wants to cause chaos in Gotham.',
        'leading',
        4
    ),
    (
        3,
        'Harvey Dent',
        'Gotham''s District Attorney.',
        'supporting',
        8
    ),
    -- Titanic (4)
    (
        4,
        'Jack Dawson',
        'Poor artist who wins a ticket on the Titanic.',
        'leading',
        3
    ),
    (
        4,
        'Rose DeWitt Bukater',
        'A young aristocrat trapped in an engagement.',
        'leading',
        7
    ),
    (
        4,
        'Cal Hockley',
        'Rose''s wealthy fiancé.',
        'supporting',
        5
    ),
    -- Pulp Fiction (5)
    (
        5,
        'Vincent Vega',
        'A hitman working for a gangster.',
        'leading',
        3
    ),
    (
        5,
        'Jules Winnfield',
        'Vincent''s partner and philosophical hitman.',
        'leading',
        5
    ),
    (
        5,
        'Mia Wallace',
        'Wife of a gangster.',
        'supporting',
        7
    ),
    -- Forrest Gump (8)
    (
        8,
        'Forrest Gump',
        'A slow-witted but kind man from Alabama.',
        'leading',
        6
    ),
    (
        8,
        'Jenny Curran',
        'Forrest''s childhood friend and love interest.',
        'supporting',
        7
    ),
    -- The Matrix (9)
    (
        9,
        'Neo',
        'A computer hacker who discovers the truth about reality.',
        'leading',
        3
    ),
    (
        9,
        'Morpheus',
        'A rebel leader who believes Neo is the One.',
        'supporting',
        9
    ),
    (
        9,
        'Trinity',
        'A hacker and member of the resistance.',
        'supporting',
        7
    ),
    -- The Godfather (11)
    (
        11,
        'Vito Corleone',
        'The aging patriarch of the Corleone crime family.',
        'leading',
        9
    ),
    (
        11,
        'Michael Corleone',
        'Vito''s youngest son who takes over the family.',
        'leading',
        8
    ),
    -- Movie Details Test (16) - For Query 6
    (
        16,
        'Test Character 1',
        'Leading character for testing.',
        'leading',
        3
    ),
    (
        16,
        'Test Character 2',
        'Supporting character for testing.',
        'supporting',
        4
    ),
    (
        16,
        'Test Character 3',
        'Background character without actor.',
        'background',
        NULL
    );

-- ============================================
-- 9. MOVIE APPEARANCES (Background/Crowd)
-- ============================================
INSERT INTO
    movie_appearances (
        movie_id,
        actor_id,
        role_description,
        character_name
    )
VALUES
    -- Jurassic Park (1)
    (1, 10, 'Park Visitor', NULL),
    (1, 6, 'Scientist', NULL),
    -- Inception (2)
    (2, 6, 'Dreamer', NULL),
    (2, 9, 'Gangster', NULL),
    -- The Dark Knight (3)
    (3, 6, 'Gotham Police Officer', NULL),
    (3, 7, 'Hospital Staff', NULL),
    -- Titanic (4)
    (4, 6, 'Titanic Passenger', NULL),
    (4, 8, 'Titanic Passenger', NULL),
    -- Pulp Fiction (5)
    (5, 6, 'Restaurant Customer', NULL),
    (5, 7, 'Waitress', 'Maria'),
    -- Forrest Gump (8)
    (8, 8, 'Army Soldier', NULL),
    (8, 9, 'Protestor', NULL),
    -- The Matrix (9)
    (9, 6, 'Office Worker', NULL),
    (9, 7, 'Office Worker', NULL),
    -- Movie Details Test (16)
    (16, 8, 'Background Extra', NULL),
    (16, 9, 'Crowd Member', NULL);

-- ============================================
-- 10. USERS
-- ============================================
INSERT INTO
    users (
        username,
        first_name,
        last_name,
        email,
        password_hash,
        avatar_file_id
    )
VALUES
    (
        'movie_master',
        'John',
        'Smith',
        'john.smith@email.com',
        'hashed_password_1',
        21
    ),
    (
        'film_fanatic',
        'Sarah',
        'Johnson',
        'sarah.j@email.com',
        'hashed_password_2',
        22
    ),
    (
        'cinema_lover',
        'Mike',
        'Wilson',
        'mike.w@email.com',
        'hashed_password_3',
        23
    ),
    (
        'screen_queen',
        'Emma',
        'Brown',
        'emma.b@email.com',
        'hashed_password_4',
        NULL
    ),
    (
        'movie_critic',
        'James',
        'Taylor',
        'james.t@email.com',
        'hashed_password_5',
        NULL
    ),
    (
        'couch_potato',
        'Lisa',
        'Martinez',
        'lisa.m@email.com',
        'hashed_password_6',
        NULL
    ),
    (
        'reel_addict',
        'David',
        'Garcia',
        'david.g@email.com',
        'hashed_password_7',
        NULL
    ),
    (
        'silver_screen',
        'Jessica',
        'Rodriguez',
        'jessica.r@email.com',
        'hashed_password_8',
        NULL
    ),
    (
        'flick_follower',
        'Robert',
        'Lee',
        'robert.l@email.com',
        'hashed_password_9',
        NULL
    ),
    -- User with NO favorites (edge case)
    (
        'new_user',
        'New',
        'User',
        'new.user@email.com',
        'hashed_password_10',
        NULL
    );

-- ============================================
-- 11. FAVORITES
-- ============================================
INSERT INTO
    favorites (user_id, movie_id)
VALUES
    -- User 1 (movie_master): 5 favorites
    (1, 1),
    (1, 2),
    (1, 3),
    (1, 4),
    (1, 11),
    -- User 2 (film_fanatic): 4 favorites
    (2, 2),
    (2, 4),
    (2, 7),
    (2, 12),
    -- User 3 (cinema_lover): 4 favorites
    (3, 1),
    (3, 5),
    (3, 9),
    (3, 16),
    -- User 4 (screen_queen): 3 favorites
    (4, 4),
    (4, 8),
    (4, 10),
    -- User 5 (movie_critic): 4 favorites
    (5, 3),
    (5, 6),
    (5, 11),
    (5, 13),
    -- User 6 (couch_potato): 3 favorites
    (6, 2),
    (6, 7),
    (6, 9),
    -- User 7 (reel_addict): 4 favorites
    (7, 5),
    (7, 8),
    (7, 12),
    (7, 15),
    -- User 8 (silver_screen): 4 favorites
    (8, 1),
    (8, 4),
    (8, 10),
    (8, 14),
    -- User 9 (flick_follower): 3 favorites
    (9, 6),
    (9, 9),
    (9, 13);

-- User 10 (new_user): 0 favorites (edge case)
-- No favorites for user 10