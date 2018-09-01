//
//  UserListPresenter.swift
//  SKILL_TEST
//
//  Created by Кирилл Чуянов on 01.09.2018.
//  Copyright © 2018 Kirill Chuyanov. All rights reserved.
//

import UIKit

protocol UserListPresenterProtocol: class {
    func dataLoaded(users: [UserEntity])
    func loadFailed(_ errorMessage: String)
    func loadFailed(_ error: LimitError)
}

final class UserListPresenter: NSObject {
    weak var view: UserListViewProtocol?
    
    private var router: UserListRouterProtocol
    private var fetchedUsers: [UserEntity] = []
    
    init(router: UserListRouterProtocol) {
        self.router = router
    }
}

extension UserListPresenter: UserListViewSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let entity = fetchedUsers[indexPath.row]
        let cellModel = UserlListCellModel(from: entity)
        return cellModel.tableView(tableView, cellForRowAt: indexPath)
    }
}

extension UserListPresenter: UserListPresenterProtocol {
    func dataLoaded(users: [UserEntity]) {
        fetchedUsers = users
        DispatchQueue.main.async {
            self.view?.reloadData()
        }
    }
    
    func loadFailed(_ errorMessage: String) {
        
    }
    
    func loadFailed(_ error: LimitError) {
        
    }
}
