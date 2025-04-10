//
//  Image+Extension.swift
//  SSChatview
//
//  Created by Palak Doshi on 15/04/25.
//
import SwiftUI

// MARK: - SSChat Image Extension

/// An extension to `Image` to support loading assets from both the app bundle
/// and the module bundle. This is especially useful when working with Swift Packages
/// where assets may reside in either the consumer app or the library module.
///
/// Usage:
/// ```swift
/// Image.ssImage("iconName")
/// ```
extension Image {

    /// Loads an image by attempting to first find it in the app/demo bundle.
    /// If not found, it falls back to the module's resource bundle (useful for Swift Packages).
    /// If still not found, returns a system fallback image.
    ///
    /// - Parameter name: The name of the image asset.
    /// - Returns: An `Image` instance loaded from the appropriate source, or a fallback system image.
    static func ssImage(_ name: String?) -> Image {
        if let name, UIImage(named: name) != nil {
            return Image(name) // From app/demo assets
        } else if let name,
                  UIImage(named: name, in: .module, compatibleWith: nil) != nil {
            return Image(name, bundle: .module) // From library/module assets
        } else {
            return Image(systemName: "questionmark.circle.fill") // Fallback system image
        }
    }
}
