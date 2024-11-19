//
//  DateFormatter.swift
//  SSChatView
//
//  Created by Palak Doshi on 18/11/24.
//

import Foundation

extension DateFormatter {

    // MARK: - Create Formatter
    /// Creates and returns a `DateFormatter` with the specified date format.
    private static func createFormatter(with format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "en_US")
        formatter.timeZone = TimeZone.current
        return formatter
    }

    // MARK: - Formatters for Different Contexts
    static let iMessageDateFormatter = createFormatter(with: "d MMM yyyy 'at' h:mm a")
    static let currentYearDateFormatter = createFormatter(with: "EEE, d MMM 'at' h:mm a")
    static let thisWeekDateFormatter = createFormatter(with: "EEEE, h:mm a")
    static let todayDateFormatter = createFormatter(with: "'Today, 'h:mm a")

    // MARK: - Time Formatter
    /// Returns a formatted time string (e.g., "11:21 AM") for the given date.
    static func timeFormatter(_ date: Date) -> String {
        return createFormatter(with: "h:mm a").string(from: date)
    }

    // MARK: - Format Message Date
    /// Returns a formatted date string based on the context of the given date.
    /// - Today: "Today, 12:24 AM"
    /// - This Week: "Tuesday, 12:29 PM"
    /// - Current Year: "Mon, 8 Apr at 5:21 PM"
    /// - Older Years: "19 Nov 2023 at 12:55 PM"
    static func formatMessageDate(_ date: Date) -> String {
        let calendar = Calendar.current
        let currentDate = Date()

        if calendar.isDateInToday(date) {
            return todayDateFormatter.string(from: date)
        } else if calendar.isDate(date, equalTo: currentDate, toGranularity: .weekOfYear) {
            return thisWeekDateFormatter.string(from: date)
        } else if calendar.component(.year, from: date) < calendar.component(.year, from: currentDate) {
            return iMessageDateFormatter.string(from: date)
        } else {
            return currentYearDateFormatter.string(from: date)
        }
    }
}
