//
//  UserService.swift
//  SKILL_TEST
//
//  Created by Кирилл Чуянов on 01.09.2018.
//  Copyright © 2018 Kirill Chuyanov. All rights reserved.
//

import Foundation

protocol UserServiceProtocol {
    func getUsers(startingFrom lastUserId: Int?, completion: @escaping (Result<[UserEntity], ResponseError>) -> Void)
}

//TODO: Shoud inject somekind of network provider
final class UserService {
    
}

extension UserService: UserServiceProtocol {
    func getUsers(startingFrom lastUserId: Int?, completion: @escaping (Result<[UserEntity], ResponseError>) -> Void) {
        let entrypoint = "https://api.github.com/users"
        var urlComponents = URLComponents(string: entrypoint)
        if let lastUserId = lastUserId {
            urlComponents?.queryItems = [URLQueryItem(name: "since", value: "\(lastUserId)")]
        }
        
        guard
            let url = urlComponents?.url
        else {
            completion(.failure(.somethingWentWrong("Incorrect Entrypoint")))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                error == nil,
                let data = data
            else {
                completion(.failure(.somethingWentWrong(error?.localizedDescription ?? "")))
                return
            }
            if let httpUrlResponse = response as? HTTPURLResponse {
                let remainingRateLimit = httpUrlResponse.allHeaderFields["X-RateLimit-Remaining"]
                let responseCode = httpUrlResponse.statusCode
                //TODO: Test limmits
            }
            
            do {
                let users = try JSONDecoder().decode([UserEntity].self, from: data)
                completion(.success(users))
            } catch {
                completion(.failure(.somethingWentWrong(error.localizedDescription)))
            }
        }.resume()
    }
    
}
