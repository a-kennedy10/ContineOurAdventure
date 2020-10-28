//
//  Adventure.swift
//  CoA
//
//  Created by Alex Kennedy on 10/24/20.
//  Copyright © 2020 Alex Kennedy. All rights reserved.
//

import Foundation
import CloudKit

struct AdventureStrings {
    static let textKey = "text"
    static let usernameKey = "username"
    static let timestampKey = "timestamp"
    static let recordTypekey = "Adventure"
}

class Adventure {
    let text: String
    let username: String
    var timestamp: Date
    let recordID: CKRecord.ID
    
    init(text: String, username: String, timestamp: Date = Date(), recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.text = text
        self.username = username
        self.timestamp = timestamp
        self.recordID = recordID
    }
}

// MARK: - extensions
extension CKRecord {
    convenience init(adventure: Adventure) {
        self.init(recordType: AdventureStrings.recordTypekey, recordID: adventure.recordID)
        setValuesForKeys([
            AdventureStrings.textKey : adventure.text,
            AdventureStrings.usernameKey : adventure.username,
            AdventureStrings.timestampKey : adventure.timestamp,
        ])
    }
}

extension Adventure {
    convenience init?(ckRecord: CKRecord) {
        guard let text = ckRecord[AdventureStrings.textKey] as? String,
            let username = ckRecord[AdventureStrings.usernameKey] as? String,
            let timestamp = ckRecord[AdventureStrings.timestampKey] as? Date
            else { return nil }
        
        self.init(text: text, username: username, timestamp: timestamp, recordID: ckRecord.recordID)
    }
}
