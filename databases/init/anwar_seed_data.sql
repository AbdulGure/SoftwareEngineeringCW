-- ============================================================================
-- FITSHARE - ANWAR'S SEED DATA
-- Author: Anwar (Backend Lead)
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
('sarah.johnson@email.com',  'password_hashed', 'sarah_j',  'Sarah',  'Johnson',  'Beginner looking for consistency',  'https://i.pravatar.cc/150/1', 'beginner'),
('marcus.lee@email.com',     'password_hashed', 'marcus_l', 'Marcus', 'Lee',      'Needs accountability',              'https://i.pravatar.cc/150/2', 'beginner'),
('priya.patel@email.com',    'password_hashed', 'priya_p',  'Priya',  'Patel',    'Evening gym sessions',              'https://i.pravatar.cc/150/3', 'beginner'),
('james.okafor@email.com',   'password_hashed', 'james_ok', 'James',  'Okafor',   'Intermediate lifter, 4x per week', 'https://i.pravatar.cc/150/4', 'intermediate'),
('elena.ross@email.com',     'password_hashed', 'elena_r',  'Elena',  'Ross',     'Gym 3x a week after work',          'https://i.pravatar.cc/150/5', 'intermediate'),
('zoe.williams@email.com',   'password_hashed', 'zoe_w',    'Zoe',    'Williams', 'Advanced lifter, 5 years training', 'https://i.pravatar.cc/150/6', 'advanced');

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
(1, '2026-02-01', 30, 'cardio',        'Getting started'),
(1, '2026-02-03', 40, 'yoga',          'Flexibility session'),
(2, '2026-02-02', 45, 'weightlifting', 'First weights session'),
(3, '2026-02-02', 35, 'cardio',        'Evening workout'),
(4, '2026-02-01', 60, 'weightlifting', 'Push day'),
(5, '2026-02-01', 30, 'hiit',          'Quick HIIT'),
(6, '2026-02-01', 90, 'weightlifting', 'Heavy session');

-- WORKOUT BUDDIES
INSERT INTO workout_buddies (user_id, fitness_level, goals, availability) VALUES
(1, 'beginner',     'fat_loss',    'Mon and Wed evenings'),
(2, 'beginner',     'muscle_gain', 'Weekends'),
(3, 'beginner',     'fat_loss',    'Evenings'),
(4, 'intermediate', 'muscle_gain', 'Morning'),
(5, 'intermediate', 'fat_loss',    'After work'),
(6, 'advanced',     'muscle_gain', 'Early mornings');

-- WORKOUT TAGS
INSERT INTO workout_tags (workout_id, tag_id) VALUES
(1, 6), (1, 12),
(2, 4), (2, 15),
(3, 5), (3, 13),
(4, 6),
(5, 5),
(6, 7), (6, 14),
(7, 5), (7, 13);

-- VERIFY
SELECT 'users' AS table_name, COUNT(*) AS total FROM users
UNION ALL SELECT 'workouts',        COUNT(*) FROM workouts
UNION ALL SELECT 'workout_buddies', COUNT(*) FROM workout_buddies
UNION ALL SELECT 'tags',            COUNT(*) FROM tags
UNION ALL SELECT 'workout_tags',    COUNT(*) FROM workout_tags;
