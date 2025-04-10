//
//  CustomFontScheme.swift
//  SSChatviewDemo
//
//  Created by Palak Doshi on 16/04/25.
//
import SSChatview
import SwiftUI

// MARK: - CustomFontScheme

/// A demo implementation of `SSChatFontScheme`
/// using the custom Poppins font family.
///
/// Assumes all fonts are correctly added to the project.
public struct CustomFontScheme: SSChatFontScheme {

    /// Creates an instance of `CustomFontScheme`.
    public init() {}

    // MARK: - Font Accessors

    public var regular: UIFont {
        UIFont(name: appFont.poppinsRegular.name, size: SystemFontSize.regularFontSize)!
    }

    public var bold: UIFont {
        UIFont(name: appFont.poppinsBold.name, size: SystemFontSize.regularFontSize)!
    }

    public var italic: UIFont {
        UIFont(name: appFont.poppinsMedium.name, size: SystemFontSize.regularFontSize)!
    }

    public var small: UIFont {
        UIFont(name: appFont.poppinsRegular.name, size: SystemFontSize.smallFontSize)!
    }

    public var medium: UIFont {
        UIFont(name: appFont.poppinsSemiBold.name, size: SystemFontSize.mediumFontSize)!
    }

    public var large: UIFont {
        UIFont(name: appFont.poppinsThin.name, size: SystemFontSize.largeFontSize)!
    }
}
