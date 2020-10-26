//
//  Post.swift
//  CoA
//
//  Created by Alex Kennedy on 10/25/20.
//  Copyright © 2020 Alex Kennedy. All rights reserved.
//

import Foundation

struct TopLevelDictionary: Codable {
    let data: SecondLevelDictionary
}

struct SecondLevelDictionary: Codable {
    let children: [ThirdLevelObject]
}

struct ThirdLevelObject: Codable {
    let data: Post
}

struct Post: Codable {
    let title: String
}
