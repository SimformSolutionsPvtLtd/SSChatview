//
//  ChatScreenView.swift
//  SSChatView
//
//  Created by Palak Doshi on 22/02/24.
//

import SwiftUI

struct ChatScreenView: View {
    //MARK: - Variables
    @State private var currentMessage: String = ""
    @StateObject private var viewModel = ChatScreenViewModel()
}

//MARK: - Body
extension ChatScreenView {
    var body: some View {
        NavigationView {
            VStack {
                MessageView(viewModel: MessageViewModel(messages: viewModel.messageArray)) // Displaying the messages view.
                ChatInputView(message: $currentMessage) { // Displaying the chat input view.
                    viewModel.addMessage(message: currentMessage)
                }
            }
        }
    }
}
