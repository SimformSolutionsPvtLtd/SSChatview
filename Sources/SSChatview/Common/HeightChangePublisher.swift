//
//  HeightChangePublisher.swift
//  SSChatview
//
//  Created by Palak Doshi on 15/11/24.
//

import SwiftUI
import Combine

// MARK: - HeightChangeReadable Protocol
/// A protocol that provides a publisher for observing height changes.
protocol HeightChangeReadable {
    static var heightChangePublisher: AnyPublisher<CGFloat, Never> { get }
}

// MARK: - HeightChangePublisher
class HeightChangePublisher: HeightChangeReadable {

    // MARK: - Singleton Instance
    /// Shared instance of `HeightChangePublisher`, used globally to access the publisher.
    static let shared = HeightChangePublisher()

    // MARK: - Private Properties
    /// The subject used to send height updates.
    /// `PassthroughSubject` is a Combine publisher that allows multiple subscribers to receive updates.
    private let subject = PassthroughSubject<CGFloat, Never>()

    // MARK: - init
    private init() {}

    // MARK: - Conforming to HeightChangeReadable
    /// The static publisher conforming to the `HeightChangeReadable` protocol.
    /// Returns the `subject` as a `AnyPublisher`, making it type-safe and encapsulating the internal details.
    static var heightChangePublisher: AnyPublisher<CGFloat, Never> {
        shared.subject.eraseToAnyPublisher()
    }

    // MARK: - UpdateHeight Method
    /// Updates the height value and sends it to all subscribers.
    ///
    /// - Parameter height: The new height value to be broadcasted to subscribers.
    func updateHeight(_ height: CGFloat) {
        subject.send(height)
    }
}
