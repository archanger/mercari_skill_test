//
//  UserListFactory.swift
//  SKILL_TEST
//
//  Created by Кирилл Чуянов on 01.09.2018.
//  Copyright © 2018 Kirill Chuyanov. All rights reserved.
//

import UIKit

final class UserListFactory {
    
    func create() -> UIViewController {
        
        let viewController = UserListViewController()
        let service = UserService()
        let interactor = UserListInteractor(userService: service)
        let presenter = UserListPresenter(router: UserListRouter())
        
        viewController.interactor = interactor
        viewController.source = presenter
        interactor.presenter = presenter
        presenter.view = viewController
        
        return viewController
    }
    
}
