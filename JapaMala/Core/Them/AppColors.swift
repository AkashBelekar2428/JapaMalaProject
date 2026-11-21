//
//  App.swift
//  JapaMala
//
//  Created by Akash Belekar on 21/11/26.
//

import SwiftUI

//MARK: One place to manage app colors.
public enum AppColors {

    // MARK: - Background Colors
    static let appBackgroundColor = Color(hex: "DBDFD2")
    static let background = Color(hex: "F6F4ED")
    static let surface = Color(hex: "FBFAF6")
    static let cardBackground = Color(hex: "E5E9DF")

    // MARK: - Primary Colors
    static let primary = Color(hex: "3D5B49")
    static let primaryDark = Color(hex: "2C3E36")

    // MARK: - Text Colors
    static let primaryText = Color(hex: "2C3E36")
    static let secondaryText = Color(hex: "677064")
    static let mutedText = Color(hex: "8A9185")

    // MARK: - Accent Colors
    static let accent = Color(hex: "985438")
    static let terracotta = Color(hex: "985438")

    // MARK: - UI Colors

    static let divider = Color(hex: "DFE2D8")
    static let border = Color(hex: "D5DACB")
    static let success = Color(hex: "3D5B49")
    static let error = Color(hex: "B65C48")

    // MARK: - Button Colors

    static let buttonBackground = Color(hex: "3D5B49")
    static let buttonText = Color(hex: "FBFAF6")

    // MARK: - Tab Bar Colors
    static let tabBarIconColor = Color(hex: "345C48")
    static let selectedTabBackgroundColor = Color(hex: "E4E9DE")
    static let unselectedTabColor = Color(hex: "FBFAF5")
}

// MARK: - Hex Color Extension

extension Color {

    init(hex: String) {
        let hex = hex.trimmingCharacters(
            in: CharacterSet.alphanumerics.inverted
        )

        let value = UInt64(hex, radix: 16) ?? 0

        let red = Double((value >> 16) & 0xFF) / 255
        let green = Double((value >> 8) & 0xFF) / 255
        let blue = Double(value & 0xFF) / 255

        self.init(
            .sRGB,
            red: red,
            green: green,
            blue: blue,
            opacity: 1
        )
    }
}
