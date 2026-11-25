//
//  hap.swift
//  JapaMala
//
//  Created by Akash Belekar on 25/11/26.
//

//We'll use Apple's native UIKit haptic engine. No additional package required.
//*/

import UIKit

final class HapticService {

   static let shared = HapticService()

   private init() {}

   // MARK: - Bead Tap Feedback

   func beadTap() {
       guard UserSettings.bool(
           forKey: UserSettings.hapticFeedbackKey
       ) else { return }

       let generator = UIImpactFeedbackGenerator(style: .soft)
       generator.prepare()
       generator.impactOccurred(intensity: 0.6)
   }

   // MARK: - Selection Feedback

   func selection() {
       guard UserSettings.bool(
           forKey: UserSettings.hapticFeedbackKey
       ) else { return }

       let generator = UISelectionFeedbackGenerator()
       generator.prepare()
       generator.selectionChanged()
   }
}
