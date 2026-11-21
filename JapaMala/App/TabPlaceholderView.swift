//
//  as.swift
//  JapaMala
//
//  Created by Akash Belekar on 21/11/26.
//


import SwiftUI

struct TabPlaceholderView: View {

    let tab: AppTab

    var body: some View {

        VStack(spacing: 16) {

            Image(systemName: tab.symbol)
                .font(.system(size: 42))
                .foregroundStyle(AppColors.primary)

            Text(tab.title)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(AppColors.primaryText)

            Text("We will design this page together.")
                .foregroundStyle(AppColors.secondaryText)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
