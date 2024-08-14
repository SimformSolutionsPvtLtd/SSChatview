//
//  MessageResponseModel.swift
//  SSChatView
//
//  Created by Palak Doshi on 23/02/24.
//

import SwiftUI

/// Model representing a message in the chat.
struct MessageResponseModel: Identifiable, Equatable {

    // MARK: - Variables
    var id: String = UUID().uuidString
    var content: String
    var isCurrentUser: Bool
    var reaction: ReactionType?
}
