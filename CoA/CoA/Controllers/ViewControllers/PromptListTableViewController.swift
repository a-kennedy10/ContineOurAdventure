//
//  PostListTableViewController.swift
//  CoA
//
//  Created by Alex Kennedy on 10/26/20.
//  Copyright © 2020 Alex Kennedy. All rights reserved.
//

import UIKit
import CloudKit

class PromptListTableViewController: UITableViewController {

    // MARK: - properties
    var posts: [Post] = []

    
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPosts()
        self.view.backgroundColor = UIColor(named: "pageColor")
        
    }

    
    // MARK: - helper functions
    func fetchPosts() {
        PostController.fetchPosts { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let posts):
                    self.posts = posts
                    self.tableView.reloadData()
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
            
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "promptCell", for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
        let post = posts[indexPath.row]
        cell.post = post
        return cell
    }
    
  
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAdventureCreationVC" {
            let destinationVC = segue.destination as! AdventureCreationViewController
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let post = posts[indexPath.row]
            destinationVC.post = post
        }
    }
   
}
