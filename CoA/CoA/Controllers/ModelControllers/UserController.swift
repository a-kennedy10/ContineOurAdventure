//
//  UserController.swift
//  CoA
//
//  Created by Alex Kennedy on 11/4/20.
//  Copyright © 2020 Alex Kennedy. All rights reserved.
//

import UIKit
import CloudKit

class UserController {
    
    // shared instance
    static let shared = UserController()
    
    // source of truth
    var currentUser: User?
    
    //public database
    let publicDB = CKContainer.default().publicCloudDatabase
    
    func createUser(username: String, completion: @escaping (Result<Bool, AdventureError>) -> Void) {
        fetchAppleUserReference { (result) in
            switch result {
            case .success(let reference):
                let user = User(username: username, appleUserReference: reference)
                let userRecord = CKRecord(user: user)
                self.publicDB.save(userRecord) { (record, error) in
                    if let error = error {
                        print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                        return completion(.failure(.ckError(error)))
                    }
                    guard let record = record, let savedUser = User(ckRecord: record) else { completion(.failure(.noData))
                        return
                    }
                    self.currentUser = savedUser
                    completion(.success(true))
                
                }
            case .failure(let error):
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                return completion(.failure(.ckError(error)))
            }
        }
        
    }
    
    func fetchUser(completion: @escaping (Result<Bool, AdventureError>) -> Void) {
        fetchAppleUserReference { (result) in
            switch result {
            case .success(let reference):
                let predicate = NSPredicate(format: "%K == %@", argumentArray: [UserStrings.appleUserReferenceKey, reference])
                let query = CKQuery(recordType: UserStrings.recordTypeKey, predicate: predicate)
                self.publicDB.perform(query, inZoneWith: nil) { (records, error) in
                    if let error = error {
                        print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                    }
                    guard let record = records?.first,
                        let fetchedUser = User(ckRecord: record) else {
                        completion(.failure(.noData))
                        return
                    }
                    self.currentUser = fetchedUser
                    print("Successfully fetched user with ID: \(fetchedUser.recordID)")
                    completion(.success(true))
                }
            case .failure(let error):
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion(.failure(.ckError(error)))
            }
        }
    }
    
    
    func fetchAppleUserReference(completion: @escaping (Result<CKRecord.Reference, AdventureError>) -> Void) {
        CKContainer.default().fetchUserRecordID { (recordID, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion(.failure(.ckError(error)))
            }
            guard let recordID = recordID else { return completion(.failure(.unableToDecode)) }
            let reference = CKRecord.Reference(recordID: recordID, action: .deleteSelf)
            completion(.success(reference))
        }
    }
    
    
    
    
    
}
