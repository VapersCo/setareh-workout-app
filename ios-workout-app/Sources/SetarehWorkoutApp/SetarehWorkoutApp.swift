//
//  SetarehWorkoutApp.swift
//  Setareh's Workout App - iOS Version
//
//  Created by Kilo Code
//  A beautiful, native iOS version of Setareh's workout app
//

import SwiftUI

@main
struct SetarehWorkoutApp: App {
    @StateObject private var workoutStore = WorkoutStore()
    @StateObject private var progressStore = ProgressStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(workoutStore)
                .environmentObject(progressStore)
                .preferredColorScheme(.light) // Keep the cute pink theme
        }
    }
}