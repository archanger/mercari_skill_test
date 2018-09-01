//
//  OtherTableViewCell+Model.swift
//  SKILL_TEST
//
//  Created by Кирилл Чуянов on 01.09.2018.
//  Copyright © 2018 Kirill Chuyanov. All rights reserved.
//

import UIKit

extension OtherTableViewCell {
    class Model: BaseMessageModel { }
}

extension OtherTableViewCell.Model: CellPresentableModel {
    static var cellIdentifier: String = "OtherTableViewCell"
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: self).cellIdentifier, for: indexPath) as! OtherTableViewCell
        cell.setText(message)
        return cell
    }
}
