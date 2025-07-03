//
//  AppConstants.swift
//  SSChatview
//
//  Created by Palak Doshi on 01/08/23.
//

import Foundation
import SwiftUI

// MARK: ScrollID
enum ScrollID: String {
    case bottomID      = "BottomID"
    case scrollAreaID  = "ScrollAreaID"
}

// MARK: AppConstants
public enum AppConstants {
    static var screenHeight: CGFloat {
        UIScreen.main.bounds.height
    }
    static var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }

    static let horizontalPadding: CGFloat = 14
    static let cornerRadius: CGFloat = 20
    static let reactionViewHeight: CGFloat = 180
    static let contentViewWidth: CGFloat = 220
    static let reactionViewWidth: CGFloat = 286
    static let chatInputHeight: CGFloat = 60
    static var portraitProfileViewHeight: CGFloat = 0

    static func profileViewHeight(isPortrait: Bool) -> CGFloat {
        return isPortrait ? portraitProfileViewHeight : 33
    }

    static let messageLineHeight = UIFont.systemFont(ofSize: SystemFontSize.regular).lineHeight + 8

    // MARK: ChatInputView
    enum ChatInputView {
        static let textFieldEdgeInsets = EdgeInsets(top: 5, leading: 15, bottom: 8, trailing: 45)
        static let plusImageSize: CGFloat = 15
        static let sendImageSize: CGFloat = 30
        static let buttonSize: CGFloat = 35
        static let offsetMinus15: CGFloat = -15
        static let offsetMinus12: CGFloat = -12
        static let offset12: CGFloat = 12
        static let micImageSize: CGFloat = 15
        static let textFieldPadding: CGFloat = 10
        static let sendViewPadding: CGFloat = 8
    }

    // MARK: TextFieldBorder
    enum TextFieldBorder {
        static let cornerRadius: CGFloat = 25
        static let trailingPadding: CGFloat = 15
        static let bottomPadding: CGFloat = 8
        static let leadingPadding: CGFloat = 15
    }

    // MARK: MessageView
    enum MessageView {
        static let spacing: CGFloat = 10
    }
}

// MARK: - Reaction Types
public enum ReactionType: String, CaseIterable {
    case love, like, dislike, laugh, exclaim, none // `none` is used as default or null

    var imageName: String {
        self == .none ? "" : self.rawValue
    }
}

// MARK: CustomMenu
public enum CustomMenu: String, CaseIterable {
    case edit
    case undoSend
    case copy
    case more
}
