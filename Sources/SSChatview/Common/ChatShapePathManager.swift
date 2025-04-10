//
//  ChatShapePathManager.swift
//  SSChatview
//
//  Created by Palak Doshi on 29/09/24.
//

import SwiftUI

// MARK: - ChatShapePathManager
struct ChatShapePathManager: Shape {

    // MARK: - Variable
    var isFromCurrentUser: Bool

    // MARK: - Body
    func path(in rect: CGRect) -> Path {
        let bezierPath = UIBezierPath()
        addBubblePath(to: bezierPath, rect: rect)
        return Path(bezierPath.cgPath)
    }

    /// Adds a common bubble path to the given bezier path.
    /// - Parameters:
    ///   - bezierPath: The UIBezierPath to add the bubble shape to.
    ///   - rect: The bounding rectangle of the shape.
    private func addBubblePath(to bezierPath: UIBezierPath, rect: CGRect) {
        let width = rect.width
        let height = rect.height
        let cornerRadius: CGFloat = 20

        // Update the logic to check if the message is from the current user
        bezierPath.move(to: CGPoint(x: isFromCurrentUser ? width - cornerRadius : cornerRadius, y: height))
        bezierPath.addLine(to: CGPoint(x: isFromCurrentUser ? 15 : width - 15, y: height))
        bezierPath.addCurve(to: CGPoint(x: isFromCurrentUser ? 0 : width, y: height - 15),
                            controlPoint1: CGPoint(x: isFromCurrentUser ? 8 : width - 8, y: height),
                            controlPoint2: CGPoint(x: isFromCurrentUser ? 0 : width, y: height - 8))

        bezierPath.addLine(to: CGPoint(x: isFromCurrentUser ? 0 : width, y: 15))
        bezierPath.addCurve(to: CGPoint(x: isFromCurrentUser ? 15 : width - 15, y: 0),
                            controlPoint1: CGPoint(x: isFromCurrentUser ? 0 : width, y: 8),
                            controlPoint2: CGPoint(x: isFromCurrentUser ? 8 : width - 8, y: 0))

        bezierPath.addLine(to: CGPoint(x: isFromCurrentUser ? width - 20 : cornerRadius, y: 0))
        bezierPath.addCurve(to: CGPoint(x: isFromCurrentUser ? width - 5 : 5, y: 15),
                            controlPoint1: CGPoint(x: isFromCurrentUser ? width - 12 : 12, y: 0),
                            controlPoint2: CGPoint(x: isFromCurrentUser ? width - 5 : 5, y: 8))

        addArrow(to: bezierPath, width: width, height: height, cornerRadius: cornerRadius)
    }

    /// Adds an arrow to the bubble shape path.
    /// - Parameters:
    ///   - bezierPath: The UIBezierPath to add the arrow to.
    ///   - width: The width of the shape.
    ///   - height: The height of the shape.
    ///   - cornerRadius: The corner radius of the shape.
    private func addArrow(to bezierPath: UIBezierPath,
                          width: CGFloat,
                          height: CGFloat,
                          cornerRadius: CGFloat) {
        if isFromCurrentUser {
            bezierPath.addLine(to: CGPoint(x: width - 5, y: height - 10))
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
        } else {
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
    }
}
