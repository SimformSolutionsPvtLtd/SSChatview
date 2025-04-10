//
//  ChatScreenView.swift
//  SSChatview
//
//  Created by Palak Doshi on 22/02/24.
//

import SwiftUI

/// A view representing the chat screen, which includes a profile image, message list, and input field.
public struct ChatScreenView: View {

    // MARK: - Environment
    @Environment(\.ssChatConfig) private var config

    // MARK: - Bindings
    @Binding var messageArray: [MessageResponseModel]

    // MARK: - ViewModel
    @StateObject private var viewModel = ChatScreenViewModel()

    // MARK: - State
    @State private var currentMessage: String = ""
    @State private var longPressPosition: CGPoint = .zero
    @State private var isBlurred: Bool = false
    @State private var isProfilePresented: Bool = false
    @State private var shouldShowDelete: Bool = false
    @State private var messageViewHeight: CGFloat = 0.0
    @State private var isLongMessage: Bool = false

    // MARK: - Dependencies
    var userName: String
    var userProfileImage: String?
    var delegate: SSChatDelegate

    // MARK: - Computed Properties
    private var topPadding: CGFloat {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?.windows
            .first(where: { $0.isKeyWindow })?
            .safeAreaInsets.top ?? 0
    }

    // MARK: - Init

    /// Initializes the chat view model with configuration, delegate, initial messages, and user details.
    ///
    /// - Parameters:
    ///   - delegate: An object conforming to `SSChatDelegate` for handling chat events.
    ///   - messageArray: A binding to the array of messages to be displayed in the chat.
    ///   - userName: The name of the user currently using the chat.
    ///   - userProfileImage: An optional string representing the URL or asset name of the user's profile image.
    public init(
        delegate: SSChatDelegate,
        messageArray: Binding<[MessageResponseModel]>,
        userName: String,
        userProfileImage: String? = nil
    ) {
        self.delegate = delegate
        self._messageArray = messageArray
        self.userName = userName
        self.userProfileImage = userProfileImage
    }
}

// MARK: - Body
extension ChatScreenView {
    public var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack {
                ProfileImageView(userName: userName,
                                 userProfileImage: userProfileImage,
                                 isPresented: $isProfilePresented,
                                 shouldShowSelectionView: $viewModel.shouldShowSelectionView,
                                 onCancelTap: {
                    viewModel.shouldShowSelectionView = false
                }, onProfileTap: {
                    if viewModel.editMessageID.isEmpty {
                        isProfilePresented = false
                    } else {
                        viewModel.editMessageID = ""
                    }
                })
                .padding(.top, topPadding)
                .disabledWithOpacity(isBlurred)

                MessageView(
                    messages: $messageArray,
                    isBlurred: $isBlurred,
                    shouldShowSelectionView: $viewModel.shouldShowSelectionView,
                    selectedMessageIDs: $viewModel.selectedMessageIDs,
                    editMessageID: $viewModel.editMessageID,
                    onLongPress: { position, model in
                        self.longPressPosition = position
                        viewModel.selectedMessage = model
                        viewModel.editMessageID = ""
                    }, onMessageEdit: { messageID, editedMessage in
                        viewModel.updateEditedMessage(messageID: messageID, editedMessage: editedMessage)
                    }
                )
                .onTapGesture {
                    withAnimation {
                        shouldShowDelete = false
                        isBlurred = false
                        viewModel.selectedMessage = nil
                        viewModel.editMessageID = ""
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
                        viewModel.sendMessage(currentMessage)
                        currentMessage = ""
                    }
                    .disabledWithOpacity(!viewModel.editMessageID.isEmpty)
                    .layoutPriority(currentMessage.isEmpty ? 0 : 1)
                }
            }
            .moveContentAboveKeyboard()
            .blur(radius: isBlurred ? 10 : 0)

            if isLongMessage && isBlurred {
                config.colors.primaryBackground
                    .ignoresSafeArea()
            }

            if let selectedMessage = viewModel.selectedMessage, isBlurred {
                messsageActionView(selectedMessage: selectedMessage)
            }
        }
        .background(config.colors.primaryBackground.ignoresSafeArea(.all, edges: .all))
        .ignoresSafeArea(.all, edges: .top)
        .onAppear {
            viewModel.config = config
            viewModel.delegate = delegate
        }
        .onTapGesture {
            isBlurred = false
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
                    .background(config.colors.deleteAlertBackground)
                    .foregroundColor(.red)
                    .font(.headline)
                    .cornerRadius(10)
            })

            Button(action: {
                withAnimation {
                    shouldShowDelete = false
                }
            }, label: {
                Text(config.strings.cancelText)
                    .frame(maxWidth: .infinity, maxHeight: 60)
                    .background(config.colors.deleteAlertBackground)
                    .foregroundColor(.blue)
                    .font(.headline)
                    .cornerRadius(10)
            })
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}
