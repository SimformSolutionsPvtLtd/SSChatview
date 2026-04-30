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
/// Tracks scroll position and distinguishes user vs. programmatic scrolling.
///
/// ### Key Features:
/// - Scroll to bottom or a specific `scrollID`
/// - Auto-scroll when keyboard appears or height changes
/// - Disables manual scrolling when needed
/// - Gesture-based keyboard dismissal
/// - Reacts to dynamic height changes (e.g., expanding input field)
/// - Bottom scroll detection with `onBottomStateChanged` callback
///
/// Example:
/// ```swift
/// CustomScrollView(scrollToBottom: $scrollToBottom,
///                  isScrollDisabled: $isScrollLocked,
///                  scrollID: $activeScrollTarget,
///                  onBottomStateChanged: { isAtBottom in
///                      // Handle bottom state
///                  }) {
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
    @State var onBottomStateChanged: (Bool) -> Void
    @State private var contentHeight: CGFloat = 0
    @State private var userManuallyScrolled = false
    @State private var programmaticScroll = false
    @State private var lastKeyboardHeight: CGFloat = 0
    @State private var textfieldHeight: CGFloat = 0

    @ViewBuilder let content: Content

    // MARK: - Environment
    @Environment(\.ssChatConfig) private var config
    @Environment(\.verticalSizeClass) private var verticalSizeClass

    private var isPortrait: Bool {
        verticalSizeClass == .regular
    }

    private var visibleContentHeight: CGFloat {
        AppConstants.screenHeight
        - AppConstants.profileViewHeight(isPortrait: isPortrait)
        - AppConstants.chatInputHeight
    }
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

                VStack(spacing: 0) {
                    content // Display the content passed to the scroll view
                    GeometryReader { proxy in
                        // Capture the content height using bottom marker
                        let contentHeight = proxy.frame(in: .named(ScrollID.scrollAreaID.rawValue)).maxY
                        Color.clear.preference(key: ScrollViewContentHeightPreferenceKey.self, value: contentHeight)
                    }
                    .frame(height: 0) // prevents affecting layout
                }

            }
            .scrollDisabled(isScrollDisabled || !scrollID.isEmpty)
            .coordinateSpace(name: ScrollID.scrollAreaID.rawValue) // Set coordinate space for tracking
            .onChange(of: scrollToBottom) {
                if scrollToBottom {
                    programmaticScroll = true
                    scrollView.scrollTo(ScrollID.bottomID.rawValue, anchor: .bottom)
                    scrollToBottom = false
                    userManuallyScrolled = false
                }
            }
            .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
                DispatchQueue.main.async {
                    handleScrollChange(value: value, scrollView: scrollView)
                }
            }
            .onPreferenceChange(ScrollViewContentHeightPreferenceKey.self) { height in
                self.contentHeight = height ?? 0
                if userManuallyScrolled {
                    evaluateScrollPosition()
                } else {
                    onBottomStateChanged(true)
                }
            }
            .onReceive(keyboardWillChangePublisher, perform: { keyboardVisible in
                isKeyboardVisible = keyboardVisible
                guard scrollID.isEmpty else {
                    if keyboardVisible {
                        withAnimation {
                            scrollToDisplayScrollID(scrollView: scrollView)
                        }
                    }
                    return
                }
                handleKeyboardVisibilityChange(visible: keyboardVisible)
            })
            .onReceive(HeightChangePublisher.heightChangePublisher) { height in
                textfieldHeight = height
                if isKeyboardVisible && !scrollID.isEmpty {
                    withAnimation {
                        scrollToDisplayScrollID(scrollView: scrollView)
                    }
                }
            }
            .onReceive(keyboardHeightPublisher) { currentKeyboardHeight in
                handleKeyboardHeightChange(currentKeyboardHeight, scrollView: scrollView)
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

        let totalBottomInset = lastKeyboardHeight + textfieldHeight + 30

        if totalBottomInset > visibleContentHeight {
            withAnimation(.easeInOut(duration: 0.3)) {
                scrollView.scrollTo(scrollID, anchor: .bottom) // Reveal message hidden by keyboard
            }
        }
    }
}

// MARK: - Keyboard Handling
extension CustomScrollView {
    /// Handles visibility changes of the keyboard
    private func handleKeyboardVisibilityChange(visible: Bool) {
        isKeyboardVisible = visible
        scrollToBottom = true
        if visible {
            isKeyboardTriggeredScroll = true
        }
    }

    /// Handles significant keyboard height changes and triggers scroll to the latest visible message.
    private func handleKeyboardHeightChange(_ currentHeight: CGFloat, scrollView: ScrollViewProxy) {
        let heightChangedSignificantly = abs(currentHeight - lastKeyboardHeight) > 30
        guard heightChangedSignificantly else { return }

        lastKeyboardHeight = currentHeight
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            scrollToDisplayScrollID(scrollView: scrollView)
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

            userManuallyScrolled = true

            // Dismiss keyboard on fast scroll or when reaching top of scroll view
            if (abs(scrollSpeed) > AppConstants.CustomScrollView.scrollSpeedThreshold || offsetValue == 0) && isKeyboardVisible {
                isKeyboardVisible = false
                dismissKeyboard()
            }
        }
    }

    private func evaluateScrollPosition() {
        let currentVisibleHeight = abs(scrollOffset) + visibleContentHeight
        let distanceFromBottom = contentHeight - currentVisibleHeight

        let isAtBottom = distanceFromBottom <= 20
        if programmaticScroll {
            programmaticScroll = false
            onBottomStateChanged(true)
            return
        } else {
            onBottomStateChanged(isAtBottom)
        }
    }
}
