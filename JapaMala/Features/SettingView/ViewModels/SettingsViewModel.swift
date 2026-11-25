//
//  s.swift
//  JapaMala
//
//  Created by Akash Belekar on 25/11/26.
//

//This ViewModel manages all settings and automatically saves changes.
import Foundation
import Combine
import UIKit

@MainActor
final class SettingsViewModel: ObservableObject {

    // MARK: - Published Settings

    @Published var beadTapSound: Bool {
        didSet {
            UserSettings.save(
                beadTapSound,
                forKey: UserSettings.beadTapSoundKey
            )
        }
    }

    @Published var completionBell: Bool {
        didSet {
            UserSettings.save(
                completionBell,
                forKey: UserSettings.completionBellKey
            )
        }
    }

    @Published var hapticFeedback: Bool {
        didSet {
            UserSettings.save(
                hapticFeedback,
                forKey: UserSettings.hapticFeedbackKey
            )
        }
    }

    @Published var backgroundAmbience: Bool {
        didSet {
            UserSettings.save(
                backgroundAmbience,
                forKey: UserSettings.backgroundAmbienceKey
            )

            AudioService.shared.setAmbienceEnabled(
                backgroundAmbience
            )
        }
    }

    // MARK: - Initialization

    init() {

        beadTapSound = UserSettings.bool(
            forKey: UserSettings.beadTapSoundKey
        )

        completionBell = UserSettings.bool(
            forKey: UserSettings.completionBellKey
        )

        hapticFeedback = UserSettings.bool(
            forKey: UserSettings.hapticFeedbackKey
        )

        backgroundAmbience = UserSettings.bool(
            forKey: UserSettings.backgroundAmbienceKey
        )

        if backgroundAmbience {
            AudioService.shared.setAmbienceEnabled(true)
        }
    }

    // MARK: - Feedback Preview

    func previewTapSound() {
        AudioService.shared.playBeadTap()
    }

    func previewCompletionBell() {
        AudioService.shared.playCompletionBell()
    }

    func previewHaptic() {
        HapticService.shared.selection()
    }
}
