//
//  SSChatConfiguration.swift
//  SSChatview
//
//  Created by Palak Doshi on 11/04/25.
//

import SwiftUI

public struct SSChatConfiguration {
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
