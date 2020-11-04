//
//  AdventureCreationViewController.swift
//  CoA
//
//  Created by Alex Kennedy on 10/26/20.
//  Copyright © 2020 Alex Kennedy. All rights reserved.
//

import UIKit
import CloudKit

class AdventureCreationViewController: UIViewController, UITextViewDelegate {
    
    // MARK: - outlets
    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var adventureTextView: UITextView!
    @IBOutlet weak var currentWordCountLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    var post: Post?
    
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - actions
    @IBAction func saveAdventureButtonTapped(_ sender: Any) {
        presentConfirmSaveController()
        self.tabBarController?.selectedIndex = 0 // change to pop to title screen
        
    }
    @IBAction func infoButtonTapped(_ sender: Any) {
        presentGuideAlertController()
    }
    
    
    // MARK: - helper functions
    func updateViews() {
        promptLabel.text = "\(post!.title)"
        adventureTextView.backgroundColor = UIColor(named: "pageColor")
        adventureTextView.layer.borderWidth = CGFloat(2)
        saveButton.layer.borderWidth = CGFloat(2)
        self.view.backgroundColor = UIColor(named: "pageColor")
        adventureTextView.text = ""
        currentWordCountLabel.text = "Word Count: 0/250"
        adventureTextView.delegate = self
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        self.currentWordCountLabel.text = "\(countWords(text: textView.text))/250"
        return true
    }
    
    func countWords(text: String) -> Int {
        let components = text.components(separatedBy: .whitespacesAndNewlines)
        let words = components.filter { !$0.isEmpty }
        return words.count
    }
    
    func presentGuideAlertController() {
        let guideAlertController = UIAlertController(title: "Thank you for choosing to Start An Adventure!", message: "Please use the writing prompt that you selected to Start An Adventure. Upon saving, your Adventure will be available for other users to continue.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in }
        guideAlertController.addAction(okAction)
        present(guideAlertController, animated: true)
    }
    
    func presentConfirmSaveController() {
        let confirmAlertController = UIAlertController(title: "Confirm", message: "Would you like to save your Adventure?", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Save", style: .default) { (_) in
            guard !self.adventureTextView.text.isEmpty else { return }
            
            guard let title = self.promptLabel.text,
                let text = self.adventureTextView.text else { return }
            
            AdventureController.shared.createAdventureWith(title: title, text: text, entryCounter: 1) { (adventure) in }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
        }
        confirmAlertController.addAction(confirmAction)
        confirmAlertController.addAction(cancelAction)
        present(confirmAlertController, animated: true)
    }
    
    
    
}
