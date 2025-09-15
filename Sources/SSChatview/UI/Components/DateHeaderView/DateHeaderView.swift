//
//  DateHeaderView.swift
//  SSChatview
//
//  Created by Palak Doshi on 19/11/24.
//

import SwiftUI

// MARK: - DateHeaderView
/// A view that displays a centered, styled date header used in chat message groups.
public struct DateHeaderView: View {

    // MARK: - Variables
    var dateString: String

    // MARK: - init
    public init(date: Date) {
        self.dateString = DateFormatter.formatMessageDate(date)
    }

    // MARK: - Body
    public var body: some View {
        VStack(alignment: .center) {
            Text(dateString)
                .foregroundColor(.gray)
        }
    }
}
