//
//  ContentView.swift
//  SSChatview
//
//  Created by Palak Doshi on 13/07/23.
//

import SwiftUI
import SSChatview

struct ContentView: View {

    // MARK: - Variables
    @State private var isBlurred = false
    @StateObject private var viewModel = ChatScreenViewModel(initialMessages: Constants.initialMessages)
}

// MARK: - Body
extension ContentView {

    var body: some View {
        VStack {
            ChatScreenView(
                isBlurred: $isBlurred,
                initialMessages: Constants.initialMessages
            )
            .ssChatConfig(
                SSChatConfiguration(
                    colors: CustomColorPalette(),
                    fonts: CustomFontScheme(),
                    strings: CustomStrings(),
                    images: CustomImageAssets()
                )
            )
        }
    }
}

// MARK: - ContentView Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
