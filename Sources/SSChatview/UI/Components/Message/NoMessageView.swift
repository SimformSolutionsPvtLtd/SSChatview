//
//  NoMessageView.swift
//  SSChatview
//
//  Created by Palak Doshi on 29/04/24.
//

import SwiftUI

// MARK: - NoMessageView
/// A view displayed when no messages are available, showing an icon and descriptive text.
struct NoMessageView: View {

    // MARK: - Environment
    @Environment(\.ssChatConfig) private var config

    // MARK: - Body
    var body: some View {
        VStack(alignment: .center) {
            Image.ssImage(config.images.message)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .foregroundColor(.gray)
            Text(config.strings.noMessagesText)
                .font(config.fonts.medium)
                .foregroundColor(config.colors.textColor)
            Text(config.strings.messagesDesc)
                .font(config.fonts.small)
                .foregroundColor(.gray)
                .padding(.horizontal, 50)
                .multilineTextAlignment(.center)
        }
    }
}
