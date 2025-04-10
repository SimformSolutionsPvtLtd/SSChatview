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
        let now = Date.now
        let calendar = Calendar.current

        // Generate a random hour less than the current hour to ensure it's in the past
        let hour = Int.random(in: 0..<calendar.component(.hour, from: now))
        let minute = Int.random(in: 0..<60)

        // Set the generated hour and minute for today's date
        return calendar.date(bySettingHour: hour, minute: minute, second: 0, of: now)!
    }

    /// Generates a random past date and time from earlier in the current week.
    /// - Returns: A `Date` object from a previous day of the same week with random time.
    static func randomPastDateThisWeek() -> Date {
        let calendar = Calendar.current
        let now = Date()

        // Determine today's weekday (1 = Sunday, 7 = Saturday)
        let weekdayToday = calendar.component(.weekday, from: now)

        // Pick a random offset from earlier days of this week (excluding today)
        let randomDayOffset = Int.random(in: 1..<weekdayToday)

        // Generate a random hour and minute
        let hour = Int.random(in: 0..<24)
        let minute = Int.random(in: 0..<60)

        // Create a date by subtracting the random offset in days, and setting random time
        let randomDate = calendar.date(byAdding: .day, value: -randomDayOffset, to: now)!
        return calendar.date(bySettingHour: hour, minute: minute, second: 0, of: randomDate)!
    }
}
