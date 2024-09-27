//
//  KeyboardReadable.swift
//  SSChatView
//
//  Created by Palak Doshi on 20/09/24.
//

import Combine
import SwiftUI

// MARK: - KeyboardReadable Protocol
/// Protocol to provide a publisher for keyboard visibility changes.
protocol KeyboardReadable {
    /// A publisher that emits a Boolean value when the keyboard shows or hides.
    var keyboardPublisher: AnyPublisher<Bool, Never> { get }
}

// MARK: - KeyboardReadable
extension KeyboardReadable {
    /// Default implementation of `keyboardPublisher` using NotificationCenter.
    /// - Emits `true` when the keyboard will show.
    /// - Emits `false` when the keyboard will hide.
    var keyboardPublisher: AnyPublisher<Bool, Never> {
        // Merge the keyboard show and hide notifications into a single publisher.
        Publishers.Merge(
            // Publisher that emits `true` when the keyboard will show.
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillShowNotification)
                .map { _ in true },

            // Publisher that emits `false` when the keyboard will hide.
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillHideNotification)
                .map { _ in false }
        )
        .eraseToAnyPublisher()
    }
}
