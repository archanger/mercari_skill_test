//
//  ChatInteractor.swift
//  SKILL_TEST
//
//  Created by Кирилл Чуянов on 01.09.2018.
//  Copyright © 2018 Kirill Chuyanov. All rights reserved.
//

import Foundation

protocol ChatInteractorProtocol {
    func loadData()
}

final class ChatInteractor {
    
    var presenter: ChatPresenterProtocol?
    
    private var chatService: ChatServiceProtocol
    private var buddy: UserEntity
    
    init(chatService: ChatServiceProtocol, buddy: UserEntity) {
        self.chatService = chatService
        self.buddy = buddy
    }
    
}

extension ChatInteractor: ChatInteractorProtocol {
    func loadData() {
        presenter?.loginReceived(buddy.login)
        chatService.getMessages(for: buddy.id) { [weak self] messages in
            self?.presenter?.loadedInitialMessages(messages)
        }
    }
}
