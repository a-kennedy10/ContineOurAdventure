//
//  AdventureError.swift
//  CoA
//
//  Created by Alex Kennedy on 10/25/20.
//  Copyright © 2020 Alex Kennedy. All rights reserved.
//

import Foundation

enum AdventureError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
}
