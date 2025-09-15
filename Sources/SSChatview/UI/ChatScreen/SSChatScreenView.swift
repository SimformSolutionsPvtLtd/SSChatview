//
//  SSChatScreenView.swift
//  SSChatview
//
//  Created by Palak Doshi on 22/02/24.
//

import SwiftUI

/// A view representing the chat screen, which includes a profile image, message list, and input field.
public struct SSChatScreenView: View {

    // MARK: - Environment
    @Environment(\.ssChatConfig) private var config
    @Environment(\.verticalSizeClass) private var verticalSizeClass

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
    @State private var isWideMessage: Bool = false
    @State private var profileViewHeight: CGFloat = 0

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

    private var isPortrait: Bool {
        verticalSizeClass == .regular
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
extension SSChatScreenView {
    public var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 0) {
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
                .trackSize(width: nil, height: $profileViewHeight)
                .onChange(of: profileViewHeight) { _, profileViewHeight in
                    if isPortrait && AppConstants.portraitProfileViewHeight == 0 && profileViewHeight > 0 {
                        AppConstants.portraitProfileViewHeight = profileViewHeight
                    }
                }
                .onChange(of: verticalSizeClass) {
                    if isPortrait, AppConstants.portraitProfileViewHeight == 0, profileViewHeight > 0 {
                        AppConstants.portraitProfileViewHeight = profileViewHeight
                    }
                }

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
                        viewModel.undoSentMessageID = model.id
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
                .trackSize(width: nil, height: $messageViewHeight)

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
                    if viewModel.editMessageID.isEmpty {
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
            }
            .moveContentAboveKeyboard()
            .blur(radius: isBlurred ? 10 : 0)

            if (isLongMessage || isWideMessage) && isBlurred {
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
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
            isBlurred = false
        }
    }
}

// MARK: - SSChatScreenView Extension
extension SSChatScreenView {

    // MARK: - MessageFocusView
    private func messsageActionView(selectedMessage: MessageResponseModel) -> some View {
        VStack(alignment: selectedMessage.isCurrentUser ? .trailing : .leading, spacing: 0) {
            if isLongMessage {
                Spacer(minLength: AppConstants.reactionViewHeight - 60)
            } else if isPortrait {
                Spacer()
                    .frame(maxHeight: (longPressPosition.y - 12) > 0 ? (longPressPosition.y - 12) : .infinity)
            } else {
                let offset: CGFloat = longPressPosition.y < 70 ? (longPressPosition.y + 52) : (longPressPosition.y - 12)
                Spacer()
                    .frame(maxHeight: (longPressPosition.y + 12) > 0 ? offset : .infinity)
            }
            MessageFocusView(
                viewModel: .init(
                    messageResponseModel: selectedMessage,
                    onActionClick: { messageID, action in
                        isBlurred = false
                        viewModel.messageActionClick(messageID: messageID, action: action)
                    },
                    onReactionClick: { messageID, reaction in
                        if reaction != .none {
                            viewModel.updateReaction(messageID: messageID, selectedReaction: reaction)
                        }
                        isBlurred = false
                    }
                ),
                messageViewHeight: $messageViewHeight,
                isLongMessage: $isLongMessage,
                isWideMessage: $isWideMessage
            )
        }

        .offset(x: selectedMessage.isCurrentUser ? -12 : 12)
    }

    // MARK: - DeleteBottomSheetView
    public var deleteBottomSheetView: some View {
        GeometryReader { geometry in
            let isPortrait = geometry.size.height > geometry.size.width
            let maxButtonWidth: CGFloat? = isPortrait ? nil : 350
            VStack {
                Spacer()
                VStack(spacing: 12) {
                    deleteButton(maxWidth: maxButtonWidth)
                    cancelButton(maxWidth: maxButtonWidth)
                }
                .padding(.horizontal)
                .padding(.bottom, 16)
            }
            .frame(maxWidth: .infinity)
        }
    }

    // MARK: - Methods
    private func deleteButton(maxWidth: CGFloat?) -> some View {
        Button(action: {
            shouldShowDelete = false
            viewModel.deleteSelectedMessages()
        }) {
            Text(viewModel.getDeleteMessageCount())
                .frame(maxWidth: maxWidth ?? .infinity, maxHeight: 60)
                .background(config.colors.deleteAlertBackground)
                .foregroundColor(.red)
                .font(.headline)
                .cornerRadius(10)
        }
    }

    private func cancelButton(maxWidth: CGFloat?) -> some View {
        Button(action: {
            withAnimation {
                shouldShowDelete = false
            }
        }) {
            Text(config.strings.cancelText)
                .frame(maxWidth: maxWidth ?? .infinity, maxHeight: 60)
                .background(config.colors.deleteAlertBackground)
                .foregroundColor(.blue)
                .font(.headline)
                .cornerRadius(10)
        }
    }
}
