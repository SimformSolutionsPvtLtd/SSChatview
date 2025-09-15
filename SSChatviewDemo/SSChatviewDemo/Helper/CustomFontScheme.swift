//
//  CustomFontScheme.swift
//  SSChatviewDemo
//
//  Created by Palak Doshi on 16/04/25.
//

import SSChatview
import SwiftUI

// MARK: - CustomFontScheme

/// A custom implementation of `SSChatFontScheme`
/// using the Poppins font family.
/// Falls back to system fonts if loading fails.
struct CustomFontScheme: SSChatFontScheme {

    /// Creates an instance of `CustomFontScheme`.
    public init() {}

    // MARK: - Font Loader

    /// Helper to load a custom SwiftUI font.
    private func font(named name: String, size: CGFloat) -> Font {
        Font.custom(name, size: size)
    }

    // MARK: - Fonts

    public var regular: Font {
        font(named: appFont.poppinsRegular.name, size: SystemFontSize.regular)
    }

    public var bold: Font {
        font(named: appFont.poppinsBold.name, size: SystemFontSize.regular)
    }

    public var italic: Font {
        font(named: appFont.poppinsMedium.name, size: SystemFontSize.regular)
    }

    public var small: Font {
        font(named: appFont.poppinsRegular.name, size: SystemFontSize.small)
    }

    public var medium: Font {
        font(named: appFont.poppinsSemiBold.name, size: SystemFontSize.medium)
    }

    public var large: Font {
        font(named: appFont.poppinsThin.name, size: SystemFontSize.large)
    }
}
