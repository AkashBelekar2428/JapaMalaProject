//
//  HomeView.swift
//  JapaMala
//
//  Created by Akash Belekar on 20/11/26.
//


import SwiftUI

struct HomeView: View {

    // MARK: - Properties
    var onBeginPractice: () -> Void
    var onSettingsTap: () -> Void
    
    @Binding var dailyMantraToChant: String?


    // MARK: - Body

    var body: some View {

        ZStack {

            AppColors.background
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {

                VStack(alignment: .leading, spacing: 14) {

                    // MARK: Header

                    headerSection
                        

                    // MARK: Welcome

                    welcomeSection
                        .padding(.top, 8)

                    // MARK: Daily Ritual

                    DailyDeityCard { mantra in

                        dailyMantraToChant = mantra

                        onBeginPractice()
                    }

                    // MARK: Reminder

                    reminderSection
                        .padding(.top, 8)
                }
                .padding(.horizontal, 24)
                .padding(.top, 10)
                .padding(.bottom, 10)
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
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
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

        VStack(alignment: .leading, spacing: 4) {

            Text("A slower start. A softer day.")
                .font(.system(size: 14, weight: .regular))
                .foregroundStyle(AppColors.secondaryText)

            HStack(alignment: .center, spacing: 0) {

                VStack(alignment: .leading, spacing: 4) {

                    Text("Come back")
                    Text("to yourself.")
                }
                .font(.system(size: 32, weight: .regular, design: .serif))
                .foregroundStyle(AppColors.primaryText)
                .fixedSize(horizontal: false, vertical: true)
                .lineSpacing(3)

                Spacer(minLength: 0)

                AnimatedMalaView()
                    .frame(width: 140, height: 145)
                    .fixedSize()
            }
            .frame(maxWidth: .infinity)
        }
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

