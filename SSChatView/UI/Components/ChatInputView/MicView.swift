//
//  MicView.swift
//  SSChatView
//
//  Created by Palak Doshi on 27/02/24.
//

import SwiftUI

struct MicView: View {

    //MARK: - Body
    var body: some View {
        Image(systemName: SystemImage.micIcon) // Displaying an image with the mic icon.
            .frame(width: ChatInputViewConstants.micImageSize, height: ChatInputViewConstants.micImageSize) // Setting the frame size of the image.
            .foregroundColor(.gray) // Setting the foreground color of the image to gray.
            .padding(AppConstants.horizontalPadding) // Adding padding around the image.
            .onTapGesture {
                // TODO: Add Mic Tap Action
            }
    }
}
