//
//  ProgressStore.swift
//  Setareh's Workout App
//
//  Observable object for managing workout progress
//

import SwiftUI
import Combine

class ProgressStore: ObservableObject {
    @Published var exerciseProgress: [String: ExerciseProgress] = [:] {
        didSet {
            saveProgress()
        }
    }

    private let progressKey = "setareh_workout_progress"

    init() {
        loadProgress()
    }

    func isExerciseCompleted(_ exerciseId: String) -> Bool {
        return exerciseProgress[exerciseId]?.completed ?? false
    }

    func toggleExerciseCompletion(_ exerciseId: String) {
        let currentProgress = exerciseProgress[exerciseId] ?? ExerciseProgress(
            exerciseId: exerciseId,
            completed: false,
            lastCompletedDate: nil,
            completedCount: 0
        )

        let newCompleted = !currentProgress.completed
        let newCount = newCompleted ? currentProgress.completedCount + 1 : currentProgress.completedCount

        exerciseProgress[exerciseId] = ExerciseProgress(
            exerciseId: exerciseId,
            completed: newCompleted,
            lastCompletedDate: newCompleted ? Date() : currentProgress.lastCompletedDate,
            completedCount: newCount
        )

        // Haptic feedback
        if newCompleted {
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        }
    }

    func getCompletedCount(for dayId: String) -> Int {
        let dayExercises = getExercisesForDay(dayId)
        return dayExercises.filter { isExerciseCompleted($0.id) }.count
    }

    func getTotalExercises(for dayId: String) -> Int {
        return getExercisesForDay(dayId).count
    }

    private func getExercisesForDay(_ dayId: String) -> [Exercise] {
        return WorkoutProgram.days.first { $0.id == dayId }?.exercises ?? []
    }

    private func saveProgress() {
        if let data = try? JSONEncoder().encode(exerciseProgress) {
            UserDefaults.standard.set(data, forKey: progressKey)
        }
    }

    private func loadProgress() {
        if let data = UserDefaults.standard.data(forKey: progressKey),
           let decoded = try? JSONDecoder().decode([String: ExerciseProgress].self, from: data) {
            exerciseProgress = decoded
        }
    }

    func resetProgress() {
        exerciseProgress.removeAll()
        UserDefaults.standard.removeObject(forKey: progressKey)
    }
}