//
//  DisabledWithOpacity.swift
//  SSChatView
//
//  Created by Palak Doshi on 05/09/24.
//

import SwiftUI

// MARK: - DisabledWithOpacity
struct DisabledWithOpacity: ViewModifier {

    // MARK: - Variables
    var isDisable: Bool

    // MARK: - Body
    public func body(content: Content) -> some View {
        content
            .disabled(isDisable)
            .opacity(isDisable ? 0.6 : 1)
    }
}

// MARK: - DisabledWithOpacity
extension View {
    public func disabledWithOpacity(_ isDisable: Bool) -> some View {
        return self.modifier(DisabledWithOpacity(isDisable: isDisable))
    }
}
