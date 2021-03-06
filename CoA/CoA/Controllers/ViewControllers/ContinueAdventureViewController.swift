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
    @IBOutlet weak var saveContinuedAdventureButton: UIButton!
    
//    var adventures: [Adventure] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        AdventureController.shared.fetchAdventureToContinue { (result) in }
    }
    
    // MARK: - actions
    @IBAction func saveAdventureButtonTapped(_ sender: Any) {
        self.tabBarController?.selectedIndex = 0
    
    }
    @IBAction func guideButtonTapped(_ sender: Any) {
        presentGuideAlertController()
    }
    
    // MARK: - helper functions
    func updateViews() {
        continueAdventureTextView.backgroundColor = UIColor(named: "pageColor")
        continueAdventureTextView.layer.borderWidth = CGFloat(2)
        saveContinuedAdventureButton.layer.borderWidth = CGFloat(2)
        self.view.backgroundColor = UIColor(named: "pageColor")
        continueAdventureTextView.text = ""
        maximumWordCountLabel.text = "0/250"
        continueAdventureTextView.delegate = self
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        self.maximumWordCountLabel.text = "Word count: \(countWords(text: textView.text))/250"
        return true
    }
    
    private func presentGuideAlertController() {
        let guideAlertController = UIAlertController(title: "Time to \n Continue An Adventure!", message: "Here you can Continue an Adventure from another user. After 10 contributions, the Adventure will be saved in the archives.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in }
        guideAlertController.addAction(okAction)
        present(guideAlertController, animated: true)
    }
    
    func countWords(text: String) -> Int {
        let components = text.components(separatedBy: .whitespacesAndNewlines)
        let words = components.filter { !$0.isEmpty }
        return words.count
    }
    
    func presentConfirmSaveController(adventure: Adventure?) {
        let confirmAlertController = UIAlertController(title: "Confirm", message: "Would you like to save your Adventure?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
        }
        let confirmAction = UIAlertAction(title: "Save", style: .default) { (_) in
            guard !self.continueAdventureTextView.text.isEmpty else { return }
            if let adventure = adventure {
                if adventure.entryCounter >= 11 {
                    adventure.isArchived = true
                } else {
                    adventure.entryCounter += 1
                }
                AdventureController.shared.update(adventure: adventure) { (result) in
                    switch result {
                    case .success(_):
                        self.tabBarController?.selectedIndex = 0
                    case .failure(let error):
                        print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                    }
                }
            }
        }
        
        confirmAlertController.addAction(confirmAction)
        confirmAlertController.addAction(cancelAction)
        present(confirmAlertController, animated: true)
    }
    

}
