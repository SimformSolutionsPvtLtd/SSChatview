//
//  CircleButtonWithPlusView.swift
//  SSChatView
//
//  Created by Palak Doshi on 27/02/24.
//

import SwiftUI

/// SwiftUI view for a circular button with a plus icon.
struct CircleButtonWithPlusView: View {
    // MARK: - Variables
    var onPlusClick: () -> Void
}

// MARK: - Body
extension CircleButtonWithPlusView {

    var body: some View {
        Button(action: {
            onPlusClick()
        }, label: {
            Image(systemName: SystemImage.plusIcon)
                .resizable()
                .frame(
                    width: ChatInputViewConstants.plusImageSize,
                    height: ChatInputViewConstants.plusImageSize
                ) // Setting the frame size of the plus icon.
                .foregroundColor(.gray) // Setting the color of the plus icon.
        })
        .frame(width: ChatInputViewConstants.buttonSize,
               height: ChatInputViewConstants.buttonSize) // Setting the frame size of the button.
        .background(SystemColors.primaryBorder.opacity(0.6)) // Setting the background color of the button.
        .cornerRadius(AppConstants.cornerRadius) // Applying corner radius to the button.
    }
}
