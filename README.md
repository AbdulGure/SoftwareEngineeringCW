# FitShare — Workout Buddy Platform

FitShare is a community fitness web application that connects people looking for workout partners. Users can log workouts, find buddies based on fitness level, earn points and badges, message each other, and track their progress on a leaderboard.

## Features

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

## Tech Stack

- Frontend: PUG, HTML5, CSS3, JavaScript
- Backend: Node.js, Express.js
- Database: MySQL 8.0
- Auth: bcryptjs, express-session
- DevOps: Docker, Docker Compose
- CI/CD: GitHub Actions
- APIs: OpenWeatherMap, API Ninjas

## Setup

1. Clone the repo
2. Create a .env file inside the pg-sd2 4 folder with your database credentials
3. Run docker-compose up inside pg-sd2 4
4. App runs at localhost:3000 and phpMyAdmin at localhost:8081
5. Load the SQL files from the databases folder in phpMyAdmin

## Team

- Anwar — Backend Lead, Database and Authentication
- Abdul — Backend Developer, API and CI/CD
- Jonathan — Frontend Lead, UI and Views
- John — Frontend Developer, Pages and Documentation

## Module

Software Engineering CMP-N204-0 — University of Roehampton — BSc Computer Science
