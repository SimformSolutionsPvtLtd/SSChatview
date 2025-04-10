//
//  Color+Extension.swift
//  SSChatview
//
//  Created by Palak Doshi on 21/04/25.
//

import SwiftUI

// MARK: - SSChat Color Extension

/// An extension on `Color` to load color assets from the module bundle or a custom CocoaPods bundle.
///
/// Usage:
/// ```swift
/// let background = Color.ssColor("PrimaryBackground")
/// ```
public extension Color {

    /// Loads a color asset with fallback support from the appropriate bundle.
    ///
    /// Checks the module's resource bundle first (for Swift Package Manager), then the custom CocoaPods bundle.
    /// Defaults to `.clear` if the color is not found.
    ///
    /// - Parameter name: The name of the color asset.
    /// - Returns: A `Color` instance, or `.clear` if not found.
    static func ssColor(_ name: String) -> Color {
        #if SWIFT_PACKAGE
        // For Swift Package Manager: use module bundle
        return Color(name, bundle: .module)
        #else
        // For CocoaPods: use custom bundle via extension
        return Color(name, bundle: Bundle())
        #endif
    }

    // MARK: - Commonly Used Colors

    /// The background color for delete confirmation alerts.
    ///
    /// Customizable in your asset catalog with the name `"DeleteAlertBackground"`.
    static var deleteAlertBackground: Color {
        ssColor("DeleteAlertBackground")
    }
}
