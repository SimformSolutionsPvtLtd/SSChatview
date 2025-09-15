//
//  SSChatEnvironment.swift
//  SSChatview
//
//  Created by Palak Doshi on 25/04/25.
//

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
