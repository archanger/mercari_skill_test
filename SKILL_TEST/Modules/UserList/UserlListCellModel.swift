//
//  UserlListCellModel.swift
//  SKILL_TEST
//
//  Created by Кирилл Чуянов on 01.09.2018.
//  Copyright © 2018 Kirill Chuyanov. All rights reserved.
//

import UIKit

struct UserlListCellModel {
    let avatarURL: URL?
    let name: String
}

extension UserlListCellModel {
    init(from entity: UserEntity) {
        self.init(
            avatarURL: URL(string: entity.avatarURL),
            name: "@\(entity.login)"
        )
    }
}

extension UserlListCellModel: CellPresentableModel {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserListCell", for: indexPath)
        if let url = avatarURL {
            do {
                cell.imageView?.image = UIImage(data: try Data(contentsOf: url))
            } catch { }
        }
        
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = name
        
        return cell
    }
}
