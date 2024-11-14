//
//  TextfieldView.swift
//  SSChatView
//
//  Created by Palak Doshi on 27/02/24.
//

import SwiftUI

struct TextfieldView: View {

    // MARK: - Variables
    @State private var dragOffset: CGSize = .zero
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
