//
//  JapaSessionModel.swift
//  JapaMala
//
//  Created by Akash Belekar on 24/11/26.
//


import Foundation
import SwiftData

//MARK: SwiftData persistence
@Model
final class JapaSession {

    var id: UUID
    var mantraTitle: String
    var sessionDate: Date
    var chantCount: Int

    init(
        mantraTitle: String,
        sessionDate: Date = .now,
        chantCount: Int
    ) {
        self.id = UUID()
        self.mantraTitle = mantraTitle
        self.sessionDate = sessionDate
        self.chantCount = chantCount
    }
}
