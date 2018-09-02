//
//  ChatViewController.swift
//  SKILL_TEST
//
//  Created by Кирилл Чуянов on 01.09.2018.
//  Copyright © 2018 Kirill Chuyanov. All rights reserved.
//

import UIKit

protocol ChatViewSource: UITableViewDelegate, UITableViewDataSource { }

protocol ChatViewProtocol: class {
    func setTitle(_ title: String)
    func reloadData()
    func insert(indexes: [IndexPath])
    func registerModels(_ models: [CellPresentableModel.Type])
}

protocol ChatViewConfigurer: class {
    func readyToConfigure()
}

class ChatViewController: UIViewController {

    weak var configurator: ChatViewConfigurer?
    weak var source: ChatViewSource? {
        didSet {
            if tableView != nil {
                tableView.dataSource = source
                tableView.delegate = source
            }
        }
    }
    var interactor: ChatInteractorProtocol?
    
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var textField: UITextField!
    private var fetchedMessages: [MessageEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        tableView.dataSource = source
        tableView.delegate = source
        
        tableView.separatorStyle = .none
        
        configurator?.readyToConfigure()
        interactor?.loadData()
    }
    
    @IBAction private func send(_ sender: UIButton) {
        if let message = textField.text {
            interactor?.sendMessage(message)
            textField.text = nil
        }
    }
}

extension ChatViewController: ChatViewProtocol {
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func insert(indexes: [IndexPath]) {
        tableView.beginUpdates()
        tableView.insertRows(at: indexes, with: .bottom)
        tableView.endUpdates()
        
        if let lastPath = indexes.last {
            tableView.scrollToRow(at: lastPath, at: .bottom, animated: true)
        }
    }
    
    func registerModels(_ models: [CellPresentableModel.Type]) {
        models.forEach { self.tableView.registerNib(of: $0.self) }
    }
}
