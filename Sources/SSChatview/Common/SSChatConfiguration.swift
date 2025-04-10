//
//  SSChatConfiguration.swift
//  SSChatview
//
//  Created by Palak Doshi on 11/04/25.
//

import SwiftUI

// MARK: - SSChatConfiguration

/// A configuration object used to customize the appearance and behavior of the chat interface.
///
/// Use this to set color schemes, fonts, localized strings, image assets.
///
/// You can access the default configuration using `SSChatConfiguration.default`, or
/// create your own customized configuration.
///
/// Example:
/// ```swift
/// let config = SSChatConfiguration(
///     colors: MyCustomColorPalette(),
///     fonts: MyCustomFontScheme(),
///     images: MyCustomImageAssets()
/// )
/// ```
public struct SSChatConfiguration {

    public static var `default`: SSChatConfiguration {
        return SSChatConfiguration()
    }

    public var colors: SSChatColorPalette
    public var fonts: SSChatFontScheme
    public var strings: SSChatStrings
    public var images: SSChatImageAssets

    public init(
        colors: SSChatColorPalette = DefaultColorPalette(),
        fonts: SSChatFontScheme = DefaultFontScheme(),
        strings: SSChatStrings = DefaultStrings(),
        images: SSChatImageAssets = DefaultImageAssets()
    ) {
        self.colors = colors
        self.fonts = fonts
        self.strings = strings
        self.images = images
    }
}
