//
//  ContentView.swift
//  JapaMala
//
//  Created by Akash Belekar on 20/11/26.
//


import SwiftUI

struct HomeView: View {

    // MARK: - Properties
    var onBeginPractice: () -> Void
    var onSettingsTap: () -> Void

    // MARK: - Body

    var body: some View {

        ZStack {
            AppColors.background
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {

                VStack(alignment: .leading, spacing: 0) {

                    // MARK: Header
                    headerSection

                    // MARK: Welcome
                    welcomeSection
                        .padding(.top, 16)

                    // MARK: Daily Ritual
                    dailyRitualCard
                        .padding(.top, 16)

                    // MARK: Reminder
                    reminderSection
                        .padding(.top, 16)

                }
                .padding(.horizontal, 24)
                .padding(.top, 20)
                .padding(.bottom, 35)
            }
        }
        .preferredColorScheme(.light)
    }

    // MARK: - Header Section

    private var headerSection: some View {

        HStack {

            Text("mala")
                .font(.system(size: 28, weight: .regular, design: .serif))
                .foregroundStyle(AppColors.primary)

            Spacer()

            Button {
                onSettingsTap()
            } label: {

                Image("setting_icon")
                    .scaledToFit()
                    .font(.system(size: 25, weight: .medium))
                    .foregroundStyle(AppColors.primary)
                    .frame(width: 50, height: 50)
            }
            .malaGlass(in: Circle())
            .buttonStyle(.plain)
            .accessibilityLabel("Settings")
        }
    }

    // MARK: - Welcome Section

    private var welcomeSection: some View {

        VStack(alignment: .leading, spacing: 20) {

            Text("A slower start. A softer day.")
                .font(.system(size: 14, weight: .regular))
                .foregroundStyle(AppColors.secondaryText)

            Text("Come back\nto yourself.")
                .font(.system(size: 32, weight: .regular, design: .serif))
                .foregroundStyle(AppColors.primaryText)
                .fixedSize(horizontal: false, vertical: true)
                .lineSpacing(3)
        }
    }

    // MARK: - Daily Ritual Card

    private var dailyRitualCard: some View {

        VStack(alignment: .leading, spacing: 0) {

            Text("YOUR DAILY RITUAL")
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(AppColors.primary)
                .padding(.top, 16)

            // Mantra and Mala
            HStack(alignment: .center, spacing: 8) {

                Text("Om Namah\nShivaya")
                    .font(.system(size: 26, weight: .regular, design: .serif))
                    .foregroundStyle(AppColors.primaryText)
                    .fixedSize(horizontal: false, vertical: true)
                    .lineSpacing(9)

                Spacer(minLength: 0)

                MalaBeadsView()
                    .frame(width: 84, height: 94)
            }
            .padding(.top, 18)

            // Description
            HStack(spacing: 12) {

                Text("108 chants")

                Text("·")

                Text("At your own pace")
            }
            .font(.system(size: 16, weight: .regular))
            .foregroundStyle(AppColors.secondaryText)
            .padding(.top, 20)

            // Begin Practice Button
            Button {
                onBeginPractice()
            } label: {

                HStack {

                    Spacer()

                    Text("Begin practice")
                        .font(.system(size: 18, weight: .semibold))

                    Spacer()

                    Image(systemName: "arrow.right")
                        .font(.system(size: 27, weight: .regular))
                }
                .foregroundStyle(AppColors.surface)
                .padding(.horizontal, 10)
                .frame(height: 50)
                .background {
                    RoundedRectangle(cornerRadius: 18)
                        .fill(AppColors.primary.opacity(0.85))
                }
                .malaGlass(
                    in: RoundedRectangle(cornerRadius: 18)
                )

            }
            .buttonStyle(.plain)
            .padding(.top, 32)
            .padding(.bottom, 32)
        }
        .padding(.horizontal, 24)
        .background(AppColors.cardBackground)
        .malaGlass(
            in: RoundedRectangle(cornerRadius: 24)
        )
    }

    // MARK: - Reminder Section

    private var reminderSection: some View {

        VStack(alignment: .leading, spacing: 18) {

            Text("A GENTLE REMINDER")
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(AppColors.accent)

            Text("No rush. No perfect way.\nJust one bead, one breath.")
                .font(.system(size: 20, weight: .regular, design: .serif))
                .foregroundStyle(AppColors.primaryText)
                .fixedSize(horizontal: false, vertical: true)
                .lineSpacing(5)

            Text("A little practice is enough for today.")
                .font(.system(size: 14, weight: .regular))
                .foregroundStyle(AppColors.secondaryText)
                .padding(.top, 8)
        }
    }
}
