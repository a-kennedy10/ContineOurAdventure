//
//  ContinueAdventureViewController.swift
//  CoA
//
//  Created by Alex Kennedy on 10/29/20.
//  Copyright © 2020 Alex Kennedy. All rights reserved.
//

import UIKit

class ContinueAdventureViewController: UIViewController, UITextViewDelegate {

    // MARK: - outlets
    @IBOutlet weak var adventureTitleLabel: UILabel!
    @IBOutlet weak var continueAdventureTextView: UITextView!
    @IBOutlet weak var maximumWordCountLabel: UILabel!
    
    var adventures: [Adventure] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AdventureController.shared.fetchAdventure { (Adventure) in }
        self.view.backgroundColor = UIColor(named: "pageColor")
        continueAdventureTextView.text = ""
        maximumWordCountLabel.text = "Word Count: 0/250"
        continueAdventureTextView.delegate = self
    }
    
    // MARK: - actions
    @IBAction func saveAdventureButtonTapped(_ sender: Any) {
        
    
        self.tabBarController?.selectedIndex = 0
        // pop back to title screen
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        self.maximumWordCountLabel.text = "\(countWords(text: textView.text))/250"
        return true
    }
    
    func countWords(text: String) -> Int {
        let components = text.components(separatedBy: .whitespacesAndNewlines)
        let words = components.filter { !$0.isEmpty }
        return words.count
    }
    

}
