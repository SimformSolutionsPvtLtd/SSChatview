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
    let userProfileImage: String?
    @Binding var isPresented: Bool
    @Binding var shouldShowSelectionView: Bool
    var onCancelTap: () -> Void
    var onProfileTap: () -> Void

    // MARK: - Environment
    @Environment(\.ssChatConfig) private var config
    @Environment(\.verticalSizeClass) private var verticalSizeClass

    // MARK: - Computed property
    private var displayImage: String {
        if let userProfileImage, !userProfileImage.isEmpty {
            return userProfileImage
        } else {
            return config.images.profileImage
        }
    }

    private var isPortrait: Bool {
        verticalSizeClass == .regular
    }
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
                if isPortrait {
                    Image.ssImage(displayImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                }

                HStack(alignment: .center, spacing: 2) {
                    Text(userName)
                        .foregroundColor(config.colors.textColor)
                        .font(config.fonts.regular)
                    Image.ssImage(config.images.arrow)
                        .font(config.fonts.small)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 4)
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
                .padding(.vertical, 5)
            }
        }
        .frame(maxWidth: .infinity)
    }
}
