//
//  Us.swift
//  JapaMala
//
//  Created by Akash Belekar on 25/11/26.
//


import Foundation

struct UserSettings {

    static let beadTapSoundKey = "beadTapSound"
    static let completionBellKey = "completionBell"
    static let hapticFeedbackKey = "hapticFeedback"
    static let backgroundAmbienceKey = "backgroundAmbience"

    static let defaults: [String: Bool] = [
        beadTapSoundKey: true,
        completionBellKey: true,
        hapticFeedbackKey: true,
        backgroundAmbienceKey: false
    ]

    static func bool(forKey key: String) -> Bool {
        if let value = UserDefaults.standard.object(forKey: key) as? Bool {
            return value
        }

        return defaults[key] ?? false
    }

    static func save(_ value: Bool, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
}
