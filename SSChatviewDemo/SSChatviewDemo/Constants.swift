//
//  Constants.swift
//  SSChatviewDemo
//
//  Created by Palak Doshi on 23/04/25.
//

import Foundation

// MARK: - R.swift variables
///Shortcuts for accessing localized strings, colors, fonts, and images via R.swift.
let appString = R.string.localizable
let appColor = R.color
let appFont = R.font
let appImage = R.image

// MARK: - SystemFont Size
/// Common font sizes used throughout SSChatview.
enum SystemFontSize {
    static let small: CGFloat = 14
    static let regular: CGFloat = 18
    static let medium: CGFloat = 20
    static let large: CGFloat = 32
}

// MARK: - Event Types
/// Represents different types of simulated chat events.
enum ChatEventType {
    case add, delete, react, edit
}

let userName = "Test User"
