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
    func sendMessage(_ message: String)
}

final class ChatInteractor {
    
    var presenter: ChatPresenterProtocol?
    
    private var chatService: ChatServiceProtocol
    private var buddy: UserEntity
    private var subscription: Subscription!
    
    init(chatService: ChatServiceProtocol, buddy: UserEntity) {
        self.chatService = chatService
        self.buddy = buddy
        
        subscription = chatService.subscribe({ [weak self] (action, payload) in
            switch action {
            case .sended:
                if let message = payload as? MessageEntity {
                    self?.handleSended(message)
                }
            case .allMessageReceived:
                if let messages = payload as? [MessageEntity] {
                    self?.handleReceivedAll(messages)
                }
            }
        })
    }
    
    deinit {
        if (subscription != nil) {
            chatService.removeSubscription(subscription)
        }
    }
    
    private func handleSended(_ message: MessageEntity) {
        presenter?.gotNewMessage(message)
    }
    
    private func handleReceivedAll(_ messages: [MessageEntity]) {
        presenter?.loadedInitialMessages(messages)
    }
}

extension ChatInteractor: ChatInteractorProtocol {
    func loadData() {
        presenter?.loginReceived(buddy.login)
        chatService.getMessages(for: buddy.id)
    }
    
    func sendMessage(_ message: String) {
        chatService.sendMessage(message, to: buddy.id)
    }
}
