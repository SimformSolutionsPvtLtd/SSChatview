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
                Spacer()
            }
            MessageCell(contentMessage: currentMessage.content,
                        isCurrentUser: currentMessage.isCurrentUser)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}
