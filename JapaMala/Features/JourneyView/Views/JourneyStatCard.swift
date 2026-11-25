//
//  JourneyStatCard.swift
//  JapaMala
//
//  Created by Akash Belekar on 24/11/26.
//

import SwiftUI

struct JourneyStatCard: View {

    let value: Int
    let title: String

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
        .background(AppColors.surface)
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .animation(.spring(response: 0.4), value: value)
    }
}
