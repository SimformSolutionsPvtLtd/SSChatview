//
//  ChatShadowModifier.swift
//  SSChatview
//
//  Created by Palak Doshi on 04/05/25.
//

import SwiftUI

/// Configuration for shadow styling.
struct ShadowStyle {

    // MARK: - variables
    var backgroundColor: UIColor = .systemBackground
    var cornerRadius: CGFloat = 16
    var shadowRadius: CGFloat = 10
    var shadowOffsetY: CGFloat = 12
}

/// A reusable view modifier for applying a soft shadow card effect.
struct ChatShadowModifier: ViewModifier {

    // MARK: - Environment
    @Environment(\.ssChatConfig) private var config

    // MARK: - Variable
    private let style: ShadowStyle

    // MARK: - init
    init(style: ShadowStyle = ShadowStyle()) {
        self.style = style
    }

    // MARK: - Body
    func body(content: Content) -> some View {
        content
            .background(Color(uiColor: style.backgroundColor))
            .cornerRadius(style.cornerRadius)
            .shadow(color: .black.opacity(0.1), radius: style.shadowRadius, y: style.shadowOffsetY)
            .overlay(
                RoundedRectangle(cornerRadius: style.cornerRadius)
                    .stroke(Color(config.colors.primaryBorder), lineWidth: 0.5)
            )
    }
}
