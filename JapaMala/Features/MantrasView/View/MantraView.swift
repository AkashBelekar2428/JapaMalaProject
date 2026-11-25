//
//  MantraView.swift
//  JapaMala
//
//  Created by Akash Belekar on 24/11/26.
//


import SwiftUI

enum MantraFilter {
    case all
    case saved
    case mine
}

struct MantraView: View {

    @StateObject private var viewModel = MantraViewModel()

    @State private var selectedFilter: MantraFilter = .all
    @State private var showAddMantra = false
    
    @State private var searchText = ""
    
    @Namespace private var segmentAnimation

    private var displayedMantras: [Mantra] {

        let filteredMantras: [Mantra]

        switch selectedFilter {

        case .all:
            filteredMantras = viewModel.allMantras

        case .saved:
            filteredMantras = viewModel.savedMantras

        case .mine:
            filteredMantras = viewModel.myMantras
        }

        guard !searchText.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).isEmpty else {
            return filteredMantras
        }

        return filteredMantras.filter { mantra in

            mantra.title.localizedCaseInsensitiveContains(searchText) ||
            mantra.subtitle.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    // MARK: - Search Bar

    private var searchBar: some View {

        HStack(spacing: 12) {

            Image(systemName: "magnifyingglass")
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(AppColors.primary)

            TextField("Search mantras...", text: $searchText)
                .font(.system(size: 17))
                .foregroundStyle(AppColors.primaryText)
                .autocorrectionDisabled()

            if !searchText.isEmpty {

                Button {
                    searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(AppColors.secondaryText)
                }
            }
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 17)
        .malaGlass(in: RoundedRectangle(cornerRadius: 20))
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(AppColors.border.opacity(0.5), lineWidth: 1)
        }
    }

    var body: some View {

        VStack(spacing: 0) {

            ScrollView(showsIndicators: false) {

                VStack(alignment: .leading, spacing: 30) {

                    // MARK: Header

                    VStack(alignment: .leading, spacing: 15) {

                        Text("WORDS TO RETURN TO")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(AppColors.accent)

                        Text("Find your mantra")
                            .font(.system(size: 40, design: .serif))
                            .foregroundStyle(AppColors.primaryText)

                        Text("Choose what feels close to your heart.")
                            .font(.system(size: 19))
                            .foregroundStyle(AppColors.secondaryText)
                    }
                    .padding(.top, 30)
                    
                    // MARK: Segmented Control

                    HStack(spacing: 10) {

                        segmentButton(
                            title: "All",
                            selected: selectedFilter == .all
                        ) {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
                                selectedFilter = .all
                            }
                        }
                        .malaGlass(in: Capsule())

                        segmentButton(
                            title: "Saved",
                            selected: selectedFilter == .saved
                        ) {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
                                selectedFilter = .saved
                            }
                        }
                        .malaGlass(in: Capsule())

                        segmentButton(
                            title: "My mantras",
                            selected: selectedFilter == .mine
                        ) {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
                                selectedFilter = .mine
                            }
                        }
                        .malaGlass(in: Capsule())
                    }
                    .padding(6)
                    .malaGlass(in: Capsule())
                    .animation(
                        .spring(response: 0.4, dampingFraction: 0.75),
                        value: selectedFilter
                    )


                    // MARK: Search

                    searchBar

                    // MARK: Mantra List

                    LazyVStack(spacing: 15) {

                        ForEach(displayedMantras) { mantra in

                            MantraRowView(
                                mantra: mantra,
                                isSelected: viewModel.selectedMantraID == mantra.id,
                                onSelect: {
                                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                                        viewModel.selectMantra(mantra)
                                    }
                                },
                                onSave: {
                                    withAnimation(.easeInOut(duration: 0.25)) {
                                        viewModel.toggleSaved(mantra)
                                    }
                                },
                                onDelete: {
                                    withAnimation(.easeInOut(duration: 0.3)) {
                                        viewModel.deleteMantra(mantra)
                                    }
                                }
                            )
                            .transition(.asymmetric(
                                insertion: .opacity.combined(with: .move(edge: .bottom)),
                                removal: .opacity
                            ))
                        }
                    }
                    .animation(
                        .spring(response: 0.4, dampingFraction: 0.85),
                        value: displayedMantras
                    )
                    // MARK: Add Mantra Button

                    Button {

                        showAddMantra = true

                    } label: {

                        HStack(spacing: 12) {

                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 21))

                            Text("Add your own mantra")
                                .font(.system(size: 17, weight: .semibold))
                        }
                        .foregroundStyle(AppColors.primary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 19)
                        .malaGlass(
                            in: RoundedRectangle(cornerRadius: 22)
                        )
                        .overlay {
                            RoundedRectangle(cornerRadius: 22)
                                .stroke(AppColors.primary.opacity(0.4), lineWidth: 1)
                        }
                    }
                    .padding(.top, 5)

                    // MARK: Footer

                    Text("Your words. Your rhythm. Your practice.")
                        .font(.system(size: 16))
                        .foregroundStyle(AppColors.secondaryText)
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 12)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 25)
            }
        }
        .background(AppColors.background.ignoresSafeArea())

        // MARK: Add Mantra Sheet

        .sheet(isPresented: $showAddMantra) {

            AddMantraView { title, subtitle in

                viewModel.addMantra(
                    title: title,
                    subtitle: subtitle
                )

                // Automatically open My Mantras
                selectedFilter = .mine
            }
        }
    }

    // MARK: Segmented Button

       private func segmentButton(
        title: String,
        selected: Bool,
        action: @escaping () -> Void
    ) -> some View {

        Button {
            action()
        } label: {

            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(
                    selected
                    ? AppColors.surface
                    : AppColors.primary
                )
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background {

                    if selected {
                        Capsule()
                            .fill(AppColors.primary)
                            .matchedGeometryEffect(
                                id: "selectedTab",
                                in: segmentAnimation
                            )
                    }
                }
                .contentShape(Capsule())
                .scaleEffect(selected ? 1.0 : 0.96)
        }
        .buttonStyle(.plain)
        .animation(
            .spring(response: 0.4, dampingFraction: 0.75),
            value: selected
        )
    }


    // MARK: Empty State

    private var emptyState: some View {

        VStack(spacing: 12) {

            Image(
                systemName: selectedFilter == .mine
                ? "plus.circle"
                : "bookmark"
            )
            .font(.system(size: 35))
            .foregroundStyle(AppColors.primary)

            Text(
                selectedFilter == .mine
                ? "No personal mantras yet"
                : "No saved mantras yet"
            )
            .font(.system(size: 21, design: .serif))
            .foregroundStyle(AppColors.primaryText)

            Text(
                selectedFilter == .mine
                ? "Create your own mantra to begin."
                : "Save a mantra to find it here."
            )
            .font(.system(size: 15))
            .foregroundStyle(AppColors.secondaryText)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 45)
    }
}

#Preview {
    MantraView()
}
