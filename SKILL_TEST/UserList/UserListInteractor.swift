//
//  UserListInteractor.swift
//  SKILL_TEST
//
//  Created by Кирилл Чуянов on 01.09.2018.
//  Copyright © 2018 Kirill Chuyanov. All rights reserved.
//

import Foundation

protocol UserListInteractorProtocol {
    func loadData()
}

final class UserListInteractor {
    
    var presenter: UserListPresenterProtocol?
    
    private let userService: UserServiceProtocol
    
    init(userService: UserServiceProtocol) {
        self.userService = userService
    }
}

extension UserListInteractor: UserListInteractorProtocol {
    func loadData() {
        userService.getUsers(startingFrom: nil) { [weak self] result in
            switch result {
            case .success(let users):
                self?.handleSuccess(users)
            case .failure(let error):
                self?.handleFailure(error)
            }
        }
    }
    
    private func handleSuccess(_ users: [UserEntity]) {
        presenter?.dataLoaded(users: users)
    }
    
    private func handleFailure(_ failure: ResponseError) {
        switch failure {
        case .limitHasReached(let limitError):
            presenter?.loadFailed(limitError)
        case .somethingWentWrong(let error):
            presenter?.loadFailed(error)
        }
    }
}
