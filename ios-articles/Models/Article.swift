//
//  Article.swift
//  ios-articles
//
//  Created by Galileo Guzman on 02/11/20.
//

import Foundation

struct Article: Codable {
    var author: String?
    var title: String?
    var createdAt: String
    var storyTitle: String?
    
    func finalTitle() -> String {
        if let title = title {
            return title
        }
        return storyTitle ?? "No title available"
    }
    
    func authorWithCreatedAt() -> String {
        // Date input formatter
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateCreatedAt = inputFormatter.date(from: createdAt) ?? Date()
        
        // Date output formmater
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMM d, y"
        let outputDate = outputFormatter.string(from: dateCreatedAt)
        
        // Output
        let authorName = author ?? "Unknow"
        return "\(authorName) - \(outputDate)"
    }
}
