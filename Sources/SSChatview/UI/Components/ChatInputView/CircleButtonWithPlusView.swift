//
//  CircleButtonWithPlusView.swift
//  SSChatview
//
//  Created by Palak Doshi on 27/02/24.
//

import SwiftUI

/// SwiftUI view for a circular button with a plus icon.
struct CircleButtonWithPlusView: View {

    // MARK: - Variables
    var onPlusClick: () -> Void

    // MARK: - Environment
    @Environment(\.ssChatConfig) private var config
}

// MARK: - Body
extension CircleButtonWithPlusView {

    var body: some View {
        Button(action: {
            onPlusClick()
        }, label: {
            Image.ssImage(config.images.plus)
                .resizable()
                .frame(
                    width: AppConstants.ChatInputView.plusImageSize,
                    height: AppConstants.ChatInputView.plusImageSize
                ) // Setting the frame size of the plus icon.
                .foregroundColor(.gray) // Setting the color of the plus icon.
        })
        .frame(width: AppConstants.ChatInputView.buttonSize,
               height: AppConstants.ChatInputView.buttonSize) // Setting the frame size of the button.
        .background(config.colors.primaryBorder.opacity(0.6)) // Setting the background color of the button.
        .cornerRadius(AppConstants.cornerRadius) // Applying corner radius to the button.
    }
}
