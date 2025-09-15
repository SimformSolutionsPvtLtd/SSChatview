//
//  ChatScreenViewModel.swift
//  SSChatview
//
//  Created by Palak Doshi on 01/03/24.
//

import SwiftUI

/// ViewModel for the chat screen, responsible for managing chat messages.
public final class ChatScreenViewModel: ObservableObject {

    // MARK: - Variables
    weak var delegate: SSChatDelegate?
    var config: SSChatConfiguration

    @Published var selectedMessageIDs: Set<String> = []
    @Published var shouldShowSelectionView: Bool = false
    @Published var selectedMessage: MessageResponseModel?
    @Published var editMessageID: String = ""
    @Published var undoSentMessageID: String = ""

    // MARK: - Init

    /// Initializes the view model with optional delegate, configuration, and initial messages.
    ///
    /// - Parameters:
    ///   - delegate: An optional delegate to handle chat-related actions and events.
    ///   - config: A configuration object for customizing the chat UI and behavior. Defaults to `SSChatConfiguration()`.
    public init(
        delegate: SSChatDelegate? = nil,
        config: SSChatConfiguration = SSChatConfiguration()
    ) {
        self.delegate = delegate
        self.config = config
    }
}

// MARK: - Methods
extension ChatScreenViewModel {

    /// Sends a new message from the current user.
    ///
    /// Ignores the message if it only contains whitespace.
    /// - Parameter content: The message text to be sent.
    func sendMessage(_ content: String) {
        guard !content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        let message = MessageResponseModel(
            content: content,
            isCurrentUser: true,
            timestamp: Date()
        )
        delegate?.didSendMessage(message)
    }

    /// Deletes all currently selected messages.
    /// Clears selection state and informs the delegate.
    func deleteSelectedMessages() {
        let deletedIDs = Array(selectedMessageIDs)
        shouldShowSelectionView = false
        delegate?.didDeleteMessages(deletedIDs)
    }

    /// Undoes a sent message and removes it for both users.
    private func undoSentMessage() {
        delegate?.didUndoMessage(undoSentMessageID)
        undoSentMessageID = ""
    }

    /// Returns a label showing how many messages are selected for deletion.
    /// Example: "Delete 2 messages"
    func getDeleteMessageCount() -> String {
        let count = selectedMessageIDs.count
        let pluralSuffix = count > 1 ? "s" : ""
        return "\(config.strings.deleteText) \(count) \(config.strings.messageText)\(pluralSuffix)"
    }

    /// Updates the reaction for a given message and optionally resets selection.
    /// - Parameters:
    ///   - messageID: The ID of the message to react to.
    ///   - selectedReaction: The new reaction to apply.
    ///   - shouldResetSelection: Whether to clear the selected message after reacting.
    func updateReaction(
        messageID: String,
        selectedReaction: ReactionType,
        shouldResetSelection: Bool = true
    ) {
        delegate?.didReactToMessage(messageID, reaction: selectedReaction)

        if shouldResetSelection {
            selectedMessage = nil
        }
    }

    /// Sends an update for an edited message to the delegate.
    /// - Parameters:
    ///   - messageID: The ID of the message to update.
    ///   - editedMessage: The new content of the message.
    func updateEditedMessage(messageID: String, editedMessage: String) {
        delegate?.didEditMessage(messageID: messageID, editedMessage: editedMessage)
    }

    /// Handles context menu actions for a message (copy, multi-select, edit).
    /// - Parameters:
    ///   - messageID: The ID of the message to apply the action to.
    ///   - action: The selected menu action.
    func messageActionClick(messageID: String, action: CustomMenu) {
        switch action {
        case .copy:
            UIPasteboard.general.string = selectedMessage?.content
        case .more:
            shouldShowSelectionView = true
            onMessageSelection(messageID: messageID)
        case .edit:
            editMessageID = messageID
        case .undoSend:
             undoSentMessage()
        }

        selectedMessage = nil
    }

    /// Selects or deselects a message by toggling its selection state.
    /// - Parameter messageID: The message ID to toggle.
    private func onMessageSelection(messageID: String) {
        if selectedMessageIDs.contains(messageID) {
            selectedMessageIDs.remove(messageID)
        } else {
            selectedMessageIDs.insert(messageID)
        }
    }
}
