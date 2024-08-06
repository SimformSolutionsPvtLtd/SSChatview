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
    @State private var reactionState = ReactionState()
}

extension MessageCell {
    // MARK: - Body
    var body: some View {
        HStack(alignment: .bottom, spacing: MessageViewConstants.spacing) {
            if currentMessage.isCurrentUser {
                Spacer() // Align the current user's message to the right
            }

            ZStack {
                messageContent
            }
            .overlay(selectedReactionView, alignment: currentMessage.isCurrentUser ? .topLeading : .topTrailing)
            .overlay(reactionView)
            .frame(
                width: UIScreen.main.bounds.width * 0.7,
                alignment: currentMessage.isCurrentUser ? .trailing : .leading
            )
        }
        .frame(maxWidth: .infinity,
               alignment: currentMessage.isCurrentUser ? .trailing : .leading)
        .padding()
    }

    // MARK: - Message Content
    private var messageContent: some View {
        Text(currentMessage.content) // Display message content
            .modifier(
                MessageText(
                    currentMessage: currentMessage,
                    isCurrentUser: currentMessage.isCurrentUser
                )
            )
            .onTapGesture {
                resetReaction() // Reset reactions on tap
            }
            .onLongPressGesture {
                guard !isBlurred else { return }
                isBlurred = true
                showReactionAnimation(shouldShow: true) // Show reactions on long press
                activeMessageID = currentMessage.id
            }
            .blur(radius: isBlurred ? 10 : 0) // Blur message content if needed
    }

    // MARK: - Selected Reaction View
    private var selectedReactionView: some View {
        Group {
            if let reaction = currentMessage.reaction?.imageName {
                ZStack {
                    Image(reaction)
                        .padding(8)
                        .background(SystemColors.primaryBorder)
                        .clipShape(Circle())
                        .shadow(radius: 3)
                        .offset(x: currentMessage.isCurrentUser ? -20 : 20, y: -20)

                    Circle()
                        .foregroundColor(SystemColors.primaryBorder)
                        .offset(x: currentMessage.isCurrentUser ? -35 : 35, y: -8)
                        .frame(width: 12, height: 12)

                    Circle()
                        .foregroundColor(SystemColors.primaryBorder)
                        .frame(width: 6, height: 6)
                        .offset(x: currentMessage.isCurrentUser ? -45 : 45, y: -2)
                }
            }
        }
        .opacity(isBlurred ? 0 : 1)
        .onTapGesture {
            activeMessageID = currentMessage.id
            currentMessage.reaction = nil
            resetReaction()
        }
    }

    // MARK: - Reaction View
    private var reactionView: some View {
        ZStack {
            reactionViewBase

            // Message content displayed over reaction view
            Text(currentMessage.content)
                .modifier(
                    MessageText(
                        currentMessage: currentMessage,
                        isCurrentUser: currentMessage.isCurrentUser
                    )
                )
                .opacity(isBlurred && currentMessage.id == activeMessageID ? 1 : 0)
        }
    }

    private var reactionViewBase: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 28)
                .fill(Color(UIColor.tertiarySystemGroupedBackground))
                .frame(width: 280, height: 60)
                .scaleEffect(
                    isBlurred && currentMessage.id == activeMessageID ? 1 : 0,
                    anchor: .bottomTrailing
                )
                .animation(
                    .interpolatingSpring(stiffness: 170, damping: 15).delay(0.05),
                    value: isBlurred
                )

            Circle()
                .foregroundColor(Color(UIColor.tertiarySystemGroupedBackground))
                .frame(width: 20, height: 20)
                .offset(x: currentMessage.isCurrentUser ? 40 : -50, y: 30)

            Circle()
                .foregroundColor(Color(UIColor.tertiarySystemGroupedBackground))
                .frame(width: 12, height: 12)
                .offset(x: currentMessage.isCurrentUser ? 25 : -30, y: 45)

            HStack(spacing: 30) {
                ForEach(ReactionType.allCases, id: \.self) { reaction in
                    Button(action: {
                        currentMessage.reaction = reaction
                        resetReaction()
                    }, label: {
                        Image(reaction.imageName)
                            .scaleEffect(
                                reactionState.isActive(reaction) ? 1 : 0) // Scale reaction image based on state
                    })
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .offset(x: currentMessage.isCurrentUser ? -90 : 100, y: -80) // Adjust position based on message sender
        .opacity(isBlurred && currentMessage.id == activeMessageID ? 1 : 0)
        .onTapGesture {
            resetReaction() // Reset reactions on tap
        }
    }

    // MARK: - Functions
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
    var currentMessage: MessageResponseModel
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
