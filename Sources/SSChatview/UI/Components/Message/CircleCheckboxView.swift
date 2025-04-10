//
//  CircleCheckboxViewView.swift
//  SSChatview
//
//  Created by Palak Doshi on 05/09/24.
//

import SwiftUI

// MARK: - Circle Checkbox View
struct CircleCheckboxView: View {

    // MARK: - Variable
    @State var isSelected: Bool

    // MARK: - Environment
    @Environment(\.ssChatConfig) private var config

    // MARK: - Body
    var body: some View {
        ZStack {
            if isSelected {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 24, height: 24)
                Image(systemName: config.images.selectIconName)
                    .foregroundColor(.white)
                    .font(Font(config.fonts.bold))
            } else {
                Circle()
                    .stroke(Color.gray, lineWidth: 2)
                    .frame(width: 24, height: 24)
            }
        }
    }
}
