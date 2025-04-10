//
//  SSChatDelegate.swift
//  SSChatview
//
//  Created by Palak Doshi on 20/04/25.
//

import SwiftUI

// MARK: - SSChatDelegate

/// A protocol that defines delegate methods for handling key chat interactions.
///
/// Conform to `SSChatDelegate` to receive callbacks when the user sends, edits, deletes,
/// or reacts to messages within the chat interface. This allows your app to synchronize
/// these events with your backend or internal state.
///
/// All methods are required to be implemented.
///
/// Example usage:
/// ```swift
/// class MyChatHandler: SSChatDelegate {
///     func didSendMessage(_ message: MessageResponseModel) { ... }
///     func didEditMessage(messageID: String, editedMessage: String) { ... }
///     func didDeleteMessages(_ messageIDs: [String]) { ... }
///     func didReactToMessage(_ messageID: String, reaction: ReactionType) { ... }
/// }
/// ```
public protocol SSChatDelegate: AnyObject {

    /// Called when the user sends a new message.
    /// - Parameter message: The message model containing the content and metadata.
    func didSendMessage(_ message: MessageResponseModel)

    /// Called when the user finishes editing an existing message.
    /// - Parameters:
    ///   - messageID: The ID of the message being edited.
    ///   - editedMessage: The new content for the message.
    func didEditMessage(messageID: String, editedMessage: String)

    /// Called when the user deletes one or more messages.
    /// - Parameter messageIDs: An array of message identifiers that were deleted.
    func didDeleteMessages(_ messageIDs: [String])

    /// Called when the user reacts to a message.
    /// - Parameters:
    ///   - messageID: The identifier of the message that received a reaction.
    ///   - reaction: The type of reaction applied.
    func didReactToMessage(_ messageID: String, reaction: ReactionType)

    /// Called when the user performs an undo send action on a message.
    /// This removes the message from both the sender and the recipient's chat views.
    /// - Parameter messageID: The identifier of the message to be undone and deleted.
    func didUndoMessage(_ messageID: String)
}
