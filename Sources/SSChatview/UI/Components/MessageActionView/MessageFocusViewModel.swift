//
//  MessageFocusViewModel.swift
//  SSChatview
//
//  Created by Palak Doshi on 27/09/24.
//

import SwiftUI

// MARK: - MessageFocusViewModel
/// ViewModel for managing the state and actions related to a focused message, including reactions and context menu actions.
class MessageFocusViewModel: ObservableObject {

    // MARK: - Variables
    @Published var messageResponseModel: MessageResponseModel
    @Published private var onActionClick: (String, CustomMenu) -> Void
    @Published private var onReactionClick: (String, ReactionType) -> Void
    @Published private(set) var reactions: Set<ReactionType> = []

    // MARK: - init
    init(messageResponseModel: MessageResponseModel,
         onActionClick: @escaping (String, CustomMenu) -> Void,
         onReactionClick: @escaping (String, ReactionType) -> Void) {
        self.messageResponseModel = messageResponseModel
        self.onActionClick = onActionClick
        self.onReactionClick = onReactionClick
    }
}

// MARK: - Methods
extension MessageFocusViewModel {

    /// Toggles the visibility of a reaction based on the 'shouldShow' flag.
    func animateReactions(_ reaction: ReactionType, shouldShow: Bool) {
        if shouldShow {
            reactions.insert(reaction)
        } else {
            reactions.remove(reaction)
        }
    }

    /// Checks if a specific reaction is currently active.
    func isActive(_ reaction: ReactionType) -> Bool {
        reactions.contains(reaction)
    }

    /// Updates the reaction for the current message and triggers the corresponding action callback.
    func updateReaction(reaction: ReactionType) {
        onReactionClick(messageResponseModel.id, reaction)
    }

    /// Handles a custom menu action (e.g., edit, copy) for the current message.
    func onActionClick(action: CustomMenu) {
        onActionClick(messageResponseModel.id, action)
    }

    /// Calculates the maximum allowed height for the message based on the screen and UI elements.
    func getMessageHeight(currentHeight: CGFloat) -> CGFloat {
        return min(currentHeight, (AppConstants.screenHeight - AppConstants.reactionViewHeight))
    }

    /// Computes the scale factor to adjust the message's size relative to its height.
    func getScaleFactor(messageHeight: CGFloat, messageWidth: CGFloat, isWideMessage: Bool) -> CGFloat {
        let baseScale: CGFloat = 1.0
        if isWideMessage {
            let safeAreaInsets = UIApplication.shared.connectedScenes
                .compactMap { ($0 as? UIWindowScene)?.keyWindow }
                .first?.safeAreaInsets ?? .zero
            let availableWidth = AppConstants.screenWidth
            - AppConstants.contentViewWidth
            - (safeAreaInsets.left + safeAreaInsets.right)

            let dynamicScale = availableWidth / messageWidth
            return min(dynamicScale, baseScale)
        } else {
            let availableHeight = AppConstants.screenHeight - AppConstants.reactionViewHeight
            let dynamicScale = availableHeight / messageHeight
            return min(dynamicScale, baseScale)
        }
    }

    /// Calculates horizontal offset for the reaction view based on message width and sender.
    func reactionXOffset(messageWidth: CGFloat) -> CGFloat {
        let isCurrentUser = messageResponseModel.isCurrentUser
        let reactionWidth = AppConstants.reactionViewWidth

        let offset: CGFloat
        if reactionWidth - messageWidth > 5 {
            offset = reactionWidth - messageWidth
        } else {
            let maxOffset = AppConstants.screenWidth - messageWidth
            let minOffset = reactionWidth / 5
            offset = min(minOffset, maxOffset)
        }

        return isCurrentUser ? -offset : offset
    }
}
