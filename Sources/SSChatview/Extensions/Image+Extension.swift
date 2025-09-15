//
//  Image+Extension.swift
//  SSChatview
//
//  Created by Palak Doshi on 15/04/25.
//

import SwiftUI

// MARK: - SSChat Image Extension

/// An extension to `Image` to support dynamically loading images from various sources.
/// It prioritizes the main app/demo bundle, then falls back to a module resource bundle
/// (for Swift Package Manager or CocoaPods), and finally checks for valid SF Symbols.
/// If none are found, it returns a fallback system symbol.
///
/// Supports both asset images and SF Symbols transparently.
///
/// Usage:
/// ```swift
/// Image.ssImage("sendIconImage") // Loads from asset, module, or SF Symbol
/// ```
extension Image {

    /// Dynamically resolves an image name from multiple sources:
    /// 1. Main app or demo asset catalog
    /// 2. Module resource bundle (for SPM or CocoaPods)
    /// 3. SF Symbols if the name matches a system icon
    /// 4. Fallback to "questionmark.circle.fill" if all else fails
    ///
    /// - Parameter name: The name of the image or SF Symbol.
    /// - Returns: An `Image` instance from the appropriate source.
    static func ssImage(_ name: String?) -> Image {
        if let name, UIImage(named: name) != nil {
            return Image(name) // Main app/demo asset
        } else if let name {
            #if SWIFT_PACKAGE
            // For Swift Package Manager: use module bundle
            if UIImage(named: name, in: .module, compatibleWith: nil) != nil {
                return Image(name, bundle: .module)
            }
            #else
            // For CocoaPods: use custom bundle via extension
            if UIImage(named: name, in: Bundle(), compatibleWith: nil) != nil {
                return Image(name, bundle: Bundle())
            }
            #endif

            if UIImage(systemName: name) != nil {
                return Image(systemName: name) // SF Symbol
            }
        }

        return Image(systemName: "questionmark.circle.fill") // Fallback
    }
}
