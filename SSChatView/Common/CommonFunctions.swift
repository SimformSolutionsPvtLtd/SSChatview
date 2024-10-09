//
//  CommonFunctions.swift
//  SSChatView
//
//  Created by Palak Doshi on 03/09/24.
//

import SwiftUI

func customDivider(color: Color = .gray, thickness: CGFloat = 0.3) -> some View {
    HStack {
        Rectangle()
            .fill(color)
            .frame(height: thickness) // Set the thickness of the divider
    }
    .frame(maxWidth: .infinity) // Make sure the divider takes up the full width
}
