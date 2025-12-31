//
//  MessageViewModel.swift
//  SSChatview
//
//  Created by Palak Doshi on 07/05/25.
//

import SwiftUI

// MARK: - MessageViewModel
/// ViewModel for managing scroll, unread count, and timestamp state in a message list.
final class MessageViewModel: ObservableObject {

    // MARK: - Variables
    @Published var showTimestamp: Bool = false
    @Published var scrollToBottom = false
    @Published var unreadMessageCount: Int = 0
    @Published var isAtBottom: Bool = true
    @Published var previousMessageCount: Int = 0
}

// MARK: - Methods
extension MessageViewModel {

    /// Handles updates to the message list and manages scroll state and unread count.
    func handleMessageListUpdate(currentMessages: [MessageResponseModel], editMessageID: String) {
        let isEditing = !editMessageID.isEmpty
        guard previousMessageCount <= currentMessages.count else {
            previousMessageCount = currentMessages.count
            return
        }

        let newMessages = currentMessages.suffix(from: previousMessageCount)
        let receivedMessages = newMessages.filter { !$0.isCurrentUser }
        let currentUserMessages = newMessages.filter { $0.isCurrentUser }

        if isEditing {
            scrollToBottom = false
            unreadMessageCount += receivedMessages.count
        } else if !currentUserMessages.isEmpty {
            scrollToBottom = true
            unreadMessageCount = 0
        } else if isAtBottom {
            scrollToBottom = true
            unreadMessageCount = 0
        } else {
            unreadMessageCount += receivedMessages.count
            scrollToBottom = false
        }

        previousMessageCount = currentMessages.count
    }

    /// Determines whether a date header should be shown before the message at the given index.
    func shouldShowDateHeader(messages: [MessageResponseModel], currentIndex: Int) -> Bool {
        let calendar = Calendar.current
        guard currentIndex > 0, currentIndex < messages.count else { return true }

        let currentDate = calendar.startOfDay(for: messages[currentIndex].timestamp)
        let previousDate = calendar.startOfDay(for: messages[currentIndex - 1].timestamp)

        return currentDate != previousDate
    }
}
