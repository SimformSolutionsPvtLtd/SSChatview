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
    @Binding var isBlurred: Bool
    @State var activeMessageID = ""
    @State private var scrollToBottom = false // Added state variable
}

// MARK: - Body
extension MessageView {
    var body: some View {
        VStack {
            ScrollViewReader { scrollView in
                ScrollView {
                    if viewModel.messages.isEmpty {
                        // If there are no messages, just add a spacer to occupy space
                        Spacer().frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        ForEach(viewModel.messages, id: \.id) { message in
                            MessageCell(currentMessage: message, isBlurred: $isBlurred, activeMessageID: $activeMessageID)
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
                .scrollDisabled(isBlurred)
                .scrollDismissesKeyboard(.immediately)
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
