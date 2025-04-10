//
//  SSChatImageAssets.swift
//  SSChatview
//
//  Created by Palak Doshi on 16/04/25.
//

import SwiftUI

// MARK: - SSChatImageAssets Protocol

/// Protocol defining all image assets used in SSChatview.
/// Consumers can conform to this protocol to override only specific images.
///
/// If a property is not overridden, it will fall back to the default image provided
/// by the `DefaultImageAssets` through the protocol extension.
///
/// Example usage:
/// ```swift
/// struct MyImages: SSChatImageAssets {
///     var sendIconName: String { "customSend" }
/// }
/// ```
public protocol SSChatImageAssets {

    /// Name of the profile image icon. @default "profile"
    var profileImageName: String { get }

    /// Name of the mic icon. @default "mic.fill"
    var micIconName: String { get }

    /// Name of the send icon. @default "send"
    var sendIconName: String { get }

    /// Name of the plus/add icon. @default "plus"
    var plusIconName: String { get }

    /// Name of the message icon. @default "message.fill"
    var messageIconName: String { get }

    /// Name of the arrow/chevron icon. @default "chevron.right"
    var arrowIconName: String { get }

    /// Name of the reply arrow icon. @default "arrowshape.turn.up.left"
    var replyIconName: String { get }

    /// Name of the edit icon. @default "pencil"
    var editIconName: String { get }

    /// Name of the copy icon. @default "doc.on.doc"
    var copyIconName: String { get }

    /// Name of the delete icon. @default "trash"
    var deleteIconName: String { get }

    /// Name of the "more options" icon. @default "ellipsis"
    var moreIconName: String { get }

    /// Name of the forward icon. @default "arrowshape.turn.up.right"
    var forwardIconName: String { get }

    /// Name of the select icon (used in selection mode). @default "checkmark"
    var selectIconName: String { get }

    /// Name of the close/cancel icon. @default "xmark"
    var crossIconName: String { get }

    /// Name of the checkmark icon. @default "checkmark"
    var checkmarkIconName: String { get }
}

// MARK: - Default Image Assets

/// Default implementation of all image asset names.
/// These are used when no override is provided via the protocol conformance.
public struct DefaultImageAssets: SSChatImageAssets {

    /// Creates an instance of `DefaultImageAssets`.
    public init() {}

    public let profileImageName = "profile"
    public let micIconName = "mic.fill"
    public let sendIconName = "arrow.up.circle.fill"
    public let plusIconName = "plus"
    public let messageIconName = "message.fill"
    public let arrowIconName = "chevron.right"
    public let replyIconName = "arrowshape.turn.up.left"
    public let editIconName = "pencil"
    public let copyIconName = "doc.on.doc"
    public let deleteIconName = "trash"
    public let moreIconName = "ellipsis"
    public let forwardIconName = "arrowshape.turn.up.right"
    public let selectIconName = "checkmark"
    public let crossIconName = "xmark"
    public let checkmarkIconName = "checkmark"
}

// MARK: - Default Fallback Implementation

/// Default fallback values for any image not provided in a custom asset struct.
/// These are automatically resolved when the consumer overrides only some properties.
extension SSChatImageAssets {
    private var defaults: DefaultImageAssets { DefaultImageAssets() }

    public var profileImageName: String { defaults.profileImageName }
    public var micIconName: String { defaults.micIconName }
    public var sendIconName: String { defaults.sendIconName }
    public var plusIconName: String { defaults.plusIconName }
    public var messageIconName: String { defaults.messageIconName }
    public var arrowIconName: String { defaults.arrowIconName }
    public var replyIconName: String { defaults.replyIconName }
    public var editIconName: String { defaults.editIconName }
    public var copyIconName: String { defaults.copyIconName }
    public var deleteIconName: String { defaults.deleteIconName }
    public var moreIconName: String { defaults.moreIconName }
    public var forwardIconName: String { defaults.forwardIconName }
    public var selectIconName: String { defaults.selectIconName }
    public var crossIconName: String { defaults.crossIconName }
    public var checkmarkIconName: String { defaults.checkmarkIconName }
}
