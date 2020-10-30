//
//  ContinueAdventureViewController.swift
//  CoA
//
//  Created by Alex Kennedy on 10/29/20.
//  Copyright © 2020 Alex Kennedy. All rights reserved.
//

import UIKit

class ContinueAdventureViewController: UIViewController {

    // MARK: - outlets
    @IBOutlet weak var adventureTitleLabel: UILabel!
    @IBOutlet weak var continueAdventureTextView: UITextView!
    @IBOutlet weak var maximumWordCountLabel: UIStackView!
    @IBOutlet weak var currentWordCountLabel: UILabel!
    
    var adventures: [Adventure] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AdventureController.shared.fetchAdventure { (Adventure) in }
        self.view.backgroundColor = UIColor(named: "pageColor")
    }
    
    // MARK: - actions
    @IBAction func saveAdventureButtonTapped(_ sender: Any) {
        // save
        // pop back to title screen
    }
    
    

}


//new custom cell
