//
//  WorkoutDetailView.swift
//  Setareh's Workout App
//
//  Detailed view for a specific workout day
//

import SwiftUI

struct WorkoutDetailView: View {
    let workoutDay: WorkoutDay
    @EnvironmentObject var progressStore: ProgressStore
    @State private var showingVideo = false
    @State private var selectedVideoId: String = ""

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header
                VStack(spacing: 16) {
                    Text(workoutDay.emoji)
                        .font(.system(size: 60))

                    VStack(spacing: 8) {
                        Text(workoutDay.name)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.darkPink)

                        let completed = progressStore.getCompletedCount(for: workoutDay.id)
                        let total = progressStore.getTotalExercises(for: workoutDay.id)

                        Text("\(completed) of \(total) exercises complete")
                            .font(.subheadline)
                            .foregroundColor(.textLight)
                    }

                    // Progress bar
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.secondaryPink.opacity(0.3))
                                .frame(height: 8)

                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.accentPink)
                                .frame(width: geometry.size.width * CGFloat(completed) / CGFloat(total), height: 8)
                        }
                    }
                    .frame(height: 8)
                    .padding(.horizontal, 40)
                }
                .padding(.top, 20)

                // Warm-up section
                VStack(alignment: .leading, spacing: 16) {
                    SectionHeader(title: "Warm-up (5 minutes)", emoji: "🏃‍♀️")

                    VStack(spacing: 12) {
                        ForEach(workoutDay.warmup, id: \.name) { warmup in
                            WarmupRow(warmup: warmup)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(color: .shadowPink, radius: 5, x: 0, y: 2)
                }
                .padding(.horizontal, 20)

                // Exercises section
                VStack(alignment: .leading, spacing: 16) {
                    SectionHeader(title: "Exercises", emoji: "💪")

                    VStack(spacing: 16) {
                        ForEach(workoutDay.exercises) { exercise in
                            ExerciseRow(exercise: exercise, showingVideo: $showingVideo, selectedVideoId: $selectedVideoId)
                        }
                    }
                }
                .padding(.horizontal, 20)

                // Cool-down section
                VStack(alignment: .leading, spacing: 16) {
                    SectionHeader(title: "Cool-down", emoji: "🧘‍♀️")

                    VStack(spacing: 12) {
                        Text(workoutDay.cooldown.name)
                            .font(.subheadline)
                            .foregroundColor(.textDark)

                        Text(workoutDay.cooldown.duration)
                            .font(.caption)
                            .foregroundColor(.textLight)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(color: .shadowPink, radius: 5, x: 0, y: 2)
                }
                .padding(.horizontal, 20)

                Spacer(minLength: 50)
            }
        }
        .background(Color.bgPink.ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingVideo) {
            VideoPlayerView(videoId: selectedVideoId)
        }
    }
}

struct SectionHeader: View {
    let title: String
    let emoji: String

    var body: some View {
        HStack {
            Text(emoji)
                .font(.title2)

            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.darkPink)

            Spacer()
        }
    }
}

struct WarmupRow: View {
    let warmup: WarmupExercise

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Circle()
                .fill(Color.secondaryPink.opacity(0.5))
                .frame(width: 8, height: 8)
                .padding(.top, 6)

            VStack(alignment: .leading, spacing: 4) {
                Text(warmup.name)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.textDark)

                Text("(\(warmup.namePersian))")
                    .font(.caption)
                    .foregroundColor(.textLight)
                    .italic()

                Text(warmup.duration ?? warmup.reps ?? "")
                    .font(.caption)
                    .foregroundColor(.accentPink)
            }

            Spacer()

            // Video button for warmup exercises
            if let videoId = warmup.videoId {
                Button(action: {
                    // Open YouTube Shorts in new tab (works better on mobile)
                    if let url = URL(string: "https://www.youtube.com/shorts/\(videoId)") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Image(systemName: "play.circle.fill")
                        .font(.title3)
                        .foregroundColor(.accentPink)
                }
            }
        }
    }
}

struct ExerciseRow: View {
    let exercise: Exercise
    @EnvironmentObject var progressStore: ProgressStore
    @Binding var showingVideo: Bool
    @Binding var selectedVideoId: String

    var body: some View {
        VStack(spacing: 16) {
            // Exercise header
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(exercise.name)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.darkPink)

                    Text("(\(exercise.namePersian))")
                        .font(.subheadline)
                        .foregroundColor(.textLight)
                        .italic()
                }

                Spacer()

                // Completion checkbox
                Button(action: {
                    progressStore.toggleExerciseCompletion(exercise.id)
                }) {
                    Image(systemName: progressStore.isExerciseCompleted(exercise.id) ? "checkmark.circle.fill" : "circle")
                        .font(.title2)
                        .foregroundColor(progressStore.isExerciseCompleted(exercise.id) ? .successGreen : .accentPink)
                }
            }

            // Exercise details
            HStack(spacing: 20) {
                ExerciseDetail(label: "Sets", value: "\(exercise.sets)")
                ExerciseDetail(label: "Reps", value: exercise.reps)
                ExerciseDetail(label: "Rest", value: "\(exercise.rest)s")
            }

            // Notes
            if let notes = exercise.notes {
                Text(notes)
                    .font(.caption)
                    .foregroundColor(.textLight)
                    .multilineTextAlignment(.leading)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .background(Color.bgPink)
                    .cornerRadius(8)
            }

            // Video button
            if let videoId = exercise.videoId {
                Button(action: {
                    selectedVideoId = videoId
                    showingVideo = true
                }) {
                    HStack {
                        Image(systemName: "play.circle.fill")
                        Text("Watch Video")
                    }
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(Color.accentPink)
                    .cornerRadius(25)
                    .shadow(color: .shadowDark, radius: 5, x: 0, y: 2)
                }
            }
        }
        .padding()
        .background(progressStore.isExerciseCompleted(exercise.id) ? Color.successGreenLight : Color.white)
        .cornerRadius(16)
        .shadow(color: .shadowPink, radius: 5, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(progressStore.isExerciseCompleted(exercise.id) ? Color.successGreen : Color.primaryPink, lineWidth: 2)
        )
    }
}

struct ExerciseDetail: View {
    let label: String
    let value: String

    var body: some View {
        VStack(spacing: 4) {
            Text(label)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.accentPink)

            Text(value)
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(.textDark)
        }
    }
}

#Preview {
    WorkoutDetailView(workoutDay: WorkoutProgram.days[0])
        .environmentObject(ProgressStore())
}