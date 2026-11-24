//
//  MantraViewModel.swift
//  JapaMala
//
//  Created by Akash Belekar on 24/11/26.
//

//MARK: This is the most important file. It controls adding, selecting, saving and deleting mantras.
import Foundation
import SwiftUI
import Combine

@MainActor
final class MantraViewModel: ObservableObject {

    @Published var mantras: [Mantra] = []
    @Published var selectedMantraID: UUID?

    private let storageKey = "savedMantras"
    private let selectedKey = "selectedMantraID"

    init() {
        loadMantras()
    }

    // MARK: - Default Mantras

    private func defaultMantras() -> [Mantra] {
        [
            Mantra(
                title: "Om Namah Shivaya",
                subtitle: "A bow to the inner self."
            ),
            Mantra(
                title: "Om Shanti Shanti Shanti",
                subtitle: "An invitation to peace."
            ),
            Mantra(
                title: "Om Gan Ganapataye Namah",
                subtitle: "For a new beginning."
            ),
            Mantra(
                title: "Om Mani Padme Hum",
                subtitle: "A reminder of compassion."
            ),
            Mantra(
                title: "So Hum",
                subtitle: "I am that."
            )
        ]
    }

    // MARK: - Load Data

    private func loadMantras() {

        if let data = UserDefaults.standard.data(forKey: storageKey),
           let savedMantras = try? JSONDecoder().decode(
               [Mantra].self,
               from: data
           ) {

            mantras = savedMantras

        } else {

            mantras = defaultMantras()
            saveMantras()
        }

        if let selectedID = UserDefaults.standard.string(
            forKey: selectedKey
        ),
        let uuid = UUID(uuidString: selectedID),
        mantras.contains(where: { $0.id == uuid }) {

            selectedMantraID = uuid

        } else {

            selectedMantraID = mantras.first?.id
        }
    }

    // MARK: - Save Data

    private func saveMantras() {

        guard let data = try? JSONEncoder().encode(mantras) else {
            return
        }

        UserDefaults.standard.set(data, forKey: storageKey)
    }

    // MARK: - Add Custom Mantra

    func addMantra(title: String, subtitle: String) {

        let newMantra = Mantra(
            title: title.trimmingCharacters(in: .whitespacesAndNewlines),
            subtitle: subtitle.trimmingCharacters(in: .whitespacesAndNewlines),
            isCustom: true
        )

        guard !newMantra.title.isEmpty else { return }

        mantras.append(newMantra)

        saveMantras()
    }
    
    // MARK: - Select Mantra

    func selectMantra(_ mantra: Mantra) {

        selectedMantraID = mantra.id

        UserDefaults.standard.set(
            mantra.id.uuidString,
            forKey: selectedKey
        )
    }

    // MARK: - Save / Unsave Mantra

    func toggleSaved(_ mantra: Mantra) {

        guard let index = mantras.firstIndex(
            where: { $0.id == mantra.id }
        ) else { return }

        mantras[index].isSaved.toggle()

        saveMantras()
    }

    // MARK: - Delete Custom Mantra

    func deleteMantra(_ mantra: Mantra) {

        guard mantra.isCustom else { return }

        mantras.removeAll { $0.id == mantra.id }

        if selectedMantraID == mantra.id {
            selectedMantraID = mantras.first?.id

            UserDefaults.standard.set(
                selectedMantraID?.uuidString,
                forKey: selectedKey
            )
        }

        saveMantras()
    }

    // MARK: - Filter Mantras

    var savedMantras: [Mantra] {
        mantras.filter { $0.isSaved }
    }

    var myMantras: [Mantra] {
        mantras.filter { $0.isCustom }
    }

    var allMantras: [Mantra] {
        mantras.filter { !$0.isCustom }
    }
}
