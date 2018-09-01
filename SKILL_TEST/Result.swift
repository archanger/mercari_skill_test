//
//  Result.swift
//  SKILL_TEST
//
//  Created by Кирилл Чуянов on 01.09.2018.
//  Copyright © 2018 Kirill Chuyanov. All rights reserved.
//

import Foundation

enum Result<TSuccess, TFailure> {
    case success(TSuccess)
    case failure(TFailure)
}
