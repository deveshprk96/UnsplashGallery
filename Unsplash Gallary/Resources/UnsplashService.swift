//
//  UnsplashService.swift
//  Unsplash Gallary
//
//  Created by Devesh Pareek on 17/04/24.
//

import Foundation

class UnsplashService {
    
    func fetchImages(page: Int, perPage: Int, imageType: String, completion: @escaping (Result<[UnsplashPhoto], Error>) -> Void) {
        let urlString = "https://api.unsplash.com/photos?page=\(page)&per_page=\(perPage)&order_by=\(imageType)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("Client-ID 9836d9c4041f5323b2e2921cbe653a3bbce58bdaa1346f68c27a0540c114b807", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let photos = try decoder.decode([UnsplashPhoto].self, from: data)
                completion(.success(photos))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case noData
    case invalidData
}
