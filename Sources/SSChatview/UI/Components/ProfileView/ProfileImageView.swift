//
//  SwiftUIView.swift
//  SSChatview
//
//  Created by Palak Doshi on 29/07/24.
//

import SwiftUI

// MARK: - ProfileImageView
/// Displays a profile image with a tap gesture to view profile details, and optionally shows a cancel button for selection.
struct ProfileImageView: View {

    // MARK: - Variables
    var userName: String
    var userProfileImage: String
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
                Image.ssImage(userProfileImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())

                HStack(alignment: .center, spacing: 2) {
                    Text(userName)
                        .foregroundColor(config.colors.textColor)
                        .font(config.fonts.regular)
                    Image.ssImage(config.images.arrow)
                        .font(config.fonts.small)
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
                        .font(config.fonts.regular)
                })
                .padding(.trailing, 16)
                .padding(.bottom, 10)
            }
        }
        .frame(maxWidth: .infinity)
    }
}
