//
//  ScrollViewOffsetPreferenceKey.swift
//  SSChatView
//
//  Created by Palak Doshi on 23/10/24.
//
import SwiftUI

// MARK: - ScrollViewOffsetPreferenceKey
/// A custom `PreferenceKey` used to track the offset of a `ScrollView`.
struct ScrollViewOffsetPreferenceKey: PreferenceKey {

    // MARK: - Variables
    /// Default value for the scroll offset, initialized as 0.
    static var defaultValue: CGFloat?

    // MARK: - Functions
    /// Merges the values passed down through the preference key hierarchy.
    /// - Parameters:
    ///   - value: The current scroll offset value.
    ///   - nextValue: The next scroll offset value to merge.
    static func reduce(value: inout CGFloat?, nextValue: () -> CGFloat?) {
        value = value ?? nextValue()
    }
}
