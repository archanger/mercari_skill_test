//
//  ChatService.swift
//  SKILL_TEST
//
//  Created by Кирилл Чуянов on 01.09.2018.
//  Copyright © 2018 Kirill Chuyanov. All rights reserved.
//

import Foundation

class MessageEntity {
    let id: Int
    let date: Date
    let text: String
    
    init(id: Int, date: Date, text: String) {
        self.id = id
        self.date = date
        self.text = text
    }
}

protocol ChatServiceProtocol {
    func getMessages(for userId: Int, completion: @escaping ([MessageEntity]) -> Void)
}

final class ChatService {
    
    private static var RFC3339DateFormatter: DateFormatter = {
        let RFC3339DateFormatter = DateFormatter()
        RFC3339DateFormatter.locale = Locale(identifier: "en_US_POSIX")
        RFC3339DateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        RFC3339DateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return RFC3339DateFormatter
    }()
    
    func getMessages(for userId: Int, completion: @escaping ([MessageEntity]) -> Void) {
        let messages = [
            MessageEntity(id: 0, date: ChatService.RFC3339DateFormatter.date(from: "2018-09-01T16:39:57+04:00")!, text: "HI"),
            MessageEntity(id: userId, date: ChatService.RFC3339DateFormatter.date(from: "2018-09-01T16:40:57+04:00")!, text: "Hi!"),
            MessageEntity(id: 0, date: ChatService.RFC3339DateFormatter.date(from: "2018-09-01T16:41:57+04:00")!, text: "How's it going?"),
            MessageEntity(id: userId, date: ChatService.RFC3339DateFormatter.date(from: "2018-09-01T16:42:18+04:00")!, text: "good, u?"),
        ]
        
        completion(messages)
    }
    
}

extension ChatService: ChatServiceProtocol { }
