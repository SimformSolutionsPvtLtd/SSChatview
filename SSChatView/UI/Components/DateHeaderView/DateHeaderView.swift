//
//  DateHeaderView.swift
//  SSChatView
//
//  Created by Palak Doshi on 19/11/24.
//

import SwiftUI

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
