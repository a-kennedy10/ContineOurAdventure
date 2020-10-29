//
//  Post.swift
//  CoA
//
//  Created by Alex Kennedy on 10/25/20.
//  Copyright © 2020 Alex Kennedy. All rights reserved.
//

import Foundation
import CloudKit

struct TopLevelDictionary: Decodable {
    let data: SecondLevelDictionary
}

struct SecondLevelDictionary: Decodable {
    let children: [ThirdLevelObject]
}

struct ThirdLevelObject: Decodable {
    let data: Post
}

struct Post: Decodable {
    let title: String
    
//    private enum Codingkeys: String, CodingKey {
//        case linkFlairText = "link_flair_text"
//    }
//
//    let linkFlairText: String
}
