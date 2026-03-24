-- ============================================================================
-- FITSHARE DATABASE - CREATE TABLES
-- ============================================================================
-- Author: Anwar (Backend Lead)
-- Sprint: Sprint 1 (Feb 5-11, 2026)
-- Concept: Gym Buddy Consistency & Accountability Platform
-- Run this BEFORE: 02_seed_data.sql
-- ============================================================================

CREATE DATABASE IF NOT EXISTS fitshare
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE fitshare;

-- ============================================================================
-- TABLE 1: USERS
-- Stores all registered gym members
-- ============================================================================
CREATE TABLE IF NOT EXISTS users (
    id                  INT             NOT NULL AUTO_INCREMENT,
    email               VARCHAR(255)    NOT NULL,
    password_hash       VARCHAR(255)    NOT NULL,
    username            VARCHAR(50)     NOT NULL,
    first_name          VARCHAR(100),
    last_name           VARCHAR(100),
    bio                 TEXT,
    profile_picture_url VARCHAR(500),
    fitness_level       ENUM('beginner', 'intermediate', 'advanced') NOT NULL DEFAULT 'beginner',
    created_at          TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    CONSTRAINT uq_email    UNIQUE (email),
    CONSTRAINT uq_username UNIQUE (username),

    INDEX idx_email       (email),
    INDEX idx_username    (username),
    INDEX idx_fitness     (fitness_level)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ============================================================================
-- TABLE 2: WORKOUTS
-- Logs every gym session posted by a user
-- ============================================================================
CREATE TABLE IF NOT EXISTS workouts (
    id            INT           NOT NULL AUTO_INCREMENT,
    user_id       INT           NOT NULL,
    date          DATE          NOT NULL,
    exercise_type VARCHAR(100)  NOT NULL,
    duration      INT           NOT NULL COMMENT 'Duration in minutes',
    notes         TEXT,
    created_at    TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    CONSTRAINT fk_workouts_user
        FOREIGN KEY (user_id) REFERENCES users(id)
        ON DELETE CASCADE ON UPDATE CASCADE,

    INDEX idx_user_id       (user_id),
    INDEX idx_date          (date),
    INDEX idx_exercise_type (exercise_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ============================================================================
-- TABLE 3: WORKOUT_BUDDIES
-- Buddy matching profiles — one per user (UNIQUE constraint)
-- Stores gym schedule and goals for consistency matching
-- ============================================================================
CREATE TABLE IF NOT EXISTS workout_buddies (
    id            INT           NOT NULL AUTO_INCREMENT,
    user_id       INT           NOT NULL,
    fitness_level ENUM('beginner', 'intermediate', 'advanced') NOT NULL DEFAULT 'beginner',
    goals         TEXT          COMMENT 'JSON array e.g. ["muscle_gain","fat_loss"]',
    availability  VARCHAR(255)  COMMENT 'Gym schedule e.g. Mon/Wed/Fri mornings 7-9am',
    created_at    TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    CONSTRAINT uq_buddy_user UNIQUE (user_id),
    CONSTRAINT fk_buddies_user
        FOREIGN KEY (user_id) REFERENCES users(id)
        ON DELETE CASCADE ON UPDATE CASCADE,

    INDEX idx_buddy_fitness (fitness_level)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ============================================================================
-- TABLE 4: TAGS
-- Reusable labels for categorising gym sessions
-- Categories: exercise_type, equipment, goal
-- ============================================================================
CREATE TABLE IF NOT EXISTS tags (
    id         INT          NOT NULL AUTO_INCREMENT,
    tag_name   VARCHAR(50)  NOT NULL,
    category   ENUM('exercise_type', 'equipment', 'goal') NOT NULL DEFAULT 'exercise_type',
    created_at TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    CONSTRAINT uq_tag_name UNIQUE (tag_name),

    INDEX idx_tag_name (tag_name),
    INDEX idx_category (category)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ============================================================================
-- TABLE 5: WORKOUT_TAGS
-- Junction table — links workouts to tags (many-to-many)
-- Composite primary key prevents duplicate tag assignments
-- ============================================================================
CREATE TABLE IF NOT EXISTS workout_tags (
    workout_id INT NOT NULL,
    tag_id     INT NOT NULL,

    PRIMARY KEY (workout_id, tag_id),
    CONSTRAINT fk_wt_workout
        FOREIGN KEY (workout_id) REFERENCES workouts(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_wt_tag
        FOREIGN KEY (tag_id) REFERENCES tags(id)
        ON DELETE CASCADE ON UPDATE CASCADE,

    INDEX idx_workout_id (workout_id),
    INDEX idx_tag_id     (tag_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ============================================================================
-- SEED: TAGS (15 pre-loaded tags)
-- ============================================================================
INSERT IGNORE INTO tags (tag_name, category) VALUES
-- Exercise types
('running',       'exercise_type'),
('cycling',       'exercise_type'),
('swimming',      'exercise_type'),
('yoga',          'exercise_type'),
('weightlifting', 'exercise_type'),
('cardio',        'exercise_type'),
('hiit',          'exercise_type'),
-- Equipment
('dumbbells',     'equipment'),
('barbell',       'equipment'),
('bodyweight',    'equipment'),
('treadmill',     'equipment'),
-- Goals
('fat_loss',      'goal'),
('muscle_gain',   'goal'),
('endurance',     'goal'),
('flexibility',   'goal');


-- ============================================================================
-- VERIFY
-- ============================================================================
SHOW TABLES;
SELECT tag_name, category FROM tags ORDER BY category, tag_name;

-- ============================================================================
-- END OF SCRIPT
-- Sprint 1 Status: COMPLETE
-- Tables: users, workouts, workout_buddies, tags, workout_tags
-- ============================================================================
