//
//  TextfieldView.swift
//  SSChatview
//
//  Created by Palak Doshi on 27/02/24.
//

import SwiftUI

struct TextfieldView: View {

    // MARK: - Variables
    @Binding var messageText: String
    @State private var dragOffset: CGSize = .zero

    // MARK: - Environment
    @Environment(\.ssChatConfig) private var config
}

extension TextfieldView {

    // MARK: - Body
    var body: some View {
        VStack {
            TextField(
                config.strings.smsText,
                text: $messageText,
                axis: .vertical
            ) // Displaying a vertical text input field.
            .font(Font(config.fonts.regular))
            .padding(ChatInputViewConstants.textFieldPadding)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        dragOffset = gesture.translation
                    }
                    .onEnded { _ in
                        if dragOffset.height > 50 {
                            dismissKeyboard()
                        }
                        dragOffset = .zero
                    }
            )
        }
    }
}
