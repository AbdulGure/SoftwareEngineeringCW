package com.fitshare.models;

import java.util.List;

public class User {
    private String name;
    private int points;
    private int streak;
    private String level;
    private List<String> goals;

    public User(String name, int points, int streak) {
        this.name = name;
        this.points = points;
        this.streak = streak;
    }

    public User(String name, String level, List<String> goals) {
        this.name = name;
        this.level = level;
        this.goals = goals;
    }

    public String getName() { return name; }
    public int getPoints() { return points; }
    public int getStreak() { return streak; }
    public String getLevel() { return level; }
    public List<String> getGoals() { return goals; }
}
