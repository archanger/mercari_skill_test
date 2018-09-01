//
//  ChatViewController.swift
//  SKILL_TEST
//
//  Created by Кирилл Чуянов on 01.09.2018.
//  Copyright © 2018 Kirill Chuyanov. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    private var chatService = ChatService()
    private var fetchedMessages: [MessageEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.separatorStyle = .none
        
        tableView.registerNib(of: MyTableViewCell.Model.self)
        tableView.registerNib(of: OtherTableViewCell.Model.self)
        
        chatService.getMessages(for: 2) { messages in
            self.fetchedMessages = messages
            self.tableView.reloadData()
        }
    }
}

extension ChatViewController: UITableViewDelegate {
    
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = fetchedMessages[indexPath.row]
        if message.isMine {
            let model = MyTableViewCell.Model(message: message.text)
            return model.tableView(tableView, cellForRowAt: indexPath)
        } else {
            let model = OtherTableViewCell.Model(message: message.text)
            return model.tableView(tableView, cellForRowAt: indexPath)
        }
    }
}

extension MessageEntity {
    var isMine: Bool {
        return id == 0
    }
}
