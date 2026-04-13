const db = require('../services/db');

class User {
    constructor(id) {
        this.id = id;
    }

    // Get user by ID
    async getById() {
        const sql = `SELECT * FROM users WHERE id = ?`;
        const results = await db.query(sql, [this.id]);
        return results[0];
    }

    // Get buddy profile for this user
    async getBuddyProfile() {
        const sql = `SELECT * FROM workout_buddies WHERE user_id = ?`;
        const results = await db.query(sql, [this.id]);
        return results[0];
    }

    // Get all tags from workouts this user has logged
    async getTags() {
        const sql = `
            SELECT DISTINCT t.tag_name, t.category
            FROM tags t
            JOIN workout_tags wt ON t.id = wt.tag_id
            JOIN workouts w ON wt.workout_id = w.id
            WHERE w.user_id = ?
        `;
        return await db.query(sql, [this.id]);
    }

    // Get all workouts for this user
    async getWorkouts() {
        const sql = `
            SELECT * FROM workouts 
            WHERE user_id = ? 
            ORDER BY date DESC
        `;
        return await db.query(sql, [this.id]);
    }

    // Find matching gym buddies by fitness level
    async findMatches() {
        const sql = `
            SELECT u.id, u.username, u.first_name, u.last_name, 
                   u.fitness_level, u.bio, u.profile_picture_url,
                   wb.goals, wb.availability
            FROM users u
            JOIN workout_buddies wb ON u.id = wb.user_id
            WHERE wb.fitness_level = (
                SELECT fitness_level FROM workout_buddies WHERE user_id = ?
            )
            AND u.id != ?
        `;
        return await db.query(sql, [this.id, this.id]);
    }

    // Get all users
    static async getAll() {
        const sql = `SELECT * FROM users ORDER BY created_at DESC`;
        return await db.query(sql);
    }
}

module.exports = User;