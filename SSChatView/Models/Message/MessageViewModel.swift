//
//  MessageViewModel.swift
//  SSChatView
//
//  Created by Palak Doshi on 23/02/24.
//

import SwiftUI

/// Model representing a message in the chat.
struct MessageResponseModel: Hashable {
    var id = UUID().uuidString
    var content: String = ""
    var isCurrentUser: Bool = false
}

/// ViewModel for handling messages in the chat.
class MessageViewModel: ObservableObject {
    // MARK: - Variables
    @Published var messages: [MessageResponseModel]

    /// Initializes the MessageViewModel with the given messages.
    init(messages: [MessageResponseModel]) {
        self.messages = messages
    }
}
