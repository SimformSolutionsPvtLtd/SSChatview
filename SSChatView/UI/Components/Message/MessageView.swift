//
//  MessageView.swift
//  SSChatView
//
//  Created by Palak Doshi on 23/02/24.
//

import SwiftUI

/// SwiftUI View for displaying messages in the chat.
struct MessageView: View {
    // MARK: - Variables
    @ObservedObject var viewModel: MessageViewModel
    @State private var scrollToBottom = false // Added state variable
}

// MARK: - Body
extension MessageView {
    var body: some View {
        VStack {
            ScrollViewReader { scrollView in
                ScrollView {
                    if viewModel.messages.isEmpty {
                        NoMessageView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding(.vertical, (UIScreen.main.bounds.height - 100) / 2)
                    } else {
                        ForEach(viewModel.messages, id: \.id) { message in
                            MessageUI(currentMessage: message)
                                .id(message.id)
                        }
                        .onChange(of: viewModel.messages) { _ in
                            withAnimation {
                                scrollToBottom = true // Set to true to trigger scroll to bottom
                            }
                        }
                        .onAppear {
                            withAnimation {
                                scrollToBottom = true // Set to true to trigger scroll to bottom
                            }
                        }
                    }
                }
                .scrollDismissesKeyboard(.immediately) // Drag to dismiss keyboard.
                .disabled(viewModel.messages.isEmpty) // Disable scroll if there are no messages
                .onChange(of: scrollToBottom) { _ in // Detect changes in scrollToBottom
                    if scrollToBottom {
                        scrollView.scrollTo(viewModel.messages.last?.id, anchor: .bottom)
                        scrollToBottom = false // Reset to false after scrolling
                    }
                }
            }
        }
    }
}
