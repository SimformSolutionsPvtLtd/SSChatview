//
//  ChatScreenView.swift
//  SSChatView
//
//  Created by Palak Doshi on 22/02/24.
//

import SwiftUI

/// A view representing the chat screen, which includes a profile image, message list, and input field.
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

            MessageView(messages: $viewModel.messageArray, isBlurred: $isBlurred)

            ChatInputView(message: $currentMessage, isBlurred: $isBlurred) {
                viewModel.addMessage(currentMessage)
                currentMessage = ""
            }
            .blur(radius: isBlurred ? 10 : 0)
        }
    }
}
