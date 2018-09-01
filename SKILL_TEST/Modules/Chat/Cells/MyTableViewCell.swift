//
//  MyTableViewCell.swift
//  SKILL_TEST
//
//  Created by Кирилл Чуянов on 01.09.2018.
//  Copyright © 2018 Kirill Chuyanov. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet private var messageText: UILabel!
    
    func setText(_ text: String) {
        messageText.text = text
    }
}
