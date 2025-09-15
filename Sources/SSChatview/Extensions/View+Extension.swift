//
//  Untitled.swift
//  SSChatview
//
//  Created by Palak Doshi on 11/04/25.
//

import SwiftUI

// MARK: - SSChatConfiguration View Extension
/// A `View` extension to inject `SSChatConfiguration` into the environment.
/// Use this modifier to provide custom color, font, and string configurations throughout the chat UI components.
public extension View {

    /// Applies a custom `SSChatConfiguration` to the view’s environment.
    ///
    /// This configuration allows injection of custom fonts, colors, localized strings,
    /// and other UI theming options used throughout the chat interface.
    ///
    /// - Parameter config: The chat configuration object containing theme settings.
    /// - Returns: A view with the configuration injected into the environment.
    func ssChatConfig(_ config: SSChatConfiguration) -> some View {
        environment(\.ssChatConfig, config)
    }
}

// MARK: - View + ChatUI Extensions
/// An extension on `View` to provide reusable modifiers for styling and configuring chat UI components.
internal extension View {
    /// Applies soft shadow and border styling used on floating buttons, bubbles, or card-like chat components.
    ///
    /// - Parameter style: A `ShadowStyle` object that defines corner radius, shadow
    ///   radius, color, and offset. Defaults to a standard soft shadow style with predefined settings.
    /// - Returns: A view styled with the specified shadow and corner radius.
    func chatShadowStyle(style: ShadowStyle = ShadowStyle()) -> some View {
        self.modifier(ChatShadowModifier(style: style))
    }
}
