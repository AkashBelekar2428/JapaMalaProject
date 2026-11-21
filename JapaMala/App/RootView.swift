//
//  RootView.swift
//  JapaMala
//
//  Created by Akash Belekar on 21/11/26.
//

//MARK: Main navigation controller
//MARK: Controls which page appears when a tab is selected.

import SwiftUI

// Stores currently selected tab
//@State: Stores selected tab

struct RootView: View {

    @State private var selectedTab: AppTab = .home

    var body: some View {

        ZStack {

            AppColors.background
                .ignoresSafeArea()

            Group {

                switch selectedTab {

                case .home:
                    HomeView {
                        navigateToTab(.chant)
                    }

                case .chant:
                    TabPlaceholderView(tab: .chant)

                case .mantras:
                    TabPlaceholderView(tab: .mantras)

                case .journey:
                    TabPlaceholderView(tab: .journey)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }

        // Custom Liquid Glass Tab Bar
        .safeAreaInset(edge: .bottom, spacing: 0) {
            CustomTabBar(selectedTab: $selectedTab)
        }

        .preferredColorScheme(.light)
    }

    // MARK: - Navigation

    private func navigateToTab(_ tab: AppTab) {

        withAnimation(
            .spring(response: 0.45, dampingFraction: 0.78)
        ) {
            selectedTab = tab
        }
    }
}

#Preview {
    RootView()
}
