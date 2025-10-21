//
//  SettingsView.swift
//  Setareh's Workout App
//
//  App settings and preferences
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var progressStore: ProgressStore
    @State private var showingResetAlert = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 12) {
                        Text("Settings")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.darkPink)

                        Text("Customize your workout experience")
                            .font(.subheadline)
                            .foregroundColor(.textLight)
                    }
                    .padding(.top, 20)

                    // App info section
                    VStack(alignment: .leading, spacing: 16) {
                        SectionHeader(title: "About", icon: "info.circle")

                        VStack(spacing: 12) {
                            InfoRow(label: "Version", value: "1.0.0")
                            InfoRow(label: "Developer", value: "Kilo Code")
                            InfoRow(label: "Designed for", value: "Setareh 💕")
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(16)
                        .shadow(color: .shadowPink, radius: 5, x: 0, y: 2)
                    }
                    .padding(.horizontal, 20)

                    // Workout settings
                    VStack(alignment: .leading, spacing: 16) {
                        SectionHeader(title: "Workout Settings", icon: "gear")

                        VStack(spacing: 0) {
                            // Reset progress button
                            Button(action: {
                                showingResetAlert = true
                            }) {
                                HStack {
                                    Image(systemName: "arrow.counterclockwise")
                                        .foregroundColor(.white)
                                        .frame(width: 24, height: 24)

                                    Text("Reset All Progress")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)

                                    Spacer()

                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.white.opacity(0.7))
                                        .font(.caption)
                                }
                                .padding()
                                .background(Color.red.opacity(0.8))
                                .cornerRadius(12)
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                            }
                        }
                        .background(Color.white)
                        .cornerRadius(16)
                        .shadow(color: .shadowPink, radius: 5, x: 0, y: 2)
                    }
                    .padding(.horizontal, 20)

                    // Support section
                    VStack(alignment: .leading, spacing: 16) {
                        SectionHeader(title: "Support", icon: "questionmark.circle")

                        VStack(spacing: 0) {
                            SupportRow(
                                title: "Workout Tips",
                                subtitle: "Get help with exercises",
                                icon: "figure.strengthtraining.traditional",
                                action: {}
                            )

                            Divider().padding(.leading, 60)

                            SupportRow(
                                title: "Contact Developer",
                                subtitle: "Report issues or suggestions",
                                icon: "envelope",
                                action: {}
                            )

                            Divider().padding(.leading, 60)

                            SupportRow(
                                title: "Rate App",
                                subtitle: "Leave a review on the App Store",
                                icon: "star",
                                action: {}
                            )
                        }
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
            .alert(isPresented: $showingResetAlert) {
                Alert(
                    title: Text("Reset Progress"),
                    message: Text("Are you sure you want to reset all workout progress? This action cannot be undone."),
                    primaryButton: .destructive(Text("Reset")) {
                        progressStore.resetProgress()
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }
}

struct SectionHeader: View {
    let title: String
    let icon: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.accentPink)
                .frame(width: 20, height: 20)

            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.darkPink)

            Spacer()
        }
    }
}

struct InfoRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .font(.subheadline)
                .foregroundColor(.textLight)

            Spacer()

            Text(value)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.textDark)
        }
    }
}

struct SupportRow: View {
    let title: String
    let subtitle: String
    let icon: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .foregroundColor(.accentPink)
                    .frame(width: 24, height: 24)

                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.textDark)

                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(.textLight)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(.textLight)
                    .font(.caption)
            }
            .padding()
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    SettingsView()
        .environmentObject(ProgressStore())
}