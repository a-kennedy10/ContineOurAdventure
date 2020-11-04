//
//  ContinueAdventureTableViewCell.swift
//  CoA
//
//  Created by Alex Kennedy on 10/30/20.
//  Copyright © 2020 Alex Kennedy. All rights reserved.
//

import UIKit

class ContinueAdventureTableViewCell: UITableViewCell {

    var adventure: Adventure? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        self.backgroundColor = UIColor(named: "pageColor")
    }

}
