//
//  MantraModel.swift
//  JapaMala
//
//  Created by Akash Belekar on 24/11/26.
//

//MARK: Every mantra has its own unique ID, title, description, and saved/selected status.
import Foundation

struct Mantra: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var title: String
    var subtitle: String
    var isSaved: Bool = false
    var isCustom: Bool = false
}
