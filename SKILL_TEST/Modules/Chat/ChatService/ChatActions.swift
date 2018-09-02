//
//  ChatActions.swift
//  SKILL_TEST
//
//  Created by Кирилл Чуянов on 02.09.2018.
//  Copyright © 2018 Kirill Chuyanov. All rights reserved.
//

import Foundation

enum MessageActions: String {
    case sended
    case allMessageReceived
}

protocol MessageAction {
    var name: MessageActions { get }
    var payload: Any { get }
}

struct MessagesSendedAction: MessageAction {
    var name = MessageActions.sended
    var payload: Any
    
    init(payload: Any) {
        self.payload = payload
    }
}

struct MessagesReceivedAction: MessageAction {
    var name = MessageActions.allMessageReceived
    var payload: Any
    
    init(payload: Any) {
        self.payload = payload
    }
}
