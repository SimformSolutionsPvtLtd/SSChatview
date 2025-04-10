//
//  CustomImageAssets.swift
//  SSChatviewDemo
//
//  Created by Palak Doshi on 16/04/25.
//

import SSChatview

// MARK: - CustomImageAssets

/// A demo implementation of `SSChatImageAssets`
/// that overrides only the required icon(s).
///
/// You can extend this struct to override additional icons as needed.
public struct CustomImageAssets: SSChatImageAssets {

    /// Creates an instance of `CustomImageAssets`.
    public init() {}

    /// The name of the send Icon image from the asset catalog.
    public var send: String {
        R.image.sendButtonImage.name
    }
}
