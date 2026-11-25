//
//  SettingsRow.swift
//  JapaMala
//
//  Created by Akash Belekar on 25/11/26.
//
/*
 This is the main screen. It uses:
 - Rounded sage cards.
 - Warm ivory background.
 - Native iOS toggles.
 - Small preview buttons for sounds.
 - Clear section headings.
 - Responsive scrolling layout.
 */


import SwiftUI

struct SettingsView: View {

    // MARK: - Properties

    @Environment(\.dismiss) private var dismiss

    @StateObject private var viewModel = SettingsViewModel()

    // MARK: - Body

    var body: some View {

        NavigationStack {

            ZStack {

                AppColors.background
                    .ignoresSafeArea()

                ScrollView(showsIndicators: false) {

                    VStack(alignment: .leading, spacing: 28) {

                        // MARK: Introduction

                        introductionSection

                        // MARK: Practice Experience

                        practiceExperienceSection

                        // MARK: Meditation Ambience

                        ambienceSection

                        // MARK: Haptic Feedback

                        hapticSection

                        // MARK: About

                        aboutSection

                        footerSection
                    }
                    .padding(.horizontal, 22)
                    .padding(.top, 24)
                    .padding(.bottom, 40)
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {

                ToolbarItem(placement: .topBarTrailing) {

                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(AppColors.primary)
                            .frame(width: 36, height: 36)
                            .background(AppColors.cardBackground)
                            .clipShape(Circle())
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .tint(AppColors.primary)
    }

    // MARK: - Introduction

    private var introductionSection: some View {

        VStack(alignment: .leading, spacing: 10) {

            Text("Make space for stillness.")
                .font(.system(size: 27, weight: .regular, design: .serif))
                .foregroundStyle(AppColors.primaryText)

            Text("Personalize your spiritual practice and create a peaceful experience.")
                .font(.system(size: 14))
                .foregroundStyle(AppColors.secondaryText)
                .lineSpacing(4)
        }
    }

    // MARK: - Practice Experience

    private var practiceExperienceSection: some View {

        VStack(alignment: .leading, spacing: 14) {

            sectionHeader(
                title: "PRACTICE EXPERIENCE",
                subtitle: "Sounds that accompany your practice"
            )

            settingsCard {

                SettingsToggleRow(
                    icon: "circle.dotted",
                    title: "Bead tap sound",
                    subtitle: "A soft sound with every count",
                    isOn: $viewModel.beadTapSound
                )

                cardDivider

                SettingsToggleRow(
                    icon: "bell",
                    title: "Completion bell",
                    subtitle: "A gentle bell when Japa is complete",
                    isOn: $viewModel.completionBell
                )

                cardDivider

                HStack {

                    Label {
                        Text("Preview sounds")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(AppColors.primaryText)
                    } icon: {
                        Image(systemName: "play.circle")
                            .foregroundStyle(AppColors.primary)
                    }

                    Spacer()

                    Button {
                        viewModel.previewTapSound()
                    } label: {
                        Text("Tap")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(AppColors.primary)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(AppColors.cardBackground)
                            .clipShape(Capsule())
                    }
                    .buttonStyle(.plain)
                    .disabled(!viewModel.beadTapSound)

                    Button {
                        viewModel.previewCompletionBell()
                    } label: {
                        Text("Bell")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(AppColors.accent)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(AppColors.cardBackground)
                            .clipShape(Capsule())
                    }
                    .buttonStyle(.plain)
                    .disabled(!viewModel.completionBell)
                }
                .padding(.vertical, 6)
            }
        }
    }

    // MARK: - Meditation Ambience

    private var ambienceSection: some View {

        VStack(alignment: .leading, spacing: 14) {

            sectionHeader(
                title: "MEDITATION AMBIENCE",
                subtitle: "Create a calm atmosphere"
            )

            settingsCard {

                SettingsToggleRow(
                    icon: "waveform",
                    title: "Background ambience",
                    subtitle: "Soft meditation sounds during practice",
                    isOn: $viewModel.backgroundAmbience
                )

                if viewModel.backgroundAmbience {

                    cardDivider

                    HStack(spacing: 10) {

                        Image(systemName: "info.circle")
                            .foregroundStyle(AppColors.primary)

                        Text("Ambience will play continuously until you turn it off.")
                            .font(.system(size: 12))
                            .foregroundStyle(AppColors.secondaryText)
                    }
                    .padding(.vertical, 5)
                }
            }
        }
    }

    // MARK: - Haptic Feedback

    private var hapticSection: some View {

        VStack(alignment: .leading, spacing: 14) {

            sectionHeader(
                title: "TOUCH EXPERIENCE",
                subtitle: "Feel each moment of your practice"
            )

            settingsCard {

                SettingsToggleRow(
                    icon: "hand.tap",
                    title: "Haptic feedback",
                    subtitle: "A gentle vibration with every count",
                    isOn: $viewModel.hapticFeedback
                )

                cardDivider

                HStack {

                    Text("Try haptic feedback")
                        .font(.system(size: 13))
                        .foregroundStyle(AppColors.secondaryText)

                    Spacer()

                    Button {
                        viewModel.previewHaptic()
                    } label: {

                        HStack(spacing: 6) {
                            Image(systemName: "iphone.radiowaves.left.and.right")
                            Text("Test")
                        }
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(AppColors.primary)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 8)
                        .background(AppColors.cardBackground)
                        .clipShape(Capsule())
                    }
                    .buttonStyle(.plain)
                    .disabled(!viewModel.hapticFeedback)
                }
                .padding(.vertical, 6)
            }
        }
    }

    // MARK: - About

    private var aboutSection: some View {

        VStack(alignment: .leading, spacing: 14) {

            sectionHeader(
                title: "ABOUT",
                subtitle: "Your mindful companion"
            )

            settingsCard {

                HStack(spacing: 12) {

                    Image(systemName: "flower.lotus")
                        .font(.system(size: 24))
                        .foregroundStyle(AppColors.primary)
                        .frame(width: 44, height: 44)
                        .background(AppColors.cardBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 13))

                    VStack(alignment: .leading, spacing: 4) {

                        Text("JapaMala")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(AppColors.primaryText)

                        Text("A little practice. A little peace.")
                            .font(.system(size: 12))
                            .foregroundStyle(AppColors.secondaryText)
                    }

                    Spacer()

                    Text("v\(appVersion)")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(AppColors.mutedText)
                }
                .padding(.vertical, 5)
            }
        }
    }

    // MARK: - Footer

    private var footerSection: some View {

        VStack(spacing: 8) {

            Image(systemName: "leaf")
                .font(.system(size: 20))
                .foregroundStyle(AppColors.accent)

            Text("Come back to yourself.")
                .font(.system(size: 16, weight: .regular, design: .serif))
                .foregroundStyle(AppColors.primary)

            Text("One bead. One breath. One moment.")
                .font(.system(size: 12))
                .foregroundStyle(AppColors.mutedText)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 8)
    }

    // MARK: - Reusable Components

    private func sectionHeader(
        title: String,
        subtitle: String
    ) -> some View {

        VStack(alignment: .leading, spacing: 5) {

            Text(title)
                .font(.system(size: 11, weight: .bold))
                .tracking(1.2)
                .foregroundStyle(AppColors.primary)

            Text(subtitle)
                .font(.system(size: 12))
                .foregroundStyle(AppColors.secondaryText)
        }
    }

    private func settingsCard<Content: View>(
        @ViewBuilder content: () -> Content
    ) -> some View {

        VStack(alignment: .leading, spacing: 14) {
            content()
        }
        .padding(16)
        .background(AppColors.surface)
        .clipShape(RoundedRectangle(cornerRadius: 22))
        .overlay {
            RoundedRectangle(cornerRadius: 22)
                .stroke(AppColors.border, lineWidth: 0.7)
        }
    }

    private var cardDivider: some View {
        Rectangle()
            .fill(AppColors.divider)
            .frame(height: 1)
    }

    private var appVersion: String {

        Bundle.main.infoDictionary?[
            "CFBundleShortVersionString"
        ] as? String ?? "1.0"
    }
}

// MARK: - Settings Toggle Row

private struct SettingsToggleRow: View {

    let icon: String
    let title: String
    let subtitle: String

    @Binding var isOn: Bool

    var body: some View {

        Toggle(isOn: $isOn) {

            HStack(spacing: 12) {

                Image(systemName: icon)
                    .font(.system(size: 17))
                    .foregroundStyle(AppColors.primary)
                    .frame(width: 38, height: 38)
                    .background(AppColors.cardBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                VStack(alignment: .leading, spacing: 4) {

                    Text(title)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(AppColors.primaryText)

                    Text(subtitle)
                        .font(.system(size: 11))
                        .foregroundStyle(AppColors.secondaryText)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
        .tint(AppColors.primary)
    }
}
