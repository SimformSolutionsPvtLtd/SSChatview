//
//  MessageTextModifier.swift
//  SSChatview
//
//  Created by Palak Doshi on 26/09/24.
//

import SwiftUI

// MARK: - MessageText Modifier
struct MessageTextModifier: ViewModifier {
    // MARK: - Variables
    var isCurrentUser: Bool

    // MARK: - Environment
    @Environment(\.ssChatConfig) private var config

    // MARK: - Body
    func body(content: Content) -> some View {
        content
            .padding(14)
            .foregroundColor(isCurrentUser ? config.colors.currentUserMessageTextColor : config.colors.nonCurrentUserMessageTextColor)
            .background(isCurrentUser ? config.colors.currentUserMessageBackgroundColor : config.colors.nonCurrentUserMessageBackgroundColor)
            .clipShape(ChatShapePathManager(isFromCurrentUser: isCurrentUser))
            .fixedSize(horizontal: false, vertical: true)
    }
}

// MARK: - View Extension
extension View {
    /// A modifier to move content above the keyboard when it appears.
    func messageTextModifier(isCurrentUser: Bool) -> some View {
        self.modifier(MessageTextModifier(isCurrentUser: isCurrentUser))
    }
}
