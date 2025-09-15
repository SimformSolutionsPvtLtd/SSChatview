//
//  UnreadMessageView.swift
//  SSChatview
//
//  Created by Palak Doshi on 04/05/25.
//

import SwiftUI

/// A badge view displaying the number of unread messages in the chat.
/// The badge is styled with a circular background and adjusts its size based on the count.
struct UnreadMessageView: View {

    // MARK: - Environment
    @Environment(\.ssChatConfig) private var config

    // MARK: - Variables
    private let size: CGFloat = 16
    var unreadMessageCount: Int

    // MARK: - Body
    var body: some View {
        Text("\(unreadMessageCount)")
            .lineLimit(1)
            .font(.footnote.bold())
            .frame(width: unreadMessageCount < 10 ? size : nil, height: size)
            .padding(.horizontal, unreadMessageCount < 10 ? 4 : 6)
            .padding(.vertical, 2)
            .background(Color.accentColor)
            .cornerRadius(9)
            .foregroundColor(.white)
            .offset(y: -size)
    }
}
