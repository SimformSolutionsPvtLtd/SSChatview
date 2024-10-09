//
//  MessageActionView.swift
//  SSChatView
//
//  Created by Palak Doshi on 05/09/24.
//

import SwiftUI

// MARK: - MessageActionView
struct MessageActionView: View {

    // MARK: - Variable
    var onDeleteTapped: () -> Void

    // MARK: - Body
    var body: some View {
        HStack {
            Button(action: {
                onDeleteTapped()
            }, label: {
                Image(systemName: SystemImage.deleteIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
            })
            .padding(.vertical)

            Spacer()

            Button(action: {
                // TODO: Implement Forward Action
            }, label: {
                Image(systemName: SystemImage.forwardIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
            })
            .padding(.vertical)
        }
        .frame(maxWidth: .infinity, maxHeight: 50)
        .padding(.horizontal, 16)
        .padding(.bottom, 6)
        .background(SystemColors.primaryBackground)
    }
}
