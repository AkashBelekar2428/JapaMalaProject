//
//  WeeklyProgressCard.swift
//  JapaMala
//
//  Created by Akash Belekar on 24/11/26.
//

import SwiftUI

struct WeeklyProgressCard: View {

    let viewModel: JourneyViewModel

    private let chartHeight: CGFloat = 110

    var body: some View {

        VStack(alignment: .leading, spacing: 24) {

            // MARK: Header

            HStack {
                Text("This week")
                    .font(.system(size: 23, weight: .semibold))
                    .foregroundStyle(AppColors.primaryText)

                Spacer()

                Text(viewModel.weekDateRange)
                    .font(.system(size: 15))
                    .foregroundStyle(AppColors.secondaryText)
            }

            // MARK: Practice Days

            HStack(alignment: .center, spacing: 12) {

                Text("\(viewModel.weeklyPracticeDays)")
                    .font(.system(size: 76, weight: .regular, design: .serif))
                    .foregroundStyle(AppColors.primaryText)
                    .contentTransition(.numericText())

                VStack(alignment: .leading, spacing: 3) {
                    Text("days of showing up")
                    Text("for yourself")
                }
                .font(.system(size: 17))
                .foregroundStyle(AppColors.primaryText)

                Spacer()
            }
            .padding(.vertical, 4)

            // MARK: Weekly Chant Progress

            VStack(alignment: .leading, spacing: 16) {

                HStack {
                    Text("Daily chanting")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(AppColors.primaryText)

                    Spacer()

                    Text("\(viewModel.weeklyChants.formatted()) chants")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(AppColors.secondaryText)
                }

                // MARK: Vertical Progress Bars

                HStack(alignment: .bottom, spacing: 10) {

                    ForEach(
                        Array(viewModel.weekDates.enumerated()),
                        id: \.offset
                    ) { index, date in

                        let count = viewModel.dailyChantCount(on: date)

                        let maximum = max(
                            viewModel.highestDailyChantCount,
                            1
                        )

                        let barHeight: CGFloat = count == 0
                            ? 4
                            : max(
                                8,
                                CGFloat(count) / CGFloat(maximum) * chartHeight
                            )

                        VStack(spacing: 9) {

                            // Chant Count

                            Text(count.formatted())
                                .font(.system(size: 11, weight: .medium))
                                .foregroundStyle(AppColors.secondaryText)
                                .lineLimit(1)
                                .minimumScaleFactor(0.7)

                            // Bar Background

                            ZStack(alignment: .bottom) {

                                RoundedRectangle(cornerRadius: 12)
                                    .fill(
                                        AppColors.background.opacity(0.9)
                                    )

                                RoundedRectangle(cornerRadius: 12)
                                    .fill(
                                        viewModel.isToday(date)
                                        ? AppColors.primary
                                        : AppColors.primary.opacity(0.65)
                                    )
                                    .frame(height: barHeight)
                            }
                            .frame(height: chartHeight)

                            // Weekday Label

                            Text(viewModel.weekdayLabel(for: date))
                                .font(.system(size: 14, weight: .medium))
                                .foregroundStyle(
                                    viewModel.isToday(date)
                                    ? AppColors.primary
                                    : AppColors.secondaryText
                                )
                        }
                        .frame(maxWidth: .infinity)
                        .accessibilityElement(children: .ignore)
                        .accessibilityLabel(
                            "\(date.formatted(date: .complete, time: .omitted)), \(count) chants"
                        )
                        .accessibilityAddTraits(
                            viewModel.isToday(date) ? .isSelected : []
                        )
                    }
                }
                .frame(height: chartHeight + 45)

                // MARK: Empty State

                if viewModel.weeklyChants == 0 {
                    Text("Your chanting journey starts with one mantra.")
                        .font(.system(size: 14))
                        .foregroundStyle(AppColors.secondaryText)
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                        .padding(.top, 4)
                }
            }
        }
        .padding(25)
        .background(AppColors.cardBackground)
        .clipShape(
            RoundedRectangle(cornerRadius: 32)
        )
        .animation(
            .easeInOut(duration: 0.35),
            value: viewModel.weeklyChants
        )
    }
}

