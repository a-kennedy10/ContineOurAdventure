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
    @IBOutlet weak var maxWordCountLabel: UILabel!
    
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "pageColor")
        updateViews()
        
    }
    
    var post: Post?
    
    // MARK: - actions
    @IBAction func saveAdventureButtonTapped(_ sender: Any) {
        presentConfirmSaveController()
        
        // pop back to title screen?
        
    }
    @IBAction func infoButtonTapped(_ sender: Any) {
        presentGuideAlertController()
    }
    
    
    // MARK: - helper functions
    func updateViews() {
        promptLabel.text = "\(post!.title)"
        adventureTextView.text = "Begin your Adventure here..."
        adventureTextView.textColor = UIColor.lightGray
        adventureTextView.backgroundColor = UIColor(named: "pageColor")
        adventureTextView.layer.borderWidth = CGFloat(3)
    }
    
    func checkMaxLength(adventureTextView: UITextView, maxLength: Int) {
        if (adventureTextView.text.count > 250) {
            adventureTextView.deleteBackward()
        }
    }
    
    func wordCount() {
        maxWordCountLabel.text = "\(adventureTextView.text.count)"
    }
    
    func presentGuideAlertController() {
        let guideAlertController = UIAlertController(title: "Thank you for choosing to Start An Adventure!", message: "Please use the prompt that you chose to Start An Adventure. Upon saving, your Adventure will be available for other users to continue.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
        }
        guideAlertController.addAction(okAction)
        present(guideAlertController, animated: true)
    }
    
    func presentConfirmSaveController() {
        let confirmAlertController = UIAlertController(title: "Confirm", message: "Would you like to save your Adventure?", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Save", style: .default) { (_) in
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
        }
        confirmAlertController.addAction(confirmAction)
        confirmAlertController.addAction(cancelAction)
        present(confirmAlertController, animated: true)
    }
    
    
    
}
