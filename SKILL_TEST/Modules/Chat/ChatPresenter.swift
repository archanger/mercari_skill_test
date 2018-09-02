//
//  ChatPresenter.swift
//  SKILL_TEST
//
//  Created by Кирилл Чуянов on 01.09.2018.
//  Copyright © 2018 Kirill Chuyanov. All rights reserved.
//

import UIKit

protocol ChatPresenterProtocol {
    func loadedInitialMessages(_ messages: [MessageEntity])
    func gotNewMessage(_ message: MessageEntity)
    func loginReceived(_ userLogin: String)
}

final class ChatPresenter: NSObject {
    weak var view: ChatViewProtocol?
    
    private var fetchedMessages: [MessageEntity] = []
}

extension ChatPresenter: ChatViewConfigurer {
    func readyToConfigure() {
        view?.registerModels([
            MyTableViewCell.Model.self,
            OtherTableViewCell.Model.self
        ])
    }
}

extension ChatPresenter: ChatPresenterProtocol {
    func loadedInitialMessages(_ messages: [MessageEntity]) {
        fetchedMessages = messages
        view?.reloadData()
    }
    
    func loginReceived(_ userLogin: String) {
        view?.setTitle("@\(userLogin)")
    }
    
    func gotNewMessage(_ message: MessageEntity) {
        let newIndexPath = IndexPath(row: fetchedMessages.count, section: 0)
        fetchedMessages.append(message)
        view?.insert(indexes: [newIndexPath])
        
    }
}

extension ChatPresenter: ChatViewSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = fetchedMessages[indexPath.row]
        return message.cellModel.tableView(tableView, cellForRowAt: indexPath)
    }
}

extension MessageEntity {
    private var isMine: Bool {
        return id == 0
    }
    
    var cellModel: CellPresentableModel {
        return isMine ? MyTableViewCell.Model(message: text)
            : OtherTableViewCell.Model(message: text)
    }
}
