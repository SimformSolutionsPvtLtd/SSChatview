//
//  ChatScreenViewModel.swift
//  SSChatView
//
//  Created by Palak Doshi on 01/03/24.
//

import UIKit

/// ViewModel for the chat screen, responsible for managing chat messages.
class ChatScreenViewModel: ObservableObject {

    // MARK: - Variables
    @Published var selectedMessageIDs: Set<String> = []
    @Published var shouldShowSelectionView: Bool = false
    @Published var selectedMessage: MessageResponseModel?

    // TODO: This will be replaced by a database integration in the future.
    /// Array of messages in the chat.
    @Published var messageArray: [MessageResponseModel] = [
        MessageResponseModel(
            content: appString.helloText(),
            isCurrentUser: false,
            reaction: nil
        ),
        MessageResponseModel(
            content: appString.helloReplyText(),
            isCurrentUser: true,
            reaction: .love
        ),
        MessageResponseModel(
            content: appString.helloText(),
            isCurrentUser: false,
            reaction: .like
        ),
        MessageResponseModel(
            content: appString.helloText(),
            isCurrentUser: false,
            reaction: nil
        ),
        MessageResponseModel(
            content: appString.helloReplyText(),
            isCurrentUser: true,
            reaction: .love
        ),
        MessageResponseModel(
            content: appString.helloText(),
            isCurrentUser: false,
            reaction: .like
        ),
        MessageResponseModel(
            content: appString.longLoremText1(),
            isCurrentUser: false,
            reaction: .like
        ),
        MessageResponseModel(
            content: appString.longLoremText1(),
            isCurrentUser: true,
            reaction: .like
        ),
        MessageResponseModel(
            content: appString.singleNumberText2(),
            isCurrentUser: false,
            reaction: nil
        ),
        MessageResponseModel(
            content: appString.singleNumberText3(),
            isCurrentUser: true,
            reaction: .love
        ),
        MessageResponseModel(
            content: appString.shortLoremText1(),
            isCurrentUser: false,
            reaction: .like
        ),
        MessageResponseModel(
            content: appString.shortLoremText2(),
            isCurrentUser: false,
            reaction: .like
        ),
        MessageResponseModel(
            content: appString.mediumLoremText(),
            isCurrentUser: false,
            reaction: nil
        ),
        MessageResponseModel(
            content: appString.mediumLoremText(),
            isCurrentUser: true,
            reaction: nil
        ),
        MessageResponseModel(
            content: appString.extendedLoremText(),
            isCurrentUser: true,
            reaction: .love
        ),
        MessageResponseModel(
            content: appString.extendedLoremText(),
            isCurrentUser: false,
            reaction: .love
        ),
        MessageResponseModel(
            content: appString.briefLoremText(),
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

    func deleteSelectedMessages() {
        messageArray.removeAll { selectedMessageIDs.contains($0.id) }
        selectedMessageIDs.removeAll()
        shouldShowSelectionView = false
    }

    func getDeleteMessageCount() -> String {
        let deleteText = appString.deleteText()
        let messageCount = selectedMessageIDs.count
        let messageText = appString.messageText() + (selectedMessageIDs.count > 1 ? "s" : "")

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
