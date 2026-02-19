module com.fitshare {
    requires javafx.controls;
    requires javafx.fxml;
    requires javafx.graphics;

    opens com.fitshare to javafx.graphics;
    opens com.fitshare.views to javafx.graphics;
    opens com.fitshare.models to javafx.base;
    opens com.fitshare.controllers to javafx.fxml;

    exports com.fitshare;
    exports com.fitshare.views;
    exports com.fitshare.models;
}
