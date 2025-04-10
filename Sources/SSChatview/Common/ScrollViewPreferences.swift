//
//  ScrollViewPreferences.swift
//  SSChatview
//
//  Created by Palak Doshi on 23/10/24.
//

import SwiftUI

// MARK: - ScrollView Offset & Height Preference Keys
/// A preference key to track the vertical offset of a ScrollView.
struct ScrollViewOffsetPreferenceKey: PreferenceKey {

    /// Default scroll offset value (nil by default).
    static var defaultValue: CGFloat?

    /// Combines values from child views using the first non-nil value.
    static func reduce(value: inout CGFloat?, nextValue: () -> CGFloat?) {
        value = value ?? nextValue()
    }
}

/// A preference key to track the total content height of a ScrollView.
struct ScrollViewContentHeightPreferenceKey: PreferenceKey {

    /// Default content height value (nil by default).
    static var defaultValue: CGFloat?

    /// Combines values from child views using the most recent non-nil value.
    static func reduce(value: inout CGFloat?, nextValue: () -> CGFloat?) {
        value = nextValue() ?? value
    }
}
