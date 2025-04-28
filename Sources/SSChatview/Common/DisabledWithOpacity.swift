//
//  DisabledWithOpacity.swift
//  SSChatview
//
//  Created by Palak Doshi on 05/09/24.
//

import SwiftUI

// MARK: - DisabledWithOpacity Modifier
/// A view modifier that disables a view and adjusts its opacity when disabled.
struct DisabledWithOpacity: ViewModifier {

    // MARK: - Variables
    var isDisable: Bool
    var opacity: Double

    // MARK: - Body
    /// Applies the disabled state and sets the opacity.
    /// - Parameter content: The view to modify.
    /// - Returns: The modified view with applied disabled state and opacity.
    public func body(content: Content) -> some View {
        content
            .disabled(isDisable)
            .opacity(isDisable ? opacity : 1)
    }
}

// MARK: - DisabledWithOpacity
extension View {
    /// Applies the `DisabledWithOpacity` modifier.
    /// - Parameters:
    ///   - isDisable: Whether the view should be disabled.
    ///   - opacity: The opacity to apply when the view is disabled (defaults to 0.6).
    /// - Returns: The view with the modifier applied.
    public func disabledWithOpacity(_ isDisable: Bool, opacity: Double = 0.6) -> some View {
        self.modifier(DisabledWithOpacity(isDisable: isDisable, opacity: opacity))
    }
}
