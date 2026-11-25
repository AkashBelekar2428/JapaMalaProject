//
//  AnimationMalaView.swift
//  JapaMala
//
//  Created by Akash Belekar on 25/11/26.
//

import SwiftUI

struct AnimatedMalaView: View {

    // MARK: - Properties

    @Environment(\.accessibilityReduceMotion)
    private var reduceMotion

    private let beadCount = 18
    private let radius: CGFloat = 53
    private let beadSize: CGFloat = 14

    private let beadColor = AppColors.primary
    private let guruColor = AppColors.accent

    // MARK: - Body

    var body: some View {

        Group {
            if reduceMotion {
                staticMala
            } else {
                animatedMala
            }
        }
        .accessibilityLabel("Animated Japa Mala")
    }

    // MARK: - Animated Mala

    private var animatedMala: some View {

        TimelineView(.animation(minimumInterval: 0.7)) { timeline in

            let activeBead = Int(
                timeline.date.timeIntervalSinceReferenceDate / 0.7
            ) % beadCount

            ZStack {

                // MARK: Mala Beads

                ForEach(0..<beadCount, id: \.self) { index in

                    let angle = (
                        Double(index) * 2 * .pi /
                        Double(beadCount)
                    ) - (.pi / 2)

                    let x = CGFloat(cos(angle)) * radius
                    let y = CGFloat(sin(angle)) * radius

                    Circle()
                        .fill(beadColor)
                        .frame(
                            width: beadSize,
                            height: beadSize
                        )
                        .overlay {
                            Circle()
                                .fill(.white.opacity(0.3))
                                .frame(width: 5, height: 5)
                                .offset(x: -3, y: -3)
                        }
                        .shadow(
                            color: beadColor.opacity(0.2),
                            radius: 3,
                            y: 2
                        )
                        .scaleEffect(
                            activeBead == index ? 1.2 : 1
                        )
                        .overlay {
                            if activeBead == index {
                                Circle()
                                    .stroke(
                                        guruColor.opacity(0.7),
                                        lineWidth: 1.5
                                    )
                                    .padding(-3)
                            }
                        }
                        .offset(x: x, y: y)
                        .animation(
                            .easeInOut(duration: 0.5),
                            value: activeBead
                        )
                }

                // MARK: Guru Bead

                Circle()
                    .fill(guruColor)
                    .frame(width: 21, height: 21)
                    .overlay {
                        Circle()
                            .fill(.white.opacity(0.3))
                            .frame(width: 7, height: 7)
                            .offset(x: -4, y: -4)
                    }
                    .shadow(
                        color: guruColor.opacity(0.25),
                        radius: 4,
                        y: 2
                    )
                    .offset(y: radius + 16)
            }
            .frame(width: 140, height: 145)
        }
    }

    // MARK: - Static Mala (Reduce Motion Enabled)

    private var staticMala: some View {

        ZStack {

            ForEach(0..<beadCount, id: \.self) { index in

                let angle =
                    Double(index) * 2 * .pi / Double(beadCount) - .pi / 2

                Circle()
                    .fill(beadColor)
                    .frame(width: beadSize, height: beadSize)
                    .offset(
                        x: CGFloat(cos(angle)) * radius,
                        y: CGFloat(sin(angle)) * radius
                    )
            }

            Circle()
                .fill(guruColor)
                .frame(width: 21, height: 21)
                .offset(y: radius + 16)
        }
        .frame(width: 140, height: 145)
    }
}

