//
//  KeyboardReadable.swift
//  SSChatview
//
//  Created by Palak Doshi on 20/09/24.
//

import Combine
import SwiftUI

// MARK: - KeyboardReadable Protocol
/// A protocol that provides publishers to observe keyboard visibility changes.
protocol KeyboardReadable {
    /// A publisher that emits `true` when the keyboard is about to show and `false` when it's about to hide.
    var keyboardWillChangePublisher: AnyPublisher<Bool, Never> { get }

    /// A publisher that emits `true` when the keyboard has been shown and `false` when it's been hidden.
    var keyboardDidChangePublisher: AnyPublisher<Bool, Never> { get }

    /// A publisher that emits the keyboard height when it shows and `0` when it hides.
    var keyboardHeightPublisher: AnyPublisher<CGFloat, Never> { get }
}

// MARK: - KeyboardReadable
extension KeyboardReadable {

    // MARK: - Keyboard Will Change Publisher
    /// A publisher for detecting when the keyboard will show or hide.
    /// Emits `true` when the keyboard is about to appear and `false` when it's about to disappear.
    public var keyboardWillChangePublisher: AnyPublisher<Bool, Never> {
        Publishers.Merge(
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillShowNotification)
                .map { _ in true },
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillHideNotification)
                .map { _ in false }
        )
        .eraseToAnyPublisher()
    }

    // MARK: - Keyboard Did Change Publisher
    /// A publisher for detecting when the keyboard has shown or hidden.
    /// Emits `true` when the keyboard has appeared and `false` when it has disappeared.
    public var keyboardDidChangePublisher: AnyPublisher<Bool, Never> {
        Publishers.Merge(
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardDidShowNotification)
                .map { _ in true },
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardDidHideNotification)
                .map { _ in false }
        )
        .eraseToAnyPublisher()
    }

    // MARK: - Keyboard Height Publisher
    /// A publisher for detecting the keyboard height when it appears or disappears.
    public var keyboardHeightPublisher: AnyPublisher<CGFloat, Never> {
        let willShowPublisher = NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillShowNotification)
            .map { notification -> CGFloat in
                if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                    return keyboardFrame.height
                }
                return 0
            }

        let willHidePublisher = NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }

        return Publishers.Merge(willShowPublisher, willHidePublisher)
            .eraseToAnyPublisher()
    }
}
