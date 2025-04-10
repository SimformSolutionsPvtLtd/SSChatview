//
//  ChatScreenViewModel.swift
//  SSChatview
//
//  Created by Palak Doshi on 01/03/24.
//

import SwiftUI

/// ViewModel for the chat screen, responsible for managing chat messages.
public class ChatScreenViewModel: ObservableObject {

    // MARK: - Variables
    @Published var selectedMessageIDs: Set<String> = []
    @Published var shouldShowSelectionView: Bool = false
    @Published var selectedMessage: MessageResponseModel?
    @Published var editMessageID: String = ""
    // TODO: This will be replaced by a database integration in the future.
    /// Array of messages in the chat.
    @Published var messageArray: [MessageResponseModel] = []

    // MARK: - Init

    /// Initializes the view model with an optional set of initial messages.
    ///
    /// - Parameter initialMessages: The initial list of messages to display.
    public init(initialMessages: [MessageResponseModel] = []) {
        self.messageArray = initialMessages
    }

    // MARK: - Environment
    @Environment(\.ssChatConfig) private var config
}

// MARK: - Methods
extension ChatScreenViewModel {
    /// Adds a new message to the chat.
    /// - Parameter message: The message content to be added.
    func addMessage(_ message: String) {
        // TODO: isCurrentUser will always be true, remove second entry with isCurrentUser false
        let newMessages = [
            MessageResponseModel(content: message, isCurrentUser: true, timestamp: Date()),
            MessageResponseModel(content: message, isCurrentUser: false, timestamp: Date())
        ]
        messageArray.append(contentsOf: newMessages)
    }

    func deleteSelectedMessages() {
        messageArray.removeAll { selectedMessageIDs.contains($0.id) }
        selectedMessageIDs.removeAll()
        shouldShowSelectionView = false
    }

    func getDeleteMessageCount() -> String {
        let deleteText = config.strings.deleteText
        let messageCount = selectedMessageIDs.count
        let messageText = config.strings.messageText + (selectedMessageIDs.count > 1 ? "s" : "")

        return "\(deleteText) \(messageCount) \(messageText)"
    }

    func updateReaction(messageID: String, selectedReaction: ReactionType) {
        if let index = messageArray.firstIndex(where: { $0.id == messageID }) {
            guard selectedReaction != .none else { return }
            messageArray[index].reaction = selectedReaction
        }
        selectedMessage = nil
    }

    func messageActionClick(messageID: String, action: CustomMenu) {
        switch action {
        case .copy:
            UIPasteboard.general.string = selectedMessage?.content
        case .delete:
            shouldShowSelectionView = true
            onMessageSelection(messageID: messageID)
        case .edit:
            editMessageID = messageID
        default:
            return
        }
        selectedMessage = nil
    }

    private func onMessageSelection(messageID: String) {
        if selectedMessageIDs.contains(messageID) {
            selectedMessageIDs.remove(messageID)
        } else {
            selectedMessageIDs.insert(messageID)
        }
    }
}
