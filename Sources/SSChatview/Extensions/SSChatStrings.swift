//
//  SSChatStrings.swift
//  SSChatview
//
//  Created by Palak Doshi on 11/04/25.
//

import SwiftUI

// MARK: - SSChatStrings Protocol

/// Protocol defining all localized strings used in SSChatview.
/// Conforming to this protocol overrides specific strings and customize the chat UI text.
///
/// If a property is not overridden, it will fall back to the default localized string
/// provided directly in the protocol extension.
///
/// Example usage:
/// ```swift
/// struct MyStrings: SSChatStrings {
///     var cancelText: String { "Dismiss" }
///     var profileName: String { "Guest User" }
/// }
/// ```
public protocol SSChatStrings {
    var cancelText: String { get }
    var deleteText: String { get }
    var messageText: String { get }
    var editedText: String { get }
    var hideEditsText: String { get }
    var profileName: String { get }
    var smsText: String { get }
    var noMessagesText: String { get }
    var messagesDesc: String { get }
    var undoSendText: String { get }
}

// MARK: - Default Localized Strings
extension SSChatStrings {
    // MARK: App Strings
    public var cancelText: String { localizedString("cancelText") }
    public var deleteText: String { localizedString("deleteText") }
    public var messageText: String { localizedString("messageText") }
    public var editedText: String { localizedString("editedText") }
    public var hideEditsText: String { localizedString("hideEditsText") }
    public var undoSendText: String { localizedString("undoSendText") }

    // MARK: Profile String
    public var profileName: String { localizedString("profileName") }

    // MARK: Message Strings
    public var smsText: String { localizedString("smsText") }
    public var noMessagesText: String { localizedString("noMessagesText") }
    public var messagesDesc: String { localizedString("messagesDesc") }

    // MARK: Localization Helper
    /// Returns a localized string for the given key, using the appropriate bundle
    private func localizedString(_ key: String) -> String {
        #if SWIFT_PACKAGE
        return NSLocalizedString(key, bundle: .module, comment: "")
        #else
        return NSLocalizedString(key, bundle: Bundle(), comment: "")
        #endif
    }
}

// MARK: - Default Strings Implementation
public struct DefaultStrings: SSChatStrings {
    public init() {}
}
