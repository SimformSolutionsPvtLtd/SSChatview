//
//  SizeTrackingModifier.swift
//  SSChatview
//
//  Created by Palak Doshi on 15/11/24.
//

import SwiftUI

// MARK: - SizeTrackingModifier
/// A view modifier that tracks the size (width & height) of a view using GeometryReader.
struct SizeTrackingModifier: ViewModifier {

    // MARK: - Variables
    var width: Binding<CGFloat>?
    var height: Binding<CGFloat>?

    // MARK: - Body
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geometry in
                    Color.clear
                        .onAppear {
                            if let width = width {
                                width.wrappedValue = geometry.size.width
                            }
                            if let height = height {
                                height.wrappedValue = geometry.size.height
                            }
                        }
                        .onChange(of: geometry.size) { _, newSize in
                            if let width = width, newSize.width != width.wrappedValue {
                                width.wrappedValue = newSize.width
                            }
                            if let height = height, newSize.height != height.wrappedValue {
                                height.wrappedValue = newSize.height
                            }
                        }
                }
            )
    }
}

// MARK: - View Extension
/// Extension to track width and height of a view.
extension View {
    func trackSize(width: Binding<CGFloat>? = nil, height: Binding<CGFloat>? = nil) -> some View {
        self.modifier(SizeTrackingModifier(width: width, height: height))
    }
}
