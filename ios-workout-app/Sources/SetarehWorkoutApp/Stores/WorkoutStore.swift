//
//  WorkoutStore.swift
//  Setareh's Workout App
//
//  Observable object for managing workout data
//

import SwiftUI
import Combine

class WorkoutStore: ObservableObject {
    @Published var workoutDays: [WorkoutDay] = WorkoutProgram.days

    func getWorkoutDay(id: String) -> WorkoutDay? {
        return workoutDays.first { $0.id == id }
    }

    func getExercise(exerciseId: String) -> Exercise? {
        for day in workoutDays {
            if let exercise = day.exercises.first(where: { $0.id == exerciseId }) {
                return exercise
            }
        }
        return nil
    }
}