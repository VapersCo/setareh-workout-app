# Setareh's Workout App - iOS Version

A beautiful, native iOS app for Setareh's personalized 3-day workout program, built with SwiftUI.

## Features

- **Cute Pink Theme**: Matching the original web design with custom colors and animations
- **3-Day Workout Program**: Lower Body & Core, Upper Body & Core, and Full Body workouts
- **Progress Tracking**: Local persistence with UserDefaults
- **Video Integration**: YouTube video demonstrations for exercises
- **Native iOS Experience**: Haptic feedback, smooth animations, and iOS-optimized UI
- **Bilingual Support**: English and Persian text for exercises

## App Structure

```
ios-workout-app/
├── Package.swift                 # Swift Package Manager configuration
├── Sources/
│   └── SetarehWorkoutApp/
│       ├── SetarehWorkoutApp.swift    # App entry point
│       ├── Models/
│       │   └── WorkoutData.swift      # Data models and workout program
│       ├── Stores/
│       │   ├── WorkoutStore.swift     # Workout data management
│       │   └── ProgressStore.swift    # Progress tracking
│       ├── Theme/
│       │   └── Colors.swift           # Color theme and extensions
│       └── Views/
│           ├── ContentView.swift      # Main tab navigation
│           ├── HomeView.swift         # Welcome screen with avatar
│           ├── WorkoutsView.swift     # Workout program overview
│           ├── WorkoutDetailView.swift # Individual workout details
│           ├── ProgressView.swift     # Progress tracking
│           ├── SettingsView.swift     # App settings
│           ├── VideoPlayerView.swift  # Video player
│           └── Components/
│               └── WorkoutCard.swift  # Reusable workout card
├── Resources/
│   └── setareh-avatar.png        # Setareh's profile image
└── Tests/
    └── SetarehWorkoutAppTests/
```

## Requirements

- **iOS 15.0+**
- **Xcode 15+**
- **Swift 5.9+**
- **macOS Sonoma+**

## Development Setup

1. **Clone or copy the project structure**
2. **Open in Xcode**: Use Swift Package Manager to create a new iOS app project
3. **Add Resources**: Copy `setareh-avatar.png` to your Xcode project's asset catalog
4. **Build and Run**: Target iOS 15.0+ simulator or device

## Key Components

### Data Models
- `Exercise`: Individual exercise with sets, reps, rest, and video
- `WorkoutDay`: Complete workout session with warm-up, exercises, and cool-down
- `ExerciseProgress`: Completion tracking and statistics

### State Management
- `WorkoutStore`: Observable object for workout data
- `ProgressStore`: Observable object for progress tracking with UserDefaults persistence

### UI Components
- Custom pink color palette matching the web design
- Rounded cards with shadows and gradients
- Smooth animations and transitions
- Haptic feedback for interactions

## App Store Deployment

### Bundle Configuration
- **Bundle ID**: `com.setareh.workoutapp`
- **Display Name**: "Setareh's Workout"
- **Version**: 1.0.0
- **Minimum iOS**: 15.0

### Required Assets
- App icons (various sizes)
- Screenshots (iPhone 6.5", 5.5", iPad)
- App Store description and keywords
- Privacy policy (if collecting data)

### Permissions
- No special permissions required (local data only)

## Architecture Decisions

### SwiftUI vs UIKit
- **SwiftUI chosen** for modern, declarative UI and better maintainability
- Easier to match the cute design with SwiftUI's animation capabilities

### Data Persistence
- **UserDefaults** for simple progress tracking
- Could be upgraded to Core Data for more complex features

### Video Integration
- **WebView with YouTube embed** for simplicity and reliability
- Could be upgraded to native AVPlayer for offline videos

## Future Enhancements

- **HealthKit Integration**: Sync workouts with Apple Health
- **Notifications**: Workout reminders and streak notifications
- **Offline Videos**: Download videos for offline viewing
- **Custom Workouts**: Allow users to create custom workout programs
- **Social Features**: Share progress with friends
- **Dark Mode**: Automatic theme switching
- **Watch App**: Companion Apple Watch app

## Credits

- **Design**: Adapted from the original web app design
- **Development**: Built with SwiftUI by Kilo Code
- **Icons**: SF Symbols and custom emojis
- **Fonts**: Quicksand font family

---

Made with 💕 for Setareh