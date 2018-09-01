//
//  Errors.swift
//  SKILL_TEST
//
//  Created by Кирилл Чуянов on 01.09.2018.
//  Copyright © 2018 Kirill Chuyanov. All rights reserved.
//

import Foundation

struct LimitError {
    let message: String
    let documentationURL: String
}

extension LimitError: Decodable {
    private enum CodingKeys: String, CodingKey {
        case message
        case documentation_url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        message = try container.decode(String.self, forKey: .message)
        documentationURL = try container.decode(String.self, forKey: .documentation_url)
    }
}

enum ResponseError: Error {
    case somethingWentWrong(String)
    case limitHasReached(LimitError)
}
