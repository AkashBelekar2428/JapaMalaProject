//
//  JourneyView.swift
//  JapaMala
//
//  Created by Akash Belekar on 24/11/26.
//

import SwiftUI
import SwiftData

struct JourneyView: View {

    @Query(
        sort: \JapaSession.sessionDate,
        order: .reverse
    )
    private var sessions: [JapaSession]

    private var journeyViewModel: JourneyViewModel {
        JourneyViewModel(sessions: sessions)
    }

    var body: some View {

        ScrollView(showsIndicators: false) {

            VStack(alignment: .leading, spacing: 30) {

                // MARK: Header

                VStack(alignment: .leading, spacing: 14) {

                    Text("EVERY RETURN COUNTS")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(AppColors.accent)

                    Text("Your quiet growth.")
                        .font(.system(size: 38, design: .serif))
                        .foregroundStyle(AppColors.primaryText)

                    Text("A little more present, one day at a time.")
                        .font(.system(size: 18))
                        .foregroundStyle(AppColors.secondaryText)
                }
                .padding(.top, 30)

                // MARK: Weekly Progress

                WeeklyProgressCard(
                    viewModel: journeyViewModel
                )

                // MARK: Statistics

                HStack(spacing: 14) {

                    JourneyStatCard(
                        value: journeyViewModel.totalMalas,
                        title: "Malas completed"
                    )

                    JourneyStatCard(
                        value: journeyViewModel.totalChants,
                        title: "Chants offered"
                    )
                }

                // MARK: Motivation

                VStack(alignment: .leading, spacing: 15) {

                    Text("MORE THAN A NUMBER")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(AppColors.accent)

                    Text("The peace you carry matters more than the count.")
                        .font(.system(size: 28, design: .serif))
                        .foregroundStyle(AppColors.primaryText)
                        .fixedSize(horizontal: false, vertical: true)

                    Text("Missed a day? Begin again, gently.")
                        .font(.system(size: 17))
                        .foregroundStyle(AppColors.secondaryText)
                }
                .padding(.top, 10)

            }
            .padding(.horizontal, 24)
            .padding(.bottom, 35)
        }
        .background(AppColors.background.ignoresSafeArea())
    }
}

#Preview {
    JourneyView()
        .modelContainer(
            for: JapaSession.self,
            inMemory: true
        )
}
