//
//  AppConstants.swift
//  SSChatView
//
//  Created by Palak Doshi on 01/08/23.
//

import Foundation
import SwiftUI

// MARK: - R.swift variables
let appString             = R.string.localizable
let appColor              = R.color
let appFont               = R.font

// MARK: SystemImage
enum SystemImage {
    static let plusIcon                      = "plus"
    static let micIcon                       = "mic.fill"
    static let sendIcon                      = "arrow.up.circle.fill"
}

// MARK: SystemColors
enum SystemColors {
    static var primaryBackground: Color {
        return Color(UIColor.systemBackground)
    }

    static var primaryBorder: Color {
        return Color(UIColor.systemGray4)
    }

    static var textColor: Color {
        return Color(UIColor.label)
    }
}

// MARK: AppConstants
enum AppConstants {
    static let horizontalPadding: CGFloat = 14
    static let cornerRadius: CGFloat = 20
}

// MARK: ChatInputViewConstants
enum ChatInputViewConstants {
    static let textFieldEdgeInsets = EdgeInsets(top: 0, leading: 60, bottom: 8, trailing: 14)
    static let plusImageSize: CGFloat = 15
    static let sendImageSize: CGFloat = 30
    static let buttonSize: CGFloat = 35
    static let offsetMinus15: CGFloat = -15
    static let offsetMinus8: CGFloat = -8
    static let micImageSize: CGFloat = 15
    static let textFieldPadding: CGFloat = 10
    static let sendViewPadding: CGFloat = 8
}

// MARK: MessageViewConstants
enum MessageViewConstants {
    static let helloText = "Hello!"
    static let helloReplyText = "Hi, there!"
    static let textPadding: CGFloat = 15
    static let spacing: CGFloat  = 10
}
