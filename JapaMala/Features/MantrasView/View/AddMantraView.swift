//
//  AddMantraView.swift
//  JapaMala
//
//  Created by Akash Belekar on 24/11/26.
//

//MARK: Add custom mantra screen
//When the user taps Add your own mantra, this sheet opens. After tapping Add Mantra, the new mantra is automatically added to the main list.
import SwiftUI

struct AddMantraView: View {

    @Environment(\.dismiss) private var dismiss

    @State private var mantraTitle = ""
    @State private var mantraDescription = ""

    let onAdd: (String, String) -> Void

    private var isValid: Bool {
        !mantraTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {

        NavigationStack {

            VStack(alignment: .leading, spacing: 25) {

                Text("Create a mantra")
                    .font(.system(size: 30, design: .serif))
                    .foregroundStyle(AppColors.primaryText)

                VStack(alignment: .leading, spacing: 10) {

                    Text("MANTRA")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(AppColors.accent)

                    TextField("Enter your mantra", text: $mantraTitle)
                        .font(.system(size: 18))
                        .padding(18)
                        .background(AppColors.surface)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }

                VStack(alignment: .leading, spacing: 10) {

                    Text("DESCRIPTION")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(AppColors.accent)

                    TextField(
                        "What does this mantra mean?",
                        text: $mantraDescription,
                        axis: .vertical
                    )
                    .lineLimit(2...4)
                    .font(.system(size: 18))
                    .padding(18)
                    .background(AppColors.surface)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                }

                Spacer()

                Button {

                    onAdd(mantraTitle, mantraDescription)
                    dismiss()

                } label: {

                    Text("Add Mantra")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(AppColors.surface)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 19)
                        .background(
                            isValid
                            ? AppColors.primary
                            : AppColors.secondaryText
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                }
                .disabled(!isValid)
            }
            .padding(25)
            .background(AppColors.background.ignoresSafeArea())
            .toolbar {

                ToolbarItem(placement: .topBarTrailing) {
                    Button("Close") {
                        dismiss()
                    }
                    .foregroundStyle(AppColors.primary)
                }
            }
        }
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
    }
}
