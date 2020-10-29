//
//  User.swift
//  CoA
//
//  Created by Alex Kennedy on 10/28/20.
//  Copyright © 2020 Alex Kennedy. All rights reserved.
//

import Foundation
import CloudKit

struct UserStrings {
    static let usernameKey = "username"
    static let appleUserReferenceKey = "appleUserReference"
    static let recordTypeKey = "User"
}

class User {
    var username: String
    var recordID: CKRecord.ID
    var appleUserReference: CKRecord.Reference
    
    init(username: String, recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString), appleUserReference: CKRecord.Reference) {
        self.username = username
        self.recordID = recordID
        self.appleUserReference = appleUserReference
    }
}

// MARK: - extensions
extension User {
    convenience init?(ckRecord: CKRecord) {
        guard let username = ckRecord[UserStrings.usernameKey] as? String,
            let appleUserReference = ckRecord[UserStrings.appleUserReferenceKey] as? CKRecord.Reference
            else { return nil }
        self.init(username: username, recordID: ckRecord.recordID, appleUserReference: appleUserReference)
    }
}

extension CKRecord {
    convenience init(user: User) {
        self.init(recordType: UserStrings.recordTypeKey, recordID: user.recordID)
        setValuesForKeys([
            UserStrings.usernameKey : user.username,
            UserStrings.appleUserReferenceKey : user.appleUserReference
        ])
    }
}
