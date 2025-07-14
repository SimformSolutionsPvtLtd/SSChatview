//
//  SSProfileImageView.swift
//  SSChatview
//
//  Created by Palak Doshi on 07/07/25.
//

import SwiftUI

/// A profile image view that supports:
/// - Remote image URLs (http/https)
/// - Local assets and SF Symbols via `Image.ssImage`
///
/// Falls back to a system placeholder if loading fails.
struct SSProfileImageView: View {

    // MARK: - Variable
    let name: String?

    // MARK: - Body
    var body: some View {
        if let name, let url = URL(string: name), url.scheme?.hasPrefix("http") == true {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable()
                case .failure:
                    Image(systemName: "questionmark.circle.fill").resizable()
                @unknown default:
                    EmptyView()
                }
            }
        } else {
            Image.ssImage(name)
                .resizable()
        }
    }
}
