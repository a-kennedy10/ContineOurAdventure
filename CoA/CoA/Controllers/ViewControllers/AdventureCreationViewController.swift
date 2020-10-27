//
//  AdventureCreationViewController.swift
//  CoA
//
//  Created by Alex Kennedy on 10/26/20.
//  Copyright © 2020 Alex Kennedy. All rights reserved.
//

import UIKit

class AdventureCreationViewController: UIViewController {

    // MARK: - properties
    
    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var adventureTextView: UITextView!
    
    
    var post: Post? {
        didSet{
            self.view.backgroundColor = UIColor(named: "pageColor")
            updateViews()
        }
    }
    
    
    @IBAction func saveAdventureButtonTapped(_ sender: Any) {
    }
    @IBAction func infoButtonTapped(_ sender: Any) {
    }
    
    func updateViews() {
        promptLabel.text = "\(post!.title)"
        adventureTextView.text = "Begin your adventure here..."
    }
    
    
    
    
    
}
