//
//  NoMessageView.swift
//  SSChatview
//
//  Created by Palak Doshi on 29/04/24.
//

import SwiftUI

struct NoMessageView: View {
    // MARK: - Environment
    @Environment(\.ssChatConfig) private var config

    // MARK: - Body
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: config.images.messageIconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .foregroundColor(.gray)
            Text(config.strings.noMessagesText)
                .font(Font(config.fonts.medium))
                .foregroundColor(config.colors.textColor)
            Text(config.strings.messagesDesc)
                .font(Font(config.fonts.small))
                .foregroundColor(.gray)
                .padding(.horizontal, 50)
                .multilineTextAlignment(.center)
        }
    }
}
