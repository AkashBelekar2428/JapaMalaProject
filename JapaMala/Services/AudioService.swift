//
//  AudioService.swift
//  JapaMala
//
//  Created by Akash Belekar on 25/11/26.
//
/*
 This service handles the three audio experiences.
 - Soft wooden tap for each count.
 - Completion bell when the target is reached.
 - Optional looping meditation ambience.
 */

import Foundation
import AVFoundation

final class AudioService {

    static let shared = AudioService()

    private var tapPlayer: AVAudioPlayer?
    private var bellPlayer: AVAudioPlayer?
    private var ambiencePlayer: AVAudioPlayer?

    private init() {}

    // MARK: - Audio Session

    private func configureAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(
                .ambient,
                mode: .default,
                options: [.mixWithOthers]
            )

            try AVAudioSession.sharedInstance().setActive(true)

        } catch {
            print("Audio session error: \(error.localizedDescription)")
        }
    }

    // MARK: - Bead Tap

    func playBeadTap() {

        guard UserSettings.bool(
            forKey: UserSettings.beadTapSoundKey
        ) else { return }

        tapPlayer = makePlayer(
            resource: "bead-tap",
            extension: "wav"
        )

        tapPlayer?.play()
    }

    // MARK: - Completion Bell

    func playCompletionBell() {

        guard UserSettings.bool(
            forKey: UserSettings.completionBellKey
        ) else { return }

        bellPlayer = makePlayer(
            resource: "completion-bell",
            extension: "wav"
        )

        bellPlayer?.play()
    }

    // MARK: - Background Ambience

    func setAmbienceEnabled(_ enabled: Bool) {

        if !enabled {
            ambiencePlayer?.stop()
            ambiencePlayer = nil
            return
        }

        guard ambiencePlayer?.isPlaying != true else {
            return
        }

        ambiencePlayer = makePlayer(
            resource: "meditation-ambience",
            extension: "m4a"
        )

        ambiencePlayer?.numberOfLoops = -1
        ambiencePlayer?.volume = 0.25
        ambiencePlayer?.prepareToPlay()
        ambiencePlayer?.play()
    }

    // MARK: - Stop Audio

    func stopAllSounds() {

        tapPlayer?.stop()
        bellPlayer?.stop()
        ambiencePlayer?.stop()

        ambiencePlayer = nil
    }

    // MARK: - Player Creation

    private func makePlayer(
        resource: String,
        extension fileExtension: String
    ) -> AVAudioPlayer? {

        configureAudioSession()

        guard let url = Bundle.main.url(
            forResource: resource,
            withExtension: fileExtension
        ) else {
            print("Missing audio file: \(resource).\(fileExtension)")
            return nil
        }

        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            return player

        } catch {
            print("Audio playback error: \(error.localizedDescription)")
            return nil
        }
    }
}
