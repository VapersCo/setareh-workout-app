//
//  ProgressView.swift
//  Setareh's Workout App
//
//  Progress tracking and statistics
//

import SwiftUI

struct ProgressView: View {
    @EnvironmentObject var workoutStore: WorkoutStore
    @EnvironmentObject var progressStore: ProgressStore

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 12) {
                        Text("Your Progress")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.darkPink)

                        Text("Track your fitness journey")
                            .font(.subheadline)
                            .foregroundColor(.textLight)
                    }
                    .padding(.top, 20)

                    // Overall stats
                    VStack(spacing: 20) {
                        HStack(spacing: 20) {
                            StatCard(
                                title: "Total Workouts",
                                value: "\(getTotalCompletedWorkouts())",
                                subtitle: "Completed",
                                color: .accentPink,
                                icon: "checkmark.circle.fill"
                            )

                            StatCard(
                                title: "Current Streak",
                                value: "\(getCurrentStreak())",
                                subtitle: "Days",
                                color: .successGreen,
                                icon: "flame.fill"
                            )
                        }

                        HStack(spacing: 20) {
                            StatCard(
                                title: "This Week",
                                value: "\(getThisWeekWorkouts())",
                                subtitle: "Workouts",
                                color: .primaryPink,
                                icon: "calendar"
                            )

                            StatCard(
                                title: "Completion Rate",
                                value: "\(getCompletionRate())%",
                                subtitle: "Overall",
                                color: .darkPink,
                                icon: "chart.pie.fill"
                            )
                        }
                    }
                    .padding(.horizontal, 20)

                    // Individual workout progress
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Workout Progress")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.textDark)
                            .padding(.horizontal, 20)

                        VStack(spacing: 16) {
                            ForEach(workoutStore.workoutDays) { workoutDay in
                                WorkoutProgressRow(workoutDay: workoutDay)
                            }
                        }
                        .padding(.horizontal, 20)
                    }

                    // Recent activity
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Recent Activity")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.textDark)
                            .padding(.horizontal, 20)

                        VStack(spacing: 12) {
                            ForEach(getRecentActivity(), id: \.exerciseId) { progress in
                                if let exercise = workoutStore.getExercise(progress.exerciseId) {
                                    ActivityRow(exercise: exercise, progress: progress)
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                    }

                    Spacer(minLength: 50)
                }
            }
            .background(Color.bgPink.ignoresSafeArea())
            .navigationBarHidden(true)
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

    private func getThisWeekWorkouts() -> Int {
        // Calculate workouts completed this week
        return 0 // Placeholder
    }

    private func getCompletionRate() -> Int {
        let totalExercises = workoutStore.workoutDays.reduce(0) { $0 + $1.exercises.count }
        let completedExercises = getTotalCompletedWorkouts()

        guard totalExercises > 0 else { return 0 }
        return Int((Double(completedExercises) / Double(totalExercises)) * 100)
    }

    private func getRecentActivity() -> [ExerciseProgress] {
        return progressStore.exerciseProgress.values
            .filter { $0.lastCompletedDate != nil }
            .sorted { ($0.lastCompletedDate ?? Date.distantPast) > ($1.lastCompletedDate ?? Date.distantPast) }
            .prefix(10)
            .map { $0 }
    }
}

struct WorkoutProgressRow: View {
    let workoutDay: WorkoutDay
    @EnvironmentObject var progressStore: ProgressStore

    var body: some View {
        let completed = progressStore.getCompletedCount(for: workoutDay.id)
        let total = progressStore.getTotalExercises(for: workoutDay.id)
        let progress = Double(completed) / Double(total)

        VStack(spacing: 12) {
            HStack {
                Text(workoutDay.emoji)
                    .font(.title2)

                VStack(alignment: .leading, spacing: 4) {
                    Text(workoutDay.name)
                        .font(.headline)
                        .foregroundColor(.darkPink)

                    Text("\(completed) of \(total) exercises")
                        .font(.subheadline)
                        .foregroundColor(.textLight)
                }

                Spacer()

                Text("\(Int(progress * 100))%")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.accentPink)
            }

            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.secondaryPink.opacity(0.3))
                        .frame(height: 6)

                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.accentPink)
                        .frame(width: geometry.size.width * progress, height: 6)
                }
            }
            .frame(height: 6)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .shadowPink, radius: 5, x: 0, y: 2)
    }
}

struct ActivityRow: View {
    let exercise: Exercise
    let progress: ExerciseProgress

    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(Color.successGreen)
                .frame(width: 8, height: 8)

            VStack(alignment: .leading, spacing: 4) {
                Text(exercise.name)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.textDark)

                if let date = progress.lastCompletedDate {
                    Text(date.formatted(.relative(presentation: .named)))
                        .font(.caption)
                        .foregroundColor(.textLight)
                }
            }

            Spacer()

            Text("×\(progress.completedCount)")
                .font(.caption)
                .foregroundColor(.accentPink)
                .fontWeight(.semibold)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .shadowPink, radius: 3, x: 0, y: 1)
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let subtitle: String
    let color: Color
    let icon: String

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)

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
    ProgressView()
        .environmentObject(WorkoutStore())
        .environmentObject(ProgressStore())
}