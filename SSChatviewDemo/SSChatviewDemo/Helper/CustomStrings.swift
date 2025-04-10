//
//  CustomStrings.swift
//  SSChatviewDemo
//
//  Created by Palak Doshi on 16/04/25.
//
import SSChatview

// MARK: - CustomStrings

/// A demo implementation of `SSChatStrings`
/// that overrides only the required string(s).
///
/// You can extend this struct to override additional strings as needed.
public struct CustomStrings: SSChatStrings {

    /// Creates an instance of `CustomStrings`.
    public init() {}

    /// Custom label text for SMS/iMessage type.
    public var smsText: String {
        appString.smsText()
    }
}
