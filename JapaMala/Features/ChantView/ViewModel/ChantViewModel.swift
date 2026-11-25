//
//  ChantViewModel.swift
//  JapaMala
//
//  Created by Akash Belekar on 25/11/26.
//

import Foundation
import SwiftUI
import SwiftData
import Combine

//MARK : Counter, session completion and saving

@MainActor
final class ChantViewModel: ObservableObject {

    // MARK: - Chant Properties

    @Published var chantCount: Int = 0
    @Published var targetCount: Int = 108

    @Published var isChanting: Bool = false
    @Published var isSessionCompleted: Bool = false

    @Published var selectedMantraTitle: String = "Om Namah Shivaya"
    @Published var isSessionSaved = false

    // MARK: - Chant Counter

    func incrementCount() {

        guard !isSessionCompleted else { return }

        chantCount += 1
        
           HapticService.shared.beadTap()
           AudioService.shared.playBeadTap()

        if chantCount >= targetCount {
            AudioService.shared.playCompletionBell()

        }
    }
    

    // MARK: - Reset Counter

    func resetCounter() {
        chantCount = 0
        isChanting = false
        isSessionSaved = false
        isSessionCompleted = false
    }

    // MARK: - Save Chant Session

    func saveSession(modelContext: ModelContext) {

        guard chantCount > 0, !isSessionSaved else { return }

        let session = JapaSession(
            mantraTitle: selectedMantraTitle,
            sessionDate: .now,
            chantCount: chantCount
        )

        modelContext.insert(session)

        do {
            try modelContext.save()
            isSessionSaved = true
        } catch {
            print("Save failed: \(error.localizedDescription)")
        }
    }
}
