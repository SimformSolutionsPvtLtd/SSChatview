//
//  MessageFocusView.swift
//  SSChatview
//
//  Created by Palak Doshi on 27/09/24.
//

import SwiftUI

struct MessageFocusView: View {
    // MARK: - Variables
    @StateObject var viewModel: MessageFocusViewModel
    @Binding var messageViewHeight: CGFloat
    @Binding var isLongMessage: Bool
    @State private var messageHeight: CGFloat = 0
    @State private var contextMenuHeight: CGFloat = 0

    // MARK: - Environment
    @Environment(\.ssChatConfig) private var config
}

// MARK: - Body
extension MessageFocusView {

    var body: some View {
        VStack(alignment: viewModel.messageResponseModel.isCurrentUser ? .trailing : .leading, spacing: 2) {
            reactionView
            HStack {
                if viewModel.messageResponseModel.isCurrentUser { Spacer() }
                messageTextView
                    .padding(.vertical, 12)
                    .padding(viewModel.messageResponseModel.isCurrentUser ? .leading : .trailing, 12)
                if !viewModel.messageResponseModel.isCurrentUser { Spacer() }
            }
            if !isLongMessage {
                customContextMenuView
            }
        }
    }
}

// MARK: - ReactionView
extension MessageFocusView {

    // MARK: - ReactionView
    private var reactionView: some View {
        HStack(spacing: 30) {
            ForEach(ReactionType.allCases.filter { $0 != .none }, id: \.self) { reaction in
                Button(action: {
                    viewModel.updateReaction(reaction: reaction)
                    resetReactionAnimation(shouldShow: false)
                }, label: {
                    Image.ssImage(reaction.imageName)
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
            resetReactionAnimation(shouldShow: true)
        }
    }
}

// MARK: - DotsView
extension MessageFocusView {

    // MARK: - DotsView
    private var dotsView: some View {
        VStack(spacing: 0) {
            Circle()
                .foregroundColor(config.colors.tertiarySystemGroupedBackground)
                .frame(width: 18, height: 18)

            Circle()
                .foregroundColor(config.colors.tertiarySystemGroupedBackground)
                .frame(width: 10, height: 10)
                .offset(x: viewModel.messageResponseModel.isCurrentUser ? -8 : 8)
        }
        .offset(x: viewModel.messageResponseModel.isCurrentUser ? -15 : 15, y: -20)
    }
}

// MARK: - MessageTextView
extension MessageFocusView {

    // MARK: - MessageTextView
    private var messageTextView: some View {
        ZStack(alignment: viewModel.messageResponseModel.isCurrentUser ? .bottomTrailing : .bottomLeading) {
            VStack(alignment: viewModel.messageResponseModel.isCurrentUser ? .trailing : .leading) {
                Text(viewModel.messageResponseModel.content)
                    .messageTextModifier(isCurrentUser: viewModel.messageResponseModel.isCurrentUser)
                    .trackHeight($messageHeight)
                    .onChange(of: messageHeight) { newHeight in
                        let availableHeight =
                        AppConstants.screenHeight -
                        AppConstants.reactionViewHeight -
                        contextMenuHeight
                        self.isLongMessage = newHeight >= availableHeight
                    }
                    .overlay(
                        dotsView
                            .scaleEffect(
                                (1 / viewModel.getScaleFactor(messageHeight: messageHeight)),
                                anchor: viewModel.messageResponseModel.isCurrentUser
                                ? .topLeading : .topTrailing
                            )
                            .frame(width: 12, height: 12),
                        alignment: viewModel.messageResponseModel.isCurrentUser ? .topLeading : .topTrailing
                    )
                    .overlay(
                        alignment: viewModel.messageResponseModel.isCurrentUser
                        ? .bottomTrailing : .bottomLeading) {
                            if isLongMessage {
                                customContextMenuView
                                    .scaleEffect(
                                        (1 / viewModel.getScaleFactor(messageHeight: messageHeight)),
                                        anchor: viewModel.messageResponseModel.isCurrentUser
                                        ? .bottomTrailing : .bottomLeading
                                    )
                            }
                        }
                        .scaleEffect(viewModel.getScaleFactor(messageHeight: messageHeight))
                        .frame(
                            maxWidth: UIScreen.main.bounds.width * 0.7,
                            maxHeight: isLongMessage ? viewModel.getMessageHeight(currentHeight: messageHeight) : nil,
                            alignment: viewModel.messageResponseModel.isCurrentUser ? .trailing : .leading
                        )

                if isLongMessage { Spacer() }
            }
        }
    }
}

// MARK: - CustomContextMenuView
extension MessageFocusView {

    // MARK: - CustomContextMenuView
    private var customContextMenuView: some View {
        VStack(spacing: 8) {
            ForEach(CustomMenu.allCases.filter { $0 != .edit ||
                viewModel.messageResponseModel.isCurrentUser &&
                viewModel.messageResponseModel.editedMessages.count < 5 }, id: \.self) { action in
                    Button(action: {
                        viewModel.onActionClick(action: action)
                        resetReactionAnimation(shouldShow: false)
                    }, label: {
                        HStack {
                            Text(action.localizedTitle)
                                .foregroundColor(config.colors.textColor)
                            Spacer()
                            Image(systemName: action.iconName)
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
        .frame(width: 220)
        .transition(.opacity)
        .trackHeight($contextMenuHeight)
    }
}

// MARK: - ResetReactionAnimation
extension MessageFocusView {

    private func resetReactionAnimation(shouldShow: Bool) {
        ReactionType.allCases.enumerated().forEach { index, reaction in
            withAnimation(
                .interpolatingSpring(stiffness: 170, damping: 15)
                .delay(Double(index) * 0.1)
            ) {
                viewModel.animateReactions(reaction, shouldShow: shouldShow)
            }
        }
    }
}
