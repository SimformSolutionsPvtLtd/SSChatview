//
//  MessageBubble.swift
//  SSChatView
//
//  Created by Palak Doshi on 03/03/24.
//

import SwiftUI

struct MessageBubble: Shape {
    // MARK: - Variable
    var myMessage: Bool
}

// MARK: - Body
extension MessageBubble {
    /// Generates the path for the message bubble based on its properties.
    ///
    /// - Parameters:
    ///   - rect: The bounding rectangle for the path.
    /// - Returns: The generated path.
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        let cornerRadius: CGFloat = 20 // Adjust this value as needed

        let bezierPath = UIBezierPath()
        if !myMessage {
            /// Bottom-left rounded corner
            bezierPath.move(to: CGPoint(x: cornerRadius, y: height)) // Move to the starting point of the bezier path at the bottom-left corner with a rounded edge
            bezierPath.addLine(to: CGPoint(x: width - 15, y: height)) // Add a horizontal line to the right, leaving space for the arrow
            bezierPath.addCurve(to: CGPoint(x: width, y: height - 15), controlPoint1: CGPoint(x: width - 8, y: height), controlPoint2: CGPoint(x: width, y: height - 8)) // Add a curve to create the rounded corner at the bottom-right of the bubble

            /// Top-right rounded corner
            bezierPath.addLine(to: CGPoint(x: width, y: 15)) // Add a vertical line to the top-right corner
            bezierPath.addCurve(to: CGPoint(x: width - 15, y: 0), controlPoint1: CGPoint(x: width, y: 8), controlPoint2: CGPoint(x: width - 8, y: 0)) // Add a curve to create the rounded corner at the top-right of the bubble

            /// Top-left rounded corner
            bezierPath.addLine(to: CGPoint(x: cornerRadius, y: 0)) // Add a horizontal line to the top-left corner
            bezierPath.addCurve(to: CGPoint(x: 5, y: 15), controlPoint1: CGPoint(x: 12, y: 0), controlPoint2: CGPoint(x: 5, y: 8)) // Add a curve to create the rounded corner at the top-left of the bubble

            /// Arrow
            bezierPath.addLine(to: CGPoint(x: 5, y: height - 10)) // Add a vertical line down to create the arrow part of the bubble
            bezierPath.addCurve(to: CGPoint(x: 0, y: height), controlPoint1: CGPoint(x: 5, y: height - 1), controlPoint2: CGPoint(x: 0, y: height)) // Add a curve to create the bottom part of the arrow
            bezierPath.addLine(to: CGPoint(x: -1, y: height)) // Add a line back up to close the arrow shape
            bezierPath.addCurve(to: CGPoint(x: 12, y: height - 4), controlPoint1: CGPoint(x: 4, y: height + 1), controlPoint2: CGPoint(x: 8, y: height - 1)) // Add a curve to smooth out the bottom part of the bubble near the arrow
            bezierPath.addCurve(to: CGPoint(x: cornerRadius, y: height), controlPoint1: CGPoint(x: 15, y: height), controlPoint2: CGPoint(x: cornerRadius, y: height)) // Add a curve to close the bubble with a rounded bottom-left corner
        } else {
            /// Bottom-right rounded corner
            bezierPath.move(to: CGPoint(x: width - cornerRadius, y: height)) // Move to the starting point of the bezier path at the bottom-right corner with a rounded edge
            bezierPath.addLine(to: CGPoint(x: 15, y: height)) // Add a horizontal line to the left, leaving space for the arrow
            bezierPath.addCurve(to: CGPoint(x: 0, y: height - 15), controlPoint1: CGPoint(x: 8, y: height), controlPoint2: CGPoint(x: 0, y: height - 8)) // Add a curve to create the rounded corner at the bottom-left of the bubble

            /// Top-left rounded corner
            bezierPath.addLine(to: CGPoint(x: 0, y: 15)) // Add a vertical line to the top-left corner
            bezierPath.addCurve(to: CGPoint(x: 15, y: 0), controlPoint1: CGPoint(x: 0, y: 8), controlPoint2: CGPoint(x: 8, y: 0)) // Add a curve to create the rounded corner at the top-left of the bubble

            /// Top-right rounded corner
            bezierPath.addLine(to: CGPoint(x: width - 20, y: 0)) // Add a horizontal line to the top-right corner, leaving space for the arrow
            bezierPath.addCurve(to: CGPoint(x: width - 5, y: 15), controlPoint1: CGPoint(x: width - 12, y: 0), controlPoint2: CGPoint(x: width - 5, y: 8)) // Add a curve to create the rounded corner at the top-right of the bubble

            /// Arrow
            bezierPath.addLine(to: CGPoint(x: width - 5, y: height - 12)) // Add a vertical line down to create the arrow part of the bubble
            bezierPath.addCurve(to: CGPoint(x: width, y: height), controlPoint1: CGPoint(x: width - 5, y: height - 1), controlPoint2: CGPoint(x: width, y: height)) // Add a curve to create the bottom part of the arrow
            bezierPath.addLine(to: CGPoint(x: width + 1, y: height)) // Add a line back up to close the arrow shape
            bezierPath.addCurve(to: CGPoint(x: width - 12, y: height - 4), controlPoint1: CGPoint(x: width - 4, y: height + 1), controlPoint2: CGPoint(x: width - 8, y: height - 1)) // Add a curve to smooth out the bottom part of the bubble near the arrow
            bezierPath.addCurve(to: CGPoint(x: width - cornerRadius, y: height), controlPoint1: CGPoint(x: width - 15, y: height), controlPoint2: CGPoint(x: width - cornerRadius, y: height)) // Add a curve to close the bubble with a rounded bottom-right corner
        }
        return Path(bezierPath.cgPath)
    }
}
