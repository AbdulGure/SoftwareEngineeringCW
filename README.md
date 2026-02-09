# FitShare Project Plan: Feb 5 - March 5, 2026
## Complete Timeline & Task Allocation

**Team Structure:**
- **Frontend Team:** Jonathan (Member 1) + John (Member 2)
- **Backend Team:** Anwar (Member 3 - You) + Abdul (Member 4)

---

## 📅 WEEK-BY-WEEK BREAKDOWN

### **WEEK 1: Feb 5-11 - Sprint 1 Setup & Planning**

#### **Everyone (Shared Tasks)**
- [ ] Form team and exchange contact info (Feb 5)
- [ ] Set up WhatsApp/Discord group (Feb 5)
- [ ] Create GitHub repository (Feb 6)
- [ ] All members: Make at least 1 commit to GitHub (Feb 6-7)
- [ ] Install Docker and verify everyone can run `docker-compose up` (Feb 7-8)
- [ ] Complete Node.js/Express lab exercises (Feb 5-9)
- [ ] Review and finalize Sprint 1 PDF (Feb 9-10)
- [ ] **SUBMIT Sprint 1 PDF to Moodle** (Feb 10)
- [ ] Attend Week 4 Code Review meeting (Feb 10-11)

#### **Frontend Team Tasks**
- **Jonathan:** hi guys
  - [ ] Research fitness app UI/UX examples (Pinterest, Dribbble, RockMyRun, HeiaHeia, Garmin Connect, Lifesum / MyFitnessPal) added more
  - [ ] Draft initial wireframes for 5 core pages (paper sketches OK)
  - [ ] Choose color scheme and fonts
  
- **John:**
  - [ ] Research PUG templating basics
  - [ ] Find/create logo for FitShare
  - [ ] Start building component library ideas (buttons, cards, forms)

#### **Backend Team Tasks**
- **Anwar:**
  - [ ] Research MySQL database design for user profiles
  - [ ] Draft initial ERD (Entity Relationship Diagram)
  - [ ] List all database tables needed
  
- **Abdul:**
  - [ ] Research Express.js routing patterns
  - [ ] List all API endpoints needed (users, workouts, buddies)
  - [ ] Set up basic Express app structure in GitHub

**Deliverables:** Sprint 1 PDF submitted ✅

---

### **WEEK 2: Feb 12-18 - Sprint 2 Requirements & Design**

#### **Everyone (Shared Tasks)**
- [ ] Daily stand-up messages (5 min each day in group chat)
- [ ] Team meeting Monday Feb 17: Sprint 2 planning (1 hour)

#### **Frontend Team Tasks**
- **Jonathan:**
  - [ ] Create detailed wireframes using Figma/Balsamiq (Feb 12-15)
    - Homepage/Dashboard
    - User Profile page
    - Workout Listings page
    - Workout Detail page
    - Find Buddies page
  - [ ] Create activity diagrams for user flows (Feb 15-17)
  - [ ] Write user stories for frontend features (Feb 17-18)

- **John:**
  - [ ] Design mockups with colors/fonts applied (Feb 12-15)
  - [ ] Create responsive layout plans (mobile/desktop) (Feb 15-17)
  - [ ] Write user stories for UI interactions (Feb 17-18)
  - [ ] Start Sprint 2 documentation layout (Feb 17-18)

#### **Backend Team Tasks**
- **Anwar:**
  - [ ] Finalize database ERD diagram (Feb 12-14)
  - [ ] Create detailed table schemas with field types (Feb 14-16)
  - [ ] Write SQL scripts to create tables (Feb 16-18)
  - [ ] Write user stories for database features (Feb 17-18)

- **Abdul:**
  - [ ] Create use case diagram for all features (Feb 12-14)
  - [ ] Map out all API endpoints with request/response (Feb 14-16)
  - [ ] Create sequence diagrams for key interactions (Feb 16-18)
  - [ ] Write user stories for API features (Feb 17-18)

#### **Everyone - Sprint 2 Documentation**
- [ ] Compile all user stories into Sprint 2 doc (Feb 18)
- [ ] Take screenshot of Kanban board (Feb 18)
- [ ] Add GitHub links to document (Feb 18)
- [ ] **SUBMIT Sprint 2 PDF to Moodle** (Feb 18)

**Deliverables:** Sprint 2 PDF with wireframes, diagrams, user stories ✅

---

### **WEEK 3: Feb 19-25 - Sprint 3 Core Development START**

#### **Database Setup (Anwar - Priority 1)**
**Feb 19-21:**
- [ ] Create MySQL database in Docker container
- [ ] Run SQL scripts to create all tables:
  - `users` table (id, name, email, password_hash, fitness_level, bio, created_at)
  - `workouts` table (id, user_id, date, exercise_type, duration, notes)
  - `workout_buddies` table (id, user_id, fitness_level, goals, availability)
  - `tags` table (id, tag_name, category)
  - `workout_tags` table (workout_id, tag_id)
- [ ] Populate with test data (10-15 sample users, 20+ workouts)
- [ ] Test all database connections
- [ ] Document database setup in README

#### **Backend API Development (Abdul)**
**Feb 19-22:**
- [ ] Set up Express.js routing structure
- [ ] Create database connection module (db.js)
- [ ] Build API endpoints (Sprint 3 minimum):
  - `GET /api/users` - Get all users
  - `GET /api/users/:id` - Get user profile
  - `GET /api/workouts` - Get all workouts (workout listings)
  - `GET /api/workouts/:id` - Get workout detail
  - `GET /api/tags` - Get all tags/categories
- [ ] Test all endpoints with Postman/Thunder Client
- [ ] Document API endpoints in README

**Feb 22-25:**
- [ ] Add error handling to all routes
- [ ] Add data validation
- [ ] Create helper functions for common queries
- [ ] Code review with Anwar

#### **Frontend Pages (Jonathan)**
**Feb 19-22:**
- [ ] Set up PUG template structure (layout.pug, header.pug, footer.pug)
- [ ] Create base CSS file with color scheme and typography
- [ ] Build **Users List page** (`/users`)
  - Display all users from database
  - Show name, fitness level, brief bio
  - Card layout with profile pictures (use placeholder images)
- [ ] Build **User Profile page** (`/users/:id`)
  - Show detailed user info
  - Display their recent workouts
  - Show buddy matching availability

**Feb 22-25:**
- [ ] Add responsive CSS (mobile-friendly)
- [ ] Add navigation menu to all pages
- [ ] Polish UI with hover effects, spacing
- [ ] Test across different browsers
- [ ] Code review with John

#### **Frontend Pages (John)**
**Feb 19-22:**
- [ ] Build **Workout Listings page** (`/workouts`)
  - Display all workouts from database
  - Show exercise type, duration, user name
  - Filter by tags/categories
- [ ] Build **Workout Detail page** (`/workouts/:id`)
  - Full workout information
  - User who posted it
  - Related tags
  - Notes and tips

**Feb 22-25:**
- [ ] Build **Tags/Categories page** (`/tags`)
  - List all workout categories
  - Click to filter workouts by tag
  - Show count of workouts per tag
- [ ] Add CSS styling consistent with Jonathan's design
- [ ] Ensure all pages use same layout template
- [ ] Code review with Jonathan

#### **Everyone**
- [ ] Daily commits to GitHub (aim for 2-3 per person this week)
- [ ] Update Kanban board daily
- [ ] Team meeting Wed Feb 19: Sprint 3 kickoff (30 min)
- [ ] Team meeting Sun Feb 23: Progress check (30 min)

**Deliverables:** 5 working pages pulling from database ✅

---

### **WEEK 4: Feb 26 - March 4 - Sprint 3 Completion + Sprint 4 Advanced Features**

#### **Sprint 3 Final Push (Feb 26-27)**

**Everyone:**
- [ ] Test all 5 pages thoroughly
- [ ] Fix any bugs found
- [ ] Ensure consistent styling across all pages
- [ ] Verify all database queries work correctly

**Anwar:**
- [ ] Create database design document for Sprint 3 PDF
- [ ] Screenshot database structure (ERD)
- [ ] Document any database changes made

**Abdul:**
- [ ] Create API documentation for Sprint 3 PDF
- [ ] Take screenshots of GitHub metrics showing all members contributing
- [ ] Screenshot Kanban board

**Jonathan & 2:**
- [ ] Take screenshots of all 5 pages for documentation
- [ ] Create task breakdown document showing who did what
- [ ] Compile Sprint 3 PDF document

**Everyone:**
- [ ] **SUBMIT Sprint 3 PDF + GitHub links** (Feb 27)
- [ ] **Attend Week 10 Code Review** (March 3)

---

#### **Sprint 4 Advanced Features (Feb 28 - March 4)**

**Priority Features Based on Your Team's Pace:**

##### **HIGH PRIORITY (Must Have)**

**Anwar - User Authentication:**
**Feb 28 - March 2:**
- [ ] Add password hashing (bcrypt)
- [ ] Create login system
  - `POST /api/login` endpoint
  - Session management or JWT tokens
- [ ] Create registration system
  - `POST /api/register` endpoint
  - Form validation
- [ ] Add "Create Account" and "Login" pages

**Abdul - User Dashboard:**
**Feb 28 - March 2:**
- [ ] Create personalized dashboard (`/dashboard`)
- [ ] Show logged-in user's own workouts
- [ ] "Add New Workout" form
  - `POST /api/workouts` endpoint
  - Save to database
- [ ] "Edit Profile" functionality
  - `PUT /api/users/:id` endpoint

**Jonathan - Buddy Matching:**
**Feb 28 - March 2:**
- [ ] Build "Find Workout Buddies" page (`/buddies`)
- [ ] Basic matching algorithm:
  - Filter by fitness level
  - Filter by goals (weight loss, muscle gain, endurance)
  - Filter by availability (morning/afternoon/evening)
- [ ] Display matched buddies with compatibility score
- [ ] "Request Buddy" button (saves to database)

**John - Ratings/Points System:**
**Feb 28 - March 2:**
- [ ] Create `user_points` table
- [ ] Award points for:
  - Logging a workout (+10 points)
  - Helping a buddy (+5 points)
  - Consistent 7-day streak (+50 bonus)
- [ ] Display user points on profile
- [ ] Create leaderboard page (`/leaderboard`)
- [ ] Show top 10 users by points

---

##### **MEDIUM PRIORITY (If Time Allows)**

**Anwar - Equipment Lending (March 3-4):**
- [ ] Create `equipment` table
- [ ] Users can list equipment to lend
- [ ] Others can request to borrow
- [ ] Simple request/approval system

**Abdul - Search Functionality (March 3-4):**
- [ ] Add search bar to workouts page
- [ ] Search by exercise type, tags, user name
- [ ] Display filtered results

**Jonathan - Progress Tracking (March 3-4):**
- [ ] Create simple chart showing workout frequency
- [ ] Use Chart.js or similar library
- [ ] Display on user profile

**John - Workout Challenges (March 3-4):**
- [ ] Create `challenges` table
- [ ] "30-Day Plank Challenge" example
- [ ] Users can join challenges
- [ ] Track participation

---

##### **LOW PRIORITY (Bonus if Ahead)**

**Anyone - External APIs (March 4-5):**
- [ ] Weather API for outdoor workout recommendations
- [ ] Google Maps API for running routes
- [ ] Nutrition API for meal suggestions

---

#### **CI/CD Setup (March 3-4)**

**Abdul (Lead) + Anwar (Support):**
- [ ] Create `.github/workflows` folder
- [ ] Set up GitHub Action for automated testing:
  ```yaml
  # Example: Run tests on every push
  name: Test
  on: [push, pull_request]
  jobs:
    test:
      runs-on: ubuntu-latest
      steps:
        - uses: actions/checkout@v2
        - name: Run tests
          run: npm test
  ```
- [ ] Set up GitHub Action for Docker build:
  ```yaml
  # Verify Docker containers build successfully
  name: Docker Build
  on: [push]
  jobs:
    build:
      runs-on: ubuntu-latest
      steps:
        - uses: actions/checkout@v2
        - name: Build containers
          run: docker-compose build
  ```
- [ ] Test that actions run successfully
- [ ] Document CI/CD setup in README

---

### **WEEK 5: March 5 - Final Sprint 4 Submission & Presentation**

#### **March 5 - Sprint 4 Documentation**

**John (Documentation Lead):**
- [ ] Compile Sprint 4 PDF:
  - List of features implemented
  - Screenshots of new functionality
  - Explanation of matching algorithm or points system
  - Description of CI/CD workflows
  - User stories completed

**Jonathan:**
- [ ] Create presentation slides (PPT) for Week 13/14:
  - Slide 1: Project introduction
  - Slide 2: Problem we're solving
  - Slide 3: Key features demo
  - Slide 4: Ethical considerations
  - Slide 5: Technical architecture
  - Slide 6: Future plans

**Anwar:**
- [ ] Take final GitHub metrics screenshots
- [ ] Screenshot Kanban board
- [ ] Verify all team members have commits this sprint

**Abdul:**
- [ ] Write deployment instructions in README
- [ ] Test that fresh `git clone` + `docker-compose up` works
- [ ] Create demo video (2-3 minutes) showing app features

**Everyone:**
- [ ] Final testing of entire application
- [ ] Fix any critical bugs
- [ ] **SUBMIT Sprint 4 PDF + Presentation PPT to Moodle** (March 5)

---

## 📊 TASK ALLOCATION SUMMARY

### **Jonathan (Jonathan) - Frontend Lead**
**Total Tasks:** ~35 tasks
- Sprint 1: Wireframes & research (5 tasks)
- Sprint 2: Detailed wireframes + activity diagrams (10 tasks)
- Sprint 3: Users pages (10 tasks)
- Sprint 4: Buddy matching + presentation (10 tasks)

**Key Skills:** PUG, HTML, CSS, UX design, wireframing

---

### **John (John) - Frontend Developer**
**Total Tasks:** ~35 tasks
- Sprint 1: Logo & component research (5 tasks)
- Sprint 2: Mockups + documentation (10 tasks)
- Sprint 3: Workout pages + tags page (10 tasks)
- Sprint 4: Points/ratings system + documentation (10 tasks)

**Key Skills:** PUG, HTML, CSS, design, documentation

---

### **Anwar (Anwar - YOU) - Backend Lead (Database)**
**Total Tasks:** ~35 tasks
- Sprint 1: Database research + ERD (5 tasks)
- Sprint 2: Database schema + SQL scripts (10 tasks)
- Sprint 3: Database setup + test data (10 tasks)
- Sprint 4: User authentication + CI/CD support (10 tasks)

**Key Skills:** MySQL, database design, SQL, authentication

---

### **Abdul (Abdul) - Backend Developer (APIs)**
**Total Tasks:** ~35 tasks
- Sprint 1: Routing research + app structure (5 tasks)
- Sprint 2: API planning + diagrams (10 tasks)
- Sprint 3: API endpoints development (10 tasks)
- Sprint 4: Dashboard + CI/CD lead (10 tasks)

**Key Skills:** Express.js, Node.js, API design, DevOps

---

## 🎯 SUCCESS METRICS

### **Sprint 1 (Week 4):**
✅ PDF submitted with all sections
✅ GitHub repo with commits from all 4 members
✅ Everyone can run Docker

### **Sprint 3 (Week 10):**
✅ 5 working pages pulling from database
✅ All team members have substantial GitHub contributions
✅ Application runs in Docker

### **Sprint 4 (Week 13/14):**
✅ At least 2 advanced features working (login + one other)
✅ At least 1 GitHub Action implemented
✅ Professional presentation delivered
✅ MVP application ready to demo

---

## ⚠️ RISK MANAGEMENT

### **Potential Issues & Solutions:**

**Risk 1:** Team member falls behind
- **Solution:** Check in Wed/Sun every week, redistribute tasks if needed

**Risk 2:** Technical blocker (Docker issues, database not connecting)
- **Solution:** Pair programming session, ask module leader in lab

**Risk 3:** Merge conflicts in GitHub
- **Solution:** Everyone works on separate files, communicate before pushing

**Risk 4:** Sprint 3/4 scope too ambitious
- **Solution:** Focus on "must haves" first, drop "nice to haves" if time runs out

---

## 📝 WEEKLY MEETING STRUCTURE

**Every Monday 2-3 PM:**
1. Check-in: How is everyone doing? (5 min)
2. Review: What did we accomplish last week? (10 min)
3. Planning: What are we doing this week? (20 min)
4. Blockers: Any issues or help needed? (10 min)
5. Assign tasks: Who does what by when? (10 min)
6. Record meeting notes (5 min)

**Quick Stand-up (Daily in group chat):**
- What did I do yesterday?
- What will I do today?
- Any blockers?

---

## 🚀 TIPS FOR SUCCESS

1. **Commit early, commit often** - Don't wait until the last day
2. **Test your code** - Make sure it actually works before pushing
3. **Communicate proactively** - If stuck, ask for help immediately
4. **Start simple, add complexity** - Get basic version working first
5. **Document as you go** - Don't leave documentation until the end
6. **Use the lab sessions** - Get help from lecturers when available
7. **Backup everything** - Push to GitHub regularly

---

## 📅 KEY DEADLINES RECAP

- **Feb 10:** Sprint 1 PDF + Code Review
- **Feb 18:** Sprint 2 PDF
- **Feb 27:** Sprint 3 PDF
- **March 3:** Sprint 3 Code Review
- **March 5:** Sprint 4 PDF + Presentation
- **Week 13/14:** Final Presentation to Class

---

**Good luck! You've got this! 💪**

Remember: The goal is a working MVP (Minimum Viable Product), not perfection. Focus on core features first, polish later.
