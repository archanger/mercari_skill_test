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
    func showMessage(_ title: String?, body: String)
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
        
        //TODO: Refactor to custom cell
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "UserListCell")
        
    }
}

extension UserListViewController: UserListViewProtocol {
    func reloadData() {
        tableview.reloadData()
    }
    
    func showMessage(_ title: String?, body: String) {
        let alert = UIAlertController(title: title, message: body, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { _ in
            self.interactor?.loadData()
        }))
        present(alert, animated: true, completion: nil)
    }
}
