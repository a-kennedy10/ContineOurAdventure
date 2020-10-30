//
//  AdventureController.swift
//  CoA
//
//  Created by Alex Kennedy on 10/25/20.
//  Copyright © 2020 Alex Kennedy. All rights reserved.
// https://www.reddit.com/r/writingprompts

import Foundation
import CloudKit

class PostController {
    
    struct StringConstants {
        fileprivate static let baseURL = "https://www.reddit.com/r"
        fileprivate static let postEndpoint = "writingprompts"
        fileprivate static let jsonExtension = ".json"
    }
    
    // MARK: - shared instance
    static let shared = PostController()
    
    // MARK: - source of truth
    var posts: [Post] = []
    
    
    static func fetchPosts(completion: @escaping (Result<[Post], AdventureError>) -> Void) {
        guard let baseURL = URL(string: StringConstants.baseURL) else { return completion(.failure(.invalidURL)) }
        let postURL = baseURL.appendingPathComponent(StringConstants.postEndpoint)
        let finalURL = postURL.appendingPathComponent(StringConstants.jsonExtension)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            guard let data = data else { return completion(.failure(.noData))}
            
            do {
                let topLevelDictionary = try JSONDecoder().decode(TopLevelDictionary.self, from: data)
                let secondLevelDictionary = topLevelDictionary.data
                let thirdLevelObjects = secondLevelDictionary.children
                var postsPlaceholderArray: [Post] = []
                
                for object in thirdLevelObjects {
                    let post = object.data
                    postsPlaceholderArray.append(post)
                }
                completion(.success(postsPlaceholderArray))
                
            } catch {
                return completion(.failure(.thrownError(error)))
            }
            
        }.resume()
    }
    
}
