//
//  MessageActionView.swift
//  SSChatview
//
//  Created by Palak Doshi on 05/09/24.
//

import SwiftUI

// MARK: - MessageActionView
/// A view that provides action buttons (Delete, Forward) for message management in a chat interface.
struct MessageActionView: View {

    // MARK: - Variables
    var onDeleteTapped: () -> Void
    var showForwardButton: Bool = false

    // MARK: - Environment
    @Environment(\.ssChatConfig) private var config

    // MARK: - Computed Properties
    private var btnDelete: some View {
        Button(action: {
            onDeleteTapped()
        }, label: {
            Image.ssImage(config.images.delete)
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
        })
        .padding(.vertical)
    }

    private var btnForward: some View {
        Button(action: {
            // TODO: Implement Forward Action
        }, label: {
            Image.ssImage(config.images.forward)
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
        })
        .padding(.vertical)
        .disabled(true)
    }

    // MARK: - Body
    var body: some View {
        HStack {
            btnDelete
            Spacer()
            if showForwardButton {
                btnForward
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 50)
        .padding(.horizontal, 16)
        .padding(.bottom, 6)
        .background(config.colors.primaryBackground)
    }
}
