//
//  NoMessageView.swift
//  SSChatView
//
//  Created by Palak Doshi on 29/04/24.
//

import SwiftUI

struct NoMessageView: View {

    // MARK: - Body
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: SystemImage.messageIcon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .foregroundColor(.gray)
            Text(MessageViewConstants.noMessagesText)
                .font(.semiBoldFont(size: SystemFontSize.mediumFontSize))
                .foregroundColor(SystemColors.textColor)
            Text(MessageViewConstants.messagesDesc)
                .font(.regularFont(size: SystemFontSize.smallFontSize))
                .foregroundColor(.gray)
                .padding(.horizontal, 50)
                .multilineTextAlignment(.center)
        }
    }
}
