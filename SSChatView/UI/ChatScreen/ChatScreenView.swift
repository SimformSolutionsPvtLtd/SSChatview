//
//  ChatScreenView.swift
//  SSChatView
//
//  Created by Palak Doshi on 22/02/24.
//

import SwiftUI

struct ChatScreenView: View {
    // MARK: - Variables
    @State private var currentMessage: String = ""
    @Binding var isBlurred: Bool
    @StateObject private var viewModel = ChatScreenViewModel()
    private var topPadding: CGFloat {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?.windows
            .first(where: { $0.isKeyWindow })?
            .safeAreaInsets.top ?? 0
    }
}

// MARK: - Body
extension ChatScreenView {
    var body: some View {
        VStack {
            ProfileImageView(imageName: ProfileConstants.profileImage, isBlurred: $isBlurred)
                .padding(.top, topPadding)

            MessageView(viewModel: MessageViewModel(messages: viewModel.messageArray), isBlurred: $isBlurred)

            // Displaying the messages view.
            ChatInputView(message: $currentMessage, isBlurred: $isBlurred) { // Displaying the chat input view.
                viewModel.addMessage(message: currentMessage)
                currentMessage = ""
            }
            .blur(radius: isBlurred ? 10 : 0)
        }
    }
}
