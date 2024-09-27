//
//  MoveContentAboveKeyboard.swift
//  SSChatView
//
//  Created by Palak Doshi on 20/09/24.
//

import SwiftUI

// MARK: - View Extension
extension View {
    /// A modifier to move content above the keyboard when it appears.
    func moveContentAboveKeyboard() -> some View {
        self.modifier(MoveContentAboveKeyboard())
    }

    // Function to dismiss the keyboard
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

// MARK: - MoveContentAboveKeyboard Modifier
/// A view modifier that adjusts the content's position when the keyboard appears or disappears.
struct MoveContentAboveKeyboard: ViewModifier {
    // MARK: - State Properties
    /// The vertical offset to adjust the content position based on the keyboard height.
    @State private var keyboardOffset: CGFloat = 0
    /// The duration of the keyboard animation.
    @State private var keyboardAnimationDuration: Double = 0

    // MARK: - Body
    func body(content: Content) -> some View {
        content
            .offset(y: keyboardOffset) // Adjusts content position based on the keyboard offset.
            .onReceive(
                NotificationCenter.default
                    .publisher(for: UIResponder.keyboardWillChangeFrameNotification)
                    .receive(on: RunLoop.main),
                perform: updateKeyboardHeight // Updates the keyboard height on notification.
            )
    }

    // MARK: - Update Keyboard Height
    /// Updates the keyboard height based on its frame changes.
    /// - Parameter notification: The notification containing keyboard frame information.
    func updateKeyboardHeight(_ notification: Notification) {
        guard let info = notification.userInfo,
              let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        else { return }

        // Apply animation when the keyboard frame changes.
        withAnimation(.easeOut(duration: keyboardAnimationDuration)) {
            // Adjust the offset based on whether the keyboard is visible or hidden.
            let isKeyboardHidden = (keyboardFrame.origin.y == UIScreen.main.bounds.height)
            keyboardOffset = isKeyboardHidden ? 0 : -(keyboardFrame.height * 0.01)
        }
    }
}
