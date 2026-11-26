//
//  DailyDeityCardView.swift
//  JapaMala
//
//  Created by Akash Belekar on 25/11/26.
//

import SwiftUI

struct DailyDeityCard: View {

    let onBeginPractice: () -> Void

    var body: some View {

        TimelineView(.periodic(from: .now, by: 60 * 60)) { context in

            let deity = DailyDeity.forDate(context.date)

            VStack(alignment: .leading, spacing: 22) {

                // MARK: Header

                HStack(alignment: .center) {

                    Text("YOUR DAILY RITUAL")
                        .font(.system(size: 13, weight: .semibold))
                        .tracking(1.1)
                        .foregroundStyle(AppColors.primary)

                    Spacer()

                    Image(systemName: "sparkles")
                        .foregroundStyle(AppColors.accent)
                        .font(.system(size: 18))
                }

                // MARK: Daily Label

                VStack(alignment: .leading, spacing: 6) {

                    Text("TODAY'S DIVINE MANTRA")
                        .font(.system(size: 13, weight: .semibold))
                        .tracking(1.2)
                        .foregroundStyle(AppColors.accent)

                    Text("\(deity.traditionalDayName) · \(deity.dayName)")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(AppColors.secondaryText)
                }

                // MARK: Deity Information

                HStack(alignment: .center, spacing: 16) {

                    ZStack {
                        Circle()
                            .fill(AppColors.surface.opacity(0.8))
                            .frame(width: 88, height: 88)

                        Image(deity.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 90, height: 90)
                            .clipShape(.circle)
                            .background(
                                Capsule()
                                    .fill(AppColors.primary.opacity(0.88))
                                    .malaGlass(in: Capsule())
                            )
                    }
                    .accessibilityHidden(true)

                    VStack(alignment: .leading, spacing: 7) {

                        Text(deity.name)
                            .font(.system(
                                size: 26,
                                weight: .regular,
                                design: .serif
                            ))
                            .foregroundStyle(AppColors.primaryText)
                            .fixedSize(
                                horizontal: false,
                                vertical: true
                            )

                        Text(deity.description)
                            .font(.system(size: 15))
                            .foregroundStyle(AppColors.secondaryText)
                            .fixedSize(
                                horizontal: false,
                                vertical: true
                            )
                    }

                    Spacer(minLength: 0)
                }

                // MARK: Mantra

                VStack(spacing: 10) {

                    Text(deity.mantra)
                        .font(.system(size: 25, weight: .semibold))
                        .foregroundStyle(AppColors.primaryText)
                        .multilineTextAlignment(.center)
                        .minimumScaleFactor(0.75)
                        .lineLimit(2)

                    Text(deity.transliteration)
                        .font(.system(size: 15))
                        .foregroundStyle(AppColors.secondaryText)
                        .multilineTextAlignment(.center)
                        .fixedSize(
                            horizontal: false,
                            vertical: true
                        )
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 14)
                .padding(.vertical, 20)
                .background {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(AppColors.surface.opacity(0.55))
                        .malaGlass(in: RoundedRectangle(cornerRadius: 24))
                }

                // MARK: Chant Button

                Button(action: onBeginPractice) {

                    HStack(spacing: 12) {

                        Image(systemName: "hands.sparkles")

                        Text("Chant Today's Mantra")
                            .lineLimit(1)
                            .minimumScaleFactor(0.85)

                        Spacer()

                        Image(systemName: "arrow.right")
                    }
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(AppColors.surface)
                    .padding(.horizontal, 20)
                    .frame(maxWidth: .infinity)
                    .frame(height: 58)
                    .background {
                        Capsule()
                            .fill(AppColors.primary.opacity(0.88))
                            .malaGlass(in: Capsule())
                    }
                }
                .buttonStyle(.plain)
            }
            .padding(22)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background {
                RoundedRectangle(cornerRadius: 28)
                    .fill(AppColors.cardBackground.opacity(0.75))
                    .malaGlass(in: RoundedRectangle(cornerRadius: 28))
            }
        }
    }
}
