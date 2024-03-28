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
}

// MARK: - Body
extension MessageView {
    var body: some View {
        VStack {
            ScrollViewReader { scrollView in
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.messages, id: \.id) { message in
                            MessageUI(currentMessage: message)
                                .id(message.id)
                        }
                    }
                    .onChange(of: viewModel.messages) { _ in
                        withAnimation {
                            scrollView.scrollTo(viewModel.messages.last?.id, anchor: .bottom)
                        }
                    }
                    .onAppear {
                        withAnimation {
                            scrollView.scrollTo(viewModel.messages.last?.id, anchor: .bottom)
                        }
                    }
                }
            }
        }
    }
}
