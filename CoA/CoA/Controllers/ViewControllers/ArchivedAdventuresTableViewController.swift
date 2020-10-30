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
    
    func fetchArchivedAdventures() {
        
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0 // return only adventures with the isArchived = true property
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "archiveCell", for: indexPath)

        // Configure the cell...

        return cell
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}
