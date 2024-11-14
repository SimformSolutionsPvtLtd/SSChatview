//
//  ChatScreenView.swift
//  SSChatView
//
//  Created by Palak Doshi on 22/02/24.
//

import SwiftUI

/// A view representing the chat screen, which includes a profile image, message list, and input field.
struct ChatScreenView: View {
    // MARK: - Variables
    @State private var currentMessage: String = ""
    @State private var longPressPosition: CGPoint = .zero
    @Binding var isBlurred: Bool
    @StateObject private var viewModel = ChatScreenViewModel()
    @State private var shouldShowDelete: Bool = false
    @State private var messageViewHeight: CGFloat = 0.0
    @State private var isLongMessage: Bool = false

    private var topPadding: CGFloat {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?.windows
            .first(where: { $0.isKeyWindow })?
            .safeAreaInsets.top ?? 0
    }
}

// MARK: - Body
extension ChatScreenView {
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack {
                ProfileImageView(
                    imageName: ProfileConstants.profileImage,
                    isBlurred: $isBlurred,
                    shouldShowSelectionView: $viewModel.shouldShowSelectionView
                ) {
                    viewModel.shouldShowSelectionView = false
                }
                .padding(.top, topPadding)
                .disabledWithOpacity(isBlurred)

                MessageView(
                    messages: $viewModel.messageArray,
                    isBlurred: $isBlurred,
                    shouldShowSelectionView: $viewModel.shouldShowSelectionView,
                    selectedMessageIDs: $viewModel.selectedMessageIDs,
                    onLongPress: {position, model in
                        self.longPressPosition = position
                        viewModel.selectedMessage = model
                    }
                )
                .onTapGesture {
                    withAnimation {
                        shouldShowDelete = false
                        isBlurred = false
                        viewModel.selectedMessage = nil
                    }
                }
                .trackHeight($messageViewHeight)

                if viewModel.shouldShowSelectionView {
                    ZStack(alignment: .bottom) {
                        MessageActionView {
                            withAnimation {
                                shouldShowDelete = true
                            }
                        }
                        .disabledWithOpacity(viewModel.selectedMessageIDs.isEmpty)

                        .sheet(isPresented: $shouldShowDelete) {
                            deleteBottomSheetView
                                .presentationDetents([.height(150)])
                                .presentationBackground(Color.clear)
                        }
                    }
                } else {
                    ChatInputView(
                        message: $currentMessage,
                        isBlurred: $isBlurred
                    ) {
                        viewModel.addMessage(currentMessage)
                        currentMessage = ""
                    }
                    .layoutPriority(currentMessage.isEmpty ? 0 : 1)
                }
            }
            .moveContentAboveKeyboard()
            .blur(radius: isBlurred ? 10 : 0)

            if isLongMessage && isBlurred {
                SystemColors.primaryBackground
                    .ignoresSafeArea()
            }

            if let selectedMessage = viewModel.selectedMessage, isBlurred {
                messsageActionView(selectedMessage: selectedMessage)
            }
        }
    }
}

// MARK: - ChatScreenView Extension
extension ChatScreenView {

    // MARK: - MessageFocusView
    private func messsageActionView(selectedMessage: MessageResponseModel) -> some View {
        VStack(alignment: selectedMessage.isCurrentUser ? .trailing : .leading, spacing: 0) {
            if isLongMessage {
                Spacer(minLength: 60)
            } else {
                Spacer()
                    .frame(maxHeight: (longPressPosition.y - 72) > 0 ? (longPressPosition.y - 72) : .infinity)
            }
            MessageFocusView(
                viewModel: .init(
                    messageResponseModel: selectedMessage,
                    onActionClick: { messageID, action in
                        isBlurred = false
                        viewModel.messageActionClick(messageID: messageID, action: action)
                    },
                    onReactionClick: { messageID, reaction in
                        viewModel.updateReaction(messageID: messageID, selectedReaction: reaction)
                        isBlurred = false
                    }
                ),
                messageViewHeight: $messageViewHeight,
                isLongMessage: $isLongMessage
            )
        }

        .offset(x: selectedMessage.isCurrentUser ? -12 : 12)
    }

    // MARK: - DeleteBottomSheetView
    private var deleteBottomSheetView: some View {
        VStack(spacing: 8) {
            Button(action: {
                shouldShowDelete = false
                viewModel.deleteSelectedMessages()
            }, label: {
                Text(viewModel.getDeleteMessageCount())
                    .frame(maxWidth: .infinity, maxHeight: 60)
                    .background(appColor.deleteAlertBackground.getColor())
                    .foregroundColor(.red)
                    .font(.headline)
                    .cornerRadius(10)
            })

            Button(action: {
                withAnimation {
                    shouldShowDelete = false
                }
            }, label: {
                Text(MessageViewConstants.cancel)
                    .frame(maxWidth: .infinity, maxHeight: 60)
                    .background(appColor.deleteAlertBackground.getColor())
                    .foregroundColor(.blue)
                    .font(.headline)
                    .cornerRadius(10)
            })
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}
