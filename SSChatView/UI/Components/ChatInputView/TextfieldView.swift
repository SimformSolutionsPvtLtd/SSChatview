//
//  TextfieldView.swift
//  SSChatView
//
//  Created by Palak Doshi on 27/02/24.
//

import SwiftUI

struct TextfieldView: View {

    // MARK: - Variables
    @Binding var messageText: String
}

// MARK: - Body
extension TextfieldView {

    var body: some View {
        VStack {
            TextField(
                appString.smsText(),
                text: $messageText,
                axis: .vertical
            ) // Displaying a vertical text input field.
                .padding(ChatInputViewConstants.textFieldPadding)
                .background(
                    RoundedRectangle(cornerRadius: AppConstants.cornerRadius)
                        .fill(SystemColors.primaryBackground) // Setting the background color of the text field.
                        .overlay(
                            RoundedRectangle(cornerRadius: AppConstants.cornerRadius)
                                .stroke(SystemColors.primaryBorder, lineWidth: 1) // Adding a border to the text field.
                        )
                )
        }
    }
}
