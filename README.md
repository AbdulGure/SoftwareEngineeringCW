# 💪 FitShare — Workout Buddy Platform

FitShare is a community fitness web application that connects people looking for workout partners. Users can log workouts, find buddies based on fitness level, earn points and badges, message each other, and track their progress on a leaderboard.

## 🚀 Features

- User registration and login with bcrypt password hashing
- Personalised dashboard with stats, streaks and badges
- Workout logging with tags and points system
- Buddy matching by fitness level, goals and availability
- Connect, accept and rate workout buddies
- In-app messaging between connected users
- Leaderboard ranking users by total points
- Weather planner using OpenWeatherMap API
- Exercise suggestions using API Ninjas
- Dark mode toggle
- Admin role with user management
- Docker containerised deployment
- GitHub Actions CI/CD

## 🛠 Tech Stack

| Layer | Technology |
|-------|-----------|
| Frontend | PUG, HTML5, CSS3, JavaScript |
| Backend | Node.js, Express.js |
| Database | MySQL 8.0 |
| Auth | bcryptjs, express-session |
| DevOps | Docker, Docker Compose |
| CI/CD | GitHub Actions |
| APIs | OpenWeatherMap, API Ninjas |

## ⚙️ Setup & Installation

### Prerequisites
- Docker Desktop installed
- Git

### Clone the repo
\`\`\`bash
git clone https://github.com/AbdulGure/SoftwareEngineeringCW.git
cd SoftwareEngineeringCW
\`\`\`

### Create your .env file
Create a \`.env\` file inside the \`pg-sd2 4\` folder:
\`\`\`
MYSQL_HOST=localhost
MYSQL_USER=admin
MYSQL_PASS=password
MYSQL_ROOT_PASSWORD=password
MYSQL_DATABASE=fitshare
MYSQL_ROOT_USER=root
DB_CONTAINER=db
DB_PORT=3306
OPENWEATHER_API_KEY=your_key_here
API_NINJAS_KEY=your_key_here
\`\`\`

### Run with Docker
\`\`\`bash
cd "pg-sd2 4"
docker-compose up
\`\`\`

The app will be available at:
- **App** → http://localhost:3000
- **phpMyAdmin** → http://localhost:8081

### Load the database
Go to phpMyAdmin at localhost:8081 and run the SQL files in the databases folder.

## 👥 Team

| Name | Role |
|------|------|
| Anwar | Backend Lead — Database and Authentication |
| Abdul | Backend Developer — API and CI/CD |
| Jonathan | Frontend Lead — UI and Views |
| John | Frontend Developer — Pages and Documentation |

## 📁 Project Structure

\`\`\`
SoftwareEngineeringCW/
├── pg-sd2 4/
│   ├── app/
│   │   ├── models/        # User model with DB methods
│   │   ├── views/         # PUG templates
│   │   ├── services/      # Database connection
│   │   └── app.js         # Express routes
│   ├── static/            # CSS and images
│   ├── docker-compose.yml
│   ├── Dockerfile
│   └── package.json
├── databases/             # SQL seed files
└── .github/workflows/     # GitHub Actions CI/CD
\`\`\`

## 📋 Module

Software Engineering (CMP-N204-0) — University of Roehampton — BSc Computer Science
