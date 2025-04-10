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

    /// Custom primary background color for the chat view.
    public var primaryBackground: Color {
        Color(appColor.chatBackgroundColor.name)
    }

    /// Text color for messages sent by the current user.
    public var currentUserMessageTextColor: Color = Color(appColor.currentUserMessageTextColor.name)

    /// Background color for messages sent by the current user.
    public var currentUserMessageBackgroundColor: Color = Color(appColor.currentUserMessageBackgroundColor.name)

    /// Text color for messages sent by other (non-current) users.
    public var nonCurrentUserMessageTextColor: Color = Color(appColor.nonCurrentUserMessageTextColor.name)

    /// Background color for messages sent by other (non-current) users.
    public var nonCurrentUserMessageBackgroundColor: Color = Color(appColor.nonCurrentUserMessageBackgroundColor.name)
}
