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
        NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillChangeFrameNotification)
            .compactMap { notification in
                guard
                    let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
                    let windowScene = UIApplication.shared.connectedScenes
                        .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
                    let window = windowScene.windows.first(where: \.isKeyWindow)
                else { return nil }

                let keyboardFrame = window.convert(frame, to: nil)

                return keyboardFrame.origin.y >= UIScreen.main.bounds.height ? 0 : keyboardFrame.height
            }
            .eraseToAnyPublisher()
    }
}
