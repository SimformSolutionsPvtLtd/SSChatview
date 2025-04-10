//
//  SSChatStrings.swift
//  SSChatview
//
//  Created by Palak Doshi on 11/04/25.
//

import SwiftUI

// MARK: - SSChatStrings Protocol

/// A protocol defining all localized strings used in SSChatview.
/// Conform to this protocol to customize string values across the chat UI.
public protocol SSChatStrings {
    // MARK: App Strings
    var cancelText: String { get }
    var deleteText: String { get }
    var messageText: String { get }
    var editedText: String { get }
    var hideEditsText: String { get }

    // MARK: Profile
    var profileName: String { get }

    // MARK: Message Text
    var smsText: String { get }
    var noMessagesText: String { get }
    var messagesDesc: String { get }
}

// MARK: - DefaultStrings Implementation

/// Default implementation of `SSChatStrings` using localized strings
/// from the `Localizable.strings` file within the Swift Package.
public struct DefaultStrings: SSChatStrings {

    /// Creates an instance of `DefaultStrings`.
    public init() {}

    // MARK: App Strings
    public var cancelText: String { localizedString("cancelText") }
    public var deleteText: String { localizedString("deleteText") }
    public var messageText: String { localizedString("messageText") }
    public var editedText: String { localizedString("editedText") }
    public var hideEditsText: String { localizedString("hideEditsText") }

    // MARK: Profile
    public var profileName: String { localizedString("profileName") }

    // MARK: Message Text
    public var smsText: String { localizedString("smsText") }
    public var noMessagesText: String { localizedString("noMessagesText") }
    public var messagesDesc: String { localizedString("messagesDesc") }

    /// Returns a localized string for the given key, using the Swift Package's module bundle.
    private func localizedString(_ key: String) -> String {
        NSLocalizedString(key, bundle: .module, comment: "")
    }
}


// MARK: - Default Fallback Implementation
extension SSChatStrings {
    private var defaults: DefaultStrings { DefaultStrings() }

    // MARK: App Strings
    public var cancelText: String { defaults.cancelText }
    public var deleteText: String { defaults.deleteText }
    public var messageText: String { defaults.messageText }
    public var editedText: String { defaults.editedText }
    public var hideEditsText: String { defaults.hideEditsText }

    // MARK: Profile
    public var profileName: String { defaults.profileName }

    // MARK: Message Text
    public var smsText: String { defaults.smsText }
    public var noMessagesText: String { defaults.noMessagesText }
    public var messagesDesc: String { defaults.messagesDesc }
}
