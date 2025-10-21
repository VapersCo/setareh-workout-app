//
//  ContentView.swift
//  Setareh's Workout App
//
//  Main navigation view with tab bar
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)

            WorkoutsView()
                .tabItem {
                    Image(systemName: "figure.strengthtraining.traditional")
                    Text("Workouts")
                }
                .tag(1)

            ProgressView()
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("Progress")
                }
                .tag(2)

            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
                .tag(3)
        }
        .accentColor(.darkPink)
        .background(Color.bgPink.ignoresSafeArea())
    }
}

#Preview {
    ContentView()
        .environmentObject(WorkoutStore())
        .environmentObject(ProgressStore())
}