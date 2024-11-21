//
//  CustomScrollView.swift
//  SSChatView
//
//  Created by Palak Doshi on 24/10/24.
//
import SwiftUI

struct CustomScrollView<Content: View>: View, KeyboardReadable {

    // MARK: - Variables
    @Binding var scrollToBottom: Bool
    @Binding var isScrollDisabled: Bool

    @State private var scrollOffset: CGFloat = 0
    @State private var isKeyboardVisible = false
    @State private var isKeyboardTriggeredScroll = false
    @State private var lastScrollOffset: CGFloat = 0

    @ViewBuilder let content: Content
}

// MARK: - Body
extension CustomScrollView {
    var body: some View {
        ScrollViewReader { scrollView in
            ScrollView {
                GeometryReader { proxy in
                    // Track the scroll offset using GeometryReader
                    let offset = proxy.frame(in: .named(AppConstants.scrollAreaID)).minY
                    Color.clear.preference(key: ScrollViewOffsetPreferenceKey.self, value: offset)
                }

                content // Display the content passed to the scroll view
            }
            .scrollDisabled(isScrollDisabled)
            .coordinateSpace(name: AppConstants.scrollAreaID) // Set coordinate space for tracking
            .onChange(of: scrollToBottom) { _ in
                if scrollToBottom {
                    scrollView.scrollTo(AppConstants.bottomID, anchor: .bottom)
                    scrollToBottom = false
                }
            }
            .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
                DispatchQueue.main.async {
                    handleScrollChange(value: value, scrollView: scrollView)
                }
            }
        }
        .onReceive(keyboardWillChangePublisher, perform: { keyboardVisible in
            isKeyboardVisible = keyboardVisible
        })
        .onReceive(keyboardDidChangePublisher) { keyboardVisible in
            DispatchQueue.main.async {
                handleKeyboardVisibilityChange(visible: keyboardVisible)
            }
        }
        .onAppear {
            isKeyboardTriggeredScroll = false
        }
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
