-- ============================================================================
-- FITSHARE DATABASE - SPRINT 2 SEED DATA
-- ============================================================================
-- Author: Anwar (Backend Lead)
-- Sprint: Sprint 2 (Feb 12-18, 2026)
-- Concept: Connecting gym-goers for consistency and accountability
-- Run AFTER: 01_create_tables.sql
-- ============================================================================

USE fitshare;

-- ============================================================================
-- SEED: USERS (15 gym members)
-- Passwords are bcrypt hashes of "Password123!" for all test accounts
-- ============================================================================

INSERT INTO users (email, password_hash, username, first_name, last_name, bio, profile_picture_url, fitness_level) VALUES

-- Beginners (just started, need accountability most)
('sarah.johnson@email.com',   '$2b$12$eImiTXuWVxfM37uY4JANjQ==', 'sarah_j',   'Sarah',   'Johnson',  'Just joined the gym and struggling to stay consistent. Looking for someone to go with so I actually show up!',                    'https://i.pravatar.cc/150?img=1',  'beginner'),
('marcus.lee@email.com',      '$2b$12$eImiTXuWVxfM37uY4JANjQ==', 'marcus_l',  'Marcus',  'Lee',      'Been paying for the gym for 3 months and barely going. Need a gym buddy to keep me accountable.',                              'https://i.pravatar.cc/150?img=3',  'beginner'),
('priya.patel@email.com',     '$2b$12$eImiTXuWVxfM37uY4JANjQ==', 'priya_p',   'Priya',   'Patel',    'New to the gym scene. Want someone to go with on Monday and Wednesday evenings — consistency is my goal.',                      'https://i.pravatar.cc/150?img=5',  'beginner'),
('tom.baker@email.com',       '$2b$12$eImiTXuWVxfM37uY4JANjQ==', 'tom_b',     'Tom',     'Baker',    'Started 2 months ago but keep skipping. A gym partner would make all the difference for me.',                                  'https://i.pravatar.cc/150?img=7',  'beginner'),
('amy.chen@email.com',        '$2b$12$eImiTXuWVxfM37uY4JANjQ==', 'amy_c',     'Amy',     'Chen',     'Beginner trying to build a habit. Goes to PureGym London Bridge — mornings before work.',                                      'https://i.pravatar.cc/150?img=9',  'beginner'),

-- Intermediate (established but want training partner)
('james.okafor@email.com',    '$2b$12$eImiTXuWVxfM37uY4JANjQ==', 'james_ok',  'James',   'Okafor',   'Been training 2 years. Consistent 4x a week but want a spotter for heavy lifts and someone to push me harder.',               'https://i.pravatar.cc/150?img=11', 'intermediate'),
('elena.ross@email.com',      '$2b$12$eImiTXuWVxfM37uY4JANjQ==', 'elena_r',   'Elena',   'Ross',     'Gym 3x a week after work. Looking for a like-minded person to train with — makes the session fly by!',                        'https://i.pravatar.cc/150?img=13', 'intermediate'),
('daniel.kim@email.com',      '$2b$12$eImiTXuWVxfM37uY4JANjQ==', 'daniel_k',  'Daniel',  'Kim',      'Weightlifting 4 days a week. Want a consistent gym partner to share the commute and keep each other on track.',               'https://i.pravatar.cc/150?img=15', 'intermediate'),
('fatima.hassan@email.com',   '$2b$12$eImiTXuWVxfM37uY4JANjQ==', 'fatima_h',  'Fatima',  'Hassan',   'Goes to gym every Tuesday and Thursday lunchtime. Would love a buddy who is reliable and committed.',                          'https://i.pravatar.cc/150?img=17', 'intermediate'),
('ryan.murphy@email.com',     '$2b$12$eImiTXuWVxfM37uY4JANjQ==', 'ryan_m',    'Ryan',    'Murphy',   'Training for a fitness competition. Goes 5x a week — need someone equally committed to keep the standard high.',              'https://i.pravatar.cc/150?img=19', 'intermediate'),

-- Advanced (experienced, want serious partners)
('zoe.williams@email.com',    '$2b$12$eImiTXuWVxfM37uY4JANjQ==', 'zoe_w',     'Zoe',     'Williams', 'Advanced lifter, 5 years training. Looking for a serious gym buddy who won't cancel last minute.',                            'https://i.pravatar.cc/150?img=21', 'advanced'),
('luca.ferrari@email.com',    '$2b$12$eImiTXuWVxfM37uY4JANjQ==', 'luca_f',    'Luca',    'Ferrari',  'Competitive powerlifter. Trains at 6am every day. Want a partner who is as committed to showing up as I am.',                'https://i.pravatar.cc/150?img=23', 'advanced'),
('aisha.robinson@email.com',  '$2b$12$eImiTXuWVxfM37uY4JANjQ==', 'aisha_r',   'Aisha',   'Robinson', 'Personal trainer and advanced gym member. Looking for a training partner at the same level who values consistency above all.', 'https://i.pravatar.cc/150?img=25', 'advanced'),
('harry.scott@email.com',     '$2b$12$eImiTXuWVxfM37uY4JANjQ==', 'harry_s',   'Harry',   'Scott',    'Trains 6 days a week. Consistency is everything to me — need a partner who shows up no matter what.',                        'https://i.pravatar.cc/150?img=27', 'advanced'),
('nina.volkov@email.com',     '$2b$12$eImiTXuWVxfM37uY4JANjQ==', 'nina_v',    'Nina',    'Volkov',   'Olympic weightlifter, now coaching. Trains afternoons. Want a partner to share the session and hold each other accountable.',  'https://i.pravatar.cc/150?img=29', 'advanced');


-- ============================================================================
-- SEED: WORKOUTS / GYM SESSIONS (27 sessions logged by members)
-- ============================================================================

INSERT INTO workouts (user_id, date, exercise_type, duration, notes) VALUES

-- Sarah (beginner - building consistency)
(1, '2026-02-05', 'Cardio',         30, 'First session in weeks. Just treadmill and bike. Felt good to actually show up!'),
(1, '2026-02-08', 'Yoga',           40, 'Stretching and yoga class. Less intimidating, building confidence in the gym.'),
(1, '2026-02-12', 'Cardio',         35, 'Went with a friend this time — made such a difference. Need a regular gym buddy!'),

-- Marcus (beginner - accountability seeker)
(2, '2026-02-06', 'Weightlifting',  45, 'Tried the weights area for first time. Was lost without knowing what to do. Need a buddy who knows the gym.'),
(2, '2026-02-11', 'Cardio',         50, 'Just cardio machines again. Really want someone to show me the weights properly.'),

-- Priya (beginner - evening sessions)
(3, '2026-02-07', 'Yoga',           50, 'Evening yoga class. Great start but want to add weights sessions too.'),
(3, '2026-02-10', 'Cardio',         30, 'Quick session after work. Would be so much easier with a gym partner to motivate me.'),
(3, '2026-02-14', 'Weightlifting',  40, 'Tried weights for the first time! Really need someone to show me the correct form.'),

-- James (intermediate - 4x per week lifter)
(6, '2026-02-05', 'Weightlifting',  65, 'Push day — bench, shoulders, triceps. Hit a new bench PB but had no spotter. Need a reliable gym buddy!'),
(6, '2026-02-09', 'Weightlifting',  70, 'Pull day — deadlifts, rows, pull-ups. Solid session. Would be better with someone to push me on last sets.'),
(6, '2026-02-13', 'Weightlifting',  60, 'Leg day. Squats felt strong. Consistency is key — been here 4x this week!'),

-- Elena (intermediate - after work sessions)
(7, '2026-02-05', 'HIIT',           30, 'Evening HIIT class. More fun when you go with someone — looking for a regular gym partner!'),
(7, '2026-02-08', 'Weightlifting',  50, 'Upper body session after work. Quiet gym tonight which was nice.'),
(7, '2026-02-12', 'HIIT',           35, 'Back to HIIT. Consistency building — 3 sessions this week for the first time!'),

-- Daniel (intermediate - wants consistent partner)
(8, '2026-02-06', 'Weightlifting',  65, 'Leg day. Squats, leg press, lunges. Train at the same time every day — need a partner who does the same.'),
(8, '2026-02-10', 'Weightlifting',  70, 'Push day. Bench press, OHP, dips. Great session — gym at 7am is so much better when someone is waiting for you.'),
(8, '2026-02-14', 'Weightlifting',  60, 'Pull day. Deadlifts and rows. Another consistent week — 3 sessions done.'),

-- Ryan (intermediate - competition training)
(10, '2026-02-07', 'HIIT',          45, 'Competition prep circuit. Need a partner who matches my intensity and won\'t let me slack off.'),
(10, '2026-02-11', 'Weightlifting', 75, 'Heavy compound session. Training partner would make the difference on heavy sets.'),
(10, '2026-02-15', 'Cardio',        50, 'Conditioning work. 5 sessions this week — consistency is non-negotiable for me.'),

-- Zoe (advanced - serious lifter)
(11, '2026-02-05', 'Weightlifting', 90, '5am session. Squats, bench, deadlift. Showing up every single day is the only way. Need a buddy who gets that.'),
(11, '2026-02-09', 'Weightlifting', 85, 'Accessory work and conditioning. Another day, another session. Consistency > motivation.'),
(11, '2026-02-13', 'Weightlifting', 95, 'Heavy deadlift day. PB of 110kg! Would have given up without the accountability mindset.'),

-- Luca (advanced - 6am every day)
(12, '2026-02-06', 'Weightlifting', 80, 'Powerlifting session 6am. Squat 170kg, bench 115kg. Early morning gym is a different world — need a partner who commits to 6am.'),
(12, '2026-02-12', 'Weightlifting', 75, 'Another 6am session. Technique work. If you can\'t commit to showing up, don\'t message me!'),

-- Aisha (advanced - PT and consistent trainer)
(13, '2026-02-07', 'HIIT',          50, 'Morning HIIT session before clients. Consistency is a habit, not a feeling.'),
(13, '2026-02-11', 'Weightlifting', 60, 'Olympic lifting practice. Clean & jerk, snatch. Looking for a partner at this level.');


-- ============================================================================
-- SEED: WORKOUT BUDDIES - gym matching profiles
-- availability reflects GYM SCHEDULE (days + times) for consistency matching
-- ============================================================================

INSERT INTO workout_buddies (user_id, fitness_level, goals, availability) VALUES
(1,  'beginner',     '["fat_loss","flexibility"]',          'Monday & Wednesday evenings 6-8pm'),
(2,  'beginner',     '["muscle_gain","fat_loss"]',          'Saturday & Sunday mornings 9-11am'),
(3,  'beginner',     '["flexibility","fat_loss"]',          'Monday, Wednesday & Friday evenings 6-7pm'),
(6,  'intermediate', '["muscle_gain"]',                     'Monday, Wednesday, Friday & Sunday 7-9am'),
(7,  'intermediate', '["fat_loss","muscle_gain"]',          'Monday, Tuesday & Thursday 5-7pm after work'),
(8,  'intermediate', '["muscle_gain"]',                     'Daily 7am — looking for same commitment level'),
(10, 'intermediate', '["muscle_gain","endurance"]',         'Monday to Friday 6-8pm, Saturday mornings'),
(11, 'advanced',     '["muscle_gain"]',                     'Daily 5-7am — serious enquiries only'),
(12, 'advanced',     '["muscle_gain"]',                     'Daily 6-8am — need someone who never cancels'),
(13, 'advanced',     '["muscle_gain","fat_loss"]',          'Weekday mornings 7-9am before work');


-- ============================================================================
-- SEED: WORKOUT TAGS
-- Tag IDs from 01_create_tables.sql seed:
--   1=running, 2=cycling, 3=swimming, 4=yoga, 5=weightlifting
--   6=cardio, 7=hiit, 8=dumbbells, 9=barbell, 10=bodyweight
--  11=treadmill, 12=fat_loss, 13=muscle_gain, 14=endurance, 15=flexibility
-- ============================================================================

INSERT INTO workout_tags (workout_id, tag_id) VALUES
-- Sarah's sessions (cardio + fat_loss)
(1, 6), (1, 11), (1, 12),
(2, 4), (2, 15),
(3, 6), (3, 12),

-- Marcus's sessions
(4, 5), (4, 8), (4, 13),
(5, 6), (5, 11),

-- Priya's sessions
(6, 4), (6, 15),
(7, 6), (7, 12),
(8, 5), (8, 8), (8, 13),

-- James's sessions (weightlifting + muscle gain)
(9,  5), (9,  9), (9,  13),
(10, 5), (10, 9), (10, 13),
(11, 5), (11, 9), (11, 13),

-- Elena's sessions
(12, 7), (12, 6), (12, 12),
(13, 5), (13, 8), (13, 13),
(14, 7), (14, 6), (14, 12),

-- Daniel's sessions
(15, 5), (15, 9), (15, 13),
(16, 5), (16, 9), (16, 13),
(17, 5), (17, 9), (17, 13),

-- Ryan's sessions
(18, 7), (18, 10), (18, 14),
(19, 5), (19, 9),  (19, 13),
(20, 6), (20, 14),

-- Zoe's sessions
(21, 5), (21, 9), (21, 13),
(22, 5), (22, 9), (22, 13),
(23, 5), (23, 9), (23, 13),

-- Luca's sessions
(24, 5), (24, 9), (24, 13),
(25, 5), (25, 9), (25, 13),

-- Aisha's sessions
(26, 7), (26, 10), (26, 12),
(27, 5), (27, 9),  (27, 13);


-- ============================================================================
-- VERIFICATION
-- ============================================================================

SELECT 'users'           AS table_name, COUNT(*) AS row_count FROM users
UNION ALL
SELECT 'workouts',         COUNT(*) FROM workouts
UNION ALL
SELECT 'workout_buddies',  COUNT(*) FROM workout_buddies
UNION ALL
SELECT 'tags',             COUNT(*) FROM tags
UNION ALL
SELECT 'workout_tags',     COUNT(*) FROM workout_tags;

-- Users + session count + buddy availability (core buddy matching query)
SELECT
    u.username,
    u.fitness_level,
    COUNT(w.id)   AS total_sessions,
    wb.availability,
    wb.goals
FROM users u
LEFT JOIN workouts w        ON w.user_id  = u.id
LEFT JOIN workout_buddies wb ON wb.user_id = u.id
GROUP BY u.id, u.username, u.fitness_level, wb.availability, wb.goals
ORDER BY total_sessions DESC;

-- ============================================================================
-- END OF SCRIPT
-- Sprint 2 Status: COMPLETE
-- Concept: Gym buddy consistency & accountability matching
-- Users: 15 | Sessions: 27 | Buddy Profiles: 10 | Tags: 70+
-- ============================================================================
