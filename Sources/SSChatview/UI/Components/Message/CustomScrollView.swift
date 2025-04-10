//
//  CustomScrollView.swift
//  SSChatview
//
//  Created by Palak Doshi on 24/10/24.
//

import SwiftUI

// MARK: - CustomScrollView
/// A scroll view tailored for chat-style UIs with smart keyboard and scroll behavior.
///
/// `CustomScrollView` manages content offset, responds to keyboard events, and supports
/// programmatic scrolling to a specific view ID. It handles layout adjustments when the
/// keyboard appears and provides gesture-based keyboard dismissal when scrolling fast.
///
/// ### Key Features:
/// - Scroll to bottom or a specific `scrollID`
/// - Auto-scroll when keyboard appears
/// - Disables manual scrolling when needed
/// - Gesture-based keyboard dismissal
/// - Reacts to dynamic height changes (e.g., input field resizing)
///
/// Example:
/// ```swift
/// CustomScrollView(scrollToBottom: $scrollToBottom,
///                  isScrollDisabled: $isScrollLocked,
///                  scrollID: $activeScrollTarget) {
///     ForEach(messages) { message in
///         MessageCell(message: message)
///             .id(message.id)
///     }
///     Spacer().id(ScrollID.bottomID.rawValue)
/// }
/// ```
struct CustomScrollView<Content: View>: View, KeyboardReadable {

    // MARK: - Variables
    @Binding var scrollToBottom: Bool
    @Binding var isScrollDisabled: Bool
    @Binding var scrollID: String

    @State private var scrollOffset: CGFloat = 0
    @State private var isKeyboardVisible = false
    @State private var isKeyboardTriggeredScroll = false
    @State private var lastScrollOffset: CGFloat = 0

    @ViewBuilder let content: Content

    // MARK: - Environment
    @Environment(\.ssChatConfig) private var config
}

// MARK: - Body
extension CustomScrollView {
    var body: some View {
        ScrollViewReader { scrollView in
            ScrollView {
                GeometryReader { proxy in
                    // Track the scroll offset using GeometryReader
                    let offset = proxy.frame(in: .named(ScrollID.scrollAreaID.rawValue)).minY
                    Color.clear.preference(key: ScrollViewOffsetPreferenceKey.self, value: offset)
                }

                content // Display the content passed to the scroll view
            }
            .scrollDisabled(isScrollDisabled || !scrollID.isEmpty)
            .coordinateSpace(name: ScrollID.scrollAreaID.rawValue) // Set coordinate space for tracking
            .onChange(of: scrollToBottom) {
                if scrollToBottom {
                    scrollView.scrollTo(ScrollID.bottomID.rawValue, anchor: .bottom)
                    scrollToBottom = false
                }
            }
            .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
                DispatchQueue.main.async {
                    handleScrollChange(value: value, scrollView: scrollView)
                }
            }
            .onReceive(keyboardWillChangePublisher, perform: { keyboardVisible in
                isKeyboardVisible = keyboardVisible
                if keyboardVisible && !scrollID.isEmpty {
                    withAnimation {
                        scrollToDisplayScrollID(scrollView: scrollView)
                    }
                }
            })
            .onReceive(keyboardDidChangePublisher) { keyboardVisible in
                guard scrollID.isEmpty else { return }
                DispatchQueue.main.async {
                    handleKeyboardVisibilityChange(visible: keyboardVisible)
                }
            }
            .onReceive(HeightChangePublisher.heightChangePublisher) { _ in
                if isKeyboardVisible && !scrollID.isEmpty {
                    withAnimation {
                        scrollToDisplayScrollID(scrollView: scrollView)
                    }
                }
            }
        }
        .onAppear {
            isKeyboardTriggeredScroll = false
        }
    }
}

// MARK: - scroll To Display ScrollID
extension CustomScrollView {
    /// Scrolls to the expanded text field, ensuring it’s visible above the keyboard
    private func scrollToDisplayScrollID(scrollView: ScrollViewProxy) {
        scrollView.scrollTo(scrollID, anchor: .bottom)
    }
}

// MARK: - Keyboard Handling
extension CustomScrollView {
    /// Handles visibility changes of the keyboard
    private func handleKeyboardVisibilityChange(visible: Bool) {
        isKeyboardVisible = visible
        if visible {
            scrollToBottom = true  // Trigger scroll to bottom when the keyboard is shown
            isKeyboardTriggeredScroll = true
        }
    }
}

// MARK: - Scroll Handling
extension CustomScrollView {
    /// Handles scroll changes by analyzing the offset and scrolling behavior
    private func handleScrollChange(value: CGFloat?, scrollView: ScrollViewProxy) {
        DispatchQueue.main.async {
            guard scrollID.isEmpty else { return }
            let offsetValue = value ?? 0
            let scrollSpeed = offsetValue - lastScrollOffset
            lastScrollOffset = offsetValue

            // Skip manual scroll handling if triggered by keyboard visibility change
            if isKeyboardTriggeredScroll {
                isKeyboardTriggeredScroll = false
                return
            }

            // Dismiss keyboard on fast scroll or when reaching top of scroll view
            if (scrollSpeed > 50 || offsetValue == 0) && isKeyboardVisible {
                isKeyboardVisible = false
                dismissKeyboard()
            }
        }
    }
}
