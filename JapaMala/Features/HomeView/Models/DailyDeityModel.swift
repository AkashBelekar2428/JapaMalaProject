//
//  DailyDeityModel.swift
//  JapaMala
//
//  Created by Akash Belekar on 25/11/26.
//


import Foundation

enum DailyDeity: Int, CaseIterable, Identifiable {

    // Calendar weekday:
    // Sunday = 1, Monday = 2 ... Saturday = 7

    case sunday = 1
    case monday = 2
    case tuesday = 3
    case wednesday = 4
    case thursday = 5
    case friday = 6
    case saturday = 7

    var id: Int { rawValue }

    // MARK: - Deity Name

    var name: String {
        switch self {
        case .monday:
            return "Lord Shiva"
        case .tuesday:
            return "Lord Hanuman"
        case .wednesday:
            return "Ganpati Bappa"
        case .thursday:
            return "Lord Vishnu"
        case .friday:
            return "Goddess Lakshmi"
        case .saturday:
            return "Shani Dev"
        case .sunday:
            return "Surya Dev"
        }
    }

    // MARK: - Day Name

    var dayName: String {
        switch self {
        case .monday: return "Monday"
        case .tuesday: return "Tuesday"
        case .wednesday: return "Wednesday"
        case .thursday: return "Thursday"
        case .friday: return "Friday"
        case .saturday: return "Saturday"
        case .sunday: return "Sunday"
        }
    }

    var traditionalDayName: String {
        switch self {
        case .monday: return "Somvar"
        case .tuesday: return "Mangalvar"
        case .wednesday: return "Budhvar"
        case .thursday: return "Guruvar"
        case .friday: return "Shukravar"
        case .saturday: return "Shanivar"
        case .sunday: return "Ravivar"
        }
    }

    // MARK: - Mantra

    var mantra: String {
        switch self {
        case .monday:
            return "ॐ नमः शिवाय"
        case .tuesday:
            return "ॐ हनुमते नमः"
        case .wednesday:
            return "ॐ गं गणपतये नमः"
        case .thursday:
            return "ॐ नमो भगवते वासुदेवाय"
        case .friday:
            return "ॐ श्रीं महालक्ष्म्यै नमः"
        case .saturday:
            return "ॐ शं शनैश्चराय नमः"
        case .sunday:
            return "ॐ सूर्याय नमः"
        }
    }

    // MARK: - Transliteration

    var transliteration: String {
        switch self {
        case .monday:
            return "Om Namah Shivaya"
        case .tuesday:
            return "Om Hanumate Namah"
        case .wednesday:
            return "Om Gam Ganapataye Namah"
        case .thursday:
            return "Om Namo Bhagavate Vasudevaya"
        case .friday:
            return "Om Shreem Mahalakshmyai Namah"
        case .saturday:
            return "Om Sham Shanaishcharaya Namah"
        case .sunday:
            return "Om Suryaya Namah"
        }
    }

    // MARK: - Description

    var description: String {
        switch self {
        case .monday:
            return "Begin your week with devotion to Lord Shiva."
        case .tuesday:
            return "Find strength and courage through Lord Hanuman."
        case .wednesday:
            return "Welcome new beginnings with Ganpati Bappa."
        case .thursday:
            return "Offer your devotion to Lord Vishnu."
        case .friday:
            return "Reflect on grace and devotion to Goddess Lakshmi."
        case .saturday:
            return "Spend a moment in prayer to Shani Dev."
        case .sunday:
            return "Begin your day with gratitude to Surya Dev."
        }
    }

    // MARK: - Emoji

    var symbol: String {
        switch self {
        case .monday: return "🔱"
        case .tuesday: return "🙏"
        case .wednesday: return "🐘"
        case .thursday: return "🪷"
        case .friday: return "🌸"
        case .saturday: return "🪔"
        case .sunday: return "☀️"
        }
    }
    
    static func forDate(_ date: Date) -> DailyDeity {
        let weekday = Calendar.current.component(
            .weekday,
            from: date
        )

        return DailyDeity(rawValue: weekday) ?? .sunday
    }

    static var today: DailyDeity {
        forDate(Date())
    }
}
