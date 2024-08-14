//
//  ChatScreenViewModel.swift
//  SSChatView
//
//  Created by Palak Doshi on 01/03/24.
//

import Foundation

/// ViewModel for the chat screen, responsible for managing chat messages.
class ChatScreenViewModel: ObservableObject {

    // MARK: - Variables
    // TODO: This will be replaced by a database integration in the future.
    /// Array of messages in the chat.
    @Published var messageArray: [MessageResponseModel] = [
        MessageResponseModel(
            content: MessageViewConstants.helloText,
            isCurrentUser: false,
            reaction: nil
        ),
        MessageResponseModel(
            content: MessageViewConstants.helloReplyText,
            isCurrentUser: true,
            reaction: .love
        ),
        MessageResponseModel(
            content: MessageViewConstants.helloText,
            isCurrentUser: false,
            reaction: .like
        )
    ]
}

// MARK: - Methods
extension ChatScreenViewModel {
    /// Adds a new message to the chat.
    /// - Parameter message: The message content to be added.
    func addMessage(_ message: String) {
        // TODO: isCurrentUser will always be true, remove second entry with isCurrentUser false
        let newMessages = [
            MessageResponseModel(content: message, isCurrentUser: true),
            MessageResponseModel(content: message, isCurrentUser: false)
        ]
        messageArray.append(contentsOf: newMessages)
    }
}
