//
//  HomeView.swift
//  Setareh's Workout App
//
//  Welcome screen with user profile and quick access to workouts
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var workoutStore: WorkoutStore
    @EnvironmentObject var progressStore: ProgressStore

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 30) {
                    // Header with avatar
                    VStack(spacing: 20) {
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 160, height: 160)
                                .shadow(color: .shadowPink, radius: 10, x: 0, y: 5)

                            // Setareh's avatar image
                            if let avatarImage = UIImage(named: "setareh-avatar") {
                                Image(uiImage: avatarImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 140, height: 140)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.accentPink, lineWidth: 4))
                            } else {
                                // Fallback to emoji if image not found
                                Text("🌸")
                                    .font(.system(size: 80))
                            }
                        }
                        .padding(.top, 20)

                        VStack(spacing: 8) {
                            Text("Hi Setareh! 💕")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.darkPink)

                            Text("Ready for your workout today?")
                                .font(.subheadline)
                                .foregroundColor(.textLight)
                        }
                    }

                    // Today's workout suggestion
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Today's Workout")
                            .font(.headline)
                            .foregroundColor(.textDark)

                        // Simple day rotation based on current day
                        let todayWorkout = getTodayWorkout()

                        NavigationLink(destination: WorkoutDetailView(workoutDay: todayWorkout)) {
                            WorkoutCard(workoutDay: todayWorkout)
                        }
                    }

                    // Quick stats
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Your Progress")
                            .font(.headline)
                            .foregroundColor(.textDark)

                        HStack(spacing: 20) {
                            StatCard(
                                title: "Workouts",
                                value: "\(getTotalCompletedWorkouts())",
                                subtitle: "Completed",
                                color: .accentPink
                            )

                            StatCard(
                                title: "Streak",
                                value: "\(getCurrentStreak())",
                                subtitle: "Days",
                                color: .successGreen
                            )
                        }
                    }

                    Spacer(minLength: 50)
                }
                .padding(.horizontal, 20)
            }
            .background(Color.bgPink.ignoresSafeArea())
            .navigationBarHidden(true)
        }
    }

    private func getTodayWorkout() -> WorkoutDay {
        let weekday = Calendar.current.component(.weekday, from: Date())
        // Monday = 2, Wednesday = 4, Friday = 6
        switch weekday {
        case 2: return workoutStore.workoutDays[0] // Day 1
        case 4: return workoutStore.workoutDays[1] // Day 2
        case 6: return workoutStore.workoutDays[2] // Day 3
        default: return workoutStore.workoutDays[0] // Default to Day 1
        }
    }

    private func getTotalCompletedWorkouts() -> Int {
        var total = 0
        for day in workoutStore.workoutDays {
            total += progressStore.getCompletedCount(for: day.id)
        }
        return total
    }

    private func getCurrentStreak() -> Int {
        // Simple streak calculation - could be enhanced
        return 0 // Placeholder
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let subtitle: String
    let color: Color

    var body: some View {
        VStack(spacing: 8) {
            Text(value)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(color)

            Text(title)
                .font(.caption)
                .foregroundColor(.textLight)

            Text(subtitle)
                .font(.caption2)
                .foregroundColor(.textLight)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .shadowPink, radius: 5, x: 0, y: 2)
    }
}

#Preview {
    HomeView()
        .environmentObject(WorkoutStore())
        .environmentObject(ProgressStore())
}