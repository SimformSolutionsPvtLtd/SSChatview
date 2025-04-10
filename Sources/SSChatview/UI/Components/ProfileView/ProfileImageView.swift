//
//  SwiftUIView.swift
//  SSChatview
//
//  Created by Palak Doshi on 29/07/24.
//

import SwiftUI

struct ProfileImageView: View {
    // MARK: - Variables
    var imageName: String?
    @Binding var isPresented: Bool
    @Binding var shouldShowSelectionView: Bool
    var onCancelTap: () -> Void
    var onProfileTap: () -> Void

    // MARK: - Environment
    @Environment(\.ssChatConfig) private var config
}

// MARK: - Body
extension ProfileImageView {
    var body: some View {
        HStack {
            Spacer()
            profileHeaderView
            Spacer()
        }
        .background(.ultraThinMaterial)
    }

    // MARK: - Functions
    private func presentProfile() {
        self.isPresented = true
    }

    private var profileSheetContent: some View {
        Text(config.strings.profileName)
    }
}

// MARK: - profileHeaderView
extension ProfileImageView {
    private var profileHeaderView: some View {
        ZStack(alignment: .trailing) {
            VStack(alignment: .center) {
                Image.ssImage(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())

                HStack(alignment: .center, spacing: 2) {
                    Text(config.strings.profileName)
                        .foregroundColor(config.colors.textColor)
                        .font(Font(config.fonts.regular))
                    Image(systemName: config.images.arrowIconName)
                        .font(Font(config.fonts.small))
                        .foregroundColor(.gray)
                }
                .padding(.bottom, 10)
            }
            .onTapGesture {
                onProfileTap()
            }
            .sheet(isPresented: $isPresented) {
                profileSheetContent
            }
            .frame(maxWidth: .infinity)

            if shouldShowSelectionView {
                Button(action: {
                    onCancelTap()
                }, label: {
                    Text(config.strings.cancelText)
                        .foregroundColor(.blue)
                        .font(Font(config.fonts.medium))
                })
                .padding(.trailing, 16)
                .padding(.bottom, 10)
            }
        }
        .frame(maxWidth: .infinity)
    }
}
