//
//  ChatService.swift
//  SKILL_TEST
//
//  Created by Кирилл Чуянов on 01.09.2018.
//  Copyright © 2018 Kirill Chuyanov. All rights reserved.
//

import Foundation

typealias Subscription = NSObjectProtocol

protocol ChatServiceProtocol {
    func getMessages(for userId: Int)
    func sendMessage(_ text: String, to userId: Int)
    func subscribe(_ subscription: @escaping (_ action: MessageActions, _ payload: Any) -> Void) -> Subscription
    func removeSubscription(_ subscription: Subscription)
}


fileprivate extension Notification.Name {
    static var messagesChanged: Notification.Name {
        return .init("ChatService.messagesChanged")
    }
}


final class FakeChatService {
    
    private var notificationCenter = NotificationCenter()
    
    func removeSubscription(_ subscription: Subscription) {
        notificationCenter.removeObserver(subscription)
    }
    
    func subscribe(_ subscription: @escaping (_ action: MessageActions, _ payload: Any) -> Void) -> Subscription {
        let subscription = notificationCenter.addObserver(
            forName: .messagesChanged,
            object: nil,
            queue: OperationQueue.main,
            using: { notification in
                if let action = notification.object as AnyObject as? MessageAction {
                    subscription(action.name, action.payload)
                }
            }
        )
        return subscription
    }
    
    private static var RFC3339DateFormatter: DateFormatter = {
        let RFC3339DateFormatter = DateFormatter()
        RFC3339DateFormatter.locale = Locale(identifier: "en_US_POSIX")
        RFC3339DateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        RFC3339DateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return RFC3339DateFormatter
    }()
    
    func getMessages(for userId: Int) {
        let messages = [
            MessageEntity(id: 0, date: FakeChatService.RFC3339DateFormatter.date(from: "2018-09-01T16:39:57+04:00")!, text: "HI"),
            MessageEntity(id: userId, date: FakeChatService.RFC3339DateFormatter.date(from: "2018-09-01T16:40:57+04:00")!, text: "Hi!"),
            MessageEntity(id: 0, date: FakeChatService.RFC3339DateFormatter.date(from: "2018-09-01T16:41:57+04:00")!, text: "How's it going?"),
            MessageEntity(id: userId, date: FakeChatService.RFC3339DateFormatter.date(from: "2018-09-01T16:42:18+04:00")!, text: "good, u?"),
        ]
        
        notificationCenter.post(name: .messagesChanged, object: MessagesReceivedAction(payload: messages))
    }
    
    func sendMessage(_ text: String, to userId: Int) {
        let message = MessageEntity(id: 0, date: Date(), text: text)
        notificationCenter.post(name: .messagesChanged, object: MessagesSendedAction(payload: message))
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            let message = MessageEntity(id: userId, date: Date(), text: "\(text) \(text)")
            self.notificationCenter.post(name: .messagesChanged, object: MessagesSendedAction(payload: message))
        }
    }
    
}

extension FakeChatService: ChatServiceProtocol { }
