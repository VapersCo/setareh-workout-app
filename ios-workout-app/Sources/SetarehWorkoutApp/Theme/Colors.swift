//
//  Colors.swift
//  Setareh's Workout App
//
//  Color theme matching the cute pink web design
//

import SwiftUI

extension Color {
    // Primary Pink Colors
    static let primaryPink = Color(hex: "#FFB6C1")
    static let secondaryPink = Color(hex: "#FFC0CB")
    static let accentPink = Color(hex: "#FF69B4")
    static let darkPink = Color(hex: "#FF1493")

    // Background Colors
    static let bgPink = Color(hex: "#FFF5F7")
    static let bgPinkLight = Color(hex: "#FFE4E9")

    // UI Colors
    static let white = Color.white
    static let shadowPink = Color(hex: "#FFB6C1").opacity(0.15)
    static let shadowDark = Color(hex: "#FF1493").opacity(0.2)

    // Text Colors
    static let textDark = Color(hex: "#333333")
    static let textLight = Color(hex: "#666666")

    // Success Color
    static let successGreen = Color(hex: "#4CAF50")
    static let successGreenLight = Color(hex: "#E8F5E9")
}

// MARK: - Hex Color Extension
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - Gradient Extensions
extension LinearGradient {
    static let primaryPink = LinearGradient(
        colors: [.secondaryPink, .darkPink],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let cardBackground = LinearGradient(
        colors: [.white, .secondaryPink],
        startPoint: .top,
        endPoint: .bottom
    )

    static let buttonGradient = LinearGradient(
        colors: [.accentPink, .darkPink],
        startPoint: .leading,
        endPoint: .trailing
    )

    static let successGradient = LinearGradient(
        colors: [.successGreenLight, .successGreen.opacity(0.1)],
        startPoint: .top,
        endPoint: .bottom
    )
}