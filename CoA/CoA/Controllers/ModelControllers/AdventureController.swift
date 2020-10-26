//
//  AdventureController.swift
//  CoA
//
//  Created by Alex Kennedy on 10/25/20.
//  Copyright © 2020 Alex Kennedy. All rights reserved.
//

import Foundation

class AdventureController {
    
    struct StringConstants {
        fileprivate static let baseURL = "https://www.reddit.com/r"
        fileprivate static let promptEndpoint = "writingprompts"
        fileprivate static let jsonExtension = "json"
    }
    
    static func fetchPosts(completion: @escaping (Result<[Post], AdventureError>) -> Void) {
        guard let baseURL = URL(string: StringConstants.baseURL) else { return completion(.failure(.invalidURL)) }
        let promptURL = baseURL.appendingPathComponent(StringConstants.promptEndpoint)
        let finalURL = promptURL.appendingPathComponent(StringConstants.jsonExtension)
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            guard let data = data else { return completion(.failure(.noData))}
        }
    }
    
    
    
    
    
    
}
