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
    
    var adventures: [Adventure?] = []
    
    // MARK: - public database
    let publicDB = CKContainer.default().publicCloudDatabase
    
    // MARK: - CRUD
    func createAdventureWith(title: String, text: String, timestamp: Date = Date(), isArchived: Bool = false, entryCounter: Int, completion: @escaping (Result<Adventure?, AdventureError>) -> Void) {
        let adventure = Adventure(title: title, text: text, timestamp: timestamp, isArchived: isArchived, entryCounter: entryCounter)
        self.adventures.append(adventure)
        let record = CKRecord(adventure: adventure)
        
        publicDB.save(record) { (record, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                return completion(.failure(.ckError(error)))
            }
            guard let record = record, let adventure = Adventure(ckRecord: record) else { return completion(.failure(.noData)) }
            completion(.success(adventure))
        }
    }
    
    func fetchAdventure(completion: @escaping (Result<[Adventure]?, AdventureError>) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: AdventureStrings.recordTypekey, predicate: predicate)
        
        publicDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                return completion(.failure(.ckError(error)))
            }
            guard let records = records else { return completion(.failure(.noData)) }
            let adventures = records.compactMap{ Adventure(ckRecord: $0) }
            self.adventures = adventures
            completion(.success(adventures))
        }
    }
    
    func saveAdventure(with title: String, text: String, date: Date, entryCounter: Int, isArchived: Bool, completion: @escaping (Result<Adventure?, AdventureError >) -> Void) {
        let adventure = Adventure(title: title, text: text, isArchived: isArchived, entryCounter: entryCounter)
        self.adventures.append(adventure)
        let record = CKRecord(adventure: adventure)
        
        publicDB.save(record) { (record, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                return completion(.failure(.ckError(error)))
            }
            guard let record = record, let adventure = Adventure(ckRecord: record) else { return completion(.failure(.noData)) }
            completion(.success(adventure))
        }
        
        if adventure.entryCounter >= 10 {
            adventure.isArchived = true
        } else {
            adventure.entryCounter += 1
        }
        
    }
    
    func incrementEntryCount(with adventure: Adventure) {
        adventure.entryCounter += 1
        if adventure.entryCounter >= 10 {
            adventure.isArchived = true
        }
    }
    
}
