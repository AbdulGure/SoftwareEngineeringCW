package com.fitshare.models;

import java.util.List;

public class Buddy {
    private int id;
    private String name;
    private String level;
    private int compatibility;
    private String imageUrl;
    private List<String> sharedGoals;

    public Buddy(int id, String name, String level, int compatibility, String imageUrl, List<String> sharedGoals) {
        this.id = id;
        this.name = name;
        this.level = level;
        this.compatibility = compatibility;
        this.imageUrl = imageUrl;
        this.sharedGoals = sharedGoals;
    }

    public int getId() { return id; }
    public String getName() { return name; }
    public String getLevel() { return level; }
    public int getCompatibility() { return compatibility; }
    public String getImageUrl() { return imageUrl; }
    public List<String> getSharedGoals() { return sharedGoals; }
}
