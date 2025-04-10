//
//  Color+Extension.swift
//  SSChatview
//
//  Created by Palak Doshi on 05/09/24.
//

import SwiftUI

// MARK: - SSChatColorPalette Protocol

/// A protocol defining the color scheme used in SSChatview.
/// Conforming types can provide a custom color palette for theming the chat UI.
public protocol SSChatColorPalette {
    /// Background color used for primary containers or screens.
    var primaryBackground: Color { get }

    /// Border color used for dividers or outlines.
    var primaryBorder: Color { get }

    /// Color used for primary text elements.
    var textColor: Color { get }

    /// Background color for grouped sections or secondary views.
    var tertiarySystemGroupedBackground: Color { get }

    /// Background color for delete alerts or critical actions.
    var deleteAlertBackgroundColor: Color { get }

    /// Background color used in chat view.
    var chatBackgroundColor: Color { get }

    /// Text color for messages sent by the current user.
    var currentUserMessageTextColor: Color { get }

    /// Background color for messages sent by the current user.
    var currentUserMessageBackgroundColor: Color { get }

    /// Text color for messages sent by non-current users.
    var nonCurrentUserMessageTextColor: Color { get }

    /// Background color for messages sent by non-current users.
    var nonCurrentUserMessageBackgroundColor: Color { get }
}

// MARK: - DefaultColorPalette

/// Default implementation of `SSChatColorPalette` using system-defined colors and asset catalog values.
/// Can be overridden by supplying a custom struct conforming to `SSChatColorPalette`.
public struct DefaultColorPalette: SSChatColorPalette {

    /// Creates an instance of `DefaultColorPalette`.
    public init() {}

    public var primaryBackground: Color = Color(UIColor.systemBackground)
    public var primaryBorder: Color = Color(UIColor.systemGray4)
    public var textColor: Color = Color(UIColor.label)
    public var tertiarySystemGroupedBackground: Color = Color(UIColor.tertiarySystemGroupedBackground)
    public var deleteAlertBackgroundColor: Color = Color("DeleteAlertBackground")
    public var chatBackgroundColor: Color = Color("BackgroundColor")
    public var currentUserMessageTextColor: Color = Color.white
    public var currentUserMessageBackgroundColor: Color = Color.blue
    public var nonCurrentUserMessageTextColor: Color = Color(UIColor.label)
    public var nonCurrentUserMessageBackgroundColor: Color = Color(UIColor.systemGray6)
}

// MARK: - Default Implementation Fallback
extension SSChatColorPalette {
    private var defaults: DefaultColorPalette { DefaultColorPalette() }

    public var primaryBackground: Color { defaults.primaryBackground }
    public var primaryBorder: Color { defaults.primaryBorder }
    public var textColor: Color { defaults.textColor }
    public var tertiarySystemGroupedBackground: Color { defaults.tertiarySystemGroupedBackground }
    public var deleteAlertBackgroundColor: Color { defaults.deleteAlertBackgroundColor }
    public var chatBackgroundColor: Color { defaults.chatBackgroundColor }
    public var currentUserMessageTextColor: Color { defaults.currentUserMessageTextColor }
    public var currentUserMessageBackgroundColor: Color { defaults.currentUserMessageBackgroundColor }
    public var nonCurrentUserMessageTextColor: Color { defaults.nonCurrentUserMessageTextColor }
    public var nonCurrentUserMessageBackgroundColor: Color { defaults.nonCurrentUserMessageBackgroundColor }
}
