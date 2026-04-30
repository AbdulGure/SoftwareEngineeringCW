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

    // Get points for this user
    async getPoints() {
        const results = await db.query(
            'SELECT * FROM user_points WHERE user_id = ?',
            [this.id]
        );
        return results[0] || null;
    }

    // Get badges for this user
    async getBadges() {
        return await db.query(
            'SELECT * FROM user_badges WHERE user_id = ?',
            [this.id]
        );
    }

    // Get total workout count for this user
    async getWorkoutCount() {
        const results = await db.query(
            'SELECT COUNT(*) as count FROM workouts WHERE user_id = ?',
            [this.id]
        );
        return results[0].count;
    }

    // Get average buddy rating for this user
    async getAvgRating() {
        const results = await db.query(
            'SELECT AVG(rating) as avg, COUNT(*) as count FROM buddy_ratings WHERE rated_id = ?',
            [this.id]
        );
        return results[0];
    }

    // Get recent workouts for dashboard
    async getRecentWorkouts() {
        return await db.query(`
            SELECT * FROM workouts 
            WHERE user_id = ? 
            ORDER BY date DESC 
            LIMIT 5
        `, [this.id]);
    }

    // Get pending buddy requests count
    async getPendingRequestsCount() {
        const results = await db.query(`
            SELECT COUNT(*) as count FROM buddy_connections 
            WHERE buddy_id = ? AND status = 'pending'
        `, [this.id]);
        return results[0].count;
    }

    // Get leaderboard rank
    async getRank() {
        const results = await db.query(`
            SELECT COUNT(*) + 1 as user_rank 
            FROM user_points 
            WHERE total_points > COALESCE(
                (SELECT total_points FROM user_points WHERE user_id = ?), 0
            )
        `, [this.id]);
        return results[0].user_rank;
    }

    // Get all data needed for the profile page
    async getProfileData() {
        const [details, buddyProfile, tags, workouts, points, badges, workoutCount, avgRating] = await Promise.all([
            this.getById(),
            this.getBuddyProfile(),
            this.getTags(),
            this.getWorkouts(),
            this.getPoints(),
            this.getBadges(),
            this.getWorkoutCount(),
            this.getAvgRating()
        ]);
        return { user: details, buddy: buddyProfile, tags, workouts, points, badges, workoutCount, avgRating };
    }

    // Get all data needed for the dashboard page
    async getDashboardData() {
        const [details, points, badges, workoutCount, recentWorkouts, pendingRequests, rank] = await Promise.all([
            this.getById(),
            this.getPoints(),
            this.getBadges(),
            this.getWorkoutCount(),
            this.getRecentWorkouts(),
            this.getPendingRequestsCount(),
            this.getRank()
        ]);
        return {
            user: details,
            points,
            badges,
            workoutCount,
            recentWorkouts,
            pendingRequests,
            rank
        };
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