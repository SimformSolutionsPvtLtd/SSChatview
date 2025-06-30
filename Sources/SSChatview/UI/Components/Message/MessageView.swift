//
//  MessageView.swift
//  SSChatview
//
//  Created by Palak Doshi on 23/02/24.
//

import SwiftUI

// MARK: - MessageView
/// SwiftUI View for displaying messages in the chat.
struct MessageView: View {

    // MARK: - Variables
    @Binding var messages: [MessageResponseModel]
    @Binding var isBlurred: Bool
    @Binding var shouldShowSelectionView: Bool
    @Binding var selectedMessageIDs: Set<String>
    @Binding var editMessageID: String

    @State private var showTimestamp: Bool = false
    @State private var scrollToBottom = false
    @State private var previousMessageCount = 0

    var onLongPress: (CGPoint, MessageResponseModel) -> Void
    var onMessageEdit: (String, String) -> Void

    // MARK: - Environment
    @Environment(\.ssChatConfig) private var config
}

// MARK: - Body
extension MessageView {
    var body: some View {
        CustomScrollView(
            scrollToBottom: $scrollToBottom,
            isScrollDisabled: $isBlurred,
            scrollID: $editMessageID
        ) {
            if messages.isEmpty {
                VStack {
                    Spacer(minLength: AppConstants.screenHeight / 4)
                    NoMessageView()
                }
                .frame(maxWidth: .infinity)
            } else {
                messageList
            }
        }
        .gesture(
            DragGesture()
                .onChanged { value in
                    if value.translation.width < -50 {
                        // Show timestamp while dragging to the left
                        withAnimation {
                            showTimestamp = true
                        }
                    }
                }
                .onEnded { _ in
                    // Hide timestamp when dragging ends
                    withAnimation {
                        showTimestamp = false
                    }
                }
        )
    }
}

// MARK: - Message List
extension MessageView {
    private var messageList: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(Array(messages.enumerated()), id: \.element.id) { index, message in

                if shouldShowDateHeader(for: message, at: index) {
                    DateHeaderView(date: message.timestamp)
                        .frame(maxWidth: .infinity, alignment: .center)
                }

                MessageCell(
                    currentMessage: Binding(
                        get: { message },
                        set: { newMessage in
                            if let index = messages.firstIndex(where: { $0.id == newMessage.id }) {
                                messages[index] = newMessage
                            }
                        }
                    ),
                    isBlurred: $isBlurred,
                    shouldShowSelectionView: $shouldShowSelectionView,
                    editMessageID: $editMessageID,
                    showTimestamp: $showTimestamp,
                    isSelected: selectedMessageIDs.contains(message.id),
                    onMessageSelection: { messageId in
                        selectDeleteMessage(id: messageId)
                    },
                    onLongPress: { position in
                        self.onLongPress(position, message)
                    },
                    onMessageEdit: { messageID, editedMessage in
                        self.onMessageEdit(messageID, editedMessage)
                    }
                )
                .id("\(message.id) \(selectedMessageIDs.contains(message.id)) \(shouldShowSelectionView)")
            }
            .onChange(of: messages.count) {
                withAnimation {
                    scrollToBottom = messages.count > previousMessageCount
                }
                previousMessageCount = messages.count
            }
            .onChange(of: shouldShowSelectionView) { _, newValue in
                if !newValue {
                    selectedMessageIDs.removeAll()
                }
            }
            .onAppear {
                previousMessageCount = messages.count
                withAnimation {
                    scrollToBottom = true
                }
            }
        }
        .id(ScrollID.bottomID.rawValue)
    }
}

// MARK: - Delete Message Handling
extension MessageView {
    private func selectDeleteMessage(id: String) {
        if selectedMessageIDs.contains(id) {
            selectedMessageIDs.remove(id)
        } else {
            selectedMessageIDs.insert(id)
        }
    }

    /// Helper method to determine if a `DateHeaderView` should be shown for the message
    private func shouldShowDateHeader(for message: MessageResponseModel, at index: Int) -> Bool {
        let calendar = Calendar.current

        // Always show the date for the first message
        if index == 0 {
            return true
        }

        // Ensure the index is valid and compare the current message's day with the previous message's day
        guard index > 0, index < messages.count else {
            return true // If the index is invalid, assume a new date header
        }

        let previousMessage = messages[index - 1]

        // Compare the current message's day with the previous message's day
        let currentMessageDate = calendar.startOfDay(for: message.timestamp)
        let previousMessageDate = calendar.startOfDay(for: previousMessage.timestamp)
        return currentMessageDate != previousMessageDate
    }
}
