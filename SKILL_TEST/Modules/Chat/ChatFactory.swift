//
//  ChatFactory.swift
//  SKILL_TEST
//
//  Created by Кирилл Чуянов on 01.09.2018.
//  Copyright © 2018 Kirill Chuyanov. All rights reserved.
//

import UIKit

final class ChatFactory {
    
    func create(with buddy: UserEntity) -> UIViewController {
        
        let viewController = ChatViewController()
        let chatService = FakeChatService()
        let interactor = ChatInteractor(chatService: chatService, buddy: buddy)
        let presenter = ChatPresenter()
        
        viewController.interactor = interactor
        viewController.configurator = presenter
        viewController.source = presenter
        interactor.presenter = presenter
        presenter.view = viewController
        
        return viewController
    }
    
}
