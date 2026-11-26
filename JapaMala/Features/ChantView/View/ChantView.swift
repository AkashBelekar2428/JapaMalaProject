//
//  ChantView.swift
//  JapaMala
//
//  Created by Akash Belekar on 22/11/26.
//


import SwiftUI
import AudioToolbox
import UIKit
import SwiftData

struct ChantView: View {

    // MARK: - Properties

    @State private var count = 0
    @State private var soundEnabled = false
    @State private var vibrationEnabled = true
    @State private var showFinishAlert = false
    
    @State private var isCompleting = false
    @State private var isCelebrating = false
    
    // MARK: - Chant Options

    private let chantOptions = [11, 21, 54, 108]

    private let mantraOptions = [
        "Om Namah Shivaya",
        "Om Namo Bhagavate Vasudevaya",
        "Om Namo Narayanaya",
        "Om Gan Ganapataye Namah",
    ]

    // MARK: - User Selection

    @State private var selectedTarget = 11

    @State private var selectedMantra = "Om Namah Shivaya"

    @State private var customMantra = ""

    @State private var showCustomMantraSheet = false

    @State private var completedRounds = 0
    
    @Environment(\.modelContext) private var modelContext

    // MARK: - Dynamic Values

    private var totalChants: Int {
        selectedTarget
    }

    private var beadCount: Int {
        selectedTarget
    }

    // MARK: - Computed Properties

    private var activeBead: Int {
        min(count, beadCount - 1)
    }
  
    // MARK: - Save Completed Chant Session

    private func saveChantSession() {

        guard count > 0 else { return }

        let session = JapaSession(
            mantraTitle: selectedMantra,
            sessionDate: .now,
            chantCount: count
        )

        modelContext.insert(session)

        do {
            try modelContext.save()
            print("Successfully saved \(count) chants!")
        } catch {
            print("Failed to save chanting session: \(error.localizedDescription)")
        }
    }

    
    // MARK: - Body

    var body: some View {

        GeometryReader { geometry in

            let compact = geometry.size.height < 750
            let ringSize = min(geometry.size.width - 76, 280)

            ScrollView{
                VStack(spacing: 0) {
                    
                    // MARK: Header
                    
                    header
                        .padding(.top, compact ? 12 : 25)
                    
                    Spacer(minLength: 15)
                    
                    // MARK: Mantra
                    
                    mantraSection
                    
                    Spacer(minLength: 10)
                    
                    // MARK: Chant Goal
                    
                    goalPicker
                    
                    Spacer(minLength: 15)
                    
                    // MARK: Mala Progress
                    
                    MalaProgressRing(
                        count: count,
                        totalChants: totalChants,
                        beadCount: beadCount,
                        activeBead: activeBead,
                        isCelebrating: isCelebrating
                    )
                    .frame(width: ringSize, height: ringSize)
                    
                    Spacer(minLength: 10)
                    
                    // MARK: Motivation Text
                    
                    Text("Breathe gently. There is no hurry.")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(AppColors.secondaryText)
                        .multilineTextAlignment(.center)
                    
                    Spacer(minLength: 15)
                    
                    // MARK: Count Button
                    
                    countButton
                    
                    // MARK: Sound and Vibration
                    
                    HStack(spacing: 12) {
                        
                        settingButton(
                            title: soundEnabled ? "Sound on" : "Sound off",
                            icon: soundEnabled
                            ? "speaker.wave.2"
                            : "speaker.slash",
                            isEnabled: soundEnabled
                        ) {
                            soundEnabled.toggle()
                        }
                        .malaGlass(in: Capsule())
                        
                        settingButton(
                            title: vibrationEnabled
                            ? "Vibration on"
                            : "Vibration off",
                            icon: "iphone.radiowaves.left.and.right",
                            isEnabled: vibrationEnabled
                        ) {
                            vibrationEnabled.toggle()
                        }
                        .malaGlass(in: Capsule())
                    }
                    .padding(.top, 18)
                    
                    Spacer(minLength: 20)
                    
                    // MARK: Finish Button
                    
                    Button {
                        showFinishAlert = true
                    } label: {
                        Text("Reset")
                            .font(.system(size: 17, weight: .medium))
                            .foregroundStyle(AppColors.secondaryText)
                            .frame(maxWidth: 100)
                            .padding(.vertical, 12)
                    }
                    .buttonStyle(.plain)
                    .background(
                        AppColors.cardBackground.opacity(0.25),
                        in: RoundedRectangle(cornerRadius: 18)
                    )
                    .malaGlass(in: Capsule())
                    
                    
                    Spacer(minLength: 12)
                }
            }
            .padding(.horizontal, 22)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(AppColors.background)
        }
        .alert("Finish your practice?", isPresented: $showFinishAlert) {

            Button("Continue", role: .cancel) { }

            Button("Reset", role: .destructive) {
                count = 0
            }

        } message: {
            Text("Your current chant count is \(count) of \(totalChants).")
        }
        
        .sheet(isPresented: $showCustomMantraSheet) {

            NavigationStack {

                VStack(spacing: 20) {

                    Text("Create your own mantra")
                        .font(.system(size: 21, weight: .semibold))
                        .foregroundStyle(AppColors.primaryText)

                    TextField(
                        "Enter your mantra",
                        text: $customMantra
                    )
                    .font(.system(size: 17))
                    .padding()
                    .background(
                        AppColors.cardBackground,
                        in: RoundedRectangle(cornerRadius: 14)
                    )

                    Button {

                        let newMantra = customMantra
                            .trimmingCharacters(in: .whitespacesAndNewlines)

                        if !newMantra.isEmpty {
                            selectMantra(newMantra)
                            showCustomMantraSheet = false
                        }

                    } label: {

                        Text("Save Mantra")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                AppColors.primary,
                                in: RoundedRectangle(cornerRadius: 16)
                            )
                    }
                    .buttonStyle(.plain)

                    Spacer()
                }
                .padding(24)
                .background(AppColors.background)
                .navigationTitle("My Mantra")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            showCustomMantraSheet = false
                        }
                        .foregroundStyle(AppColors.primary)
                    }
                }
            }
            .presentationDetents([.medium])
        }

    }
    
    
    private var goalPicker: some View {

        VStack(spacing: 10) {

            Text("CHOOSE YOUR COUNT")
                .font(.system(size: 11, weight: .bold))
                .foregroundStyle(AppColors.secondaryText)

            HStack(spacing: 8) {

                ForEach(chantOptions, id: \.self) { goal in

                    Button {

                        guard !isCompleting else { return }

                        withAnimation(.spring(response: 0.3)) {
                            selectedTarget = goal
                            count = 0
                            completedRounds = 0
                        }

                    } label: {

                        Text("\(goal)")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(
                                selectedTarget == goal
                                ? .white
                                : AppColors.primary
                            )
                            .frame(maxWidth: .infinity)
                            .frame(height: 38)
                            .background(
                                selectedTarget == goal
                                ? AppColors.primary
                                : AppColors.cardBackground,
                                in: Capsule()
                            )
                    }
                    .buttonStyle(.plain)
                    .malaGlass(in: Capsule())
                    .animation(
                        .spring(response: 0.4, dampingFraction: 0.75),
                        value: selectedTarget
                    )
                }
            }
        }
        .disabled(isCompleting)
    }


    // MARK: - Header

    private var header: some View {

        HStack {

            Text("TODAYS YOUR CHANT")
                .font(.system(size: 12, weight: .bold))
                .foregroundStyle(AppColors.primary)

            Spacer()

            Text("Mala 1 of 1")
                .font(.system(size: 14, weight: .regular))
                .foregroundStyle(AppColors.secondaryText)
        }
    }

    // MARK: - Mantra Section

        private var mantraSection: some View {

        VStack(spacing: 9) {

            Menu {

                ForEach(mantraOptions, id: \.self) { mantra in

                    Button {
                        selectMantra(mantra)
                    } label: {
                        if selectedMantra == mantra {
                            Label(mantra, systemImage: "checkmark")
                        } else {
                            Text(mantra)
                        }
                    }
                    
                }

                Divider()

                Button {
                    customMantra = ""
                    showCustomMantraSheet = true
                } label: {
                    Label("Custom Mantra", systemImage: "plus")
                }

            } label: {

                HStack(spacing: 7) {

                    Text(selectedMantra)
                        .font(.system(
                            size: 27,
                            weight: .regular,
                            design: .serif
                        ))
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)

                    Image(systemName: "chevron.down")
                        .font(.system(size: 12, weight: .medium))
                }
                .foregroundStyle(AppColors.primaryText)
            }

        }
    }

    private func selectMantra(_ mantra: String) {

        withAnimation(.spring(response: 0.35)) {
            selectedMantra = mantra
            count = 0
            completedRounds = 0
        }
    }

    // MARK: - Count Button

    private var countButton: some View {

        Button {

            guard count < totalChants && !isCompleting else {
                return
            }

            let nextCount = count + 1

            withAnimation(.spring(response: 0.4)) {
                count = nextCount
            }

            if nextCount == totalChants {
                completeMala()
            } else {
                if vibrationEnabled {
                    UIImpactFeedbackGenerator(style: .light)
                        .impactOccurred()
                }

                if soundEnabled {
                    AudioServicesPlaySystemSound(1104)
                }
            }

        } label: {

            HStack(spacing: 14) {

                Image(systemName: "plus")
                    .font(.system(size: 25, weight: .medium))

                Text("Tap to count")
                    .font(.system(size: 21, weight: .semibold))
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 64)
            .background {
                Capsule()
                    .fill(AppColors.primary)
                    .malaGlass(in: Capsule())
            }
            .overlay {
                Capsule()
                    .strokeBorder(
                        Color.white.opacity(0.25),
                        lineWidth: 1
                    )
            }
        }
        .buttonStyle(.plain)
        .disabled(isCompleting)
        .opacity(isCompleting ? 0.7 : 1)
    }

    // MARK: - Complete Mala

    private func completeMala() {

        guard !isCompleting else { return }

        isCompleting = true
        completedRounds += 1

        // Save completed chanting session
        saveChantSession()

        // Completion vibration
        if vibrationEnabled {
            UINotificationFeedbackGenerator()
                .notificationOccurred(.success)
        }

        // Completion sound
        if soundEnabled {
            AudioServicesPlaySystemSound(1025)
        }

        // Celebration animation
        withAnimation(.easeInOut(duration: 0.3)) {
            isCelebrating = true
        }

        // Reset for next round
        Task { @MainActor in

            try? await Task.sleep(
                nanoseconds: 1_200_000_000
            )

            withAnimation(.spring(response: 0.6)) {
                count = 0
                isCelebrating = false
                isCompleting = false
            }
        }
    }


    // MARK: - Setting Button

    private func settingButton(
        title: String,
        icon: String,
        isEnabled: Bool,
        action: @escaping () -> Void
    ) -> some View {

        Button(action: action) {

            HStack(spacing: 9) {

                Image(systemName: icon)
                    .font(.system(size: 19, weight: .medium))

                Text(title)
                    .font(.system(size: 15, weight: .medium))
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            .foregroundStyle(AppColors.primary)
            .frame(maxWidth: .infinity)
            .frame(height: 48)
            .background(
                AppColors.cardBackground.opacity(
                    isEnabled ? 1 : 0.75
                ),
                in: RoundedRectangle(cornerRadius: 18)
            )
        }
        .buttonStyle(.plain)
    }
}


// MARK: - Mala Progress Ring

struct MalaProgressRing: View {

    let count: Int
    let totalChants: Int
    let beadCount: Int
    let activeBead: Int
    let isCelebrating: Bool

    private let radius: CGFloat = 118

    // Dynamic bead sizes
    private var beadSize: CGFloat {

        switch beadCount {
        case 1...11: return 13
        case 12...30: return 10
        case 31...60: return 8
        default: return 5.5
        }
    }

    var body: some View {

        GeometryReader { geometry in

            let centerX = geometry.size.width / 2
            let centerY = geometry.size.height / 2

            ZStack {

                // MARK: Circular Beads

                ForEach(0..<beadCount, id: \.self) { index in

                    let angle = Double(index) *
                        (360.0 / Double(beadCount))

                    let radians = angle * .pi / 180

                    let x = centerX +
                        radius * sin(radians)

                    let y = centerY -
                        radius * cos(radians)

                    Circle()

                        .fill(beadColor(for: index))

                        .frame(
                            width: index == activeBead
                                ? beadSize + 3
                                : beadSize,
                            height: index == activeBead
                                ? beadSize + 3
                                : beadSize
                        )

                        .position(x: x, y: y)

                        .scaleEffect(
                            isCelebrating ? 1.35 : 1.0
                        )

                        .opacity(
                            isCelebrating ? 0.75 : 1.0
                        )

                        .shadow(
                            color: index == activeBead
                                ? AppColors.accent.opacity(0.3)
                                : .clear,
                            radius: 5
                        )

                        .animation(
                            .spring(
                                response: 0.4,
                                dampingFraction: 0.7
                            ),
                            value: activeBead
                        )

                        .animation(
                            .easeInOut(duration: 0.3),
                            value: isCelebrating
                        )
                }

                // MARK: Center Counter

                VStack(spacing: 8) {

                    Text("\(count)")
                        .font(.system(
                            size: 82,
                            weight: .regular,
                            design: .serif
                        ))
                        .monospacedDigit()
                        .foregroundStyle(AppColors.primaryText)
                        .contentTransition(.numericText())

                    Text("of \(totalChants) chants")
                        .font(.system(size: 17))
                        .foregroundStyle(AppColors.secondaryText)

                    Text("ONE BEAD AT A TIME")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundStyle(AppColors.primary)
                        .padding(.top, 1)
                }
                .scaleEffect(isCelebrating ? 1.04 : 1.0)
                .animation(
                    .easeInOut(duration: 0.3),
                    value: isCelebrating
                )
            }
            .frame(
                width: geometry.size.width,
                height: geometry.size.height
            )
        }
    }

    // MARK: Bead Color

    private func beadColor(for index: Int) -> Color {

        if index < activeBead {
            return AppColors.primary
        }

        if index == activeBead {
            return AppColors.accent
        }

        return AppColors.cardBackground
    }
}

// MARK: - Preview

#Preview {
    ChantView()
        .background(AppColors.background)
}
