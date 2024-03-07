//
//  ChatInputView.swift
//  SSChatView
//
//  Created by Palak Doshi on 27/02/24.
//

import SwiftUI

struct ChatInputView: View {

    //MARK: - Variables
    @State var messageText: String = ""
}

//MARK: - Body
extension ChatInputView {

    var body: some View {
        VStack {
            TextfieldView(messageText: $messageText) // Displaying the text input field.
                .padding(ChatInputViewConstants.textFieldEdgeInsets)
                .overlay(
                    CircleButtonWithPlusView() // Displaying the button for adding attachments.
                        .offset(x: 0, y: ChatInputViewConstants.offsetMinus15)
                        .padding(.horizontal, AppConstants.horizontalPadding),
                    alignment: .bottomLeading
                )
                .overlay(
                    Group {
                        if messageText.isEmpty {
                            MicView() // Displaying the microphone icon when no text is entered.
                        } else {
                            CircleButtonWithSendView() // Displaying the send button when text is entered.
                        }
                    }
                        .offset(x: 0, y: ChatInputViewConstants.offsetMinus8)
                        .padding(.horizontal, AppConstants.horizontalPadding),
                    alignment: .bottomTrailing
                )
        }
    }
}

#Preview {
    ChatInputView() // Preview of ChatInputView.
}

