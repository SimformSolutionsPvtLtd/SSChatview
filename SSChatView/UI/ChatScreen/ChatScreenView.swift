//
//  ChatScreenView.swift
//  SSChatView
//
//  Created by Palak Doshi on 22/02/24.
//

import SwiftUI

struct ChatScreenView: View {

    //MARK: - Variables
    @State var messageText: String = "" // State variable to store the text input in the chat screen.
}

//MARK: - Body
extension ChatScreenView {

    //MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                ChatInputView() // Displaying the chat input view.
            }
        }
    }
}

#Preview {
    ChatScreenView() // Preview of ChatScreenView.
}
