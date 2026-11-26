//
//  WeeklyProgressCard.swift
//  JapaMala
//
//  Created by Akash Belekar on 24/11/26.
//

import SwiftUI

struct WeeklyProgressCard: View {

    let viewModel: HistoryViewModel

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

                    ForEach(viewModel.weekDates, id: \.self) { date in

                        let count = viewModel.dailyChantCount(on: date)

                        WeeklyChartDay(
                            date: date,
                            count: count,
                            maximum: viewModel.highestDailyChantCount,
                            chartHeight: chartHeight,
                            weekday: viewModel.weekdayLabel(for: date),
                            isToday: viewModel.isToday(date)
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
        .background {
            RoundedRectangle(cornerRadius: 32, style: .continuous)
                .fill(AppColors.cardBackground.opacity(0.65))
                .malaGlass(in: RoundedRectangle(cornerRadius: 32, style: .continuous))
        }
        .overlay {
            RoundedRectangle(cornerRadius: 32, style: .continuous)
                .strokeBorder(
                    AppColors.surface.opacity(0.8),
                    lineWidth: 1
                )
        }
        .shadow(
            color: AppColors.primaryText.opacity(0.06),
            radius: 16,
            x: 0,
            y: 8
        )
        .animation(
            .easeInOut(duration: 0.35),
            value: viewModel.weeklyChants
        )
    }
}

