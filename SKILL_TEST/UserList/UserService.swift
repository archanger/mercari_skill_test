//
//  UserService.swift
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

final class UserService {
    
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
