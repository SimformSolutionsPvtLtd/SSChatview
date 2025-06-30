//
//  DateExtension.swift
//  SSChatviewDemo
//
//  Created by Palak Doshi on 29/04/25.
//

import SwiftUI

// MARK: - Date Extension for Generating Random Timestamps
extension Date {

    /// Generates a random time earlier today.
    /// - Returns: A `Date` object with a random hour and minute before the current time today.
    static func randomPastTimeToday() -> Date {
        let now = Date()
        let calendar = Calendar.current
        let currentHour = calendar.component(.hour, from: now)

        // If it's midnight (hour == 0), return now or fallback to a fixed earlier time (e.g., 11:59 PM yesterday)
        guard currentHour > 0 else {
            return calendar.date(byAdding: .minute, value: -1, to: now) ?? now
        }

        let randomHour = Int.random(in: 0..<currentHour)
        let randomMinute = Int.random(in: 0..<60)

        return calendar.date(bySettingHour: randomHour, minute: randomMinute, second: 0, of: now) ?? now
    }

    /// Generates a random past date and time from earlier in the current week.
    /// - Returns: A `Date` object from a previous day of the same week with random time.
    static func randomPastDateThisWeek() -> Date {
        let calendar = Calendar.current
        let now = Date()

        let weekdayToday = calendar.component(.weekday, from: now)

        // If today is Sunday (1), there's no earlier day this week — return a fallback like "yesterday"
        guard weekdayToday > 1 else {
            return calendar.date(byAdding: .day, value: -1, to: now) ?? now
        }

        // Pick a random day earlier this week
        let randomDayOffset = Int.random(in: 1..<weekdayToday)
        guard let randomDate = calendar.date(byAdding: .day, value: -randomDayOffset, to: now) else {
            return now
        }

        let hour = Int.random(in: 0..<24)
        let minute = Int.random(in: 0..<60)

        return calendar.date(bySettingHour: hour, minute: minute, second: 0, of: randomDate) ?? randomDate
    }
}
