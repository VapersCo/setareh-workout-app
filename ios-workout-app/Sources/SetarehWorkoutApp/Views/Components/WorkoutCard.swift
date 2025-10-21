//
//  WorkoutCard.swift
//  Setareh's Workout App
//
//  Reusable card component for workout days
//

import SwiftUI

struct WorkoutCard: View {
    let workoutDay: WorkoutDay
    @EnvironmentObject var progressStore: ProgressStore

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(color: .shadowPink, radius: 8, x: 0, y: 4)

            VStack(alignment: .leading, spacing: 16) {
                // Header
                HStack {
                    Text(workoutDay.emoji)
                        .font(.largeTitle)

                    VStack(alignment: .leading, spacing: 4) {
                        Text(workoutDay.name)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.darkPink)

                        Text("\(workoutDay.exercises.count) exercises")
                            .font(.subheadline)
                            .foregroundColor(.textLight)
                    }

                    Spacer()

                    // Progress indicator
                    let completed = progressStore.getCompletedCount(for: workoutDay.id)
                    let total = progressStore.getTotalExercises(for: workoutDay.id)

                    VStack(spacing: 4) {
                        Text("\(completed)/\(total)")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.accentPink)

                        ZStack {
                            Circle()
                                .stroke(Color.secondaryPink.opacity(0.3), lineWidth: 4)
                                .frame(width: 40, height: 40)

                            Circle()
                                .trim(from: 0, to: CGFloat(completed) / CGFloat(total))
                                .stroke(Color.accentPink, lineWidth: 4)
                                .frame(width: 40, height: 40)
                                .rotationEffect(.degrees(-90))
                        }
                    }
                }

                // Exercise preview
                VStack(alignment: .leading, spacing: 8) {
                    Text("Exercises:")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.textDark)

                    ForEach(workoutDay.exercises.prefix(3)) { exercise in
                        HStack(spacing: 8) {
                            Circle()
                                .fill(progressStore.isExerciseCompleted(exercise.id) ? Color.successGreen : Color.secondaryPink.opacity(0.5))
                                .frame(width: 8, height: 8)

                            Text(exercise.name)
                                .font(.caption)
                                .foregroundColor(.textLight)
                                .lineLimit(1)

                            Spacer()

                            Text("\(exercise.sets)×\(exercise.reps)")
                                .font(.caption2)
                                .foregroundColor(.accentPink)
                                .fontWeight(.semibold)
                        }
                    }

                    if workoutDay.exercises.count > 3 {
                        Text("+\(workoutDay.exercises.count - 3) more exercises")
                            .font(.caption2)
                            .foregroundColor(.textLight)
                            .padding(.top, 4)
                    }
                }
            }
            .padding(20)
        }
        .frame(height: 200)
    }
}

#Preview {
    WorkoutCard(workoutDay: WorkoutProgram.days[0])
        .environmentObject(ProgressStore())
        .padding()
}