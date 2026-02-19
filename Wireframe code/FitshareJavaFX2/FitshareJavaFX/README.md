# Fitshare JavaFX

A JavaFX port of the Fitshare Figma design — a fitness companion app for finding gyms, tracking workouts, and connecting with workout buddies.

## Project Structure

```
FitshareJavaFX/
├── pom.xml
└── src/main/java/
    ├── module-info.java
    └── com/fitshare/
        ├── MainApp.java                  ← Entry point
        ├── models/
        │   ├── User.java
        │   ├── Buddy.java
        │   └── Workout.java
        └── views/
            ├── LandingPageView.java      ← Header + Hero + About + Membership
            └── DashboardView.java        ← Dashboard + Navigation
```

## Screens Converted

| React Component     | JavaFX Class         |
|---------------------|----------------------|
| `LandingPage.tsx`   | `LandingPageView`    |
| `Header.tsx`        | Built into Landing   |
| `Hero.tsx`          | Built into Landing   |
| `About.tsx`         | Built into Landing   |
| `Membership.tsx`    | Built into Landing   |
| `Dashboard.tsx`     | `DashboardView`      |
| `Navigation.tsx`    | Built into Dashboard |
| `ProfileHeader.tsx` | Built into Dashboard |

## Requirements

- **Java 17+**
- **JavaFX 21** (via Maven dependency)
- **Maven 3.8+**

## Run

```bash
cd FitshareJavaFX
mvn javafx:run
```

## Build Fat JAR

```bash
mvn package
java -jar target/fitshare-javafx-1.0.0-shaded.jar
```

## Design Notes

- Tailwind color classes → JavaFX `Color.web()` hex values
- CSS gradients → JavaFX `LinearGradient`
- Flexbox layouts → `HBox` / `VBox` with `Priority.ALWAYS`
- CSS grid → `GridPane` / `HBox` with equal grow
- `rounded-*` → `CornerRadii`
- `shadow-*` → `-fx-effect: dropshadow(...)`
- Lucide icons → Unicode emoji equivalents
- React Router navigation → `Stage.setScene()`
