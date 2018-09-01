//
//  CellPresentableModel.swift
//  SKILL_TEST
//
//  Created by Кирилл Чуянов on 01.09.2018.
//  Copyright © 2018 Kirill Chuyanov. All rights reserved.
//

import UIKit

protocol CellPresentableModel {
    static var nib: UINib { get }
    static var cellIdentifier: String { get }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
}

extension CellPresentableModel {
    static var nib: UINib {
        return UINib(nibName: cellIdentifier, bundle: nil)
    }
}

extension UITableView {
    func registerNib(of modelType: CellPresentableModel.Type) {
        register(modelType.nib, forCellReuseIdentifier: modelType.cellIdentifier)
    }
}
