//
//  WorkoutsView.swift
//  Setareh's Workout App
//
//  Main workouts screen showing all 3 workout days
//

import SwiftUI

struct WorkoutsView: View {
    @EnvironmentObject var workoutStore: WorkoutStore
    @EnvironmentObject var progressStore: ProgressStore

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 12) {
                        Text("Your Workout Program")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.darkPink)

                        Text("3-day functional training program")
                            .font(.subheadline)
                            .foregroundColor(.textLight)
                    }
                    .padding(.top, 20)

                    // Schedule info
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Weekly Schedule")
                            .font(.headline)
                            .foregroundColor(.textDark)

                        VStack(spacing: 8) {
                            ScheduleRow(day: "Monday", workout: "Day 1 - Lower Body & Core")
                            ScheduleRow(day: "Wednesday", workout: "Day 2 - Upper Body & Core")
                            ScheduleRow(day: "Friday", workout: "Day 3 - Full Body")
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(16)
                        .shadow(color: .shadowPink, radius: 5, x: 0, y: 2)
                    }
                    .padding(.horizontal, 20)

                    // Workout cards
                    VStack(spacing: 20) {
                        ForEach(workoutStore.workoutDays) { workoutDay in
                            NavigationLink(destination: WorkoutDetailView(workoutDay: workoutDay)) {
                                WorkoutCard(workoutDay: workoutDay)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal, 20)

                    // Tips section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Important Tips ✨")
                            .font(.headline)
                            .foregroundColor(.textDark)

                        VStack(spacing: 12) {
                            TipRow(emoji: "🌸", text: "Rest at least one day between workouts")
                            TipRow(emoji: "💪", text: "Focus on form before speed or weight")
                            TipRow(emoji: "❤️", text: "Listen to your body - soreness is normal, pain is not")
                            TipRow(emoji: "💧", text: "Stay hydrated throughout your workout")
                            TipRow(emoji: "🔥", text: "Never skip warm-ups or cool-downs")
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
            .navigationBarHidden(true)
        }
    }
}

struct ScheduleRow: View {
    let day: String
    let workout: String

    var body: some View {
        HStack {
            Text(day)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.accentPink)
                .frame(width: 80, alignment: .leading)

            Text(workout)
                .font(.subheadline)
                .foregroundColor(.textDark)

            Spacer()
        }
    }
}

struct TipRow: View {
    let emoji: String
    let text: String

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Text(emoji)
                .font(.title3)

            Text(text)
                .font(.subheadline)
                .foregroundColor(.textDark)
                .multilineTextAlignment(.leading)

            Spacer()
        }
    }
}

#Preview {
    WorkoutsView()
        .environmentObject(WorkoutStore())
        .environmentObject(ProgressStore())
}