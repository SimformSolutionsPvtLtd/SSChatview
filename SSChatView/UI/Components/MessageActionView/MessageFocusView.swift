//
//  MessageFocusView.swift
//  SSChatView
//
//  Created by Palak Doshi on 27/09/24.
//

import SwiftUI

struct MessageFocusView: View {
    // MARK: - Variables
    @StateObject var viewModel: MessageFocusViewModel
}

// MARK: - Body
extension MessageFocusView {

    var body: some View {
        VStack(alignment: viewModel.messageResponseModel.isCurrentUser ? .trailing : .leading, spacing: 0) {
            reactionView
                .onAppear {
                    resetReactionAnimation(shouldShow: true)
                }

            HStack(alignment: .top) {
                if viewModel.messageResponseModel.isCurrentUser {
                    dotsView
                    messageTextView
                } else {
                    messageTextView
                    dotsView
                }
            }
            .padding(.vertical, 12)

            customContextMenuView
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
                    Image(reaction.imageName)
                        .scaleEffect(viewModel.isActive(reaction) ? 1 : 0)
                })
                .buttonStyle(PlainButtonStyle())
            }
        }
        .frame(height: 60)
        .padding(.horizontal, 30)
        .background(SystemColors.tertiarySystemGroupedBackground)
        .clipShape(RoundedRectangle(cornerRadius: 28))
        .scaleEffect(1, anchor: .bottomTrailing)
        .animation(
            .interpolatingSpring(stiffness: 170, damping: 15).delay(0.05),
            value: true
        )
        .onTapGesture {
            viewModel.updateReaction(reaction: .none)
        }
    }
}

// MARK: - DotsView
extension MessageFocusView {

    // MARK: - DotsView
    private var dotsView: some View {
        HStack {
            if viewModel.messageResponseModel.isCurrentUser {
                Spacer(minLength: 100)
                circleView(isCurrentUser: true)
            } else {
                circleView(isCurrentUser: false)
                Spacer(minLength: 100)
            }
        }
    }

    // MARK: - CircleView
    private func circleView(isCurrentUser: Bool) -> some View {
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
}

// MARK: - MessageTextView
extension MessageFocusView {

    // MARK: - MessageTextView
    private var messageTextView: some View {
        Text(viewModel.messageResponseModel.content)
            .messageTextModifier(isCurrentUser: viewModel.messageResponseModel.isCurrentUser)
    }
}

// MARK: - CustomContextMenuView
extension MessageFocusView {

    // MARK: - CustomContextMenuView
    private var customContextMenuView: some View {
        VStack(spacing: 8) {
            ForEach(CustomMenu.allCases, id: \.self) { action in
                Button(action: {
                    viewModel.onActionClick(action: action)
                    resetReactionAnimation(shouldShow: false)
                }, label: {
                    HStack {
                        Text(action.rawValue)
                            .foregroundColor(SystemColors.textColor)
                        Spacer()
                        Image(systemName: action.iconName)
                            .foregroundColor(SystemColors.textColor)
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
                .fill(SystemColors.tertiarySystemGroupedBackground)
                .shadow(radius: 5)
        )
        .frame(width: 220)
        .transition(.opacity)
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
