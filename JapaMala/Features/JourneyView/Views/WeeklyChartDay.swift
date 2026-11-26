//
//  WeeklyChartDay.swift
//  JapaMala
//
//  Created by Akash Belekar on 25/11/26.
//

import SwiftUI

struct WeeklyChartDay: View {

    let date: Date
    let count: Int
    let maximum: Int
    let chartHeight: CGFloat
    let weekday: String
    let isToday: Bool

    var body: some View {

        VStack(spacing: 9) {

            // Chant Count
            Text(count.formatted())
                .font(.system(size: 11, weight: .medium))
                .foregroundStyle(AppColors.secondaryText)
                .lineLimit(1)
                .minimumScaleFactor(0.7)

            // Glass Progress Bar
            WeeklyProgressBar(
                count: count,
                maximum: maximum,
                chartHeight: chartHeight,
                isToday: isToday
            )

            // Weekday
            Text(weekday)
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(
                    isToday
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
            isToday ? .isSelected : []
        )
    }
}
