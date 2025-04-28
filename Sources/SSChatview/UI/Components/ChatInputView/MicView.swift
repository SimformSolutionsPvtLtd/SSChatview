//
//  MicView.swift
//  SSChatview
//
//  Created by Palak Doshi on 27/02/24.
//

import SwiftUI

// MARK: - MicView
/// A microphone button view for the chat input area.
struct MicView: View {

    // MARK: - Variables
    var onMicClick: () -> Void

    // MARK: - Environment
    @Environment(\.ssChatConfig) private var config
}

// MARK: - Body
extension MicView {
    var body: some View {
        Image.ssImage(config.images.mic) // Displaying an image with the mic icon.
            .frame(
                width: AppConstants.ChatInputView.micImageSize,
                height: AppConstants.ChatInputView.micImageSize
            ) // Setting the frame size of the image.
            .foregroundColor(.gray) // Setting the foreground color of the image to gray.
            .padding(AppConstants.horizontalPadding) // Adding padding around the image.
            .onTapGesture {
                onMicClick()
            }
    }
}
