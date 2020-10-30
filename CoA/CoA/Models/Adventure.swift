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
    static let titleKey = "title"
    static let textKey = "text"
    static let isArchivedKey = "isArchived"
    static let entryCounterKey = "entryCounter"
    static let timestampKey = "timestamp"
    static let recordTypekey = "Adventure"
}

class Adventure {
    var title: String
    var text: String
    var timestamp: Date
    var isArchived: Bool
    var entryCounter: Int
    let recordID: CKRecord.ID
    
    init(title: String, text: String, timestamp: Date = Date(), isArchived: Bool, entryCounter: Int, recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.title = title
        self.text = text
        self.timestamp = timestamp
        self.isArchived = isArchived
        self.entryCounter = entryCounter
        self.recordID = recordID
    }
}

// MARK: - extensions
extension CKRecord {
    convenience init(adventure: Adventure) {
        self.init(recordType: AdventureStrings.recordTypekey, recordID: adventure.recordID)
        setValuesForKeys([
            AdventureStrings.titleKey : adventure.title,
            AdventureStrings.textKey : adventure.text,
            AdventureStrings.isArchivedKey : adventure.isArchived,
            AdventureStrings.entryCounterKey : adventure.entryCounter,
            AdventureStrings.timestampKey : adventure.timestamp,
        ])
    }
}

extension Adventure {
    convenience init?(ckRecord: CKRecord) {
        guard let title = ckRecord[AdventureStrings.titleKey] as? String,
            let text = ckRecord[AdventureStrings.textKey] as? String,
            let timestamp = ckRecord[AdventureStrings.timestampKey] as? Date,
            let isArchived = ckRecord[AdventureStrings.isArchivedKey] as? Bool,
            let entryCounter = ckRecord[AdventureStrings.entryCounterKey] as? Int
            
            else { return nil }
        
        self.init(title : title, text: text, timestamp: timestamp, isArchived: isArchived, entryCounter: entryCounter, recordID: ckRecord.recordID)
    }
}

