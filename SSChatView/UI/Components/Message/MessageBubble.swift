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
        let cornerRadius: CGFloat = 20

        let bezierPath = UIBezierPath()
        if !myMessage {
            addLeftPath(to: bezierPath, width: width, height: height, cornerRadius: cornerRadius)
        } else {
            addRightPath(to: bezierPath, width: width, height: height, cornerRadius: cornerRadius)
        }
        return Path(bezierPath.cgPath)
    }

    private func addLeftPath(to bezierPath: UIBezierPath, width: CGFloat, height: CGFloat, cornerRadius: CGFloat) {
        // Bottom-left rounded corner
        bezierPath.move(to: CGPoint(x: cornerRadius, y: height))
        bezierPath.addLine(to: CGPoint(x: width - 15, y: height))
        bezierPath.addCurve(to: CGPoint(x: width, y: height - 15),
                            controlPoint1: CGPoint(x: width - 8, y: height),
                            controlPoint2: CGPoint(x: width, y: height - 8))

        // Top-right rounded corner
        bezierPath.addLine(to: CGPoint(x: width, y: 15))
        bezierPath.addCurve(to: CGPoint(x: width - 15, y: 0),
                            controlPoint1: CGPoint(x: width, y: 8),
                            controlPoint2: CGPoint(x: width - 8, y: 0))

        // Top-left rounded corner
        bezierPath.addLine(to: CGPoint(x: cornerRadius, y: 0))
        bezierPath.addCurve(to: CGPoint(x: 5, y: 15),
                            controlPoint1: CGPoint(x: 12, y: 0),
                            controlPoint2: CGPoint(x: 5, y: 8))

        // Arrow
        bezierPath.addLine(to: CGPoint(x: 5, y: height - 10))
        bezierPath.addCurve(to: CGPoint(x: 0, y: height),
                            controlPoint1: CGPoint(x: 5, y: height - 1),
                            controlPoint2: CGPoint(x: 0, y: height))
        bezierPath.addLine(to: CGPoint(x: -1, y: height))
        bezierPath.addCurve(to: CGPoint(x: 12, y: height - 4),
                            controlPoint1: CGPoint(x: 4, y: height + 1),
                            controlPoint2: CGPoint(x: 8, y: height - 1))
        bezierPath.addCurve(to: CGPoint(x: cornerRadius, y: height),
                            controlPoint1: CGPoint(x: 15, y: height),
                            controlPoint2: CGPoint(x: cornerRadius, y: height))
    }

    private func addRightPath(to bezierPath: UIBezierPath, width: CGFloat, height: CGFloat, cornerRadius: CGFloat) {
        // Bottom-right rounded corner
        bezierPath.move(to: CGPoint(x: width - cornerRadius, y: height))
        bezierPath.addLine(to: CGPoint(x: 15, y: height))
        bezierPath.addCurve(to: CGPoint(x: 0, y: height - 15),
                            controlPoint1: CGPoint(x: 8, y: height),
                            controlPoint2: CGPoint(x: 0, y: height - 8))

        // Top-left rounded corner
        bezierPath.addLine(to: CGPoint(x: 0, y: 15))
        bezierPath.addCurve(to: CGPoint(x: 15, y: 0),
                            controlPoint1: CGPoint(x: 0, y: 8),
                            controlPoint2: CGPoint(x: 8, y: 0))

        // Top-right rounded corner
        bezierPath.addLine(to: CGPoint(x: width - 20, y: 0))
        bezierPath.addCurve(to: CGPoint(x: width - 5, y: 15),
                            controlPoint1: CGPoint(x: width - 12, y: 0),
                            controlPoint2: CGPoint(x: width - 5, y: 8))

        // Arrow
        bezierPath.addLine(to: CGPoint(x: width - 5, y: height - 12))
        bezierPath.addCurve(to: CGPoint(x: width, y: height),
                            controlPoint1: CGPoint(x: width - 5, y: height - 1),
                            controlPoint2: CGPoint(x: width, y: height))
        bezierPath.addLine(to: CGPoint(x: width + 1, y: height))
        bezierPath.addCurve(to: CGPoint(x: width - 12, y: height - 4),
                            controlPoint1: CGPoint(x: width - 4, y: height + 1),
                            controlPoint2: CGPoint(x: width - 8, y: height - 1))
        bezierPath.addCurve(to: CGPoint(x: width - cornerRadius, y: height),
                            controlPoint1: CGPoint(x: width - 15, y: height),
                            controlPoint2: CGPoint(x: width - cornerRadius, y: height))
    }
}
