//
//  MessageFocusView.swift
//  SSChatview
//
//  Created by Palak Doshi on 27/09/24.
//

import SwiftUI

// MARK: - MessageFocusView
/// A view that handles displaying and interacting with a focused message, including reactions, context menus, and message content.
struct MessageFocusView: View {

    // MARK: - Variables
    @StateObject var viewModel: MessageFocusViewModel
    @Binding var messageViewHeight: CGFloat
    @Binding var isLongMessage: Bool
    @Binding var isWideMessage: Bool

    @State private var messageHeight: CGFloat = 0
    @State private var messageWidth: CGFloat = 0
    @State private var contextMenuHeight: CGFloat = 0

    private var isCurrentUser: Bool {
        viewModel.messageResponseModel.isCurrentUser
    }

    private var isPortrait: Bool {
        verticalSizeClass == .regular
    }

    // MARK: - Environment
    @Environment(\.ssChatConfig) private var config
    @Environment(\.verticalSizeClass) private var verticalSizeClass
}

// MARK: - Body
extension MessageFocusView {
    var body: some View {
        VStack(alignment: isCurrentUser ? .trailing : .leading, spacing: 2) {
            messageBubbleView

            if !isLongMessage && isPortrait {
                customContextMenuView
            }
        }
    }
}

// MARK: - Message Bubble
private extension MessageFocusView {
    var messageBubbleView: some View {
        HStack {
            if isCurrentUser { Spacer() }

            messageTextView
                .padding(.vertical, 12)
                .padding(isCurrentUser ? .leading : .trailing, 12)

            if !isCurrentUser { Spacer() }
        }
    }
}

// MARK: - ReactionView
private extension MessageFocusView {
    var reactionView: some View {
        HStack(spacing: 25) {
            ForEach(ReactionType.allCases.filter { $0 != .none }, id: \.self) { reaction in
                let isSelected = viewModel.messageResponseModel.reaction == reaction

                Button(action: {
                    viewModel.updateReaction(reaction: reaction)
                    animateReactionView(shouldShow: false)
                }, label: {
                    let reactionImage = Image.ssImage(reaction.imageName)
                    Group {
                        if isSelected {
                            reactionImage
                                .padding(8)
                                .foregroundColor(.white)
                                .background(config.colors.selectedReactionBackground)
                                .clipShape(Circle())
                        } else {
                            reactionImage
                                .foregroundColor(.gray)
                        }
                    }
                    .scaleEffect(viewModel.isActive(reaction) ? 1 : 0)
                })
                .buttonStyle(PlainButtonStyle())
            }
        }
        .frame(height: 60)
        .padding(.horizontal, 30)
        .background(config.colors.tertiarySystemGroupedBackground)
        .clipShape(RoundedRectangle(cornerRadius: 28))
        .scaleEffect(1, anchor: .bottomTrailing)
        .animation(
            .interpolatingSpring(stiffness: 170, damping: 15).delay(0.05),
            value: true
        )
        .onTapGesture {
            viewModel.updateReaction(reaction: .none)
        }
        .onAppear {
            animateReactionView(shouldShow: true)
        }
    }
}

// MARK: - DotsView
private extension MessageFocusView {
    var dotsView: some View {
        VStack(spacing: 0) {
            Circle()
                .foregroundColor(config.colors.tertiarySystemGroupedBackground)
                .frame(width: 18, height: 18)

            Circle()
                .foregroundColor(config.colors.tertiarySystemGroupedBackground)
                .frame(width: 10, height: 10)
                .offset(x: isCurrentUser ? -8 : 8)
        }
        .offset(x: isCurrentUser ? -15 : 15, y: -20)
    }
}

// MARK: - MessageTextView
private extension MessageFocusView {
    var messageTextView: some View {
        ZStack(alignment: isCurrentUser ? .bottomTrailing : .bottomLeading) {
            VStack(alignment: isCurrentUser ? .trailing : .leading) {
                Text(viewModel.messageResponseModel.content)
                    .messageTextModifier(isCurrentUser: isCurrentUser)
                    .trackSize(width: $messageWidth, height: $messageHeight)
                    .onChange(of: messageHeight) {
                        handleMessageHeightChange()
                    }
                    .overlay(dotsOverlayView, alignment: dotsOverlayAlignment)
                    .overlay(reactionOverlayView, alignment: dotsOverlayAlignment)
                    .overlay(contextMenuLandscapeOverlay, alignment: dotsOverlayAlignment)
                    .overlay(contextMenuPortraitOverlay, alignment: contextMenuAlignment)
                    .scaleEffect(
                        viewModel.getScaleFactor(
                            messageHeight: messageHeight,
                            messageWidth: messageWidth,
                            isWideMessage: isWideMessage
                        )
                    )
                    .frame(
                        maxWidth: UIScreen.main.bounds.width * 0.7,
                        maxHeight: isLongMessage
                        ? viewModel.getMessageHeight(currentHeight: messageHeight)
                        : nil,
                        alignment: isCurrentUser ? .trailing : .leading
                    )
                if isLongMessage && isPortrait {
                    Spacer()
                }
            }
        }
    }
}

// MARK: - CustomContextMenuView
private extension MessageFocusView {
    var customContextMenuView: some View {
        VStack(spacing: 8) {
            ForEach(CustomMenu.allCases.filter { $0 != .edit ||
                isCurrentUser && viewModel.messageResponseModel.editedMessages.count < 5 }, id: \.self) { action in
                    Button(action: {
                        viewModel.onActionClick(action: action)
                        animateReactionView(shouldShow: false)
                    }, label: {
                        HStack {
                            Text(action.localizedTitle)
                                .foregroundColor(config.colors.textColor)
                            Spacer()
                            Image.ssImage(iconName(for: action))
                                .foregroundColor(config.colors.textColor)
                        }
                    })
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)

                    if action != .more {
                        customDivider()
                    }
                }
        }
        .padding(.vertical)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(config.colors.tertiarySystemGroupedBackground)
                .shadow(radius: 5)
        )
        .frame(width: AppConstants.contentViewWidth)
        .transition(.opacity)
        .trackSize(width: nil, height: $contextMenuHeight)
    }

    func iconName(for action: CustomMenu) -> String {
        switch action {
        case .edit: return config.images.edit
        case .copy: return config.images.copy
        case .more: return config.images.more
        }
    }
}

// MARK: - Overlays
private extension MessageFocusView {
    var dotsOverlayView: some View {
        dotsView
            .scaleEffect(inverseScaleFactor, anchor: isCurrentUser ? .topLeading : .topTrailing)
            .frame(width: 12, height: 12)
    }

    var reactionOverlayView: some View {
        Group {
            reactionView
                .offset(x: reactionXOffset, y: -80)
                .scaleEffect(inverseScaleFactor, anchor: isCurrentUser ? .topLeading : .topTrailing)
        }
    }

    var contextMenuLandscapeOverlay: some View {
        Group {
            if !isPortrait {
                customContextMenuView
                    .offset(x: isCurrentUser ? -230 : 230)
                    .scaleEffect(inverseScaleFactor, anchor: isCurrentUser ? .topLeading : .topTrailing)
            }
        }
    }

    var contextMenuPortraitOverlay: some View {
        Group {
            if isLongMessage && isPortrait {
                customContextMenuView
                    .scaleEffect(inverseScaleFactor, anchor: isCurrentUser ? .bottomTrailing : .bottomLeading)
            }
        }
    }
}

// MARK: - Computed Properties
private extension MessageFocusView {
    var dotsOverlayAlignment: Alignment {
        isCurrentUser ? .topLeading : .topTrailing
    }

    var contextMenuAlignment: Alignment {
        isPortrait
            ? (isCurrentUser ? .bottomTrailing : .bottomLeading)
            : (isCurrentUser ? .topLeading : .topTrailing)
    }

    var reactionXOffset: CGFloat {
        viewModel.reactionXOffset(messageWidth: messageWidth)
    }

    var inverseScaleFactor: CGFloat {
        1 / viewModel.getScaleFactor(
            messageHeight: messageHeight,
            messageWidth: messageWidth,
            isWideMessage: isWideMessage
        )
    }
}

// MARK: - Helper Methods
private extension MessageFocusView {
    func animateReactionView(shouldShow: Bool) {
        ReactionType.allCases.enumerated().forEach { index, reaction in
            withAnimation(
                .interpolatingSpring(stiffness: 170, damping: 15)
                .delay(Double(index) * 0.1)
            ) {
                viewModel.animateReactions(reaction, shouldShow: shouldShow)
            }
        }
    }

    func handleMessageHeightChange() {
        isLongMessage = false
        isWideMessage = false

        let availableHeight = AppConstants.screenHeight
        - AppConstants.reactionViewHeight
        - (isPortrait ? contextMenuHeight : 0)

        if messageHeight >= availableHeight {
            isLongMessage = true
        } else if !isPortrait {
            let safeAreaInsets = UIApplication.shared.connectedScenes
                .compactMap { ($0 as? UIWindowScene)?.keyWindow }
                .first?.safeAreaInsets ?? .zero
            let availableWidth = AppConstants.screenWidth - AppConstants.contentViewWidth - (safeAreaInsets.left + safeAreaInsets.right)

            isWideMessage = messageWidth >= availableWidth
        } else {
            isLongMessage = false
        }
    }
}
