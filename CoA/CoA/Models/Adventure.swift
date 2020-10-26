//
//  Adventure.swift
//  CoA
//
//  Created by Alex Kennedy on 10/24/20.
//  Copyright © 2020 Alex Kennedy. All rights reserved.
//

import Foundation

class Adventure: Codable {
    let entry: String
    let username: String
    var timestamp: Date
    
    init(entry: String, username: String, timestamp: Date = Date()) {
        self.entry = entry
        self.username = username
        self.timestamp = timestamp
    }
}
