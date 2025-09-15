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

    /// Unique identifier for the message.
    public var id: String = UUID().uuidString

    /// The main content of the message.
    public var content: String

    /// A Boolean indicating whether the message was sent by the current user.
    public var isCurrentUser: Bool

    /// Optional reaction associated with the message (e.g., like, heart, etc).
    public var reaction: ReactionType?

    /// A copy of the message content, used for edit tracking or rollback.
    public var contentCopy: String = ""

    /// List of previous message versions, used to show edit history.
    public var editedMessages: [String] = []

    /// A Boolean indicating whether the edited version of the message should be shown.
    public var showEditedMessage: Bool = false

    /// The timestamp when the message was sent or received.
    public var timestamp: Date

    // MARK: - Initializer

    /// Initializes a new message model with the specified properties.
    ///
    /// - Parameters:
    ///   - id: Unique identifier for the message. Defaults to a new UUID.
    ///   - content: The message text.
    ///   - isCurrentUser: Whether the message was sent by the current user.
    ///   - reaction: Optional reaction associated with the message.
    ///   - contentCopy: A backup copy of the message content.
    ///   - editedMessages: An array of previous message versions.
    ///   - showEditedMessage: Whether to display the edited message.
    ///   - timestamp: The date and time the message was sent or received.
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
}
