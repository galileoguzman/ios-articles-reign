//
//  NetworkManager.swift
//  ios-articles
//
//  Created by Galileo Guzman on 02/11/20.
//


import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private let BASE_URL = "https://hn.algolia.com/api/v1/search_by_date?query=ios"
    
    private init() {}
    
    func getArticles(for page: Int, completed: @escaping(Result<Articles, Errors>) -> Void ) {
        
        let endpoint = BASE_URL + "&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.unableToComplete))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error{
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let articles = try decoder.decode(Articles.self, from: data)
                completed(.success(articles))
            } catch {
                completed(.failure(.invalidData))
            }
            
        }
        
        task.resume()
    }
}
