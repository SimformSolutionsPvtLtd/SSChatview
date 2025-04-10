//
//  Font+Extension.swift
//  SSChatview
//
//  Created by Palak Doshi on 01/08/23.
//

import SwiftUI

// MARK: - SystemFontSize

/// A container for predefined font sizes used throughout the SSChatview.
public enum SystemFontSize {
    public static let smallFontSize: CGFloat = 14
    public static let regularFontSize: CGFloat = 18
    public static let mediumFontSize: CGFloat = 20
    public static let largeFontSize: CGFloat = 32
}

// MARK: - SSChatFontScheme Protocol

/// A protocol defining font styles used in SSChatview.
/// Conforming types can provide custom font schemes for consistent typography.
public protocol SSChatFontScheme {
    /// Default regular font.
    var regular: UIFont { get }

    /// Bold font variant.
    var bold: UIFont { get }

    /// Italic font variant.
    var italic: UIFont { get }

    /// Smaller size font.
    var small: UIFont { get }

    /// Medium size font.
    var medium: UIFont { get }

    /// Large size font.
    var large: UIFont { get }
}

// MARK: - DefaultFontScheme

/// Default implementation of `SSChatFontScheme` using system fonts.
/// Customize this struct to apply app-specific typography.
public struct DefaultFontScheme: SSChatFontScheme {

    /// Creates an instance of `DefaultFontScheme`.
    public init() {}

    public var regular: UIFont = .systemFont(ofSize: SystemFontSize.regularFontSize)
    public var bold: UIFont = .boldSystemFont(ofSize: SystemFontSize.regularFontSize)
    public var italic: UIFont = .italicSystemFont(ofSize: SystemFontSize.regularFontSize)

    public var small: UIFont = .systemFont(ofSize: SystemFontSize.smallFontSize)
    public var medium: UIFont = .systemFont(ofSize: SystemFontSize.mediumFontSize)
    public var large: UIFont = .systemFont(ofSize: SystemFontSize.largeFontSize)
}
