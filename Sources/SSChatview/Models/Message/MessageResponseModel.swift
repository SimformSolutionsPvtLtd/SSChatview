//
//  MessageResponseModel.swift
//  SSChatview
//
//  Created by Palak Doshi on 23/02/24.
//

import SwiftUI

/// Model representing a message in the chat.
public struct MessageResponseModel: Identifiable, Equatable {

    // MARK: - Variables
    public var id: String = UUID().uuidString
    public var content: String
    public var isCurrentUser: Bool
    public var reaction: ReactionType?
    public var contentCopy: String = ""
    public var editedMessages: [String] = []
    public var showEditedMessage: Bool = false
    public var timestamp: Date

    public init(
        id: String = UUID().uuidString,
        content: String,
        isCurrentUser: Bool,
        reaction: ReactionType? = nil,
        contentCopy: String = "",
        editedMessages: [String] = [],
        showEditedMessage: Bool = false,
        timestamp: Date
    ) {
        self.id = id
        self.content = content
        self.isCurrentUser = isCurrentUser
        self.reaction = reaction
        self.contentCopy = contentCopy
        self.editedMessages = editedMessages
        self.showEditedMessage = showEditedMessage
        self.timestamp = timestamp
    }

    public mutating func updateEditedMessages(newMessage: String) {
        editedMessages.append(content)
        content = newMessage
    }
}
