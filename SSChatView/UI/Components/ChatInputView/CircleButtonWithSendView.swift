//
//  CircleButtonWithSendView.swift
//  SSChatView
//
//  Created by Palak Doshi on 27/02/24.
//

import SwiftUI

struct CircleButtonWithSendView: View {

    //MARK: - Body
    var body: some View {
        ZStack {
            Circle()
                .fill(.white) // Filling the circle with a white color.
                .frame(width: ChatInputViewConstants.sendImageSize, height: ChatInputViewConstants.sendImageSize) // Setting the frame size of the circle.
            Image(systemName: SystemImage.sendIcon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: ChatInputViewConstants.sendImageSize, height: ChatInputViewConstants.sendImageSize) // Setting the frame size of the send icon.
                .foregroundColor(.green) // Setting the color of the send icon.
        }
        .padding(ChatInputViewConstants.sendViewPadding) // Adding padding around the ZStack.
        .onTapGesture {
            // TODO: Add Send Tap Action
        }
    }
}

#Preview {
    CircleButtonWithSendView() // Preview of CircleButtonWithSendView.
}
