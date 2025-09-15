//
//  ScrollToBottomView.swift
//  SSChatview
//
//  Created by Palak Doshi on 04/05/25.
//

import SwiftUI

/// A floating button view that appears in a chat UI when there are unread messages.
/// Tapping the button scrolls the chat to the latest message.
/// It also displays a badge with the unread message count if available.
public struct ScrollToBottomView: View {

    // MARK: - Environment
    @Environment(\.ssChatConfig) private var config

    // MARK: - Variables
    private let buttonSize: CGFloat = 40
    var unreadMessageCount: Int
    var onScrollToBottomTap: () -> Void

    // MARK: - Body
    public var body: some View {
        HStack {
            Spacer()
            Button(action: onScrollToBottomTap) {
                Image.ssImage(config.images.scrollDownArrow)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: buttonSize, height: buttonSize)
                    .chatShadowStyle(style: ShadowStyle(cornerRadius: buttonSize / 2))
            }
            .padding()
            .overlay(
                unreadMessageCount > 0 ?
                UnreadMessageView(unreadMessageCount: unreadMessageCount) : nil
            )
        }
    }
}
