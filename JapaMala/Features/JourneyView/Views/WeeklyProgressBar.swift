//
//  WeeklyProgressBar.swift
//  JapaMala
//
//  Created by Akash Belekar on 25/11/26.
//


import SwiftUI

struct WeeklyProgressBar: View {

    let count: Int
    let maximum: Int
    let chartHeight: CGFloat
    let isToday: Bool

    private var barHeight: CGFloat {
        guard count > 0 else { return 4 }

        let progress = CGFloat(count) / CGFloat(max(maximum, 1))
        return max(8, progress * chartHeight)
    }

    private var progressGradient: LinearGradient {
        LinearGradient(
            colors: [
                AppColors.primary.opacity(isToday ? 0.85 : 0.45),
                AppColors.primary.opacity(isToday ? 1.0 : 0.75)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }

    private let barShape = RoundedRectangle(
        cornerRadius: 12,
        style: .continuous
    )

    var body: some View {

        ZStack(alignment: .bottom) {

            // Glass Track
            barShape
                .fill(AppColors.surface.opacity(0.55))
                .malaGlass(in: barShape)

            // Chant Progress
            barShape
                .fill(progressGradient)
                .frame(height: barHeight)
                .overlay {
                    barShape
                        .strokeBorder(
                            Color.white.opacity(0.25),
                            lineWidth: 0.8
                        )
                }
        }
        .frame(height: chartHeight)
        .animation(
            .spring(response: 0.5, dampingFraction: 0.75),
            value: count
        )
    }
}
