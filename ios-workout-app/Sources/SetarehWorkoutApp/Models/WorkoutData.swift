//
//  WorkoutData.swift
//  Setareh's Workout App
//
//  Data models for the 3-day workout program
//

import Foundation

// MARK: - Exercise Model
struct Exercise: Identifiable, Codable {
    let id: String
    let name: String
    let namePersian: String
    let sets: Int
    let reps: String // Can be number or range like "8-12"
    let rest: Int // seconds
    let videoId: String?
    let notes: String?

    var isCompleted: Bool = false
}

// MARK: - Workout Day Model
struct WorkoutDay: Identifiable, Codable {
    let id: String
    let name: String
    let emoji: String
    let exercises: [Exercise]

    var warmup: [WarmupExercise]
    var cooldown: CooldownExercise
}

// MARK: - Warmup Exercise Model
struct WarmupExercise: Codable {
    let name: String
    let namePersian: String
    let duration: String? // e.g., "2 minutes"
    let reps: String? // e.g., "10 each direction"
    let videoId: String? // YouTube Shorts video ID
}

// MARK: - Cooldown Exercise Model
struct CooldownExercise: Codable {
    let name: String
    let duration: String
}

// MARK: - Progress Tracking
struct ExerciseProgress: Codable {
    let exerciseId: String
    var completed: Bool
    var lastCompletedDate: Date?
    var completedCount: Int = 0
}

// MARK: - Workout Program
struct WorkoutProgram {
    static let days: [WorkoutDay] = [
        WorkoutDay(
            id: "day1",
            name: "Lower Body & Core",
            emoji: "🌸",
            exercises: [
                Exercise(
                    id: "d1-e1",
                    name: "Bodyweight Squats",
                    namePersian: "حرکت اسکوات",
                    sets: 3,
                    reps: "12",
                    rest: 60,
                    videoId: "L7FV0Z7k4No",
                    notes: "Keep chest up, weight in heels"
                ),
                Exercise(
                    id: "d1-e2",
                    name: "Reverse Lunges",
                    namePersian: "لانژ معکوس",
                    sets: 3,
                    reps: "10 each leg",
                    rest: 60,
                    videoId: "ljZA17b52FE",
                    notes: "Step back and lower until front knee is at 90 degrees"
                ),
                Exercise(
                    id: "d1-e3",
                    name: "Glute Bridges",
                    namePersian: "بریج باسن",
                    sets: 3,
                    reps: "15",
                    rest: 45,
                    videoId: "X_IGw8U_e38",
                    notes: "Squeeze glutes at the top, hold for 1 second"
                ),
                Exercise(
                    id: "d1-e4",
                    name: "Plank Hold",
                    namePersian: "پلانک",
                    sets: 3,
                    reps: "20-30 seconds",
                    rest: 45,
                    videoId: "oPgZR4jlZi4",
                    notes: "Keep body in straight line, don't let hips sag"
                ),
                Exercise(
                    id: "d1-e5",
                    name: "Dead Bug",
                    namePersian: "دد باگ",
                    sets: 3,
                    reps: "10 each side",
                    rest: 45,
                    videoId: "_wXaGBkegdY",
                    notes: "Lower back stays pressed to floor throughout"
                )
            ],
            warmup: [
                WarmupExercise(name: "Marching in place", namePersian: "مارش در محل", duration: "2 minutes"),
                WarmupExercise(name: "Hip circles", namePersian: "دایره ران", duration: "10 each direction"),
                WarmupExercise(name: "Leg swings", namePersian: "نوسان پا", duration: "10 each leg")
            ],
            cooldown: CooldownExercise(name: "Full body stretching", duration: "5 minutes")
        ),

        WorkoutDay(
            id: "day2",
            name: "Upper Body & Core",
            emoji: "✨",
            exercises: [
                Exercise(
                    id: "d2-e1",
                    name: "Push-ups",
                    namePersian: "شنا",
                    sets: 3,
                    reps: "8-12",
                    rest: 60,
                    videoId: "wD1M-f69Yy8",
                    notes: "Knee push-ups OK for beginners - keep elbows at 45 degrees"
                ),
                Exercise(
                    id: "d2-e2",
                    name: "Dumbbell Rows",
                    namePersian: "پارویی با دمبل",
                    sets: 3,
                    reps: "12 each arm",
                    rest: 60,
                    videoId: "WkFX6_GxAs8",
                    notes: "Pull elbow back and up, squeeze shoulder blade"
                ),
                Exercise(
                    id: "d2-e3",
                    name: "Dumbbell Shoulder Press",
                    namePersian: "پرس سرشانه",
                    sets: 3,
                    reps: "10",
                    rest: 60,
                    videoId: "k6tzKisR3NY",
                    notes: "Press straight up, don't arch back excessively"
                ),
                Exercise(
                    id: "d2-e4",
                    name: "Tricep Dips",
                    namePersian: "دیپ سه سر",
                    sets: 3,
                    reps: "10",
                    rest: 45,
                    videoId: "0M2W8MgC8Qk",
                    notes: "Use a chair or bench - keep shoulders down"
                ),
                Exercise(
                    id: "d2-e5",
                    name: "Russian Twists",
                    namePersian: "چرخش روسی",
                    sets: 3,
                    reps: "20 total",
                    rest: 45,
                    videoId: "KUsvxlmpPoI",
                    notes: "Twist from the core, tap floor on each side"
                )
            ],
            warmup: [
                WarmupExercise(name: "Arm circles", namePersian: "دایره بازو", duration: "10 each direction"),
                WarmupExercise(name: "Shoulder rolls", namePersian: "چرخش شانه", duration: "10 forward, 10 back"),
                WarmupExercise(name: "Cat-cow stretch", namePersian: "کشش گربه-گاو", duration: "10 reps")
            ],
            cooldown: CooldownExercise(name: "Upper body stretching", duration: "5 minutes")
        ),

        WorkoutDay(
            id: "day3",
            name: "Full Body",
            emoji: "🎀",
            exercises: [
                Exercise(
                    id: "d3-e1",
                    name: "Goblet Squats",
                    namePersian: "اسکوات گابلت",
                    sets: 3,
                    reps: "12",
                    rest: 60,
                    videoId: "7E-ugKcWeu4",
                    notes: "Hold dumbbell at chest, squat deep"
                ),
                Exercise(
                    id: "d3-e2",
                    name: "Step-ups",
                    namePersian: "بالا رفتن از پله",
                    sets: 3,
                    reps: "10 each leg",
                    rest: 60,
                    videoId: "OlsIQNNYszE",
                    notes: "Use stairs or sturdy platform, drive through heel"
                ),
                Exercise(
                    id: "d3-e3",
                    name: "Dumbbell Thrusters",
                    namePersian: "تراسترز",
                    sets: 3,
                    reps: "10",
                    rest: 60,
                    videoId: "k8QsgOFLp_g",
                    notes: "Squat + overhead press in one fluid motion"
                ),
                Exercise(
                    id: "d3-e4",
                    name: "Mountain Climbers",
                    namePersian: "کوهنوردی",
                    sets: 3,
                    reps: "20 total",
                    rest: 45,
                    videoId: "K3Xt4QH4b-U",
                    notes: "Keep hips level, drive knees to chest quickly"
                ),
                Exercise(
                    id: "d3-e5",
                    name: "Bird Dogs",
                    namePersian: "برد داگ",
                    sets: 3,
                    reps: "10 each side",
                    rest: 45,
                    videoId: "wh2spJeDDQs",
                    notes: "Extend opposite arm and leg, hold for 2 seconds"
                )
            ],
            warmup: [
                WarmupExercise(name: "Jumping jacks", namePersian: "جامپینگ جک", duration: "30 seconds"),
                WarmupExercise(name: "Bodyweight squats", namePersian: "اسکوات", duration: "10 reps"),
                WarmupExercise(name: "Arm swings", namePersian: "نوسان بازو", duration: "10 each direction")
            ],
            cooldown: CooldownExercise(name: "Full body cool down", duration: "5 minutes")
        )
    ]
}