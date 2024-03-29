//
//  MessageUI.swift
//  SSChatView
//
//  Created by Palak Doshi on 26/02/24.
//

import SwiftUI

/// SwiftUI View for displaying a message in the chat.
struct MessageUI: View {
    // MARK: - Variables
    var currentMessage: MessageResponseModel
}

// MARK: - Body
extension MessageUI {
    
    var body: some View {
        HStack(alignment: .bottom, spacing: MessageViewConstants.spacing) {
            if currentMessage.isCurrentUser {
                Spacer() // Add a spacer to right-align the current user's message
            }

            /// Display the MessageCell with the content and sender information
            MessageCell(contentMessage: currentMessage.content,
                        isCurrentUser: currentMessage.isCurrentUser)
        }
        .frame(maxWidth: .infinity, alignment: .leading) // Ensure the HStack fills the available width
        .padding() // Apply padding around the HStack
    }
}

