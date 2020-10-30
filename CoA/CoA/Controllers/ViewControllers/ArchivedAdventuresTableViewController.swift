//
//  ArchivedAdventuresTableViewController.swift
//  CoA
//
//  Created by Alex Kennedy on 10/29/20.
//  Copyright © 2020 Alex Kennedy. All rights reserved.
//

import UIKit

class ArchivedAdventuresTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var adventures: [Adventure] = []
    
    func fetchArchivedAdventures(with isArchived: Bool = true) {
        
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adventures.count // return only adventures with the isArchived = true property
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "archiveCell", for: indexPath) as? ArchivedAdventureTableViewCell else { return UITableViewCell() }
        let selectedAdventure = adventures[indexPath.row]
        cell.adventure = selectedAdventure
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toArchivedAdventureDetailVC" {
            let destinationVC = segue.destination as! ArchivedAdventureDetailViewController
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let archivedAdventure = adventures[indexPath.row]
            destinationVC.adventure = archivedAdventure
            
        }
        
    }
}
