//
//  Color+Extension.swift
//  SSChatView
//
//  Created by Palak Doshi on 05/09/24.
//

import SwiftUI
import RswiftResources

// MARK: - ColorResource Extension
extension RswiftResources.ColorResource {

    func getColor() -> Color {
        Color(self)
    }
}
