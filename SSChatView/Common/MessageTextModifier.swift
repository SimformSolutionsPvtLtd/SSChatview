//
//  MessageTextModifier.swift
//  SSChatView
//
//  Created by Palak Doshi on 26/09/24.
//

import SwiftUI

// MARK: - MessageText Modifier
struct MessageTextModifier: ViewModifier {
    // MARK: - Variables
    var isCurrentUser: Bool

    // MARK: - Body
    func body(content: Content) -> some View {
        content
            .padding()
            .foregroundColor(isCurrentUser ? Color.white : SystemColors.textColor)
            .background(isCurrentUser ? Color.blue : Color(UIColor.systemGray6))
            .clipShape(MessageBubble(myMessage: isCurrentUser))
            .contentShape(.contextMenuPreview, MessageBubble(myMessage: isCurrentUser))
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
