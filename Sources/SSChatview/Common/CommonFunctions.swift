//
//  CommonFunctions.swift
//  SSChatview
//
//  Created by Palak Doshi on 03/09/24.
//

import SwiftUI

// MARK: - Custom Divider
/// Creates a custom horizontal divider with adjustable color.
func customDivider(color: Color = .gray) -> some View {
    HStack {
        Rectangle()
            .fill(color.opacity(0.4))
            .frame(height: 1)
    }
    .frame(maxWidth: .infinity) // Make sure the divider takes up the full width
}
