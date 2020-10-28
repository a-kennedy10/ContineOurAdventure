//
//  AdventureController.swift
//  CoA
//
//  Created by Alex Kennedy on 10/26/20.
//  Copyright © 2020 Alex Kennedy. All rights reserved.
//

import Foundation
import CloudKit

class AdventureController {
    
    // MARK: - shared instance
    static let shared = AdventureController()
    
    // MARK: - public database
    let publicDB = CKContainer.default().publicCloudDatabase
    
    
    func createAdventureWith(text: String, username: String, timestamp: Date = Date(), completion: @escaping (Result<Adventure?, AdventureError>) -> Void) {
        let adventure = Adventure(text: text, username: username, timestamp: timestamp)
        
    }
    
    
}
