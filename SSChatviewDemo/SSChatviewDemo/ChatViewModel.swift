//
//  ChatViewModel.swift
//  SSChatviewDemo
//
//  Created by Palak Doshi on 20/04/25.
//

import SwiftUI
import SSChatview

// MARK: - ChatViewModel
/// Generates and manages simulated chat events such as incoming messages, reactions, edits, and deletions at regular intervals.
class ChatViewModel: ObservableObject {

    // MARK: - Variables
    private var counter: Int = 1
    @Published var messageArray: [MessageResponseModel] = ChatMessagesData.initialMessages
}

// MARK: - Helper Methods
/// Handles all direct message updates including add, delete, react, and edit operations.
extension ChatViewModel {

    /// Appends a new message to the chat message array.
    /// - Parameter newMessage: The `MessageResponseModel` to be added.
    private func addMessage(newMessage: MessageResponseModel) {
        self.messageArray.append(newMessage)
    }

    /// Deletes messages from the chat based on their IDs.
    /// - Parameter messagesToDelete: An array of message IDs to be removed.
    private func deleteMessage(messagesToDelete: [String]) {
        self.messageArray.removeAll { messagesToDelete.contains($0.id) }
    }

    /// Adds or updates a reaction for a specific message.
    /// - Parameters:
    ///   - messageID: The ID of the message to react to.
    ///   - reaction: The `ReactionType` to apply.
    private func reactMessage(_ messageID: String, reaction: ReactionType) {
        guard let index = self.messageArray.firstIndex(where: { $0.id == messageID }) else {
            print("Error: Message with ID \(messageID) not found.")
            return
        }
        self.messageArray[index].reaction = reaction
    }

    /// Updates the content of a message and stores its previous version in `editedMessages`.
    /// - Parameters:
    ///   - id: The ID of the message to edit.
    ///   - editedMessage: The new content for the message.
    private func editMessage(id: String, editedMessage: String) {
        if let index = self.messageArray.firstIndex(where: { $0.id == id }) {
            let currentContent = self.messageArray[index].content
            self.messageArray[index].editedMessages.append(currentContent)
            self.messageArray[index].content = editedMessage
        } else {
            print("Message with ID \(id) not found for editing.")
        }
    }

    /// Undoes a sent message by removing it from the message array.
    /// Typically used for "Undo Send" functionality.
    ///
    /// - Parameter id: The ID of the message to be removed.
    private func undoMessage(id: String) {
        if let index = messageArray.firstIndex(where: { $0.id == id }) {
            self.messageArray.remove(at: index)
        }
    }
}

// MARK: - HandleEvent Method
/// Handles the execution of a specific chat event.
extension ChatViewModel {
    func handleEvent(_ eventType: ChatEventType) {
        switch eventType {
        case .add:
            // Add a new incoming message
            let newMessage = MessageResponseModel(
                content: "📩 Incoming message \(counter)",
                isCurrentUser: false,
                reaction: nil,
                timestamp: Date()
            )
            addMessage(newMessage: newMessage)
            counter += 1

        case .delete:
            // Randomly select and delete two non-current-user messages
            let toDelete = messageArray
                .filter { !$0.isCurrentUser }
                .shuffled()
                .prefix(2)
                .map { $0.id }

            deleteMessage(messagesToDelete: toDelete)

        case .react:
            // Randomly react to any message
            guard let message = messageArray.randomElement() else { return }

            let reaction = ReactionType.allCases
                .filter { $0 != .none }
                .randomElement() ?? .like

            reactMessage(message.id, reaction: reaction)

        case .edit:
            // Randomly edit a non-current-user message
            if let message = messageArray.filter({ !$0.isCurrentUser }).randomElement() {
                let edited = "✏️ Edited message \(counter)"
                editMessage(id: message.id, editedMessage: edited)
                counter += 1
            }
        }
    }
}

// MARK: - SSChatDelegate Conformance
/// Handles message interactions triggered from the SSChat view, such as sending, editing,
/// deleting, and reacting to messages.
extension ChatViewModel: SSChatDelegate {

    /// Called when a new message is sent by the user.
    /// - Parameter message: A `MessageResponseModel` representing the sent message.
    func didSendMessage(_ message: MessageResponseModel) {
        print("📤 Sent message: \"\(message.content)\"")
        addMessage(newMessage: message)
    }

    /// Called when a message is edited by the user.
    /// - Parameters:
    ///   - messageID: The ID of the message that was edited.
    ///   - editedMessage: The new content to update the message with.
    func didEditMessage(messageID: String, editedMessage: String) {
        print("✏️ Edited message ID [\(messageID)] with new content: \"\(editedMessage)\"")
        editMessage(id: messageID, editedMessage: editedMessage)
    }

    /// Called when one or more messages are deleted by the user.
    /// - Parameter messageIDs: An array of IDs for the messages to be deleted.
    func didDeleteMessages(_ messageIDs: [String]) {
        print("🗑️ Deleted messages with IDs: \(messageIDs)")
        deleteMessage(messagesToDelete: messageIDs)
    }

    /// Called when the user reacts to a message.
    /// - Parameters:
    ///   - messageID: The ID of the message receiving a reaction.
    ///   - reaction: The selected `ReactionType`.
    func didReactToMessage(_ messageID: String, reaction: ReactionType) {
        print("❤️‍🔥 Reacted to message ID [\(messageID)] with: \(reaction.rawValue)")
        reactMessage(messageID, reaction: reaction)
    }

    /// Called when the user undoes a sent message.
    /// This removes the message for both sender and receiver.
    /// - Parameter messageID: The ID of the message to be undone.
    func didUndoMessage(_ messageID: String) {
        print("↩️ Undo message ID [\(messageID)]")
        undoMessage(id: messageID)
    }

}
