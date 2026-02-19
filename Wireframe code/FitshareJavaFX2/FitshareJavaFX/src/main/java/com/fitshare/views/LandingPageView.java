package com.fitshare.views;

import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.layout.*;
import javafx.scene.paint.Color;
import javafx.scene.paint.LinearGradient;
import javafx.scene.paint.CycleMethod;
import javafx.scene.paint.Stop;
import javafx.scene.shape.Circle;
import javafx.scene.shape.Rectangle;
import javafx.stage.Stage;

public class LandingPageView {

    private final BorderPane root;
    private final Stage stage;

    public LandingPageView(Stage stage) {
        this.stage = stage;
        this.root = new BorderPane();
        buildUI();
    }

    private void buildUI() {
        // Background gradient: blue-100 → blue-50 → white
        root.setBackground(new Background(new BackgroundFill(
            new LinearGradient(0, 0, 1, 1, true, CycleMethod.NO_CYCLE,
                new Stop(0, Color.web("#dbeafe")),
                new Stop(0.5, Color.web("#eff6ff")),
                new Stop(1, Color.WHITE)
            ), CornerRadii.EMPTY, Insets.EMPTY
        )));

        VBox mainContent = new VBox();
        mainContent.getChildren().addAll(
            buildHeader(),
            buildScrollableContent()
        );

        root.setCenter(mainContent);
    }

    // ─── HEADER ─────────────────────────────────────────────────────────────────
    private HBox buildHeader() {
        HBox header = new HBox();
        header.setPadding(new Insets(16, 32, 16, 32));
        header.setAlignment(Pos.CENTER);
        header.setBackground(new Background(new BackgroundFill(
            Color.web("#ffffffcc"), CornerRadii.EMPTY, Insets.EMPTY
        )));
        header.setStyle("-fx-border-color: #dbeafe; -fx-border-width: 0 0 1 0;");

        // Logo text (image asset not bundled)
        Label logo = new Label("🏋 Fitshare");
        logo.setStyle("-fx-font-size: 24px; -fx-font-weight: bold; -fx-text-fill: #1e3a8a;");

        Region spacer = new Region();
        HBox.setHgrow(spacer, Priority.ALWAYS);

        Button loginBtn = new Button("Login");
        loginBtn.setStyle("-fx-background-color: transparent; -fx-text-fill: #2563eb; "
                + "-fx-font-size: 14px; -fx-cursor: hand; -fx-border-color: transparent;");
        loginBtn.setOnAction(e -> navigateToDashboard());

        Button signUpBtn = new Button("Sign Up");
        signUpBtn.setStyle("-fx-background-color: #2563eb; -fx-text-fill: white; "
                + "-fx-font-size: 14px; -fx-background-radius: 8; -fx-cursor: hand; "
                + "-fx-padding: 8 24;");
        signUpBtn.setOnAction(e -> navigateToDashboard());
        signUpBtn.setOnMouseEntered(e -> signUpBtn.setStyle(
                "-fx-background-color: #1d4ed8; -fx-text-fill: white; "
                + "-fx-font-size: 14px; -fx-background-radius: 8; -fx-cursor: hand; -fx-padding: 8 24;"));
        signUpBtn.setOnMouseExited(e -> signUpBtn.setStyle(
                "-fx-background-color: #2563eb; -fx-text-fill: white; "
                + "-fx-font-size: 14px; -fx-background-radius: 8; -fx-cursor: hand; -fx-padding: 8 24;"));

        HBox buttons = new HBox(12, loginBtn, signUpBtn);
        buttons.setAlignment(Pos.CENTER_RIGHT);

        header.getChildren().addAll(logo, spacer, buttons);
        return header;
    }

    // ─── SCROLLABLE BODY ────────────────────────────────────────────────────────
    private javafx.scene.control.ScrollPane buildScrollableContent() {
        VBox body = new VBox();
        body.getChildren().addAll(buildHero(), buildAbout(), buildMembership());

        javafx.scene.control.ScrollPane scrollPane = new javafx.scene.control.ScrollPane(body);
        scrollPane.setFitToWidth(true);
        scrollPane.setStyle("-fx-background-color: transparent; -fx-background: transparent;");
        scrollPane.setHbarPolicy(javafx.scene.control.ScrollPane.ScrollBarPolicy.NEVER);
        VBox.setVgrow(scrollPane, Priority.ALWAYS);
        return scrollPane;
    }

    // ─── HERO SECTION ───────────────────────────────────────────────────────────
    private VBox buildHero() {
        VBox hero = new VBox(24);
        hero.setPadding(new Insets(80, 32, 80, 32));
        hero.setAlignment(Pos.CENTER);

        Label title = new Label("Find Your Fitness Journey");
        title.setStyle("-fx-font-size: 52px; -fx-text-fill: #1e3a8a; -fx-wrap-text: true;");
        title.setWrapText(true);
        title.setAlignment(Pos.CENTER);

        Label subtitle = new Label("Discover the best fitness centers and wellness deals in your area");
        subtitle.setStyle("-fx-font-size: 20px; -fx-text-fill: #1d4ed8;");
        subtitle.setWrapText(true);

        // Search bar
        HBox searchBar = new HBox(8);
        searchBar.setPadding(new Insets(8));
        searchBar.setAlignment(Pos.CENTER_LEFT);
        searchBar.setMaxWidth(600);
        searchBar.setBackground(new Background(new BackgroundFill(Color.WHITE, new CornerRadii(16), Insets.EMPTY)));
        searchBar.setStyle("-fx-effect: dropshadow(gaussian, rgba(0,0,0,0.15), 10, 0, 0, 3);");

        Label pinIcon = new Label("📍");
        pinIcon.setStyle("-fx-font-size: 20px; -fx-padding: 0 4 0 8;");

        TextField locationField = new TextField();
        locationField.setPromptText("Enter your location...");
        locationField.setStyle("-fx-font-size: 16px; -fx-background-color: transparent; -fx-border-color: transparent;");
        HBox.setHgrow(locationField, Priority.ALWAYS);

        Button searchBtn = new Button("🔍  Search");
        searchBtn.setStyle("-fx-background-color: #2563eb; -fx-text-fill: white; "
                + "-fx-font-size: 16px; -fx-background-radius: 12; -fx-cursor: hand; -fx-padding: 12 28;");

        searchBar.getChildren().addAll(pinIcon, locationField, searchBtn);

        hero.getChildren().addAll(title, subtitle, searchBar);
        return hero;
    }

    // ─── ABOUT SECTION ──────────────────────────────────────────────────────────
    private VBox buildAbout() {
        VBox about = new VBox(40);
        about.setPadding(new Insets(80, 64, 80, 64));
        about.setAlignment(Pos.CENTER);
        about.setBackground(new Background(new BackgroundFill(
            Color.web("#ffffff80"), CornerRadii.EMPTY, Insets.EMPTY
        )));

        Label title = new Label("About Fitshare");
        title.setStyle("-fx-font-size: 44px; -fx-text-fill: #1e3a8a;");

        Label desc = new Label(
            "Fitshare is your ultimate fitness companion, connecting you with premium gyms, " +
            "wellness centers, and exclusive fitness deals. We believe everyone deserves " +
            "access to quality fitness resources at affordable prices."
        );
        desc.setStyle("-fx-font-size: 18px; -fx-text-fill: #1d4ed8; -fx-wrap-text: true;");
        desc.setWrapText(true);
        desc.setMaxWidth(750);
        desc.setAlignment(Pos.CENTER);

        // Feature cards
        HBox cards = new HBox(24);
        cards.setAlignment(Pos.CENTER);

        String[][] features = {
            {"❤", "Wellness Focused", "We connect you with the best fitness centers and wellness programs tailored to your needs."},
            {"👥", "Community Driven", "Join a community of fitness enthusiasts and find workout partners in your area."},
            {"📈", "Track Progress", "Monitor your fitness journey with integrated tracking tools and personalized insights."},
            {"🎯", "Goal Oriented", "Set and achieve your fitness goals with expert guidance and motivation."}
        };

        for (String[] f : features) {
            cards.getChildren().add(buildFeatureCard(f[0], f[1], f[2]));
        }

        about.getChildren().addAll(title, desc, cards);
        return about;
    }

    private VBox buildFeatureCard(String icon, String title, String desc) {
        VBox card = new VBox(12);
        card.setPadding(new Insets(24));
        card.setAlignment(Pos.CENTER);
        card.setPrefWidth(220);
        card.setBackground(new Background(new BackgroundFill(Color.WHITE, new CornerRadii(12), Insets.EMPTY)));
        card.setStyle("-fx-effect: dropshadow(gaussian, rgba(0,0,0,0.1), 8, 0, 0, 2);");

        StackPane iconContainer = new StackPane();
        iconContainer.setPrefSize(64, 64);
        iconContainer.setMaxSize(64, 64);
        Circle circle = new Circle(32, Color.web("#dbeafe"));
        Label iconLabel = new Label(icon);
        iconLabel.setStyle("-fx-font-size: 28px;");
        iconContainer.getChildren().addAll(circle, iconLabel);

        Label titleLabel = new Label(title);
        titleLabel.setStyle("-fx-font-size: 18px; -fx-font-weight: bold; -fx-text-fill: #1e3a8a;");

        Label descLabel = new Label(desc);
        descLabel.setStyle("-fx-font-size: 13px; -fx-text-fill: #2563eb; -fx-wrap-text: true;");
        descLabel.setWrapText(true);

        card.getChildren().addAll(iconContainer, titleLabel, descLabel);
        return card;
    }

    // ─── MEMBERSHIP SECTION ─────────────────────────────────────────────────────
    private VBox buildMembership() {
        VBox section = new VBox(32);
        section.setPadding(new Insets(80, 64, 80, 64));
        section.setAlignment(Pos.CENTER);

        Label title = new Label("Premium Membership");
        title.setStyle("-fx-font-size: 44px; -fx-text-fill: #1e3a8a;");

        Label subtitle = new Label("Unlock exclusive features and find your perfect gym partner");
        subtitle.setStyle("-fx-font-size: 20px; -fx-text-fill: #1d4ed8;");

        // Membership card
        VBox card = new VBox();
        card.setMaxWidth(600);
        card.setBackground(new Background(new BackgroundFill(Color.WHITE, new CornerRadii(20), Insets.EMPTY)));
        card.setStyle("-fx-effect: dropshadow(gaussian, rgba(0,0,0,0.2), 20, 0, 0, 5);");

        // Card header
        VBox cardHeader = new VBox(8);
        cardHeader.setPadding(new Insets(40, 40, 40, 40));
        cardHeader.setAlignment(Pos.CENTER);
        cardHeader.setBackground(new Background(new BackgroundFill(
            new LinearGradient(0, 0, 1, 0, true, CycleMethod.NO_CYCLE,
                new Stop(0, Color.web("#2563eb")),
                new Stop(1, Color.web("#1e3a8a"))
            ), new CornerRadii(20, 20, 0, 0, false), Insets.EMPTY
        )));

        Label buddyIcon = new Label("👥");
        buddyIcon.setStyle("-fx-font-size: 40px;");

        Label planName = new Label("Gym Buddy Match");
        planName.setStyle("-fx-font-size: 28px; -fx-font-weight: bold; -fx-text-fill: white;");

        Label planDesc = new Label("Connect with experienced fitness partners");
        planDesc.setStyle("-fx-font-size: 18px; -fx-text-fill: white;");

        Label price = new Label("$9.99/month");
        price.setStyle("-fx-font-size: 44px; -fx-font-weight: bold; -fx-text-fill: white;");

        cardHeader.getChildren().addAll(buddyIcon, planName, planDesc, price);

        // Card body
        VBox cardBody = new VBox(20);
        cardBody.setPadding(new Insets(32, 40, 32, 40));

        String[][] perks = {
            {"Find Experienced Gym Buddies", "Get matched with experienced workout partners based on your fitness level and goals"},
            {"Personalized Matching", "Our algorithm connects you with partners who match your schedule and preferences"},
            {"Chat & Coordinate", "Message your gym buddies and plan your workouts together"},
            {"Verified Profiles", "All members are verified for a safe and trustworthy community"}
        };

        for (String[] perk : perks) {
            HBox row = new HBox(12);
            row.setAlignment(Pos.TOP_LEFT);
            Label checkIcon = new Label("✅");
            checkIcon.setStyle("-fx-font-size: 18px;");
            VBox textCol = new VBox(2);
            Label perkTitle = new Label(perk[0]);
            perkTitle.setStyle("-fx-font-size: 16px; -fx-font-weight: bold; -fx-text-fill: #1e3a8a;");
            Label perkDesc = new Label(perk[1]);
            perkDesc.setStyle("-fx-font-size: 13px; -fx-text-fill: #2563eb; -fx-wrap-text: true;");
            perkDesc.setWrapText(true);
            textCol.getChildren().addAll(perkTitle, perkDesc);
            row.getChildren().addAll(checkIcon, textCol);
            cardBody.getChildren().add(row);
        }

        Button trialBtn = new Button("Start Your Free Trial");
        trialBtn.setMaxWidth(Double.MAX_VALUE);
        trialBtn.setStyle("-fx-background-color: #2563eb; -fx-text-fill: white; "
                + "-fx-font-size: 18px; -fx-background-radius: 12; -fx-cursor: hand; -fx-padding: 14 0;");
        trialBtn.setOnAction(e -> navigateToDashboard());

        Label trialNote = new Label("7-day free trial • Cancel anytime");
        trialNote.setStyle("-fx-font-size: 13px; -fx-text-fill: #2563eb;");
        trialNote.setAlignment(Pos.CENTER);

        cardBody.getChildren().addAll(trialBtn, trialNote);
        card.getChildren().addAll(cardHeader, cardBody);
        section.getChildren().addAll(title, subtitle, card);
        return section;
    }

    // ─── NAVIGATION ─────────────────────────────────────────────────────────────
    private void navigateToDashboard() {
        DashboardView dashboard = new DashboardView(stage);
        javafx.scene.Scene scene = new javafx.scene.Scene(dashboard.getRoot(), 1280, 800);
        scene.getStylesheets().add(getClass().getResource("/styles/theme.css").toExternalForm());
        stage.setScene(scene);
    }

    public BorderPane getRoot() { return root; }
}
