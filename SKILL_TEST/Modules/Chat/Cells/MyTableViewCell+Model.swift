//
//  MyTableViewCell+Model.swift
//  SKILL_TEST
//
//  Created by Кирилл Чуянов on 01.09.2018.
//  Copyright © 2018 Kirill Chuyanov. All rights reserved.
//

import UIKit

extension MyTableViewCell {
    class Model: BaseMessageModel { }
}

extension MyTableViewCell.Model: CellPresentableModel {
    static var cellIdentifier: String = "MyTableViewCell"
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: self).cellIdentifier, for: indexPath) as! MyTableViewCell
        cell.setText(message)
        return cell
    }
}
