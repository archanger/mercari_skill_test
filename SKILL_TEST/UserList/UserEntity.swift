//
//  User.swift
//  SKILL_TEST
//
//  Created by Кирилл Чуянов on 01.09.2018.
//  Copyright © 2018 Kirill Chuyanov. All rights reserved.
//

import Foundation

final class UserEntity {
    let id: Int
    let login: String
    let avatarURL: String
    
    init(id: Int, login: String, avatarURL: String) {
        self.id = id
        self.login = login
        self.avatarURL = avatarURL
    }
}

extension UserEntity: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case avatar_url
        case login
    }
    
    convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(Int.self, forKey: .id)
        let avatarUrl = try container.decode(String.self, forKey: .avatar_url)
        let login = try container.decode(String.self, forKey: .login)
        
        self.init(id: id, login: login, avatarURL: avatarUrl)
    }
}
