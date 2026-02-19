package com.fitshare;

import com.fitshare.views.LandingPageView;
import javafx.application.Application;
import javafx.scene.Scene;
import javafx.stage.Stage;

public class MainApp extends Application {

    @Override
    public void start(Stage primaryStage) {
        LandingPageView landingPage = new LandingPageView(primaryStage);
        Scene scene = new Scene(landingPage.getRoot(), 1280, 800);
        scene.getStylesheets().add(getClass().getResource("/styles/theme.css").toExternalForm());

        primaryStage.setTitle("Fitshare - Find Your Fitness Journey");
        primaryStage.setScene(scene);
        primaryStage.setMinWidth(800);
        primaryStage.setMinHeight(600);
        primaryStage.show();
    }

    public static void main(String[] args) {
        launch(args);
    }
}
