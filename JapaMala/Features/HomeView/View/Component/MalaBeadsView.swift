//
//  a.swift
//  JapaMala
//
//  Created by Akash Belekar on 21/11/26.
//


import SwiftUI
public import Combine

struct MalaBeadsView: View {

    private let beadCount = 18
    private let radius: CGFloat = 42

    @State private var activeBead = 0

    // Animation timer
    private let timer = Timer.publish(
        every: 1.5,
        on: .main,
        in: .common
    ).autoconnect()

    var body: some View {

        ZStack {

            // Mala beads
            ForEach(0..<beadCount, id: \.self) { index in

                let angle = Double(index) *
                    (360.0 / Double(beadCount))

                Circle()
                    .fill(
                        index == activeBead
                        ? AppColors.accent
                        : AppColors.primary
                    )
                    .frame(
                        width: index == activeBead ? 15 : 12,
                        height: index == activeBead ? 15 : 12
                    )
                    .overlay {
                        Circle()
                            .fill(.white.opacity(0.25))
                            .frame(width: 5, height: 5)
                            .offset(x: -3, y: -3)
                    }
                    .shadow(
                        color: index == activeBead
                        ? AppColors.accent.opacity(0.4)
                        : AppColors.primary.opacity(0.15),
                        radius: index == activeBead ? 7 : 3
                    )
                    .offset(y: -radius)
                    .rotationEffect(.degrees(angle))
                    .animation(
                        .spring(
                            response: 0.45,
                            dampingFraction: 0.65
                        ),
                        value: activeBead
                    )
            }

            // Guru bead - stationary
            Circle()
                .fill(AppColors.accent)
                .frame(width: 15, height: 15)
                .overlay {
                    Circle()
                        .stroke(.white.opacity(0.5), lineWidth: 1)
                }
                .shadow(
                    color: AppColors.accent.opacity(0.3),
                    radius: 5
                )
                .offset(y: 53)
        }
        .frame(width: 124, height: 124)

        // Move one bead at a time
        .onReceive(timer) { _ in
            withAnimation(.spring(
                response: 0.20,
                dampingFraction: 0.40
            )) {
                activeBead = (activeBead + 1) % beadCount
            }
        }

        .accessibilityLabel("Japa Mala with sequentially moving beads")
    }
}

#Preview {
    MalaBeadsView()
        .padding()
        .background(AppColors.background)
}
