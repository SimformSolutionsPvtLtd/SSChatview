//
//  ChatScreenViewModel.swift
//  SSChatView
//
//  Created by Palak Doshi on 01/03/24.
//

import Foundation

class ChatScreenViewModel: ObservableObject {
    // MARK: - Variables
    // TODO: Will be removed on database integration
    @Published var messageArray: [MessageResponseModel] = [
        MessageResponseModel(content: MessageViewConstants.helloText, isCurrentUser: false),
        MessageResponseModel(content: MessageViewConstants.helloReplyText, isCurrentUser: true),
        MessageResponseModel(content: MessageViewConstants.helloText, isCurrentUser: false),
        MessageResponseModel(content: MessageViewConstants.helloReplyText, isCurrentUser: true),
        MessageResponseModel(content: MessageViewConstants.helloText, isCurrentUser: false),
        MessageResponseModel(content: MessageViewConstants.helloReplyText, isCurrentUser: true)
    ]

}

// MARK: - Add Message
extension ChatScreenViewModel {
    /// Adds a new message to the chat.
     /// - Parameter message: The message content to be added.
    func addMessage(message: String) {
        messageArray.append(MessageResponseModel(content: message, isCurrentUser: true))
        messageArray.append(MessageResponseModel(content: message, isCurrentUser: false))
    }
}
