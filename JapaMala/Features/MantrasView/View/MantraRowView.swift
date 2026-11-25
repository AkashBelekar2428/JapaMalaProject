//
//  MantraRowView.swift
//  JapaMala
//
//  Created by Akash Belekar on 24/11/26.
//


import SwiftUI

struct MantraRowView: View {

    let mantra: Mantra
    let isSelected: Bool
    let onSelect: () -> Void
    let onSave: () -> Void
    let onDelete: () -> Void

    var body: some View {

        Button(action: onSelect) {

            HStack(alignment: .center, spacing: 16) {

                VStack(alignment: .leading, spacing: 10) {

                    Text(mantra.title)
                        .font(.system(size: 25, weight: .regular,
                                      design: .serif))
                        .foregroundStyle(AppColors.primaryText)
                        .multilineTextAlignment(.leading)

                    Text(mantra.subtitle)
                        .font(.system(size: 16))
                        .foregroundStyle(AppColors.secondaryText)
                        .multilineTextAlignment(.leading)

                    if isSelected {
                        Text("Selected for your practice")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundStyle(AppColors.primary)
                            .padding(.top, 7)
                    }
                }

                Spacer(minLength: 4)

                if isSelected {

                    Image(systemName: "checkmark")
                        .font(.system(size: 23, weight: .semibold))
                        .foregroundStyle(AppColors.surface)
                        .frame(width: 70, height: 70)
                        .background(AppColors.primary)
                        .clipShape(Circle())

                } else {

                    Image(systemName: "chevron.right")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(AppColors.primary)
                }
            }
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .malaGlass(
                in: RoundedRectangle(cornerRadius: 30)
            )
            .overlay {
                RoundedRectangle(cornerRadius: 30)
                    .stroke(
                        isSelected
                        ? AppColors.primary.opacity(0.55)
                        : AppColors.border.opacity(0.5),
                        lineWidth: isSelected ? 1.5 : 1
                    )
            }
            .overlay {
                RoundedRectangle(cornerRadius: 30)
                    .stroke(
                        isSelected
                        ? AppColors.primary
                        : AppColors.border,
                        lineWidth: isSelected ? 1.5 : 1
                    )
            }
        }
        .buttonStyle(.plain)
        .contextMenu {

            Button {
                onSave()
            } label: {
                Label(
                    mantra.isSaved ? "Remove from Saved" : "Save Mantra",
                    systemImage: mantra.isSaved ? "bookmark.slash" : "bookmark"
                )
            }

            if mantra.isCustom {
                Button(role: .destructive) {
                    onDelete()
                } label: {
                    Label("Delete Mantra", systemImage: "trash")
                }
            }
        }
    }
}
