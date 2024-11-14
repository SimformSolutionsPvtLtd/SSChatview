//
//  MessageView.swift
//  SSChatView
//
//  Created by Palak Doshi on 23/02/24.
//

import SwiftUI

/// SwiftUI View for displaying messages in the chat.
struct MessageView: View {

    // MARK: - Variables
    @Binding var messages: [MessageResponseModel]
    @Binding var isBlurred: Bool
    @Binding var shouldShowSelectionView: Bool
    @Binding var selectedMessageIDs: Set<String>
    @Binding var editMessageID: String

    @State private var scrollToBottom = false
    @State private var previousMessageCount = 0

    var onLongPress: (CGPoint, MessageResponseModel) -> Void
}

// MARK: - Body
extension MessageView {
    var body: some View {
        CustomScrollView(scrollToBottom: $scrollToBottom,
                         isScrollDisabled: $isBlurred,
                         scrollID: $editMessageID) {
            if messages.isEmpty {
                Spacer()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                messageList
            }
        }
    }
}

// MARK: - Message List
extension MessageView {
    private var messageList: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(messages) { message in
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
                    isSelected: selectedMessageIDs.contains(message.id),
                    onMessageSelection: { messageId in
                        selectDeleteMessage(id: messageId)
                    },
                    onLongPress: { position in
                        self.onLongPress(position, message)
                    }
                )
                .id("\(message.id) \(selectedMessageIDs.contains(message.id)) \(shouldShowSelectionView)")
            }
            .onChange(of: messages.count) { _ in
                withAnimation {
                    scrollToBottom = messages.count > previousMessageCount
                }
                previousMessageCount = messages.count
            }
            .onChange(of: shouldShowSelectionView) { newValue in
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
        .id(appString.bottomID())
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
}
