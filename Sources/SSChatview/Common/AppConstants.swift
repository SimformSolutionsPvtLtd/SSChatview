//
//  AppConstants.swift
//  SSChatview
//
//  Created by Palak Doshi on 01/08/23.
//

import Foundation
import SwiftUI

// MARK: - SSChatConfigurationKey

/// A custom environment key to inject and access the `SSChatConfiguration`
/// throughout the SwiftUI view hierarchy. This allows customization of theme,
/// fonts, strings, and behavior from a single configuration object.
private struct SSChatConfigurationKey: EnvironmentKey {

    /// The default value used if no explicit configuration is provided.
    static let defaultValue = SSChatConfiguration()
}

// MARK: - EnvironmentValues Extension

public extension EnvironmentValues {

    /// A computed property for reading and writing `SSChatConfiguration` from the environment.
    ///
    /// Usage:
    /// ```swift
    /// @Environment(\.ssChatConfig) var config
    /// ```
    ///
    /// To inject:
    /// ```swift
    /// .environment(\.ssChatConfig, SSChatConfiguration(...))
    /// ```
    var ssChatConfig: SSChatConfiguration {
        get { self[SSChatConfigurationKey.self] }
        set { self[SSChatConfigurationKey.self] = newValue }
    }
}

// MARK: ScrollID
enum ScrollID: String {
    case bottomID      = "BottomID"
    case scrollAreaID  = "ScrollAreaID"
}

// MARK: AppConstants
public enum AppConstants {
    static let screenHeight = UIScreen.main.bounds.height
    static let horizontalPadding: CGFloat = 14
    static let cornerRadius: CGFloat = 20
    static let reactionViewHeight: CGFloat = 180
    static let profileViewHeight: CGFloat = 180
}

// MARK: ChatInputViewConstants
public enum ChatInputViewConstants {
    static let textFieldEdgeInsets = EdgeInsets(top: 5, leading: 60, bottom: 8, trailing: 45)
    static let plusImageSize: CGFloat = 15
    static let sendImageSize: CGFloat = 30
    static let buttonSize: CGFloat = 35
    static let offsetMinus15: CGFloat = -15
    static let offsetMinus8: CGFloat = -8
    static let micImageSize: CGFloat = 15
    static let textFieldPadding: CGFloat = 10
    static let sendViewPadding: CGFloat = 8
}

// MARK: TextfieldBorderConstants
public enum TextfieldBorderConstants {
    static let cornerRadius: CGFloat = 25
    static let trailingPadding: CGFloat = 15
    static let bottomPadding: CGFloat = 8
    static let leadingPadding: CGFloat = AppConstants.horizontalPadding + ChatInputViewConstants.buttonSize + 8
}

// MARK: MessageViewConstants
enum MessageViewConstants {
    static let spacing: CGFloat = 10
}

// MARK: SystemImage
public enum SystemImage {
    static let plusIcon = "plus"
    static let micIcon = "mic.fill"
    static let sendIcon = "arrow.up.circle.fill"
    static let messageIcon = "message.fill"
    static let arrowIcon = "chevron.right"
    static let replyIcon = "arrowshape.turn.up.left"
    static let editIcon = "pencil"
    static let copyIcon = "doc.on.doc"
    static let deleteIcon = "trash"
    static let moreIcon = "ellipsis"
    static let forwardIcon = "arrowshape.turn.up.right"
    static let selectIcon = "checkmark"
    static let crossIcon = "xmark"
    static let checkmarkIcon = "checkmark"
}

// MARK: - Reaction Types
public enum ReactionType: String, CaseIterable {
    case love, like, dislike, laugh, exclaim, none // `none` is used as default or null

    var imageName: String {
        self == .none ? "" : self.rawValue
    }
}



    // MARK: CustomMenu
    enum CustomMenu: String, CaseIterable {
        case edit
        case delete
        case reply
        case copy
        case more

        var localizedTitle: String {
            return self.rawValue.capitalized
        }

        var iconName: String {
            switch self {
            case .edit: return SystemImage.editIcon
            case .delete: return SystemImage.deleteIcon
            case .reply: return SystemImage.replyIcon
            case .copy: return SystemImage.copyIcon
            case .more: return SystemImage.moreIcon
            }
        }
    }
