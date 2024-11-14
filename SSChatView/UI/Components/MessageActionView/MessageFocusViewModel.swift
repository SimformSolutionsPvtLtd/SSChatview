//
//  MessageFocusViewModel.swift
//  SSChatView
//
//  Created by Palak Doshi on 27/09/24.
//

import Foundation

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

    // MARK: - AnimateReactions
    func animateReactions(_ reaction: ReactionType, shouldShow: Bool) {
        if shouldShow {
            reactions.insert(reaction)
        } else {
            reactions.remove(reaction)
        }
    }

    func isActive(_ reaction: ReactionType) -> Bool {
        reactions.contains(reaction)
    }

    func updateReaction(reaction: ReactionType) {
        onReactionClick(messageResponseModel.id, reaction)
    }

    func onActionClick(action: CustomMenu) {
        onActionClick(messageResponseModel.id, action)
    }

    func getMessageHeight(currentHeight: CGFloat) -> CGFloat {
        return min(currentHeight, (AppConstants.screenHeight - AppConstants.reactionViewHeight))
    }

    func getScaleFactor(messageHeight: CGFloat) -> CGFloat {
        let baseScale: CGFloat = 1.0
        let availableHeight = AppConstants.screenHeight - AppConstants.reactionViewHeight
        let dynamicScale = availableHeight / messageHeight
        return min(dynamicScale, baseScale)
    }
}
