//
//  MessageCell.swift
//  SSChatView
//
//  Created by Palak Doshi on 23/02/24.
//

import SwiftUI

/// SwiftUI View for displaying an individual message cell in the chat.
struct MessageCell: View {
    // MARK: - Variables
    var contentMessage: String
    var isCurrentUser: Bool
}

// MARK: - Body
extension MessageCell {
    var body: some View {
        Text(contentMessage)
            .padding(MessageViewConstants.textPadding)
            .foregroundColor(isCurrentUser ? Color.white : SystemColors.textColor)
            .background(isCurrentUser ? Color.blue : Color(UIColor.systemGray6))
            .cornerRadius(AppConstants.cornerRadius)
            .frame(width: UIScreen.main.bounds.width * 0.7, alignment: isCurrentUser ? .trailing : .leading)
    }
}
