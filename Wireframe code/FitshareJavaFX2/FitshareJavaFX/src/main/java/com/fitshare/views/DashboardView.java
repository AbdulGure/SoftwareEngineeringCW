package com.fitshare.views;

import com.fitshare.models.Buddy;
import com.fitshare.models.User;
import com.fitshare.models.Workout;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.control.*;
import javafx.scene.layout.*;
import javafx.scene.paint.*;
import javafx.scene.shape.Circle;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.stage.Stage;

import java.util.Arrays;
import java.util.List;

public class DashboardView {

    private final BorderPane root;
    private final Stage stage;

    private final User currentUser = new User("Alex", 2450, 14);
    private final Workout todayWorkout = new Workout("Upper Body Strength", "12-Week Strength Builder", 5, "45 min", false);

    private final List<Buddy> suggestedBuddies = Arrays.asList(
        new Buddy(1, "Sarah Chen", "Intermediate", 92, "", Arrays.asList("Weight Loss", "Cardio")),
        new Buddy(2, "Mike Rodriguez", "Intermediate", 88, "", Arrays.asList("Muscle Gain", "Strength")),
        new Buddy(3, "Emma Wilson", "Advanced", 85, "", Arrays.asList("Muscle Gain", "Cardio"))
    );

    private final String[][] recentActivity = {
        {"✅", "Completed Upper Body workout", "2 hours ago"},
        {"🏆", "New buddy request from Sarah Chen", "5 hours ago"},
        {"▶", "Started 12-Week Strength Builder", "1 day ago"},
        {"📈", "Earned 50 points", "1 day ago"}
    };

    public DashboardView(Stage stage) {
        this.stage = stage;
        this.root = new BorderPane();
        buildUI();
    }

    private void buildUI() {
        root.setBackground(new Background(new BackgroundFill(
            new LinearGradient(0, 0, 1, 1, true, CycleMethod.NO_CYCLE,
                new Stop(0, Color.web("#dbeafe")),
                new Stop(0.5, Color.web("#eff6ff")),
                new Stop(1, Color.WHITE)
            ), CornerRadii.EMPTY, Insets.EMPTY
        )));

        root.setTop(buildProfileHeader());
        root.setCenter(buildMainContent());
        root.setBottom(buildBottomNav());
    }

    // ─── PROFILE HEADER ─────────────────────────────────────────────────────────
    private HBox buildProfileHeader() {
        HBox header = new HBox(16);
        header.setPadding(new Insets(16, 32, 16, 32));
        header.setAlignment(Pos.CENTER_LEFT);
        header.setBackground(new Background(new BackgroundFill(Color.WHITE, CornerRadii.EMPTY, Insets.EMPTY)));
        header.setStyle("-fx-border-color: #dbeafe; -fx-border-width: 0 0 1 0;");

        Label logo = new Label("🏋 Fitshare");
        logo.setStyle("-fx-font-size: 22px; -fx-font-weight: bold; -fx-text-fill: #1e3a8a;");

        Region spacer = new Region();
        HBox.setHgrow(spacer, Priority.ALWAYS);

        Label notification = new Label("🔔");
        notification.setStyle("-fx-font-size: 20px; -fx-cursor: hand;");

        // Avatar circle
        StackPane avatar = new StackPane();
        Circle circle = new Circle(22, Color.web("#2563eb"));
        Label initials = new Label("A");
        initials.setStyle("-fx-text-fill: white; -fx-font-size: 18px; -fx-font-weight: bold;");
        avatar.getChildren().addAll(circle, initials);

        header.getChildren().addAll(logo, spacer, notification, avatar);
        return header;
    }

    // ─── MAIN SCROLLABLE CONTENT ────────────────────────────────────────────────
    private ScrollPane buildMainContent() {
        HBox content = new HBox(24);
        content.setPadding(new Insets(32, 32, 100, 32));

        // LEFT COLUMN (2/3 width)
        VBox leftCol = new VBox(24);
        HBox.setHgrow(leftCol, Priority.ALWAYS);
        leftCol.getChildren().addAll(
            buildWelcomeBanner(),
            buildTodayWorkout(),
            buildWeeklyStats(),
            buildQuickActions()
        );

        // RIGHT COLUMN (1/3 width)
        VBox rightCol = new VBox(24);
        rightCol.setPrefWidth(340);
        rightCol.setMinWidth(280);
        rightCol.getChildren().addAll(
            buildSuggestedBuddies(),
            buildRecentActivity()
        );

        content.getChildren().addAll(leftCol, rightCol);

        ScrollPane scrollPane = new ScrollPane(content);
        scrollPane.setFitToWidth(true);
        scrollPane.setStyle("-fx-background-color: transparent; -fx-background: transparent;");
        scrollPane.setHbarPolicy(ScrollPane.ScrollBarPolicy.NEVER);
        return scrollPane;
    }

    // ─── WELCOME BANNER ─────────────────────────────────────────────────────────
    private HBox buildWelcomeBanner() {
        HBox banner = new HBox(24);
        banner.setPadding(new Insets(32, 32, 32, 32));
        banner.setAlignment(Pos.CENTER_LEFT);
        banner.setBackground(new Background(new BackgroundFill(
            new LinearGradient(0, 0, 1, 0, true, CycleMethod.NO_CYCLE,
                new Stop(0, Color.web("#2563eb")),
                new Stop(1, Color.web("#1d4ed8"))
            ), new CornerRadii(16), Insets.EMPTY
        )));

        VBox textSection = new VBox(16);
        HBox.setHgrow(textSection, Priority.ALWAYS);
        Label welcome = new Label("Welcome back, " + currentUser.getName() + "! 👋");
        welcome.setStyle("-fx-font-size: 28px; -fx-font-weight: bold; -fx-text-fill: white;");

        HBox stats = new HBox(16);
        stats.getChildren().addAll(
            buildStatChip("🏆", String.valueOf(currentUser.getPoints()), "Total Points"),
            buildStatChip("🔥", currentUser.getStreak() + " 🔥", "Day Streak")
        );
        textSection.getChildren().addAll(welcome, stats);
        banner.getChildren().add(textSection);
        return banner;
    }

    private VBox buildStatChip(String icon, String value, String label) {
        HBox chip = new HBox(12);
        chip.setPadding(new Insets(12, 24, 12, 24));
        chip.setAlignment(Pos.CENTER_LEFT);
        chip.setBackground(new Background(new BackgroundFill(Color.web("#ffffff33"), new CornerRadii(12), Insets.EMPTY)));
        Label iconL = new Label(icon);
        iconL.setStyle("-fx-font-size: 24px;");
        VBox text = new VBox(2);
        Label valueL = new Label(value);
        valueL.setStyle("-fx-font-size: 26px; -fx-font-weight: bold; -fx-text-fill: white;");
        Label labelL = new Label(label);
        labelL.setStyle("-fx-font-size: 12px; -fx-text-fill: rgba(255,255,255,0.85);");
        text.getChildren().addAll(valueL, labelL);
        chip.getChildren().addAll(iconL, text);
        VBox wrapper = new VBox(chip);
        return wrapper;
    }

    // ─── TODAY'S WORKOUT ────────────────────────────────────────────────────────
    private VBox buildTodayWorkout() {
        VBox card = buildCard("Today's Workout");

        VBox inner = new VBox(12);
        inner.setPadding(new Insets(20));
        inner.setBackground(new Background(new BackgroundFill(
            new LinearGradient(0, 0, 0, 1, true, CycleMethod.NO_CYCLE,
                new Stop(0, Color.web("#eff6ff")),
                new Stop(1, Color.web("#dbeafe"))
            ), new CornerRadii(12), Insets.EMPTY
        )));
        inner.setStyle("-fx-border-color: #bfdbfe; -fx-border-width: 2; -fx-border-radius: 12;");

        Label name = new Label(todayWorkout.getName());
        name.setStyle("-fx-font-size: 20px; -fx-font-weight: bold; -fx-text-fill: #1e3a8a;");

        Label program = new Label("From: " + todayWorkout.getProgram());
        program.setStyle("-fx-font-size: 13px; -fx-text-fill: #2563eb;");

        HBox details = new HBox(20);
        details.getChildren().addAll(
            new Label("✔ " + todayWorkout.getExercises() + " exercises"),
            new Label("⏱ " + todayWorkout.getDuration())
        );
        details.getChildren().forEach(n -> ((Label) n).setStyle("-fx-font-size: 13px; -fx-text-fill: #1d4ed8;"));

        Button startBtn = new Button("▶  Start Workout");
        startBtn.setMaxWidth(Double.MAX_VALUE);
        startBtn.setStyle("-fx-background-color: #2563eb; -fx-text-fill: white; "
                + "-fx-font-size: 16px; -fx-background-radius: 8; -fx-cursor: hand; -fx-padding: 12 0;");

        inner.getChildren().addAll(name, program, details, startBtn);
        card.getChildren().add(inner);
        return card;
    }

    // ─── WEEKLY STATS ───────────────────────────────────────────────────────────
    private VBox buildWeeklyStats() {
        VBox card = buildCard("This Week's Progress");

        HBox statsRow = new HBox(16);
        statsRow.setAlignment(Pos.CENTER);

        statsRow.getChildren().addAll(
            buildMiniStat("4/6", "Workouts Done", "#f0fdf4", "#166534", "#dcfce7"),
            buildMiniStat("180", "Minutes Active", "#faf5ff", "#6b21a8", "#f3e8ff"),
            buildMiniStat("14", "Day Streak", "#fff7ed", "#9a3412", "#ffedd5")
        );

        card.getChildren().add(statsRow);
        return card;
    }

    private VBox buildMiniStat(String value, String label, String bgColor, String textColor, String borderColor) {
        VBox box = new VBox(4);
        box.setPadding(new Insets(16));
        box.setAlignment(Pos.CENTER);
        HBox.setHgrow(box, Priority.ALWAYS);
        box.setBackground(new Background(new BackgroundFill(Color.web(bgColor), new CornerRadii(12), Insets.EMPTY)));
        box.setStyle("-fx-border-color: " + borderColor + "; -fx-border-width: 1; -fx-border-radius: 12;");
        Label valueL = new Label(value);
        valueL.setStyle("-fx-font-size: 28px; -fx-font-weight: bold; -fx-text-fill: " + textColor + ";");
        Label labelL = new Label(label);
        labelL.setStyle("-fx-font-size: 12px; -fx-text-fill: " + textColor + ";");
        box.getChildren().addAll(valueL, labelL);
        return box;
    }

    // ─── QUICK ACTIONS ──────────────────────────────────────────────────────────
    private HBox buildQuickActions() {
        Button logBtn = new Button("✔  Log Workout\nMark completed");
        logBtn.setStyle("-fx-background-color: white; -fx-text-fill: #1e3a8a; "
                + "-fx-font-size: 15px; -fx-background-radius: 12; -fx-cursor: hand; "
                + "-fx-effect: dropshadow(gaussian, rgba(0,0,0,0.1), 8, 0, 0, 2); -fx-padding: 24;");
        HBox.setHgrow(logBtn, Priority.ALWAYS);
        logBtn.setMaxWidth(Double.MAX_VALUE);

        Button programBtn = new Button("📅  View Program\nSee full plan");
        programBtn.setStyle("-fx-background-color: white; -fx-text-fill: #1e3a8a; "
                + "-fx-font-size: 15px; -fx-background-radius: 12; -fx-cursor: hand; "
                + "-fx-effect: dropshadow(gaussian, rgba(0,0,0,0.1), 8, 0, 0, 2); -fx-padding: 24;");
        HBox.setHgrow(programBtn, Priority.ALWAYS);
        programBtn.setMaxWidth(Double.MAX_VALUE);

        HBox row = new HBox(16, logBtn, programBtn);
        return row;
    }

    // ─── SUGGESTED BUDDIES ──────────────────────────────────────────────────────
    private VBox buildSuggestedBuddies() {
        VBox card = buildCard("Suggested Buddies");

        for (Buddy buddy : suggestedBuddies) {
            card.getChildren().add(buildBuddyCard(buddy));
        }
        return card;
    }

    private VBox buildBuddyCard(Buddy buddy) {
        VBox card = new VBox(10);
        card.setPadding(new Insets(14));
        card.setBackground(new Background(new BackgroundFill(Color.WHITE, new CornerRadii(12), Insets.EMPTY)));
        card.setStyle("-fx-border-color: #dbeafe; -fx-border-width: 2; -fx-border-radius: 12;");

        // Top row: avatar + name + compatibility
        HBox topRow = new HBox(12);
        topRow.setAlignment(Pos.CENTER_LEFT);

        // Avatar with initials
        StackPane avatar = new StackPane();
        Circle avatarCircle = new Circle(24, Color.web("#93c5fd"));
        Label initials = new Label(buddy.getName().substring(0, 1));
        initials.setStyle("-fx-font-size: 18px; -fx-font-weight: bold; -fx-text-fill: #1e3a8a;");
        avatar.getChildren().addAll(avatarCircle, initials);
        avatar.setPrefSize(48, 48);
        avatar.setMaxSize(48, 48);

        VBox nameCol = new VBox(2);
        HBox.setHgrow(nameCol, Priority.ALWAYS);
        Label nameLabel = new Label(buddy.getName());
        nameLabel.setStyle("-fx-font-size: 15px; -fx-font-weight: bold; -fx-text-fill: #1e3a8a;");
        Label levelLabel = new Label(buddy.getLevel());
        levelLabel.setStyle("-fx-font-size: 12px; -fx-text-fill: #2563eb;");
        nameCol.getChildren().addAll(nameLabel, levelLabel);

        VBox matchCol = new VBox(2);
        matchCol.setAlignment(Pos.CENTER_RIGHT);
        Label matchVal = new Label(buddy.getCompatibility() + "%");
        matchVal.setStyle("-fx-font-size: 22px; -fx-font-weight: bold; -fx-text-fill: #16a34a;");
        Label matchLabel = new Label("Match");
        matchLabel.setStyle("-fx-font-size: 11px; -fx-text-fill: #16a34a;");
        matchCol.getChildren().addAll(matchVal, matchLabel);

        topRow.getChildren().addAll(avatar, nameCol, matchCol);

        // Goal tags
        HBox tags = new HBox(8);
        for (String goal : buddy.getSharedGoals()) {
            Label tag = new Label(goal);
            tag.setStyle("-fx-background-color: #eff6ff; -fx-text-fill: #2563eb; "
                    + "-fx-font-size: 11px; -fx-padding: 4 10; -fx-background-radius: 20;");
            tags.getChildren().add(tag);
        }

        Button connectBtn = new Button("Connect");
        connectBtn.setMaxWidth(Double.MAX_VALUE);
        connectBtn.setStyle("-fx-background-color: #2563eb; -fx-text-fill: white; "
                + "-fx-font-size: 13px; -fx-background-radius: 8; -fx-cursor: hand; -fx-padding: 8 0;");

        card.getChildren().addAll(topRow, tags, connectBtn);
        return card;
    }

    // ─── RECENT ACTIVITY ────────────────────────────────────────────────────────
    private VBox buildRecentActivity() {
        VBox card = buildCard("Recent Activity");

        for (String[] activity : recentActivity) {
            HBox row = new HBox(12);
            row.setPadding(new Insets(0, 0, 12, 0));
            row.setStyle("-fx-border-color: #dbeafe; -fx-border-width: 0 0 1 0;");
            Label icon = new Label(activity[0]);
            icon.setStyle("-fx-font-size: 18px;");
            VBox text = new VBox(2);
            Label action = new Label(activity[1]);
            action.setStyle("-fx-font-size: 13px; -fx-text-fill: #1e3a8a; -fx-wrap-text: true;");
            action.setWrapText(true);
            Label time = new Label(activity[2]);
            time.setStyle("-fx-font-size: 11px; -fx-text-fill: #93c5fd;");
            text.getChildren().addAll(action, time);
            row.getChildren().addAll(icon, text);
            card.getChildren().add(row);
        }
        return card;
    }

    // ─── BOTTOM NAVIGATION ──────────────────────────────────────────────────────
    private HBox buildBottomNav() {
        HBox nav = new HBox();
        nav.setAlignment(Pos.CENTER);
        nav.setPadding(new Insets(8, 0, 8, 0));
        nav.setBackground(new Background(new BackgroundFill(Color.WHITE, CornerRadii.EMPTY, Insets.EMPTY)));
        nav.setStyle("-fx-border-color: #dbeafe; -fx-border-width: 2 0 0 0; "
                + "-fx-effect: dropshadow(gaussian, rgba(0,0,0,0.15), 10, 0, 0, -3);");

        String[][] navItems = {
            {"🏠", "Home"},
            {"📖", "Programs"},
            {"👥", "Buddies"},
            {"🏆", "Rewards"},
            {"👤", "Profile"}
        };

        for (int i = 0; i < navItems.length; i++) {
            VBox item = buildNavItem(navItems[i][0], navItems[i][1], i == 0);
            HBox.setHgrow(item, Priority.ALWAYS);
            nav.getChildren().add(item);
        }
        return nav;
    }

    private VBox buildNavItem(String icon, String label, boolean active) {
        VBox item = new VBox(4);
        item.setAlignment(Pos.CENTER);
        item.setPadding(new Insets(8, 12, 8, 12));
        if (active) {
            item.setBackground(new Background(new BackgroundFill(Color.web("#eff6ff"), new CornerRadii(8), Insets.EMPTY)));
        }
        Label iconL = new Label(icon);
        iconL.setStyle("-fx-font-size: 22px;");
        Label labelL = new Label(label);
        labelL.setStyle("-fx-font-size: 11px; -fx-text-fill: " + (active ? "#2563eb" : "#6b7280") + ";");
        item.getChildren().addAll(iconL, labelL);
        item.setStyle("-fx-cursor: hand;");
        return item;
    }

    // ─── HELPER ─────────────────────────────────────────────────────────────────
    private VBox buildCard(String title) {
        VBox card = new VBox(16);
        card.setPadding(new Insets(24));
        card.setBackground(new Background(new BackgroundFill(Color.WHITE, new CornerRadii(16), Insets.EMPTY)));
        card.setStyle("-fx-effect: dropshadow(gaussian, rgba(0,0,0,0.1), 10, 0, 0, 3);");

        Label titleLabel = new Label(title);
        titleLabel.setStyle("-fx-font-size: 20px; -fx-font-weight: bold; -fx-text-fill: #1e3a8a;");
        card.getChildren().add(titleLabel);
        return card;
    }

    public BorderPane getRoot() { return root; }
}
