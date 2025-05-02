//
//  ChatMessagesData.swift
//  SSChatviewDemo
//
//  Created by Palak Doshi on 29/04/25.
//

import Foundation
import SSChatview

// MARK: - ChatMessagesData
/// Contains initial dummy messages used to populate the chat screen for testing and preview purposes.
struct ChatMessagesData {

    static let initialMessages: [MessageResponseModel] = [
        MessageResponseModel(
            content: appString.helloText(),
            isCurrentUser: false,
            reaction: nil,
            timestamp: Date(timeIntervalSince1970: 1724824260) // 28 Aug 2024 at 11:21 AM
        ),
        MessageResponseModel(
            content: appString.helloReplyText(),
            isCurrentUser: true,
            reaction: .love,
            timestamp: Date(timeIntervalSince1970: 1734358860) // 16 Dec 2024 at 19:51 PM
        ),
        MessageResponseModel(
            content: appString.helloText(),
            isCurrentUser: false,
            reaction: nil,
            timestamp: Date(timeIntervalSince1970: 1735718640) // 1 Jan 2025 at 13:34 PM
        ),
        MessageResponseModel(
            content: appString.helloReplyText(),
            isCurrentUser: true,
            reaction: .love,
            timestamp: Date(timeIntervalSince1970: 1735718640) // 1 Jan 2025 at 1:34 PM
        ),
        MessageResponseModel(
            content: appString.helloText(),
            isCurrentUser: false,
            reaction: .like,
            timestamp: Date(timeIntervalSince1970: 1735731440) // 1 Jan 2025 at 17:07 PM
        ),
        MessageResponseModel(
            content: appString.helloText(),
            isCurrentUser: false,
            reaction: nil,
            timestamp: Date(timeIntervalSince1970: 1738573920) // Mon, 3 Feb at 14:42 PM
        ),
        MessageResponseModel(
            content: appString.helloText(),
            isCurrentUser: true,
            reaction: nil,
            timestamp: Date(timeIntervalSince1970: 1742059260) // Sat, 15 Mar at 22:51 PM
        ),
        MessageResponseModel(
            content: appString.helloText(),
            isCurrentUser: false,
            reaction: .like,
            timestamp: Date(timeIntervalSince1970: 1742061900) // Sat, 15 Mar at 23:35 PM
        ),
        MessageResponseModel(
            content: appString.helloText(),
            isCurrentUser: true,
            reaction: nil,
            timestamp: Date(timeIntervalSince1970: 1742066160) // Sat, 16 Mar at 12:46 AM
        ),
        MessageResponseModel(
            content: appString.helloText(),
            isCurrentUser: false,
            reaction: nil,
            timestamp: Date(timeIntervalSince1970: 1742077140) // Sat, 16 Mar at 03:49 AM
        ),
        MessageResponseModel(
            content: appString.helloReplyText(),
            isCurrentUser: true,
            reaction: .love,
            timestamp: Date(timeIntervalSince1970: 1743926400) // Sun, 6 Apr at 13:30 PM
        ),
        MessageResponseModel(
            content: appString.helloText(),
            isCurrentUser: false,
            reaction: .like,
            timestamp: Date(timeIntervalSince1970: 1743926976) // Sun, 6 Apr at 13:39 PM
        ),
        MessageResponseModel(
            content: appString.longLoremText1(),
            isCurrentUser: false,
            reaction: .like,
            timestamp: Date(timeIntervalSince1970: 1743928020) // Sun, 6 Apr at 13:57 PM
        ),
        MessageResponseModel(
            content: appString.longLoremText1(),
            isCurrentUser: true,
            reaction: .like,
            timestamp: Date(timeIntervalSince1970: 1744461960) // Sat, 12 Apr at 18:16 PM
        ),
        MessageResponseModel(
            content: appString.singleNumberText2(),
            isCurrentUser: false,
            reaction: nil,
            editedMessages: [
                appString.editedNumberText2_1(),
                appString.editedNumberText2_2()
            ],
            timestamp: Date(timeIntervalSince1970: 1744463700) // Sat, 12 Apr at 18:45 PM
        ),
        MessageResponseModel(
            content: appString.shortLoremText1(),
            isCurrentUser: false,
            reaction: .like,
            timestamp: Date(timeIntervalSince1970: 1744464300) // Sat, 12 Apr at 18:55 PM
        ),
        MessageResponseModel(
            content: appString.singleNumberText3(),
            isCurrentUser: false,
            reaction: .like,
            editedMessages: [
                appString.editedNumberText3_1(),
                appString.editedNumberText3_2(),
                appString.editedNumberText3_3()
            ],
            timestamp: Date(timeIntervalSince1970: 1744716523) // Tue, 15 Apr at 16:58 PM
        ),
        MessageResponseModel(
            content: appString.shortLoremText2(),
            isCurrentUser: true,
            reaction: .like,
            timestamp: .randomPastDateThisWeek() // Random Past Date This Week
        ),
        MessageResponseModel(
            content: appString.mediumLoremText(),
            isCurrentUser: false,
            reaction: .like,
            timestamp: .randomPastTimeToday() // Random Past Time Today
        )
    ]
}
