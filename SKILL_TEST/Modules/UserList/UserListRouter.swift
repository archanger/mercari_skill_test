//
//  UserListRouter.swift
//  SKILL_TEST
//
//  Created by Кирилл Чуянов on 01.09.2018.
//  Copyright © 2018 Kirill Chuyanov. All rights reserved.
//

import UIKit

protocol UserListRouterProtocol {
    func openChat()
}

final class UserListRouter {
    private var rootViewController: UIViewController
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
}

extension UserListRouter: UserListRouterProtocol {
    func openChat() {
        let viewController = ChatViewController()
        rootViewController.navigationController?.pushViewController(viewController, animated: true)
    }
}
