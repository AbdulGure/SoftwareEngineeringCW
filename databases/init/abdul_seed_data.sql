-- ============================================================================
-- FITSHARE - ABDUL'S SEED DATA
-- Author: Abdul (Backend Developer)
-- Sprint: Sprint 3
-- ============================================================================

USE fitshare;

-- Reset all tables cleanly
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE workout_tags;
TRUNCATE TABLE workout_buddies;
TRUNCATE TABLE workouts;
TRUNCATE TABLE tags;
TRUNCATE TABLE users;
SET FOREIGN_KEY_CHECKS = 1;

-- USERS
INSERT INTO users (email, password_hash, username, first_name, last_name, bio, profile_picture_url, fitness_level) VALUES
('daniel.kim@email.com',     'password_hashed', 'daniel_k',  'Daniel',  'Kim',      'Weightlifting 4 days a week',       'https://i.pravatar.cc/150/7',  'intermediate'),
('fatima.hassan@email.com',  'password_hashed', 'fatima_h',  'Fatima',  'Hassan',   'Gym every Tue and Thu lunchtime',   'https://i.pravatar.cc/150/8',  'intermediate'),
('ryan.murphy@email.com',    'password_hashed', 'ryan_m',    'Ryan',    'Murphy',   'Training for fitness competition',  'https://i.pravatar.cc/150/9',  'intermediate'),
('luca.ferrari@email.com',   'password_hashed', 'luca_f',    'Luca',    'Ferrari',  'Powerlifter, trains 6am every day', 'https://i.pravatar.cc/150/10', 'advanced'),
('aisha.robinson@email.com', 'password_hashed', 'aisha_r',   'Aisha',   'Robinson', 'Personal trainer, values consistency', 'https://i.pravatar.cc/150/11', 'advanced'),
('harry.scott@email.com',    'password_hashed', 'harry_s',   'Harry',   'Scott',    'Trains 6 days a week, never skips', 'https://i.pravatar.cc/150/12', 'advanced');

-- TAGS
INSERT INTO tags (tag_name, category) VALUES
('running',       'exercise_type'),
('cycling',       'exercise_type'),
('swimming',      'exercise_type'),
('yoga',          'exercise_type'),
('weightlifting', 'exercise_type'),
('cardio',        'exercise_type'),
('hiit',          'exercise_type'),
('dumbbells',     'equipment'),
('barbell',       'equipment'),
('bodyweight',    'equipment'),
('treadmill',     'equipment'),
('fat_loss',      'goal'),
('muscle_gain',   'goal'),
('endurance',     'goal'),
('flexibility',   'goal');

-- WORKOUTS
INSERT INTO workouts (user_id, date, duration, exercise_type, notes) VALUES
(1, '2026-02-06', 65, 'weightlifting', 'Leg day. Squats, leg press, lunges'),
(1, '2026-02-10', 70, 'weightlifting', 'Push day. Bench press, OHP, dips'),
(1, '2026-02-14', 60, 'weightlifting', 'Pull day. Deadlifts and rows'),
(3, '2026-02-07', 45, 'hiit',          'Competition prep circuit'),
(3, '2026-02-11', 75, 'weightlifting', 'Heavy compound session'),
(3, '2026-02-15', 50, 'cardio',        'Conditioning work, 5 sessions this week'),
(4, '2026-02-06', 80, 'weightlifting', 'Powerlifting 6am. Squat 170kg bench 115kg'),
(4, '2026-02-12', 75, 'weightlifting', 'Another 6am session. Technique work'),
(5, '2026-02-07', 50, 'hiit',          'Morning HIIT session before clients'),
(5, '2026-02-11', 60, 'weightlifting', 'Olympic lifting practice');

-- WORKOUT BUDDIES
INSERT INTO workout_buddies (user_id, fitness_level, goals, availability) VALUES
(1, 'intermediate', 'muscle_gain',           'Daily 7am'),
(3, 'intermediate', 'muscle_gain,endurance', 'Mon to Fri 6-8pm'),
(4, 'advanced',     'muscle_gain',           'Daily 6-8am'),
(5, 'advanced',     'muscle_gain,fat_loss',  'Weekday mornings 7-9am'),
(6, 'advanced',     'muscle_gain',           'Trains 6 days a week');

-- WORKOUT TAGS
INSERT INTO workout_tags (workout_id, tag_id) VALUES
(1, 5), (1, 9), (1, 13),
(2, 5), (2, 9), (2, 13),
(3, 5), (3, 9), (3, 13),
(4, 7), (4, 10),(4, 14),
(5, 5), (5, 9), (5, 13),
(6, 6), (6, 14),
(7, 5), (7, 9), (7, 13),
(8, 5), (8, 9), (8, 13),
(9, 7), (9, 10),(9, 12),
(10,5), (10,9), (10,13);

-- VERIFY
SELECT 'users' AS table_name, COUNT(*) AS total FROM users
UNION ALL SELECT 'workouts',        COUNT(*) FROM workouts
UNION ALL SELECT 'workout_buddies', COUNT(*) FROM workout_buddies
UNION ALL SELECT 'tags',            COUNT(*) FROM tags
UNION ALL SELECT 'workout_tags',    COUNT(*) FROM workout_tags;
