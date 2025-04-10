//
//  Color+Extension.swift
//  SSChatview
//
//  Created by Palak Doshi on 05/09/24.
//

import SwiftUI

// MARK: - SSChatColorPalette Protocol

/// Protocol defining all colors used in SSChatview.
/// Cconforming to this protocol overrides specific colors and customize the chat UI theme.
///
/// If a property is not overridden, it will fall back to the default color
/// provided directly in the protocol extension.
///
/// Example usage:
/// ```swift
/// struct MyColorPalette: SSChatColorPalette {
///     var currentUserMessageBackground: Color { Color.green }
/// }
/// ```
public protocol SSChatColorPalette {
    var primaryBackground: Color { get }
    var primaryBorder: Color { get }
    var textColor: Color { get }
    var tertiarySystemGroupedBackground: Color { get }
    var deleteAlertBackground: Color { get }
    var currentUserMessageText: Color { get }
    var currentUserMessageBackground: Color { get }
    var nonCurrentUserMessageText: Color { get }
    var nonCurrentUserMessageBackground: Color { get }
    var selectedReactionBackground: Color { get }
}

// MARK: - Default Color Values
extension SSChatColorPalette {
    public var primaryBackground: Color { Color(UIColor.systemBackground) }
    public var primaryBorder: Color { Color(UIColor.systemGray4) }
    public var textColor: Color { Color(UIColor.label) }
    public var tertiarySystemGroupedBackground: Color { Color(UIColor.tertiarySystemGroupedBackground) }
    public var deleteAlertBackground: Color { Color.deleteAlertBackground }
    public var currentUserMessageText: Color { Color.white }
    public var currentUserMessageBackground: Color { Color.blue }
    public var nonCurrentUserMessageText: Color { Color(UIColor.label) }
    public var nonCurrentUserMessageBackground: Color { Color(UIColor.systemGray6) }
    public var selectedReactionBackground: Color { Color.green }
}

// MARK: - Default Color Palette Implementation
public struct DefaultColorPalette: SSChatColorPalette {
    public init() {}
}
