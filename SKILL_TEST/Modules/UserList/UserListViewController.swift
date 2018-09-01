//
//  UserListViewController.swift
//  SKILL_TEST
//
//  Created by Кирилл Чуянов on 01.09.2018.
//  Copyright © 2018 Kirill Chuyanov. All rights reserved.
//

import UIKit

protocol UserListViewSource: UITableViewDataSource, UITableViewDelegate { }

protocol UserListViewProtocol: class {
    func reloadData()
    func showMessage(_ message: String)
}

class UserListViewController: UIViewController {
    var interactor: UserListInteractorProtocol?
    weak var source: UserListViewSource? {
        didSet {
            if tableview != nil {
                tableview.delegate = source
                tableview.dataSource = source
            }
        }
    }
    
    @IBOutlet private var tableview: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Twitter DM"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableview.dataSource = source
        tableview.delegate = source
        
        interactor?.loadData()
        
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "UserListCell")
        
    }
}

extension UserListViewController: UserListViewProtocol {
    func reloadData() {
        tableview.reloadData()
    }
    
    func showMessage(_ message: String) {
        //TODO: Show alert
    }
}
