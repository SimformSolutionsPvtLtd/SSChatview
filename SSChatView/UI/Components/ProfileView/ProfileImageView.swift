//
//  SwiftUIView.swift
//  SSChatView
//
//  Created by Palak Doshi on 29/07/24.
//

import SwiftUI

struct ProfileImageView: View {
    // MARK: - Variables
    var imageName: String
    @Binding var isPresented: Bool
    @Binding var shouldShowSelectionView: Bool
    var onCancelTap: () -> Void
    var onProfileTap: () -> Void
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
        Text(appString.profileName)
    }
}

// MARK: - profileHeaderView
extension ProfileImageView {
    private var profileHeaderView: some View {
        ZStack(alignment: .trailing) {
            VStack(alignment: .center) {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())

                HStack(alignment: .center, spacing: 2) {
                    Text(appString.profileName)
                        .foregroundColor(SystemColors.textColor)
                        .font(Font.system(size: 12).weight(.medium))
                    Image(systemName: SystemImage.arrowIcon)
                        .font(Font.system(size: 12))
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
                    Text(appString.cancelText())
                        .foregroundColor(.blue)
                        .font(Font.system(size: 18).weight(.medium))
                })
                .padding(.trailing, 16)
                .padding(.bottom, 10)
            }
        }
        .frame(maxWidth: .infinity)
    }
}
