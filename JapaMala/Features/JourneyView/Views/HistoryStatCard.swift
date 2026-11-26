//
//  HistoryStatCard.swift
//  JapaMala
//
//  Created by Akash Belekar on 24/11/26.
//

import SwiftUI

struct HistoryStatCard: View {

    let value: Int
    let title: String

    private let cardShape = RoundedRectangle(
        cornerRadius: 30,
        style: .continuous
    )

    var body: some View {

        VStack(alignment: .leading, spacing: 12) {

            Text(value.formatted())
                .font(.system(size: 42, weight: .regular, design: .serif))
                .foregroundStyle(AppColors.primaryText)
                .contentTransition(.numericText())

            Text(title)
                .font(.system(size: 16))
                .foregroundStyle(AppColors.secondaryText)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .frame(minHeight: 140)

        // Liquid Glass Background
        .background {
            cardShape
                .fill(AppColors.surface.opacity(0.65))
                .malaGlass(in: cardShape)
        }

        // Subtle Glass Border
        .overlay {
            cardShape
                .strokeBorder(
                    AppColors.surface.opacity(0.8),
                    lineWidth: 1
                )
        }

        // Soft Shadow
        .shadow(
            color: AppColors.primaryText.opacity(0.05),
            radius: 12,
            x: 0,
            y: 6
        )

        .animation(
            .spring(response: 0.4),
            value: value
        )
    }
}

