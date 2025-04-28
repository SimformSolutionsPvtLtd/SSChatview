//
//  Font+Extension.swift
//  SSChatview
//
//  Created by Palak Doshi on 01/08/23.
//

import SwiftUI

// MARK: - SSChatFontScheme Protocol

/// Protocol defining all font styles used in SSChatview.
/// Conforming to this protocol overrides specific fonts and apply custom typography.
///
/// If a property is not overridden, it will fall back to the default font
/// provided directly in the protocol extension.
///
/// Example usage:
/// ```swift
/// struct MyFontScheme: SSChatFontScheme {
///     var regular: UIFont { UIFont(name: "AvenirNext-Regular", size: 18)! }
/// }
/// ```
public protocol SSChatFontScheme {
    var regular: Font { get }
    var bold: Font { get }
    var italic: Font { get }

    var small: Font { get }
    var medium: Font { get }
    var large: Font { get }
}

// MARK: - Default Font Values

extension SSChatFontScheme {
    public var regular: Font {
        Font.system(size: SystemFontSize.regular, weight: .regular)
    }

    public var bold: Font {
        Font.system(size: SystemFontSize.regular, weight: .bold)
    }

    public var italic: Font {
        Font.system(size: SystemFontSize.regular, design: .default).italic()
    }

    public var small: Font {
        Font.system(size: SystemFontSize.small, weight: .regular)
    }

    public var medium: Font {
        Font.system(size: SystemFontSize.medium, weight: .regular)
    }

    public var large: Font {
        Font.system(size: SystemFontSize.large, weight: .regular)
    }
}

// MARK: - Default Font Scheme

/// Default implementation of `SSChatFontScheme` using system fonts.
/// Can be overridden by passing a custom struct conforming to `SSChatFontScheme`.
public struct DefaultFontScheme: SSChatFontScheme {
    public init() {}
}

// MARK: - System Font Sizes

/// Common font sizes used throughout SSChatview.
private enum SystemFontSize {
    static let small: CGFloat = 14
    static let regular: CGFloat = 18
    static let medium: CGFloat = 20
    static let large: CGFloat = 32
}
