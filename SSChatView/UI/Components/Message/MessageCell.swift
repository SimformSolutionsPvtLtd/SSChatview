//
//  MessageCell.swift
//  SSChatView
//
//  Created by Palak Doshi on 23/02/24.
//

import SwiftUI

/// SwiftUI View for displaying an individual message cell in the chat.
struct MessageCell: View {

    // MARK: - Variables
    @Binding var currentMessage: MessageResponseModel
    @Binding var isBlurred: Bool
    @Binding var activeMessageID: String
    @Binding var shouldShowSelectionView: Bool
    @State var isSelected: Bool
    @State private var reactionState = ReactionState()
    var onMessageSelection: (String) -> Void
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

            if currentMessage.isCurrentUser {
                Spacer() // Align the current user's message to the right
            }

            ZStack(alignment: currentMessage.isCurrentUser ? .trailing : .leading) {
                messageContent
                if isBlurred && currentMessage.id == activeMessageID {
                    reactionView
                        .offset(y: -60)
                }
            }
        }
        .padding()
    }

    // MARK: - Message Content
    private var messageContent: some View {
        ZStack(alignment: currentMessage.isCurrentUser ? .topLeading : .topTrailing) {
            selectedReactionView
                .offset(x: currentMessage.isCurrentUser ? -25 : 25, y: -25)
                .zIndex(1)
            Text(currentMessage.content) // Display message content
                .modifier(MessageText(isCurrentUser: currentMessage.isCurrentUser))
                .onTapGesture {
                    resetReaction() // Reset reactions on tap
                    guard shouldShowSelectionView else { return }
                    onMessageSelection(currentMessage.id)
                }
                .onLongPressGesture {
                    guard !isBlurred, !shouldShowSelectionView else { return }
                    dismissKeyboard()
                    isBlurred = true
                    showReactionAnimation(shouldShow: true) // Show reactions on long press
                    activeMessageID = currentMessage.id
                }
                .blur(radius: isBlurred ? 10 : 0) // Blur message content if needed
        }
        .padding(.trailing, currentMessage.isCurrentUser ? 0 : 100)
        .padding(.leading, currentMessage.isCurrentUser ? 100 : 0)
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
                .opacity(isBlurred ? 0 : 1)
                .onTapGesture {
                    activeMessageID = currentMessage.id
                    currentMessage.reaction = nil
                    resetReaction()
                }
            }
        }
    }

    // MARK: - ReactionBottomView
    private func reactionBottomView(isCurrentUser: Bool) -> some View {
        VStack(spacing: 0) {
            Circle()
                .foregroundColor(SystemColors.tertiarySystemGroupedBackground)
                .frame(width: 20, height: 20)

            Circle()
                .foregroundColor(SystemColors.tertiarySystemGroupedBackground)
                .frame(width: 12, height: 12)
                .offset(x: isCurrentUser ? -15 : 15, y: 0)
        }
        .offset(y: -10)
    }

    // MARK: - Reaction View
    private var reactionView: some View {
        VStack(alignment: currentMessage.isCurrentUser ? .trailing : .leading) {
            reactionViewBase
            HStack(alignment: .top) {
                if currentMessage.isCurrentUser {
                    Spacer(minLength: 100)
                    reactionBottomView(isCurrentUser: true)
                }
                Text(currentMessage.content)
                    .modifier(MessageText(isCurrentUser: currentMessage.isCurrentUser))
                    .opacity(isBlurred && currentMessage.id == activeMessageID ? 1 : 0)
                    .background(Color.clear)
                if !currentMessage.isCurrentUser {
                    reactionBottomView(isCurrentUser: false)
                    Spacer(minLength: 100)
                }
            }
            customMenu
        }
        .fixedSize(horizontal: false, vertical: true)
    }

    // MARK: - ReactionsStackBase
    private var reactionsStackBase: some View {
        HStack(spacing: 30) {
            ForEach(ReactionType.allCases, id: \.self) { reaction in
                Button(action: {
                    currentMessage.reaction = reaction
                    resetReaction()
                }, label: {
                    Image(reaction.imageName)
                        .scaleEffect(reactionState.isActive(reaction) ? 1 : 0)
                })
                .buttonStyle(PlainButtonStyle())
            }
        }
        .frame(width: 280, height: 60)
        .background(SystemColors.tertiarySystemGroupedBackground)
        .clipShape(RoundedRectangle(cornerRadius: 28))
        .scaleEffect(
            isBlurred && currentMessage.id == activeMessageID ? 1 : 0,
            anchor: .bottomTrailing
        )
        .animation(
            .interpolatingSpring(stiffness: 170, damping: 15).delay(0.05),
            value: isBlurred
        )
    }

    // MARK: - ReactionViewBase
    private var reactionViewBase: some View {
        HStack {
            reactionsStackBase
            Spacer()
        }
        .opacity(isBlurred && currentMessage.id == activeMessageID ? 1 : 0)
        .onTapGesture {
            resetReaction()
        }
        .opacity(isBlurred && currentMessage.id == activeMessageID ? 1 : 0)
    }

    // MARK: - Custom Menu
    private var customMenu: some View {
        VStack(spacing: 8) {
            Button(action: {
                // TODO: Implement Reply Action
                resetReaction()
            }, label: {
                menuButtonLabel(title: CustomMenuTitles.reply, systemImage: SystemImage.replyIcon)
            })
            .padding(.horizontal)

            customDivider(color: .gray)

            Button(action: {
                // TODO: Implement Edit Action
                resetReaction()
            }, label: {
                menuButtonLabel(title: CustomMenuTitles.edit, systemImage: SystemImage.editIcon)
            })
            .padding(.horizontal)

            customDivider(color: .gray)

            Button(action: {
                UIPasteboard.general.string = currentMessage.content
                resetReaction()
            }, label: {
                menuButtonLabel(title: CustomMenuTitles.copy, systemImage: SystemImage.copyIcon)
            })
            .padding(.horizontal)

            customDivider(color: .gray)

            Button(action: {
                shouldShowSelectionView = true
                onMessageSelection(currentMessage.id)
                resetReaction()
            }, label: {
                menuButtonLabel(title: CustomMenuTitles.delete, systemImage: SystemImage.deleteIcon)
            })
            .padding(.horizontal)

            customDivider(color: .gray)

            Button(action: {
                // TODO: Implement More Action
                resetReaction()
            }, label: {
                menuButtonLabel(title: CustomMenuTitles.more, systemImage: SystemImage.moreIcon)
            })
            .padding(.horizontal)
        }
        .padding(.vertical)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(SystemColors.tertiarySystemGroupedBackground)
                .shadow(radius: 5)
        )
        .frame(width: 220) // Width of the menu
        .transition(.opacity) // Optional: Fade-in transition
        .opacity(isBlurred && currentMessage.id == activeMessageID ? 1 : 0)
    }

    // MARK: - Functions
    private func menuButtonLabel(title: String, systemImage: String) -> some View {
        HStack {
            Text(title)
                .foregroundColor(SystemColors.textColor)
            Spacer()
            Image(systemName: systemImage)
                .foregroundColor(SystemColors.textColor)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func showReactionAnimation(shouldShow: Bool) {
        let delayIncrement = 0.1
        ReactionType.allCases.enumerated().forEach { index, reaction in
            withAnimation(
                .interpolatingSpring(stiffness: 170, damping: 15)
                .delay(Double(index) * delayIncrement)
            ) {
                reactionState.update(reaction, shouldShow: shouldShow)
            }
        }
    }

    private func resetReaction() {
        guard isBlurred else { return }
        showReactionAnimation(shouldShow: false) // Hide reactions
        isBlurred = false
        activeMessageID = "" // Reset active message ID
    }

}

// MARK: - ReactionState
private struct ReactionState {
    private(set) var reactions: Set<ReactionType> = []

    mutating func update(_ reaction: ReactionType, shouldShow: Bool) {
        if shouldShow {
            reactions.insert(reaction)
        } else {
            reactions.remove(reaction)
        }
    }

    func isActive(_ reaction: ReactionType) -> Bool {
        reactions.contains(reaction)
    }
}

// MARK: - MessageText Modifier
private struct MessageText: ViewModifier {
    // MARK: - Variables
    var isCurrentUser: Bool

    // MARK: - Body
    func body(content: Content) -> some View {
        content
            .padding() // Padding around the text
            .foregroundColor(
                isCurrentUser ? Color.white : SystemColors.textColor
            ) // Text color based on sender
            .background(
                isCurrentUser ? Color.blue : Color(UIColor.systemGray6)
            ) // Background color based on sender
            .clipShape(
                MessageBubble(myMessage: isCurrentUser)
            ) // Clip shape to message bubble
            .contentShape(
                .contextMenuPreview, MessageBubble(myMessage: isCurrentUser)
            ) // Set content shape for context menu
    }
}

// MARK: - VisualEffectBlur
struct VisualEffectBlur: UIViewRepresentable {
    var blurStyle: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}
