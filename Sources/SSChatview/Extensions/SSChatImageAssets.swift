//
//  SSChatImageAssets.swift
//  SSChatview
//
//  Created by Palak Doshi on 16/04/25.
//

import SwiftUI

// MARK: - SSChatImageAssets Protocol

/// Protocol defining all image assets used in SSChatview.
/// Conforming to this protocol overrides only specific images.
///
/// If a property is not overridden, it will fall back to the default image
/// provided directly in the protocol extension.
///
/// Example usage:
/// ```swift
/// struct MyImages: SSChatImageAssets {
///     var send: String { "customSend" }
/// }
/// ```
public protocol SSChatImageAssets {
    var profileImage: String { get }
    var mic: String { get }
    var send: String { get }
    var plus: String { get }
    var message: String { get }
    var arrow: String { get }
    var edit: String { get }
    var copy: String { get }
    var delete: String { get }
    var more: String { get }
    var forward: String { get }
    var select: String { get }
    var cross: String { get }
    var checkmark: String { get }
}

// MARK: - Default Image Assets
extension SSChatImageAssets {
    public var profileImage: String { "profilePlaceholder" }
    public var mic: String { "mic.fill" }
    public var send: String { "arrow.up.circle.fill" }
    public var plus: String { "plus" }
    public var message: String { "message.fill" }
    public var arrow: String { "chevron.right" }
    public var edit: String { "pencil" }
    public var copy: String { "doc.on.doc" }
    public var delete: String { "trash" }
    public var more: String { "ellipsis" }
    public var forward: String { "arrowshape.turn.up.right" }
    public var select: String { "checkmark" }
    public var cross: String { "xmark" }
    public var checkmark: String { "checkmark" }
}

// MARK: - Default Assets Implementation
public struct DefaultImageAssets: SSChatImageAssets {
    public init() {}
}
