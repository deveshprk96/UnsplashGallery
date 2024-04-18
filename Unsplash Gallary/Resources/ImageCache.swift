//
//  ImageCache.swift
//  Unsplash Gallary
//
//  Created by Devesh Pareek on 17/04/24.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func loadImage(from urlString: String, placeholder: UIImage? = nil) {
        // Set placeholder image while loading
        self.image = placeholder
        
            ImageLoader.shared.cancelTask(for: self)
        
        // Check if image is already cached
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }
        
        // If not, download image asynchronously
        guard let url = URL(string: urlString) else { return }
        
        // Load image using ImageLoader shared instance
        ImageLoader.shared.loadImage(from: url) { [weak self] resultUrl, image in
            guard let strongSelf = self, let resultUrl = resultUrl, resultUrl == urlString else {
                return // Cell has been reused or URL has changed, discard the image
            }
            if let image = image {
                // Cache the image
                imageCache.setObject(image, forKey: urlString as NSString)
                
                DispatchQueue.main.async {
                    // Update the image view with the downloaded image
                    strongSelf.image = image
                }
            }
        }
    }
}

class ImageLoader {
    static let shared = ImageLoader()
    private var imageTasks = [String: URLSessionDataTask]()
    private let imageLoadingQueue = DispatchQueue(label: "com.example.imageloader")
    
    private init() {}
    
    func loadImage(from url: URL, completion: @escaping (String?, UIImage?) -> Void) {
        imageLoadingQueue.async { [weak self] in
            let urlString = url.absoluteString
            
            // Check if the task is already in progress for this URL
            if let existingTask = self?.imageTasks[urlString] {
                existingTask.resume()
                return
            }
            
            // Create new data task for downloading image
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                defer {
                    // Remove task from dictionary once completed
                    self?.imageTasks[urlString] = nil
                }
                
                // Check for errors
                if let error = error {
                    print("Error loading image: \(error.localizedDescription)")
                    completion(nil, nil)
                    return
                }
                
                // Check for valid data and response
                guard let data = data, let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    print("Invalid response or data")
                    completion(nil, nil)
                    return
                }
                
                // Convert data to UIImage
                if let image = UIImage(data: data) {
                    completion(urlString, image)
                } else {
                    print("Invalid image data")
                    completion(nil, nil)
                }
            }
            
            // Add task to dictionary
            self?.imageTasks[urlString] = task
            
            // Start the task
            task.resume()
        }
    }
    
    func cancelTask(for imageView: UIImageView) {
        guard let urlString = imageView.accessibilityIdentifier else { return }
        imageTasks[urlString]?.cancel()
        imageTasks[urlString] = nil
    }
}
