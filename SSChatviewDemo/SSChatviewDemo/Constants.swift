//
//  Constants.swift
//  SSChatviewDemo
//
//  Created by Palak Doshi on 15/04/25.
//
import Foundation
import SSChatview

// MARK: - R.swift variables
let appString = R.string.localizable
let appColor = R.color
let appFont = R.font

// MARK: - Constants
enum Constants {
   static let initialMessages: [MessageResponseModel] = [
        // 28 Aug 2023 at 11:21 AM
        MessageResponseModel(
            content: appString.helloText(),
            isCurrentUser: false,
            reaction: nil,
            timestamp: Date(timeIntervalSince1970: 1693201872)
        ),
        // 1 Sep 2023 at 11:44 AM
        MessageResponseModel(
            content: appString.helloReplyText(),
            isCurrentUser: true,
            reaction: .love,
            timestamp: Date(timeIntervalSince1970: 1693548852)
        ),
        // 1 Sep 2023 at 3:37 PM
        MessageResponseModel(
            content: appString.helloText(),
            isCurrentUser: false,
            reaction: .like,
            timestamp: Date(timeIntervalSince1970: 1693562832)
        ),
        // Sun, 29 Sep at 12:52 PM
        MessageResponseModel(
            content: appString.helloText(),
            isCurrentUser: false,
            reaction: nil,
            timestamp: Date(timeIntervalSince1970: 1727594532)
        ),
        // Tue, 15 Oct at 6:31 PM
        MessageResponseModel(
            content: appString.helloText(),
            isCurrentUser: true,
            reaction: nil,
            timestamp: Date(timeIntervalSince1970: 1728997261)
        ),
        // Tue, 15 Oct at 7:15 PM
        MessageResponseModel(
            content: appString.helloText(),
            isCurrentUser: false,
            reaction: .like,
            timestamp: Date(timeIntervalSince1970: 1728999901)
        ),
        // Tue, 15 Oct at 8:26 PM
        MessageResponseModel(
            content: appString.helloText(),
            isCurrentUser: true,
            reaction: nil,
            timestamp: Date(timeIntervalSince1970: 1729004161)
        ),
        // Tue, 15 Oct at 11:59 PM
        MessageResponseModel(
            content: appString.helloText(),
            isCurrentUser: false,
            reaction: nil,
            timestamp: Date(timeIntervalSince1970: 1729016941)
        ),
        // Sun, 3 Nov at 12:00 AM
        MessageResponseModel(
            content: appString.helloReplyText(),
            isCurrentUser: true,
            reaction: .love,
            timestamp: Date(timeIntervalSince1970: 1730572200)
        ),
        // Sun, 3 Nov at 12:16 AM
        MessageResponseModel(
            content: appString.helloText(),
            isCurrentUser: false,
            reaction: .like,
            timestamp: Date(timeIntervalSince1970: 1730573160)
        ),
        // Sun, 3 Nov at 12:47 AM
        MessageResponseModel(
            content: appString.longLoremText1(),
            isCurrentUser: false,
            reaction: .like,
            timestamp: Date(timeIntervalSince1970: 1730575020)
        ),
        // Sun, 3 Nov at 1:26 AM
        MessageResponseModel(
            content: appString.longLoremText1(),
            isCurrentUser: true,
            reaction: .like,
            timestamp: Date(timeIntervalSince1970: 1730577360)
        ),
        // Sun, 3 Nov at 2:05 AM
        MessageResponseModel(
            content: appString.singleNumberText2(),
            isCurrentUser: false,
            reaction: nil,
            editedMessages: [
                appString.editedNumberText2_1(),
                appString.editedNumberText2_2()
            ],
            timestamp: Date(timeIntervalSince1970: 1730579700)
        ),
        // Monday, 9:27 AM
        MessageResponseModel(
            content: appString.shortLoremText1(),
            isCurrentUser: false,
            reaction: .like,
            timestamp: Date(timeIntervalSince1970: 1731902249)
        ),
        // Monday, 4:35 PM
        MessageResponseModel(
            content: appString.singleNumberText3(),
            isCurrentUser: false,
            reaction: .like,
            editedMessages: [
                appString.editedNumberText3_1(),
                appString.editedNumberText3_2(),
                appString.editedNumberText3_3()
            ],
            timestamp: Date(timeIntervalSince1970: 1731927929)
        ),
        // Today, 7:16 AM
        MessageResponseModel(
            content: appString.shortLoremText2(),
            isCurrentUser: true,
            reaction: .like,
            timestamp: Date(timeIntervalSince1970: 1731980789)
        ),
        // Today, 9:27 PM
        MessageResponseModel(
            content: appString.mediumLoremText(),
            isCurrentUser: false,
            reaction: .like,
            timestamp: Date(timeIntervalSince1970: 1731988649)
        )
    ]
}
