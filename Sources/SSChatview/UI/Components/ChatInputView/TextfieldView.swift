//
//  TextfieldView.swift
//  SSChatview
//
//  Created by Palak Doshi on 27/02/24.
//

import SwiftUI

// MARK: - TextfieldView
/// A vertically expanding text field for chat input, with drag-to-dismiss keyboard gesture.
struct TextfieldView: View {

    // MARK: - Variables
    @Binding var messageText: String

    // MARK: - Environment
    @Environment(\.ssChatConfig) private var config
}

// MARK: - Body
extension TextfieldView {

    var body: some View {
        VStack {
            TextField(
                config.strings.smsText,
                text: $messageText,
                axis: .vertical
            ) // Displaying a vertical text input field.
            .font(config.fonts.regular)
            .padding(AppConstants.ChatInputView.textFieldPadding)
            .simultaneousGesture(
                DragGesture()
                    .onEnded { gesture in
                        let dragThreshold: CGFloat = messageText.count > AppConstants.ChatInputView.messageCharacterThreshold ? 30 : 50
                        if gesture.translation.height > dragThreshold {
                            dismissKeyboard()
                        }
                    }
            )
        }
    }
}
