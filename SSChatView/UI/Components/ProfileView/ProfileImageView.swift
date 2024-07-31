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
    @State private var isPresented = false
    @Binding var isBlurred: Bool
}

// MARK: - Body
extension ProfileImageView {

    var body: some View {
        HStack {
            Spacer()
            Button(action: presentProfile) {
                profileButtonContent
            }
            .sheet(isPresented: $isPresented) {
                profileSheetContent
            }
            Spacer()
        }
        .background(.ultraThinMaterial)
        .blur(radius: isBlurred ? 10 : 0)
    }

    // MARK: - Functions
    private func presentProfile() {
        self.isPresented = true
    }
}

// MARK: - ProfileButtonContent View
extension ProfileImageView {

    private var profileSheetContent: some View {
        // Content of the modal presentation goes here
        Text(ProfileConstants.profileName)
    }

    var profileButtonContent: some View {
        VStack {
            // Profile Image
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipShape(Circle())

            // Profile Name with Icon
            HStack(alignment: .center, spacing: 2) {
                Text(ProfileConstants.profileName)
                    .foregroundColor(SystemColors.textColor)
                    .font(Font.system(size: 12).weight(.medium))
                + Text(Image(systemName: SystemImage.arrowIcon))
                    .font(Font.system(size: 12))
                    .foregroundColor(.gray)
            }
            .padding(.bottom, 10)
        }
    }
}
