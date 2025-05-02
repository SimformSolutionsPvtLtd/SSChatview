//
//  CustomColorPalette.swift
//  SSChatviewDemo
//
//  Created by Palak Doshi on 16/04/25.
//

import SwiftUI
import SSChatview

/// A demo implementation of `SSChatColorPalette`
/// that overrides only the required color(s).
///
/// You can extend this struct to override additional colors as needed.
public struct CustomColorPalette: SSChatColorPalette {

    /// Creates an instance of `CustomColorPalette`.
    public init() {}

    /// Primary background color for the chat view.
    public var primaryBackground: Color {
        Color(appColor.chatBackground.name)
    }

    /// Text color for messages sent by the current user.
    public var currentUserMessageText: Color {
        Color(appColor.currentUserMessageText.name)
    }

    /// Background color for messages sent by the current user.
    public var currentUserMessageBackground: Color {
        Color(appColor.currentUserMessageBackground.name)
    }

    /// Text color for messages sent by non-current users.
    public var nonCurrentUserMessageText: Color {
        Color(appColor.nonCurrentUserMessageText.name)
    }

    /// Background color for messages sent by non-current users.
    public var nonCurrentUserMessageBackground: Color {
        Color(appColor.nonCurrentUserMessageBackground.name)
    }

}
