-- ============================================================================
-- FITSHARE DATABASE - SPRINT 1 CORE TABLES
-- ============================================================================
-- Author: Anwar (Backend Lead)
-- Sprint: Sprint 1 (Feb 5-11, 2026)
-- Purpose: Create the 5 core tables for FitShare
-- ============================================================================

-- Create database
CREATE DATABASE IF NOT EXISTS fitshare 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE fitshare;

-- ============================================================================
-- TABLE 1: USERS
-- Purpose: Store user accounts and profiles
-- ============================================================================
CREATE TABLE users (
    -- Primary Key
    id INT PRIMARY KEY AUTO_INCREMENT,
    
    -- Login Credentials
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    
    -- Profile Information
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    bio TEXT,
    profile_picture_url VARCHAR(500),
    fitness_level ENUM('beginner', 'intermediate', 'advanced') DEFAULT 'beginner',
    
    -- Metadata
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Indexes for fast lookups
    INDEX idx_email (email),
    INDEX idx_username (username)
    
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- TABLE 2: WORKOUTS
-- Purpose: Log individual workout sessions
-- ============================================================================
CREATE TABLE workouts (
    -- Primary Key
    id INT PRIMARY KEY AUTO_INCREMENT,
    
    -- Foreign Key to Users
    user_id INT NOT NULL,
    
    -- Workout Details
    date DATE NOT NULL,
    exercise_type VARCHAR(100) NOT NULL,
    duration INT NOT NULL COMMENT 'Duration in minutes',
    notes TEXT,
    
    -- Metadata
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign Key Constraint
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    
    -- Indexes
    INDEX idx_user_id (user_id),
    INDEX idx_date (date),
    INDEX idx_exercise_type (exercise_type)
    
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- TABLE 3: WORKOUT_BUDDIES
-- Purpose: Store buddy matching preferences
-- ============================================================================
CREATE TABLE workout_buddies (
    -- Primary Key
    id INT PRIMARY KEY AUTO_INCREMENT,
    
    -- Foreign Key to Users (one-to-one relationship)
    user_id INT NOT NULL UNIQUE,
    
    -- Matching Criteria
    fitness_level ENUM('beginner', 'intermediate', 'advanced') NOT NULL,
    goals TEXT COMMENT 'JSON array: ["weight_loss", "muscle_gain"]',
    availability VARCHAR(100) COMMENT 'e.g., "Monday evening, Wednesday morning"',
    
    -- Metadata
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign Key Constraint
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    
    -- Index
    INDEX idx_fitness_level (fitness_level)
    
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- TABLE 4: TAGS
-- Purpose: Categorize workouts with reusable labels
-- ============================================================================
CREATE TABLE tags (
    -- Primary Key
    id INT PRIMARY KEY AUTO_INCREMENT,
    
    -- Tag Information
    tag_name VARCHAR(50) UNIQUE NOT NULL,
    category ENUM('exercise_type', 'equipment', 'goal') DEFAULT 'exercise_type',
    
    -- Metadata
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Index
    INDEX idx_tag_name (tag_name)
    
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- TABLE 5: WORKOUT_TAGS (Junction Table)
-- Purpose: Many-to-many relationship between workouts and tags
-- ============================================================================
CREATE TABLE workout_tags (
    -- Composite Primary Key (prevents duplicate tag assignments)
    workout_id INT NOT NULL,
    tag_id INT NOT NULL,
    PRIMARY KEY (workout_id, tag_id),
    
    -- Foreign Key Constraints
    FOREIGN KEY (workout_id) REFERENCES workouts(id) ON DELETE CASCADE,
    FOREIGN KEY (tag_id) REFERENCES tags(id) ON DELETE CASCADE,
    
    -- Indexes
    INDEX idx_workout_id (workout_id),
    INDEX idx_tag_id (tag_id)
    
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- SEED DATA: Sample Tags
-- ============================================================================

INSERT INTO tags (tag_name, category) VALUES
-- Exercise Types
('running', 'exercise_type'),
('cycling', 'exercise_type'),
('swimming', 'exercise_type'),
('yoga', 'exercise_type'),
('weightlifting', 'exercise_type'),
('cardio', 'exercise_type'),
('hiit', 'exercise_type'),

-- Equipment
('dumbbells', 'equipment'),
('barbell', 'equipment'),
('bodyweight', 'equipment'),
('treadmill', 'equipment'),

-- Goals
('fat_loss', 'goal'),
('muscle_gain', 'goal'),
('endurance', 'goal'),
('flexibility', 'goal');

-- ============================================================================
-- VERIFICATION QUERIES
-- ============================================================================

-- Show all tables
SHOW TABLES;

-- Verify table structures
DESCRIBE users;
DESCRIBE workouts;
DESCRIBE workout_buddies;
DESCRIBE tags;
DESCRIBE workout_tags;

-- Count rows
SELECT 'users' as table_name, COUNT(*) as row_count FROM users
UNION ALL SELECT 'workouts', COUNT(*) FROM workouts
UNION ALL SELECT 'workout_buddies', COUNT(*) FROM workout_buddies
UNION ALL SELECT 'tags', COUNT(*) FROM tags
UNION ALL SELECT 'workout_tags', COUNT(*) FROM workout_tags;

-- ============================================================================
-- SAMPLE QUERIES FOR TESTING
-- ============================================================================

-- Get all users
-- SELECT * FROM users;

-- Get user's workouts
-- SELECT * FROM workouts WHERE user_id = 1;

-- Get workout with its tags
-- SELECT w.*, GROUP_CONCAT(t.tag_name) as tags
-- FROM workouts w
-- LEFT JOIN workout_tags wt ON w.id = wt.workout_id
-- LEFT JOIN tags t ON wt.tag_id = t.id
-- WHERE w.id = 1
-- GROUP BY w.id;

-- Find potential workout buddies
-- SELECT u.username, wb.fitness_level, wb.goals
-- FROM workout_buddies wb
-- JOIN users u ON wb.user_id = u.id
-- WHERE wb.fitness_level = 'intermediate';

-- ============================================================================
-- END OF SCRIPT
-- ============================================================================
-- Sprint 1 Status: ✅ COMPLETE
-- Total Tables: 5
-- Next Step: Sprint 2 - Add sample data and test queries
-- ============================================================================
