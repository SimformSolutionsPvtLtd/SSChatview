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

    // MARK: - Bindings
    @Binding var messages: [MessageResponseModel]
    @Binding var isBlurred: Bool
    @Binding var shouldShowSelectionView: Bool
    @Binding var selectedMessageIDs: Set<String>
    @Binding var editMessageID: String

    // MARK: - Callbacks
    var onLongPress: (CGPoint, MessageResponseModel) -> Void
    var onMessageEdit: (String, String) -> Void

    // MARK: - ViewModel
    @StateObject private var viewModel = MessageViewModel()

    // MARK: - Environment
    @Environment(\.ssChatConfig) private var config
}

// MARK: - Body
extension MessageView {
    var body: some View {
        CustomScrollView(
            scrollToBottom: $viewModel.scrollToBottom,
            isScrollDisabled: $isBlurred,
            scrollID: $editMessageID,
            onBottomStateChanged: handleBottomStateChange
        ) {
            if messages.isEmpty {
                EmptyMessageView
            } else {
                MessageListView
            }
        }
        .overlay(scrollToBottomOverlayView, alignment: .bottomTrailing)
        .gesture(showTimestampGesture)
        .onChange(of: messages.count) {
            viewModel.handleMessageListUpdate(currentMessages: messages, editMessageID: editMessageID)
        }
        .onChange(of: shouldShowSelectionView) { _, newValue in
            if !newValue { selectedMessageIDs.removeAll() }
        }
        .onAppear {
            viewModel.previousMessageCount = messages.count
            DispatchQueue.main.async {
                viewModel.scrollToBottom = true
            }
        }
    }
}

// MARK: - Overlays & Gestures
extension MessageView {

    /// View shown when the message list is empty.
    private var EmptyMessageView: some View {
        VStack {
            Spacer(minLength: AppConstants.screenHeight / 4)
            NoMessageView()
        }
        .frame(maxWidth: .infinity)
    }

    /// Overlay view that appears when user is not at bottom or has unread messages.
    private var scrollToBottomOverlayView: some View {
        Group {
            if !viewModel.isAtBottom || viewModel.unreadMessageCount > 0 {
                ScrollToBottomView(
                    unreadMessageCount: viewModel.unreadMessageCount,
                    onScrollToBottomTap: {
                        viewModel.scrollToBottom = true
                        viewModel.unreadMessageCount = 0
                        editMessageID = ""
                    }
                )
            }
        }
    }

    /// List view that displays all messages and optional date headers.
    private var MessageListView: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(Array(messages.enumerated()), id: \.element.id) { index, message in

                if viewModel.shouldShowDateHeader(messages: messages, currentIndex: index) {
                    DateHeaderView(date: message.timestamp)
                        .frame(maxWidth: .infinity, alignment: .center)
                }

                messageRow(for: message)
            }
        }
        .id(ScrollID.bottomID.rawValue)
    }

    /// Gesture to show timestamps when dragging left beyond a threshold.
    private var showTimestampGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                if value.translation.width < -50 {
                    withAnimation { viewModel.showTimestamp = true }
                }
            }
            .onEnded { _ in
                withAnimation { viewModel.showTimestamp = false }
            }
    }
}

// MARK: - Methods
extension MessageView {

    /// Toggles the selection state for a message by its ID.
    private func toggleMessageSelection(for id: String) {
        if selectedMessageIDs.contains(id) {
            selectedMessageIDs.remove(id)
        } else {
            selectedMessageIDs.insert(id)
        }
    }

    /// Updates scroll state and clears unread count if at bottom.
    private func handleBottomStateChange(_ atBottom: Bool) {
        viewModel.isAtBottom = atBottom
        if atBottom {
            viewModel.unreadMessageCount = 0
        }
    }

    /// Renders a single message row with selection, edit, and gesture support.
    private func messageRow(for message: MessageResponseModel) -> some View {
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
            showTimestamp: $viewModel.showTimestamp,
            isSelected: selectedMessageIDs.contains(message.id),
            onMessageSelection: toggleMessageSelection,
            onLongPress: { position in
                self.onLongPress(position, message)
            },
            onMessageEdit: { messageID, editedMessage in
                self.onMessageEdit(messageID, editedMessage)
            }
        )
        .id("\(message.id)-\(selectedMessageIDs.contains(message.id))-\(shouldShowSelectionView)")
    }
}
