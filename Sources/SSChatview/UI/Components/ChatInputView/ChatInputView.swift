//
//  ChatInputView.swift
//  SSChatview
//
//  Created by Palak Doshi on 27/02/24.
//

import SwiftUI

struct ChatInputView: View {

    // MARK: - Variables
    @Binding var message: String
    @Binding var isBlurred: Bool
    var onSendMsgTap: () -> Void

    // MARK: - Environment
    @Environment(\.ssChatConfig) private var config
}

// MARK: - Body
extension ChatInputView {

    var body: some View {
        VStack {
            TextfieldView(messageText: $message) // Displaying the text input field.
                .padding(ChatInputViewConstants.textFieldEdgeInsets)
                .disabled(isBlurred)
                .overlay(
                    RoundedRectangle(cornerRadius: TextfieldBorderConstants.cornerRadius)
                        .stroke(config.colors.primaryBorder, lineWidth: 1)
                        .padding(.leading, TextfieldBorderConstants.leadingPadding)
                        .padding(.trailing, TextfieldBorderConstants.trailingPadding)
                        .padding(.bottom, TextfieldBorderConstants.bottomPadding)
                )
                .overlay(
                    CircleButtonWithPlusView(onPlusClick: { // Displaying the button for adding attachments.
                        // TODO: Add on Click of Plus
                    })
                    .offset(x: 0, y: ChatInputViewConstants.offsetMinus15)
                    .padding(.horizontal, AppConstants.horizontalPadding),
                    alignment: .bottomLeading
                )
                .overlay(
                    Group {
                        if message.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            MicView { // Displaying the microphone icon when no text is entered.
                                // TODO: Handle Mic Tap Action
                            }
                        } else {
                            CircleButtonWithSendView { // Displaying the send button when text is entered.
                                onSendMsgTap()
                                message = ""
                            }
                        }
                    }
                        .offset(x: 0, y: ChatInputViewConstants.offsetMinus8)
                        .padding(.horizontal, AppConstants.horizontalPadding),
                    alignment: .bottomTrailing
                )
        }
    }
}
