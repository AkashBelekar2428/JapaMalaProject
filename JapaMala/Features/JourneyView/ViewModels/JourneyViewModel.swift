//
//  JourneyViewModel.swift
//  JapaMala
//
//  Created by Akash Belekar on 24/11/26.
//

import Foundation

struct JourneyViewModel {

    let sessions: [JapaSession]

    // MARK: - Calendar

    private var calendar: Calendar {
        var calendar = Calendar.current
        calendar.firstWeekday = 2 // Monday
        return calendar
    }

    // MARK: - Total Chants

    var totalChants: Int {
        sessions.reduce(0) { $0 + $1.chantCount }
    }

    // MARK: - Total Malas

    var totalMalas: Int {
        totalChants / 108
    }

    // MARK: - Current Week

    var weekDates: [Date] {
        let today = Date()

        let weekday = calendar.component(.weekday, from: today)
        let daysFromMonday = (weekday + 5) % 7

        let monday = calendar.date(
            byAdding: .day,
            value: -daysFromMonday,
            to: calendar.startOfDay(for: today)
        )!

        return (0..<7).compactMap {
            calendar.date(byAdding: .day, value: $0, to: monday)
        }
    }

    // MARK: - Weekly Date Range

    var weekDateRange: String {
        guard let first = weekDates.first,
              let last = weekDates.last else {
            return ""
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM"

        return "\(formatter.string(from: first))–\(formatter.string(from: last))"
    }

    // MARK: - Practice Days

    var weeklyPracticeDays: Int {
        weekDates.filter { date in
            hasPracticed(on: date)
        }.count
    }

    // MARK: - Weekly Chants

    var weeklyChants: Int {
        weekDates.reduce(0) { total, date in
            total + dailyChantCount(on: date)
        }
    }

    // MARK: - Daily Chant Count

    func dailyChantCount(on date: Date) -> Int {
        sessions.reduce(0) { total, session in

            guard session.chantCount > 0,
                  calendar.isDate(
                    session.sessionDate,
                    inSameDayAs: date
                  ) else {
                return total
            }

            return total + session.chantCount
        }
    }

    // MARK: - Highest Daily Chant Count

    var highestDailyChantCount: Int {
        weekDates.map {
            dailyChantCount(on: $0)
        }.max() ?? 0
    }

    // MARK: - Check Daily Practice

    func hasPracticed(on date: Date) -> Bool {
        dailyChantCount(on: date) > 0
    }

    // MARK: - Day Labels

    func weekdayLabel(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEEE"
        return formatter.string(from: date)
    }

    // MARK: - Check Today

    func isToday(_ date: Date) -> Bool {
        calendar.isDateInToday(date)
    }
}
