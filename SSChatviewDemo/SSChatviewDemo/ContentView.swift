//
//  ContentView.swift
//  SSChatview
//
//  Created by Palak Doshi on 13/07/23.
//

import SwiftUI
import SSChatview

// MARK: - ContentView
/// ContentView: Main view displaying chat interface with simulated message actions.
struct ContentView: View {

    // MARK: - Variables
    @StateObject private var viewModel = ChatViewModel()
    @State private var activeTimer: Timer? = nil

    // MARK: - Chat Configuration
    private var chatConfig: SSChatConfiguration {
        SSChatConfiguration(
            colors: CustomColorPalette(),
            fonts: CustomFontScheme(),
            strings: CustomStrings(),
            images: CustomImageAssets()
        )
    }
}

// MARK: - Body
extension ContentView {
    var body: some View {
        VStack {
            // Displays chat UI with user details, message list, and view model as delegate for actions.
            SSChatScreenView(
                delegate: viewModel,
                messageArray: $viewModel.messageArray,
                userName: userName,
                userProfileImage: appImage.userProfileImage.name
            )
            .environment(\.ssChatConfig, chatConfig) // Injects custom chat config via environment.
            .onAppear {
                startEvent(eventType: .add, interval: 20) // Start simulating add-message event every 20 seconds
            }
            .onDisappear {
                stopEvent() // Stop chat events.
            }
        }
    }
}

// MARK: - Methods
extension ContentView {

    /// Stops and clears the active timer if running.
    func stopEvent() {
        activeTimer?.invalidate()
        activeTimer = nil
    }

    /// Starts a new timer for a specific chat event, cancelling any previous timer.
    func startEvent(eventType: ChatEventType, interval: TimeInterval) {
        stopEvent() // Ensure only one timer runs at a time

        activeTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
            viewModel.handleEvent(eventType)
        }
    }
}
