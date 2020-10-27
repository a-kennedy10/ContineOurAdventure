//
//  PromptTableViewCell.swift
//  CoA
//
//  Created by Alex Kennedy on 10/26/20.
//  Copyright © 2020 Alex Kennedy. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    // MARK: - outlets
    @IBOutlet weak var postTitleLabel: UILabel!
    
    // MARK: - properties
    var post: Post? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - helper functions
    func updateViews() {
        guard let post = post else { return }
        postTitleLabel.text = post.title
        self.backgroundColor = UIColor(named: "pageColor")
        
    }

}
