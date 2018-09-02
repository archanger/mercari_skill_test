//
//  MessageEntity.swift
//  SKILL_TEST
//
//  Created by Кирилл Чуянов on 02.09.2018.
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
