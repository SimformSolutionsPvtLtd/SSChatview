//
//  Untitled.swift
//  SSChatview
//
//  Created by Palak Doshi on 11/04/25.
//

import SwiftUI

// MARK: - SSChatConfiguration View Extension

/// A `View` extension to inject `SSChatConfiguration` into the environment.
/// Use this modifier to provide custom color, font, and string configurations
/// throughout the chat UI components.
public extension View {
    /// Injects `SSChatConfiguration` into the environment.
    ///
    /// - Parameter config: The chat configuration to inject.
    /// - Returns: A modified view with the configuration applied.
    func ssChatConfig(_ config: SSChatConfiguration) -> some View {
        environment(\.ssChatConfig, config)
    }
}
