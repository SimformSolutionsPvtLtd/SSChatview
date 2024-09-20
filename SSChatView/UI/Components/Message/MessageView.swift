//
//  MessageView.swift
//  SSChatView
//
//  Created by Palak Doshi on 23/02/24.
//

import SwiftUI

/// SwiftUI View for displaying messages in the chat.
struct MessageView: View, KeyboardReadable {

    // MARK: - Variables
    @Binding var messages: [MessageResponseModel]
    @Binding var isBlurred: Bool
    @State private var activeMessageID = ""
    @State private var scrollToBottom = false
    @Binding var shouldShowSelectionView: Bool
    @Binding var selectedMessageIDs: Set<String>
    @State private var previousMessageCount = 0
}

// MARK: - Body
extension MessageView {
    var body: some View {
        VStack {
            ScrollViewReader { scrollView in
                ScrollView {
                    if messages.isEmpty {
                        Spacer()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        messageList
                    }
                }
                .scrollDisabled(isBlurred)
                .scrollDismissesKeyboard(.immediately)
                .onReceive(keyboardPublisher, perform: { isKeyBoardVisible in
                    scrollToBottom = isKeyBoardVisible
                })
                .onChange(of: scrollToBottom) { _ in
                    if scrollToBottom {
                        scrollView.scrollTo(MessageViewConstants.bottomID, anchor: .bottom)
                        scrollToBottom = false
                    }
                }
            }
        }
    }

    // MARK: - Message List
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
                    activeMessageID: $activeMessageID,
                    shouldShowSelectionView: $shouldShowSelectionView,
                    isSelected: selectedMessageIDs.contains(message.id),
                    onMessageSelection: { messageId in
                        selectDeleteMessage(id: messageId)
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
        .id(MessageViewConstants.bottomID)
    }

    private func selectDeleteMessage(id: String) {
        if selectedMessageIDs.contains(id) {
            selectedMessageIDs.remove(id)
        } else {
            selectedMessageIDs.insert(id)
        }
    }
}
