//
//  MessageCell.swift
//  SSChatView
//
//  Created by Palak Doshi on 23/02/24.
//

import SwiftUI

/// SwiftUI View for displaying an individual message cell in the chat.
struct MessageCell: View, KeyboardReadable {

    // MARK: - Variables
    @Binding var currentMessage: MessageResponseModel
    @Binding var isBlurred: Bool
    @Binding var shouldShowSelectionView: Bool
    @Binding var editMessageID: String
    @State var isSelected: Bool
    var onMessageSelection: (String) -> Void
    var onLongPress: (CGPoint) -> Void
    @State private var editMessageDraft: String = ""
    @State private var editedMessageLongPressed: Bool = false
    @FocusState private var isTextFieldFocused: Bool
    @State private var keyboardHeight: CGFloat = 0
}

extension MessageCell {
    // MARK: - Body
    var body: some View {
        HStack(alignment: .center, spacing: MessageViewConstants.spacing) {
            if shouldShowSelectionView {
                CircleCheckboxView(isSelected: isSelected)
                    .onTapGesture {
                        onMessageSelection(currentMessage.id)
                    }
            }
            messageContent
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 20)
    }

    // MARK: - Message Content
    private var messageContent: some View {
        ZStack(alignment: currentMessage.isCurrentUser ? .topLeading : .topTrailing) {
            if currentMessage.id == editMessageID {
                editMessageContent
                    .padding(.vertical, 14)
            } else {
                HStack {
                    if currentMessage.isCurrentUser { Spacer() }
                    messageBubbleContent
                    if !currentMessage.isCurrentUser { Spacer() }
                }
            }
        }
    }

    // MARK: - Message Bubble Content
    private var messageBubbleContent: some View {
        VStack(alignment: currentMessage.isCurrentUser ? .trailing : .leading, spacing: 0.5) {

            // Edited messages stack
            if !currentMessage.editedMessages.isEmpty && !isBlurred && currentMessage.showEditedMessage {
                ForEach(currentMessage.editedMessages, id: \.self) { message in
                    Text(message)
                        .foregroundColor(Color.white)
                        .padding(12)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .contentShape(.contextMenuPreview, RoundedRectangle(cornerRadius: 20))
                        .onHover { isHovered in
                            editedMessageLongPressed = isHovered
                        }
                        .contextMenu {
                            editedMessageContextMenu(for: message)
                        }
                        .opacity(!editedMessageLongPressed ? 0.7 : 1)
                        .frame(maxWidth: UIScreen.main.bounds.width * 0.7,
                               alignment: currentMessage.isCurrentUser ? .trailing : .leading) // Max width constraint
                }
            }

            if currentMessage.reaction != nil {
                Spacer(minLength: 18) // Space between message with reaction and edited messages stack
            }

            // Message Content
            Text(currentMessage.content)
                .messageTextModifier(isCurrentUser: currentMessage.isCurrentUser)
                .onTapGesture {
                    resetReaction() // Reset reactions on tap
                    guard shouldShowSelectionView else { return }
                    onMessageSelection(currentMessage.id)
                }
                .disabledWithOpacity(!editMessageID.isEmpty, opacity: 0.6)
                .overlay(selectedReactionView,
                         alignment: currentMessage.isCurrentUser ? .topLeading : .topTrailing)
                .overlay(
                    GeometryReader { geometry in
                        Color.clear
                            .contentShape(Rectangle()) // Make sure the entire area is tappable
                            .onLongPressGesture {
                                guard !isBlurred, !shouldShowSelectionView else { return }
                                dismissKeyboard()
                                isBlurred = true
                                editMessageID = ""
                                let position = geometry.frame(in: .global)
                                onLongPress(CGPoint(x: position.maxX, y: position.minY))
                            }
                    })
                .frame(maxWidth: UIScreen.main.bounds.width * 0.7,
                       alignment: currentMessage.isCurrentUser ? .trailing : .leading) // Max width constraint

            // Edited Message Footnote
            if !currentMessage.editedMessages.isEmpty {
                Text(
                    currentMessage.showEditedMessage
                    ? appString.hideEditsText()
                    : appString.editedText()
                )
                .font(.footnote)
                .foregroundColor(.blue)
                .onTapGesture {
                    currentMessage.showEditedMessage.toggle()
                }
                .padding(.horizontal, 2)
                .opacity(isBlurred ? 0 : 1)
                .disabledWithOpacity(!editMessageID.isEmpty, opacity: 0.6)
            }
        }
    }

    // MARK: - Edit Message Content
    private var editMessageContent: some View {
        HStack(alignment: .center) {

            // Cross Button
            Button(action: {
                editMessageID = ""
                editMessageDraft = ""
            }, label: {
                Image(systemName: SystemImage.crossIcon)
                    .foregroundColor(.white)
                    .frame(width: 30, height: 30)
                    .background(Circle().fill(Color.gray))
            })

            // Edit Message Textfield
            TextfieldView(messageText: $editMessageDraft)
                .focused($isTextFieldFocused)
                .onAppear {
                    editMessageDraft = currentMessage.content
                    isTextFieldFocused = true
                }
                .background(
                    GeometryReader { geometry in
                        Color.clear
                            .onChange(of: geometry.size.height) { expandedHeight in
                                HeightChangePublisher.shared.updateHeight(expandedHeight)
                            }
                    }
                )
                .animation(.easeInOut(duration: 0.5), value: currentMessage.id == editMessageID)
                .background(editTextFieldBubble)
                .onReceive(keyboardHeightPublisher) { height in
                    withAnimation {
                        self.keyboardHeight = height
                    }
                }
                .lineLimit(Int(maxTextFieldHeight()/40))

            // Check Button
            Button(action: {
                guard !editMessageDraft.isEmpty else { return }
                if currentMessage.content != editMessageDraft {
                    currentMessage.updateEditedMessages(newMessage: editMessageDraft)
                }
                editMessageDraft = ""
                editMessageID = ""
            }, label: {
                Image(systemName: SystemImage.checkmarkIcon)
                    .foregroundColor(.white)
                    .frame(width: 30, height: 30)
                    .background(Circle().fill(editMessageDraft.isEmpty ? Color.gray : Color.blue))
            })
        }
        .frame(maxWidth: .infinity)
    }

    // MARK: - EditTextFieldBubble
    @ViewBuilder
    private var editTextFieldBubble: some View {
        ChatShapePathManager(isFromCurrentUser: true)
            .stroke(SystemColors.primaryBorder, lineWidth: 1)
            .background(SystemColors.primaryBackground)
    }

    // MARK: - Selected Reaction View
    private var selectedReactionView: some View {
        Group {
            if let reaction = currentMessage.reaction?.imageName {
                ZStack(alignment: currentMessage.isCurrentUser ? .bottomLeading : .bottomTrailing) {
                    Image(reaction)
                        .padding(8)
                        .frame(width: 40, height: 40)
                        .background(SystemColors.primaryBorder)
                        .clipShape(Circle())

                    Circle()
                        .foregroundColor(SystemColors.primaryBorder)
                        .offset(y: 5)
                        .frame(width: 12, height: 12)

                    Circle()
                        .foregroundColor(SystemColors.primaryBorder)
                        .frame(width: 6, height: 6)
                        .offset(x: currentMessage.isCurrentUser ? -5 : 5, y: 10)
                }
                .disabledWithOpacity(!editMessageID.isEmpty, opacity: 0.9)
                .offset(x: currentMessage.isCurrentUser ? -20 : 20, y: -20)
                .opacity(isBlurred ? 0 : 1)
                .onTapGesture {
                    guard editMessageID.isEmpty else {
                        editMessageID = ""
                        return
                    }
                    currentMessage.reaction = nil
                    resetReaction()
                }
            }
        }
    }

    private func resetReaction() {
        guard isBlurred else { return }
        isBlurred = false
    }

    private func maxTextFieldHeight() -> CGFloat {
        AppConstants.screenHeight - keyboardHeight - AppConstants.profileViewHeight // Prevents overlap with keyboard
    }

    // MARK: - Edited Message Context Menu
    private func editedMessageContextMenu(for message: String) -> some View {
        Group {
            Button(action: {
                /// No Action Required
            }, label: {
                Text(CustomMenu.reply.rawValue)
                Image(systemName: SystemImage.replyIcon)
            })
            .disabled(true)

            Button(action: {
                UIPasteboard.general.string = message
            }, label: {
                Text(CustomMenu.copy.rawValue)
                Image(systemName: SystemImage.copyIcon)
            })

            Button(action: {
                shouldShowSelectionView = true
            }, label: {
                Text(CustomMenu.more.rawValue)
                Image(systemName: SystemImage.moreIcon)
            })
        }
    }
}
