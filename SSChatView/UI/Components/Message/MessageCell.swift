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
    @Binding var shouldShowSelectionView: Bool
    @State var isSelected: Bool
    var onMessageSelection: (String) -> Void
    var onLongPress: (CGPoint) -> Void
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
            HStack {
                if currentMessage.isCurrentUser {
                    Spacer() // Align the current user's message to the right
                }

                // Display message content
                Text(currentMessage.content)
                    .messageTextModifier(isCurrentUser: currentMessage.isCurrentUser)
                    .onTapGesture {
                        resetReaction() // Reset reactions on tap
                        guard shouldShowSelectionView else { return }
                        onMessageSelection(currentMessage.id)
                    }
                    .overlay(selectedReactionView,
                             alignment: currentMessage.isCurrentUser ? .topLeading : .topTrailing)
                    .blur(radius: isBlurred ? 10 : 0) // Blur message content if needed
                    .overlay(
                        GeometryReader { geometry in
                            Color.clear
                                .contentShape(Rectangle()) // Make sure the entire area is tappable
                                .onLongPressGesture {
                                    guard !isBlurred, !shouldShowSelectionView else { return }
                                    dismissKeyboard()
                                    isBlurred = true
                                    let position = geometry.frame(in: .global)
                                    onLongPress(CGPoint(x: position.maxX, y: position.minY))
                                }
                        })
            }
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
                .offset(x: currentMessage.isCurrentUser ? -20 : 20, y: -20)
                .opacity(isBlurred ? 0 : 1)
                .onTapGesture {
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
}
