//
//  AppTab.swift
//  JapaMala
//
//  Created by Akash Belekar on 21/11/26.
//

import SwiftUI

/* enum: Defines a fixed set of options. We have exactly four tabs.
CaseIterable: Allows us to loop through all four tabs automatically.
Identifiable: Gives each tab a unique identity for SwiftUI.
var title: Provides the text displayed below the icon.
var symbol: Provides the SF Symbol used for the tab icon. */


//MARK: Defines our four tabs and their properties.
enum AppTab: String, CaseIterable, Identifiable {

    //Defines available tabs
    case home
    case chant
    case mantras
    case journey

    var id: String {
        rawValue
    }

    // Tab title
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .chant:
            return "Chant"
        case .mantras:
            return "Mantras"
        case .journey:
            return "Journey"
        }
    }

    // Assests icon
    var symbol: String {
        switch self {
        case .home:
            return "Home_icon"
        case .chant:
            return "Chant_icon"
        case .mantras:
            return "Mantras_icon"
        case .journey:
            return "Journey_icon"
        }
    }
}
