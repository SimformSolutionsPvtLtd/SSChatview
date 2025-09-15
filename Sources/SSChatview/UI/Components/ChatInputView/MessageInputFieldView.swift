//
//  MessageInputFieldView.swift
//  SSChatview
//
//  Created by Palak Doshi on 25/04/25.
//

import SwiftUI

/// SwiftUI view for a text input field with optional plus, mic, and send buttons for sending messages.
struct MessageInputFieldView: View {

    // MARK: - Variables
    @Binding var message: String
    @Binding var isBlurred: Bool
    var onSendMsgTap: () -> Void
    var showMicButton: Bool = false

    // MARK: - Environment
    @Environment(\.ssChatConfig) private var config
}

// MARK: - Body
extension MessageInputFieldView {

    var body: some View {
        TextfieldView(messageText: $message) // Displaying the text input field.
            .padding(AppConstants.ChatInputView.textFieldEdgeInsets)
            .disabled(isBlurred)
            .overlay(
                RoundedRectangle(cornerRadius: AppConstants.TextFieldBorder.cornerRadius)
                    .stroke(config.colors.primaryBorder, lineWidth: 1)
                    .padding(.leading, AppConstants.TextFieldBorder.leadingPadding)
                    .padding(.trailing, AppConstants.TextFieldBorder.trailingPadding)
                    .padding(.bottom, AppConstants.TextFieldBorder.bottomPadding)
            )
            .overlay(
                Group {
                    let trimmedText = message.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                    if !trimmedText {
                        CircleButtonWithSendView( // Displaying the send button when text is entered.
                            onSendClick: {
                                onSendMsgTap()
                                message = ""
                            },
                            disabled: false
                        )
                    } else if showMicButton {
                        MicView { // Displaying the microphone icon when no text is entered.
                            // TODO: Handle Mic Tap Action
                        }
                    } else {
                        CircleButtonWithSendView( // Displaying the send button when text is entered.
                            onSendClick: {
                                onSendMsgTap()
                                message = ""
                            },
                            disabled: true
                        ).disabled(true)
                    }
                }
                    .offset(x: 0, y: AppConstants.ChatInputView.offsetMinus12)
                    .padding(.horizontal, AppConstants.horizontalPadding),
                alignment: .bottomTrailing
            )
    }
}
