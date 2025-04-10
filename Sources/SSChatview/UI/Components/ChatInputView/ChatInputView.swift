//
//  ChatInputView.swift
//  SSChatview
//
//  Created by Palak Doshi on 27/02/24.
//

import SwiftUI

/// A SwiftUI view that provides a text input field with optional plus, mic, and send buttons for sending messages.
struct ChatInputView: View {

    // MARK: - Variables
    @Binding var message: String
    @Binding var isBlurred: Bool
    var onSendMsgTap: () -> Void
    var showPlusButton: Bool = false
    var showMicButton: Bool = false

    // MARK: - Environment
    @Environment(\.ssChatConfig) private var config
}

// MARK: - Body
extension ChatInputView {

    var body: some View {
        HStack(alignment: .bottom) {

            if showPlusButton {
                CircleButtonWithPlusView {
                    // TODO: Add on Click of Plus
                }
                .offset(x: AppConstants.ChatInputView.offset12, y: AppConstants.ChatInputView.offsetMinus15)
            }

            MessageInputFieldView(
                message: $message,
                isBlurred: $isBlurred,
                onSendMsgTap: onSendMsgTap,
                showMicButton: showMicButton
            )
        }
    }
}
