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
    @State private var shouldShowDelete: Bool = false

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
            ProfileImageView(
                imageName: ProfileConstants.profileImage,
                isBlurred: $isBlurred,
                shouldShowSelectionView: $viewModel.shouldShowSelectionView
            ) {
                viewModel.shouldShowSelectionView = false
            }
            .padding(.top, topPadding)
            .disabledWithOpacity(isBlurred)

            MessageView(
                messages: $viewModel.messageArray,
                isBlurred: $isBlurred,
                shouldShowSelectionView: $viewModel.shouldShowSelectionView,
                selectedMessageIDs: $viewModel.selectedMessageIDs
            )
            .onTapGesture {
                withAnimation {
                    shouldShowDelete = false
                    isBlurred = false
                }
            }

            if viewModel.shouldShowSelectionView {
                ZStack(alignment: .bottom) {
                    MessageActionView {
                        withAnimation {
                            shouldShowDelete = true
                        }
                    }
                    .disabledWithOpacity(viewModel.selectedMessageIDs.isEmpty)

                    .sheet(isPresented: $shouldShowDelete) {
                        deleteAlertView
                            .presentationDetents([.height(150)])
                            .presentationBackground(Color.clear)
                    }
                }
            } else {
                ChatInputView(
                    message: $currentMessage,
                    isBlurred: $isBlurred
                ) {
                    viewModel.addMessage(currentMessage)
                    currentMessage = ""
                }
                .blur(radius: isBlurred ? 10 : 0)
            }
        }
        .moveContentAboveKeyboard()
    }
}

// MARK: - Bottom Action Buttons
extension ChatScreenView {
    private var deleteAlertView: some View {
        VStack(spacing: 8) {
            Button(action: {
                viewModel.deleteSelectedMessages()
            }, label: {
                Text(viewModel.getDeleteMessage())
                    .frame(maxWidth: .infinity, maxHeight: 60)
                    .background(appColor.deleteAlertBackground.getColor())
                    .foregroundColor(.red)
                    .font(.headline)
                    .cornerRadius(10)
            })

            Button(action: {
                withAnimation {
                    shouldShowDelete = false
                }
            }, label: {
                Text(CustomMenuTitles.cancel)
                    .frame(maxWidth: .infinity, maxHeight: 60)
                    .background(appColor.deleteAlertBackground.getColor())
                    .foregroundColor(.blue)
                    .font(.headline)
                    .cornerRadius(10)
            })
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}
