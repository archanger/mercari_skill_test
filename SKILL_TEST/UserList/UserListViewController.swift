//
//  UserListViewController.swift
//  SKILL_TEST
//
//  Created by Кирилл Чуянов on 01.09.2018.
//  Copyright © 2018 Kirill Chuyanov. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController {
    @IBOutlet private var tableview: UITableView!
    
    private let userService = UserService()
    private var fetchedUsers = [UserEntity]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Twitter DM"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "UserListCell")
        
        userService.getUsers(startingFrom: nil) { result in
            switch result {
            case .success(let users):
                self.fetchedUsers = users
            case .failure(let error):
                switch error {
                case .limitHasReached(let limitError):
                    print(limitError.message)
                case .somethingWentWrong(let error):
                    print(error)
                }
            }
            DispatchQueue.main.async {            
                self.tableview.reloadData()
            }
        }
    }
}

extension UserListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let entity = fetchedUsers[indexPath.row]
        let cellModel = UserlListCellModel(from: entity)
        return cellModel.tableView(tableView, cellForRowAt: indexPath)
    }
}

extension UserListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
