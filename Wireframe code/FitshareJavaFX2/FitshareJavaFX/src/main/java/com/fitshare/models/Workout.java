package com.fitshare.models;

public class Workout {
    private String name;
    private String program;
    private int exercises;
    private String duration;
    private boolean completed;

    public Workout(String name, String program, int exercises, String duration, boolean completed) {
        this.name = name;
        this.program = program;
        this.exercises = exercises;
        this.duration = duration;
        this.completed = completed;
    }

    public String getName() { return name; }
    public String getProgram() { return program; }
    public int getExercises() { return exercises; }
    public String getDuration() { return duration; }
    public boolean isCompleted() { return completed; }
    public void setCompleted(boolean completed) { this.completed = completed; }
}
