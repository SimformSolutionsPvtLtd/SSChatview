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
    @Published var editMessageID: String = ""

    // TODO: This will be replaced by a database integration in the future.
    /// Array of messages in the chat.
    @Published var messageArray: [MessageResponseModel] = [
        // 28 Aug 2023 at 11:21 AM
        MessageResponseModel(
            content: appString.helloText(),
            isCurrentUser: false,
            reaction: nil,
            timestamp: Date(timeIntervalSince1970: 1693201872)
        ),
        // 1 Sep 2023 at 11:44 AM
        MessageResponseModel(
            content: appString.helloReplyText(),
            isCurrentUser: true,
            reaction: .love,
            timestamp: Date(timeIntervalSince1970: 1693548852)
        ),
        // 1 Sep 2023 at 3:37 PM
        MessageResponseModel(
            content: appString.helloText(),
            isCurrentUser: false,
            reaction: .like,
            timestamp: Date(timeIntervalSince1970: 1693562832)
        ),
        // Sun, 29 Sep at 12:52 PM
        MessageResponseModel(
            content: appString.helloText(),
            isCurrentUser: false,
            reaction: nil,
            timestamp: Date(timeIntervalSince1970: 1727594532)
        ),
        // Tue, 15 Oct at 6:31 PM
        MessageResponseModel(
            content: appString.helloText(),
            isCurrentUser: true,
            reaction: nil,
            timestamp: Date(timeIntervalSince1970: 1728997261)
        ),
        // Tue, 15 Oct at 7:15 PM
        MessageResponseModel(
            content: appString.helloText(),
            isCurrentUser: false,
            reaction: .like,
            timestamp: Date(timeIntervalSince1970: 1728999901)
        ),
        // Tue, 15 Oct at 8:26 PM
        MessageResponseModel(
            content: appString.helloText(),
            isCurrentUser: true,
            reaction: nil,
            timestamp: Date(timeIntervalSince1970: 1729004161)
        ),
        // Tue, 15 Oct at 11:59 PM
        MessageResponseModel(
            content: appString.helloText(),
            isCurrentUser: false,
            reaction: nil,
            timestamp: Date(timeIntervalSince1970: 1729016941)
        ),
        // Sun, 3 Nov at 12:00 AM
        MessageResponseModel(
            content: appString.helloReplyText(),
            isCurrentUser: true,
            reaction: .love,
            timestamp: Date(timeIntervalSince1970: 1730572200)
        ),
        // Sun, 3 Nov at 12:16 AM
        MessageResponseModel(
            content: appString.helloText(),
            isCurrentUser: false,
            reaction: .like,
            timestamp: Date(timeIntervalSince1970: 1730573160)
        ),
        // Sun, 3 Nov at 12:47 AM
        MessageResponseModel(
            content: appString.longLoremText1(),
            isCurrentUser: false,
            reaction: .like,
            timestamp: Date(timeIntervalSince1970: 1730575020)
        ),
        // Sun, 3 Nov at 1:26 AM
        MessageResponseModel(
            content: appString.longLoremText1(),
            isCurrentUser: true,
            reaction: .like,
            timestamp: Date(timeIntervalSince1970: 1730577360)
        ),
        // Sun, 3 Nov at 2:05 AM
        MessageResponseModel(
            content: appString.singleNumberText2(),
            isCurrentUser: false,
            reaction: nil,
            editedMessages: [
                appString.editedNumberText2_1(),
                appString.editedNumberText2_2()
            ],
            timestamp: Date(timeIntervalSince1970: 1730579700)
        ),
        // Monday, 9:27 AM
        MessageResponseModel(
            content: appString.shortLoremText1(),
            isCurrentUser: false,
            reaction: .like,
            timestamp: Date(timeIntervalSince1970: 1731902249)
        ),
        // Monday, 4:35 PM
        MessageResponseModel(
            content: appString.singleNumberText3(),
            isCurrentUser: false,
            reaction: .like,
            editedMessages: [
                appString.editedNumberText3_1(),
                appString.editedNumberText3_2(),
                appString.editedNumberText3_3()
            ],
            timestamp: Date(timeIntervalSince1970: 1731927929)
        ),
        // Today, 7:16 AM
        MessageResponseModel(
            content: appString.shortLoremText2(),
            isCurrentUser: true,
            reaction: .like,
            timestamp: Date(timeIntervalSince1970: 1731980789)
        ),
        // Today, 9:27 PM
        MessageResponseModel(
            content: appString.mediumLoremText(),
            isCurrentUser: false,
            reaction: .like,
            timestamp: Date(timeIntervalSince1970: 1731988649)
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
