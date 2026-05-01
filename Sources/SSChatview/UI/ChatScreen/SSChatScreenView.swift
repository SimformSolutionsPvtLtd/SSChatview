//
//  SSChatScreenView.swift
//  SSChatview
//
//  Created by Palak Doshi on 22/02/24.
//

import SwiftUI

// MARK: - MessageSelectionState
/// Observable state for message selection to handle view invalidation in iOS 18+.
/// @State mutations from nested callbacks don't trigger parent view re-evaluation in iOS 18,
/// so @Observable ensures reliable state notifications.
@Observable
class MessageSelectionState {
    var selectedMessage: MessageResponseModel?
    var isBlurred: Bool = false
    
    func selectMessage(_ message: MessageResponseModel) {
        self.selectedMessage = message
    }
    
    func setBlurred(_ value: Bool) {
        self.isBlurred = value
    }
    
    func clear() {
        self.selectedMessage = nil
        self.isBlurred = false
    }
}

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
    @State private var messageSelectionState = MessageSelectionState()
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
        ZStack(alignment: .topLeading) {
            mainContentStack
            messageFocusOverlay
        }
        .background(config.colors.primaryBackground.ignoresSafeArea(.all, edges: .all))
        .ignoresSafeArea(.all, edges: .top)
        .onAppear {
            viewModel.config = config
            viewModel.delegate = delegate
        }
    }
}

// MARK: - Main Content Stack
extension SSChatScreenView {
    
    private var mainContentStack: some View {
        VStack(spacing: 0) {
            profileSection
            messageListSection
            messageActionOrInputSection
        }
        .moveContentAboveKeyboard()
        .blur(radius: isBlurred ? AppConstants.blurRadius : 0)
        .animation(.easeInOut(duration: 0.2), value: isBlurred)
    }
}

// MARK: - Content Sections
extension SSChatScreenView {
    
    private var profileSection: some View {
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
    }
    
    private var messageListSection: some View {
        MessageView(
            messages: $messageArray,
            isBlurred: $isBlurred,
            shouldShowSelectionView: $viewModel.shouldShowSelectionView,
            selectedMessageIDs: $viewModel.selectedMessageIDs,
            editMessageID: $viewModel.editMessageID,
            onLongPress: handleLongPress,
            onMessageEdit: { messageID, editedMessage in
                self.viewModel.updateEditedMessage(messageID: messageID, editedMessage: editedMessage)
            }
        )
        .onTapGesture {
            guard messageSelectionState.isBlurred else { return }
            withAnimation(.easeOut(duration: 0.2)) {
                messageSelectionState.clear()
                shouldShowDelete = false
                isBlurred = false
                viewModel.selectedMessage = nil
                viewModel.editMessageID = ""
            }
        }
        .trackSize(width: nil, height: $messageViewHeight)
    }
    
    private var messageActionOrInputSection: some View {
        Group {
            if viewModel.shouldShowSelectionView {
                ZStack(alignment: .bottom) {
                    MessageActionView {
                        withAnimation { shouldShowDelete = true }
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
    }
    
    private var messageFocusOverlay: some View {
        Group {
            if let selectedMessage = messageSelectionState.selectedMessage, messageSelectionState.isBlurred {
                ZStack(alignment: .topLeading) {
                    Color.clear
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation(.easeOut(duration: 0.2)) {
                                messageSelectionState.clear()
                                isBlurred = false
                            }
                        }
                    
                    messageActionOverlayView(selectedMessage: selectedMessage)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
                .zIndex(999)
            }
        }
    }
}

// MARK: - Event Handlers
extension SSChatScreenView {
    
    private func handleLongPress(position: CGPoint, model: MessageResponseModel) {
        longPressPosition = position
        messageSelectionState.selectMessage(model)
        viewModel.selectedMessage = model
        viewModel.editMessageID = ""
        viewModel.undoSentMessageID = model.id
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            withAnimation(.easeInOut(duration: 0.2)) {
                self.messageSelectionState.setBlurred(true)
                self.isBlurred = true
            }
        }
    }
}

// MARK: - Message Action View
extension SSChatScreenView {
    
    private func messageActionOverlayView(selectedMessage: MessageResponseModel) -> some View {
        return VStack(alignment: selectedMessage.isCurrentUser ? .trailing : .leading, spacing: 0) {
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
                        withAnimation(.easeOut(duration: 0.2)) {
                            self.messageSelectionState.clear()
                            self.isBlurred = false
                        }
                        self.viewModel.messageActionClick(messageID: messageID, action: action)
                    },
                    onReactionClick: { messageID, reaction in
                        withAnimation(.easeOut(duration: 0.2)) {
                            self.messageSelectionState.clear()
                            self.isBlurred = false
                        }
                        if reaction != .none {
                            self.viewModel.updateReaction(messageID: messageID, selectedReaction: reaction)
                        }
                    }
                ),
                messageViewHeight: $messageViewHeight,
                isLongMessage: $isLongMessage,
                isWideMessage: $isWideMessage
            )
        }
        .offset(x: selectedMessage.isCurrentUser ? -12 : 12)
    }
}

// MARK: - Delete Action View
extension SSChatScreenView {
    
    var deleteBottomSheetView: some View {
        GeometryReader { geometry in
            let isPortrait = geometry.size.height > geometry.size.width
            let maxButtonWidth: CGFloat? = isPortrait ? nil : 350
            VStack {
                Spacer()
                VStack(spacing: 12) {
                    deleteButtonView(maxWidth: maxButtonWidth)
                    cancelButtonView(maxWidth: maxButtonWidth)
                }
                .padding(.horizontal)
                .padding(.bottom, 16)
            }
            .frame(maxWidth: .infinity)
        }
    }
    
    private func deleteButtonView(maxWidth: CGFloat?) -> some View {
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

    private func cancelButtonView(maxWidth: CGFloat?) -> some View {
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
