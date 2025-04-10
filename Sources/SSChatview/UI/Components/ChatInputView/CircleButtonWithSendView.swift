//
//  CircleButtonWithSendView.swift
//  SSChatview
//
//  Created by Palak Doshi on 27/02/24.
//

import SwiftUI

/// SwiftUI view for a circular button with a send icon.
struct CircleButtonWithSendView: View {

    // MARK: - Variables
    var onSendClick: () -> Void
    var disabled: Bool = false

    // MARK: - Environment
    @Environment(\.ssChatConfig) private var config
}

// MARK: - Body
extension CircleButtonWithSendView {

    var body: some View {
        ZStack {
            Circle()
                .fill(.white) // Filling the circle with a white color.
                .frame(
                    width: AppConstants.ChatInputView.sendImageSize,
                    height: AppConstants.ChatInputView.sendImageSize
                ) // Setting the frame size of the circle.
            Image.ssImage(config.images.send)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(
                    width: AppConstants.ChatInputView.sendImageSize,
                    height: AppConstants.ChatInputView.sendImageSize
                ) // Setting the frame size of the send icon.
                .foregroundColor(disabled ? .gray : .green) // Setting the color of the send icon.
        }
        .padding(AppConstants.ChatInputView.sendViewPadding) // Adding padding around the ZStack.
        .opacity(disabled ? 0.5 : 1.0)
        .onTapGesture {
            onSendClick()
        }
    }
}
