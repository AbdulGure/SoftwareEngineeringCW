const express = require("express");
const path = require("path");
const session = require("express-session");
const bcrypt = require("bcryptjs");
const fetch = require("node-fetch");
const app = express();

// Middleware
app.use(express.static("static"));
app.use(express.urlencoded({ extended: true }));
app.use(express.json());

// Session
app.use(session({
    secret: "fitshare_secret_key",
    resave: false,
    saveUninitialized: false,
    cookie: { maxAge: 1000 * 60 * 60 * 24 }
}));

// View engine
app.set("views", path.join(__dirname, "views"));
app.set("view engine", "pug");

// Database
const db = require('./services/db');

// Model
const User = require('./models/users');

// Middleware to pass session user to all views
app.use((req, res, next) => {
    res.locals.sessionUser = req.session.user || null;
    next();
});

// -----------------------------
// Points Helper
// -----------------------------

async function awardPoints(userId, points, reason) {
    await db.query(`
        INSERT INTO user_points (user_id, total_points)
        VALUES (?, ?)
        ON DUPLICATE KEY UPDATE total_points = total_points + ?
    `, [userId, points, points]);

    const rows = await db.query(
        'SELECT total_points, current_streak FROM user_points WHERE user_id = ?',
        [userId]
    );
    if (rows.length === 0) return;
    const { total_points, current_streak } = rows[0];

    const badges = [
        { name: 'First Workout',    icon: '🏃', condition: total_points >= 10 },
        { name: 'On Fire',          icon: '🔥', condition: current_streak >= 3 },
        { name: 'Week Warrior',     icon: '⚡', condition: current_streak >= 7 },
        { name: 'Century Club',     icon: '💯', condition: total_points >= 100 },
        { name: 'Elite Athlete',    icon: '🏆', condition: total_points >= 500 },
        { name: 'Social Butterfly', icon: '🦋', condition: reason === 'buddy_connected' },
        { name: 'Helping Hand',     icon: '🤝', condition: reason === 'buddy_accepted' },
    ];

    for (const badge of badges) {
        if (badge.condition) {
            await db.query(`
                INSERT IGNORE INTO user_badges (user_id, badge_name, badge_icon)
                VALUES (?, ?, ?)
            `, [userId, badge.name, badge.icon]);
        }
    }
}

async function updateStreak(userId, workoutDate) {
    const rows = await db.query(
        'SELECT last_workout_date, current_streak, longest_streak FROM user_points WHERE user_id = ?',
        [userId]
    );

    if (rows.length === 0) {
        await db.query(`
            INSERT INTO user_points (user_id, current_streak, longest_streak, last_workout_date, total_points)
            VALUES (?, 1, 1, ?, 0)
        `, [userId, workoutDate]);
        return;
    }

    const { last_workout_date, current_streak, longest_streak } = rows[0];
    const last = last_workout_date ? new Date(last_workout_date) : null;
    const current = new Date(workoutDate);
    let newStreak = 1;

    if (last) {
        const diffDays = Math.floor((current - last) / (1000 * 60 * 60 * 24));
        if (diffDays === 1) newStreak = current_streak + 1;
        else if (diffDays === 0) newStreak = current_streak;
        else newStreak = 1;
    }

    const newLongest = Math.max(newStreak, longest_streak);

    await db.query(`
        UPDATE user_points 
        SET current_streak = ?, longest_streak = ?, last_workout_date = ?
        WHERE user_id = ?
    `, [newStreak, newLongest, workoutDate, userId]);
}

// -----------------------------
// Routes
// -----------------------------

app.get("/", (req, res) => {
    res.render("index");
});

// -----------------------------
// Auth Routes
// -----------------------------

app.get("/register", (req, res) => {
    res.render("register", { error: null });
});

app.post("/register", async (req, res) => {
    try {
        const { email, username, first_name, last_name, password, fitness_level } = req.body;
        const existing = await db.query(
            "SELECT id FROM users WHERE email = ? OR username = ?",
            [email, username]
        );
        if (existing.length > 0) {
            return res.render("register", { error: "Email or username already taken." });
        }
        const password_hash = await bcrypt.hash(password, 10);
        const result = await db.query(
            `INSERT INTO users (email, password_hash, username, first_name, last_name, fitness_level, role)
             VALUES (?, ?, ?, ?, ?, ?, 'user')`,
            [email, password_hash, username, first_name, last_name, fitness_level]
        );
        req.session.user = { id: result.insertId, username, email, fitness_level, role: 'user' };
        res.redirect("/dashboard");
    } catch (err) {
        console.error(err);
        res.render("register", { error: "Something went wrong. Please try again." });
    }
});

app.get("/login", (req, res) => {
    res.render("login", { error: null });
});

app.post("/login", async (req, res) => {
    try {
        const { email, password } = req.body;
        const users = await db.query(
            "SELECT * FROM users WHERE email = ?",
            [email]
        );
        if (users.length === 0) {
            return res.render("login", { error: "Invalid email or password." });
        }
        const user = users[0];
        const match = await bcrypt.compare(password, user.password_hash);
        if (!match) {
            return res.render("login", { error: "Invalid email or password." });
        }
        req.session.user = {
            id: user.id,
            username: user.username,
            email: user.email,
            fitness_level: user.fitness_level,
            role: user.role
        };
        res.redirect("/dashboard");
    } catch (err) {
        console.error(err);
        res.render("login", { error: "Something went wrong. Please try again." });
    }
});

app.get("/logout", (req, res) => {
    req.session.destroy();
    res.redirect("/login");
});

// -----------------------------
// Dashboard
// -----------------------------

app.get('/dashboard', async (req, res) => {
    if (!req.session.user) return res.redirect('/login');
    try {
        const userId = req.session.user.id;
        const user = new User(userId);
        const details = await user.getById();
        const points = await db.query(
            'SELECT * FROM user_points WHERE user_id = ?', [userId]
        );
        const badges = await db.query(
            'SELECT * FROM user_badges WHERE user_id = ?', [userId]
        );
        const workoutCount = await db.query(
            'SELECT COUNT(*) as count FROM workouts WHERE user_id = ?', [userId]
        );
        const recentWorkouts = await db.query(`
            SELECT * FROM workouts 
            WHERE user_id = ? 
            ORDER BY date DESC 
            LIMIT 5
        `, [userId]);
        const pendingRequests = await db.query(`
            SELECT COUNT(*) as count FROM buddy_connections 
            WHERE buddy_id = ? AND status = 'pending'
        `, [userId]);
        const rank = await db.query(`
            SELECT COUNT(*) + 1 as user_rank 
            FROM user_points 
            WHERE total_points > COALESCE(
                (SELECT total_points FROM user_points WHERE user_id = ?), 0
            )
        `, [userId]);
        res.render('dashboard', {
            user: details,
            points: points[0] || null,
            badges,
            workoutCount: workoutCount[0].count,
            recentWorkouts,
            pendingRequests: pendingRequests[0].count,
            rank: rank[0].user_rank
        });
    } catch (err) {
        console.error(err);
        res.status(500).send("Error loading dashboard");
    }
});

// -----------------------------
// Users (Admin only)
// -----------------------------

app.get('/users', async (req, res) => {
    if (!req.session.user) return res.redirect('/login');
    if (req.session.user.role !== 'admin') return res.redirect('/');
    try {
        const users = await User.getAll();
        res.render('user', { users });
    } catch (err) {
        console.error(err);
        res.status(500).send("Error loading users page");
    }
});

app.get('/user/:id', async (req, res) => {
    if (!req.session.user) return res.redirect('/login');
    try {
        const user = new User(req.params.id);
        const details = await user.getById();
        const buddyProfile = await user.getBuddyProfile();
        const tags = await user.getTags();
        const workouts = await user.getWorkouts();
        const points = await db.query(
            'SELECT * FROM user_points WHERE user_id = ?', [req.params.id]
        );
        const badges = await db.query(
            'SELECT * FROM user_badges WHERE user_id = ?', [req.params.id]
        );
        const workoutCount = await db.query(
            'SELECT COUNT(*) as count FROM workouts WHERE user_id = ?', [req.params.id]
        );
        const avgRating = await db.query(
            'SELECT AVG(rating) as avg, COUNT(*) as count FROM buddy_ratings WHERE rated_id = ?',
            [req.params.id]
        );
        res.render('profile', {
            user: details,
            buddy: buddyProfile,
            tags: tags,
            workouts: workouts,
            points: points[0] || null,
            badges: badges,
            workoutCount: workoutCount[0].count,
            avgRating: avgRating[0]
        });
    } catch (err) {
        console.error(err);
        res.status(500).send("Error loading user page");
    }
});

// -----------------------------
// Edit Profile
// -----------------------------

app.get('/user/:id/edit', async (req, res) => {
    if (!req.session.user) return res.redirect('/login');
    if (req.session.user.id != req.params.id) return res.redirect('/');
    try {
        const user = new User(req.params.id);
        const details = await user.getById();
        res.render('edit-profile', { user: details, error: null, success: null });
    } catch (err) {
        console.error(err);
        res.status(500).send("Error loading edit page");
    }
});

app.post('/user/:id/edit', async (req, res) => {
    if (!req.session.user) return res.redirect('/login');
    if (req.session.user.id != req.params.id) return res.redirect('/');
    try {
        const { first_name, last_name, bio, fitness_level, profile_picture_url } = req.body;
        await db.query(`
            UPDATE users 
            SET first_name = ?, last_name = ?, bio = ?, 
                fitness_level = ?, profile_picture_url = ?
            WHERE id = ?
        `, [first_name, last_name, bio, fitness_level, profile_picture_url, req.params.id]);
        req.session.user.fitness_level = fitness_level;
        res.render('edit-profile', {
            user: { ...req.body, id: req.params.id },
            error: null,
            success: 'Profile updated successfully!'
        });
    } catch (err) {
        console.error(err);
        res.status(500).send("Error updating profile");
    }
});

// -----------------------------
// Workouts
// -----------------------------

app.get('/workouts', async (req, res) => {
    if (!req.session.user) return res.redirect('/login');
    try {
        const workouts = await db.query(`
            SELECT w.*, u.first_name, u.last_name 
            FROM workouts w
            JOIN users u ON w.user_id = u.id
            ORDER BY w.date DESC
        `);
        res.render('workouts', { workouts });
    } catch (err) {
        console.error(err);
        res.status(500).send("Error loading workouts");
    }
});

app.get('/workouts/log', async (req, res) => {
    if (!req.session.user) return res.redirect('/login');
    try {
        const tags = await db.query('SELECT * FROM tags ORDER BY category, tag_name');
        res.render('log-workout', { tags, error: null });
    } catch (err) {
        console.error(err);
        res.status(500).send("Error loading workout form");
    }
});

app.post('/workouts', async (req, res) => {
    if (!req.session.user) return res.redirect('/login');
    try {
        const { date, exercise_type, duration, notes, tags } = req.body;
        const userId = req.session.user.id;
        const result = await db.query(
            `INSERT INTO workouts (user_id, date, exercise_type, duration, notes)
             VALUES (?, ?, ?, ?, ?)`,
            [userId, date, exercise_type, duration, notes || null]
        );
        const workoutId = result.insertId;
        if (tags) {
            const tagList = Array.isArray(tags) ? tags : [tags];
            for (const tagId of tagList) {
                await db.query(
                    'INSERT INTO workout_tags (workout_id, tag_id) VALUES (?, ?)',
                    [workoutId, tagId]
                );
            }
        }
        await updateStreak(userId, date);
        await awardPoints(userId, 10, 'workout_logged');
        const streakRows = await db.query(
            'SELECT current_streak FROM user_points WHERE user_id = ?', [userId]
        );
        if (streakRows.length > 0) {
            const streak = streakRows[0].current_streak;
            if (streak === 7)  await awardPoints(userId, 50, 'week_streak');
            if (streak === 30) await awardPoints(userId, 200, 'month_streak');
        }
        res.redirect('/workouts');
    } catch (err) {
        console.error(err);
        res.status(500).send("Error saving workout");
    }
});

app.get('/workouts/:id', async (req, res) => {
    if (!req.session.user) return res.redirect('/login');
    try {
        const workouts = await db.query(`
            SELECT w.*, u.first_name, u.last_name
            FROM workouts w
            JOIN users u ON w.user_id = u.id
            WHERE w.id = ?
        `, [req.params.id]);
        const tags = await db.query(`
            SELECT t.tag_name, t.category
            FROM tags t
            JOIN workout_tags wt ON t.id = wt.tag_id
            WHERE wt.workout_id = ?
        `, [req.params.id]);
        res.render('workout-detail', { workout: workouts[0], tags });
    } catch (err) {
        console.error(err);
        res.status(500).send("Error loading workout");
    }
});

// -----------------------------
// Leaderboard
// -----------------------------

app.get('/leaderboard', async (req, res) => {
    if (!req.session.user) return res.redirect('/login');
    try {
        const leaders = await db.query(`
            SELECT u.id, u.first_name, u.last_name, u.username,
                   u.profile_picture_url, u.fitness_level,
                   COALESCE(up.total_points, 0) as total_points,
                   COALESCE(up.current_streak, 0) as current_streak,
                   COALESCE(up.longest_streak, 0) as longest_streak,
                   COUNT(w.id) as workout_count
            FROM users u
            LEFT JOIN user_points up ON u.id = up.user_id
            LEFT JOIN workouts w ON u.id = w.user_id
            GROUP BY u.id
            ORDER BY total_points DESC
            LIMIT 20
        `);
        res.render('leaderboard', { leaders });
    } catch (err) {
        console.error(err);
        res.status(500).send("Error loading leaderboard");
    }
});

// -----------------------------
// Buddies
// -----------------------------

app.get('/buddies', async (req, res) => {
    if (!req.session.user) return res.redirect('/login');
    try {
        const buddies = await db.query(`
            SELECT u.id, u.first_name, u.last_name, u.username, 
                   u.fitness_level, u.bio, u.profile_picture_url,
                   wb.goals, wb.availability,
                   COALESCE(AVG(br.rating), 0) as avg_rating,
                   COUNT(br.id) as rating_count
            FROM users u
            JOIN workout_buddies wb ON u.id = wb.user_id
            LEFT JOIN buddy_ratings br ON u.id = br.rated_id
            GROUP BY u.id
            ORDER BY avg_rating DESC
        `);
        res.render('buddies', { buddies });
    } catch (err) {
        console.error(err);
        res.status(500).send("Error loading buddies page");
    }
});

app.get('/matches/:id', async (req, res) => {
    if (!req.session.user) return res.redirect('/login');
    try {
        const user = new User(req.params.id);
        const matches = await user.findMatches();
        let connectionStatuses = {};
        const conns = await db.query(`
            SELECT buddy_id, status FROM buddy_connections 
            WHERE user_id = ?
        `, [req.session.user.id]);
        conns.forEach(c => {
            connectionStatuses[c.buddy_id] = c.status;
        });
        res.render('matches', { matches, connectionStatuses });
    } catch (err) {
        console.error(err);
        res.status(500).send("Error loading matches");
    }
});

// -----------------------------
// Buddy Connections
// -----------------------------

app.post('/buddy/connect/:id', async (req, res) => {
    if (!req.session.user) return res.redirect('/login');
    try {
        await db.query(`
            INSERT IGNORE INTO buddy_connections (user_id, buddy_id, status)
            VALUES (?, ?, 'pending')
        `, [req.session.user.id, req.params.id]);
        await awardPoints(req.session.user.id, 5, 'buddy_connected');
        res.redirect('/connections');
    } catch (err) {
        console.error(err);
        res.status(500).send("Error sending connection request");
    }
});

app.post('/buddy/accept/:id', async (req, res) => {
    if (!req.session.user) return res.redirect('/login');
    try {
        await db.query(`
            UPDATE buddy_connections 
            SET status = 'accepted'
            WHERE user_id = ? AND buddy_id = ?
        `, [req.params.id, req.session.user.id]);
        await awardPoints(req.session.user.id, 10, 'buddy_accepted');
        res.redirect('/connections');
    } catch (err) {
        console.error(err);
        res.status(500).send("Error accepting request");
    }
});

app.post('/buddy/decline/:id', async (req, res) => {
    if (!req.session.user) return res.redirect('/login');
    try {
        await db.query(`
            DELETE FROM buddy_connections 
            WHERE user_id = ? AND buddy_id = ?
        `, [req.params.id, req.session.user.id]);
        res.redirect('/connections');
    } catch (err) {
        console.error(err);
        res.status(500).send("Error declining request");
    }
});

app.get('/connections', async (req, res) => {
    if (!req.session.user) return res.redirect('/login');
    try {
        const userId = req.session.user.id;
        const requests = await db.query(`
            SELECT u.id, u.first_name, u.last_name, 
                   u.profile_picture_url, u.fitness_level
            FROM buddy_connections bc
            JOIN users u ON bc.user_id = u.id
            WHERE bc.buddy_id = ? AND bc.status = 'pending'
        `, [userId]);
        const sent = await db.query(`
            SELECT u.id, u.first_name, u.last_name,
                   u.profile_picture_url, u.fitness_level
            FROM buddy_connections bc
            JOIN users u ON bc.buddy_id = u.id
            WHERE bc.user_id = ? AND bc.status = 'pending'
        `, [userId]);
        const connections = await db.query(`
            SELECT u.id, u.first_name, u.last_name,
                   u.profile_picture_url, u.fitness_level
            FROM buddy_connections bc
            JOIN users u ON bc.buddy_id = u.id
            WHERE bc.user_id = ? AND bc.status = 'accepted'
            UNION
            SELECT u.id, u.first_name, u.last_name,
                   u.profile_picture_url, u.fitness_level
            FROM buddy_connections bc
            JOIN users u ON bc.user_id = u.id
            WHERE bc.buddy_id = ? AND bc.status = 'accepted'
        `, [userId, userId]);
        res.render('connections', { requests, sent, connections });
    } catch (err) {
        console.error(err);
        res.status(500).send("Error loading connections");
    }
});

// -----------------------------
// Buddy Ratings
// -----------------------------

app.post('/buddy/rate/:id', async (req, res) => {
    if (!req.session.user) return res.redirect('/login');
    try {
        const { rating, review } = req.body;
        await db.query(`
            INSERT INTO buddy_ratings (rater_id, rated_id, rating, review)
            VALUES (?, ?, ?, ?)
            ON DUPLICATE KEY UPDATE rating = ?, review = ?
        `, [req.session.user.id, req.params.id, rating, review, rating, review]);
        res.redirect('/connections');
    } catch (err) {
        console.error(err);
        res.status(500).send("Error saving rating");
    }
});

// -----------------------------
// Messages
// -----------------------------

app.get('/messages', async (req, res) => {
    if (!req.session.user) return res.redirect('/login');
    try {
        const conversations = await db.query(`
            SELECT DISTINCT 
                u.id, u.first_name, u.last_name, 
                u.profile_picture_url, u.fitness_level,
                m.message as last_message,
                m.created_at as last_time
            FROM messages m
            JOIN users u ON (
                CASE 
                    WHEN m.sender_id = ? THEN m.receiver_id = u.id
                    ELSE m.sender_id = u.id
                END
            )
            WHERE m.sender_id = ? OR m.receiver_id = ?
            ORDER BY m.created_at DESC
        `, [req.session.user.id, req.session.user.id, req.session.user.id]);
        res.render('messages', { conversations });
    } catch (err) {
        console.error(err);
        res.status(500).send("Error loading messages");
    }
});

app.get('/messages/:id', async (req, res) => {
    if (!req.session.user) return res.redirect('/login');
    try {
        const otherId = req.params.id;
        const messages = await db.query(`
            SELECT m.*, u.first_name, u.last_name, u.profile_picture_url
            FROM messages m
            JOIN users u ON m.sender_id = u.id
            WHERE (m.sender_id = ? AND m.receiver_id = ?)
               OR (m.sender_id = ? AND m.receiver_id = ?)
            ORDER BY m.created_at ASC
        `, [req.session.user.id, otherId, otherId, req.session.user.id]);
        const otherUser = await db.query(
            'SELECT * FROM users WHERE id = ?', [otherId]
        );
        res.render('chat', {
            messages,
            otherUser: otherUser[0],
            sessionUser: req.session.user
        });
    } catch (err) {
        console.error(err);
        res.status(500).send("Error loading conversation");
    }
});

app.post('/messages/:id', async (req, res) => {
    if (!req.session.user) return res.redirect('/login');
    try {
        const { message } = req.body;
        await db.query(
            'INSERT INTO messages (sender_id, receiver_id, message) VALUES (?, ?, ?)',
            [req.session.user.id, req.params.id, message]
        );
        res.redirect('/messages/' + req.params.id);
    } catch (err) {
        console.error(err);
        res.status(500).send("Error sending message");
    }
});

// -----------------------------
// Weather API
// -----------------------------

app.get('/weather', async (req, res) => {
    if (!req.session.user) return res.redirect('/login');
    try {
        const city = req.query.city || 'London';
        const apiKey = process.env.OPENWEATHER_API_KEY;
        const response = await fetch(
            `https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${apiKey}&units=metric`
        );
        const data = await response.json();
        let recommendation = '';
        if (data.main) {
            const temp = data.main.temp;
            const weather = data.weather[0].main;
            if (weather === 'Rain' || weather === 'Snow' || weather === 'Thunderstorm') {
                recommendation = 'Bad weather outside — perfect day for an indoor workout! 🏋️';
            } else if (temp < 5) {
                recommendation = 'It\'s very cold outside — consider an indoor session today. 🥶';
            } else if (temp > 25) {
                recommendation = 'It\'s warm and sunny — great day for a run or cycle! ☀️';
            } else {
                recommendation = 'Great weather for an outdoor workout today! 🏃';
            }
        }
        res.render('weather', { weather: data, recommendation, city });
    } catch (err) {
        console.error(err);
        res.status(500).send("Error fetching weather");
    }
});

// -----------------------------
// Exercise API
// -----------------------------

app.get('/exercises', async (req, res) => {
    if (!req.session.user) return res.redirect('/login');
    try {
        const muscle = req.query.muscle || 'biceps';
        const apiKey = process.env.API_NINJAS_KEY;
        const response = await fetch(
            `https://api.api-ninjas.com/v1/exercises?muscle=${muscle}`,
            { headers: { 'X-Api-Key': apiKey } }
        );
        const exercises = await response.json();
        const muscles = [
            'biceps', 'triceps', 'chest', 'back', 'shoulders',
            'quadriceps', 'hamstrings', 'glutes', 'calves', 'abdominals'
        ];
        res.render('exercises', { exercises, muscle, muscles });
    } catch (err) {
        console.error(err);
        res.status(500).send("Error fetching exercises");
    }
});

// -----------------------------
// DB test
// -----------------------------

app.get("/db_test", async (req, res) => {
    try {
        const results = await db.query('SELECT * FROM test_table');
        res.send(results);
    } catch (err) {
        console.error(err);
        res.status(500).send("DB error");
    }
});

// -----------------------------
// Start Server
// -----------------------------

app.listen(3000, () => {
    console.log("Server running at http://127.0.0.1:3000/");
});