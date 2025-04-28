//
//  HeightTrackingModifier.swift
//  SSChatview
//
//  Created by Palak Doshi on 15/11/24.
//

import SwiftUI

// MARK: - HeightTracking Modifier
/// A view modifier that tracks the height of a view using GeometryReader.
struct HeightTrackingModifier: ViewModifier {

    // MARK: - Variables
    @Binding var height: CGFloat

    // MARK: - Body
    func body(content: Content) -> some View {
        content
            .background(GeometryReader { geometry in
                Color.clear
                    .onAppear {
                        self.height = geometry.size.height
                    }
                    .onChange(of: geometry.size.height) { _, newHeight in
                        if newHeight != self.height {  // Prevent unnecessary updates
                            self.height = newHeight
                        }
                    }
            })
    }
}

// MARK: - View Extension
/// Extension for View to add functionality for tracking and updating its height using a custom modifier.
extension View {
    // Custom modifier to track height of the view
    func trackHeight(_ height: Binding<CGFloat>) -> some View {
        self.modifier(HeightTrackingModifier(height: height))
    }
}
