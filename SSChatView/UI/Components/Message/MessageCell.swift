//
//  MessageCell.swift
//  SSChatView
//
//  Created by Palak Doshi on 23/02/24.
//

import SwiftUI

/// SwiftUI View for displaying an individual message cell in the chat.
struct MessageCell: View {
    // MARK: - Variables
    var contentMessage: String
    var isCurrentUser: Bool
}

// MARK: - Body
extension MessageCell {
    // SwiftUI view body for displaying a message cell
    var body: some View {
        Text(contentMessage) // Display the message content
            .padding() // Apply padding around the text
            .foregroundColor(isCurrentUser ? Color.white : SystemColors.textColor) // Set text color based on the sender
            .background(isCurrentUser ? Color.blue : Color(UIColor.systemGray6)) // Set background color based on the sender
            .clipShape(MessageBubble(myMessage: isCurrentUser ? true : false)) // Clip the view into a bubble shape
            .frame(width: UIScreen.main.bounds.width * 0.7, alignment: isCurrentUser ? .trailing : .leading) // Set the frame width to 70% of the screen width and adjust alignment
    }
}
