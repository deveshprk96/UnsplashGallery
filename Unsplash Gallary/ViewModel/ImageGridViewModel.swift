//
//  ImageGridViewModel.swift
//  Unsplash Gallary
//
//  Created by Devesh Pareek on 17/04/24.
//

import Foundation

class ImageGridViewModel {
    
    let unsplashService = UnsplashService()
    var images: [UnsplashPhoto] = []
    var statusImages: [UnsplashPhoto] = []

    let currentPage = 1
    
    func fetchImages(page: Int, perPage: Int, imageType:String, completion: @escaping (Result<Void, Error>) -> Void) {
        unsplashService.fetchImages(page: page, perPage: perPage, imageType: imageType) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let photos):
                    self?.images.append(contentsOf: photos)
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func fetchStatusImages(page: Int, perPage: Int, imageType:String, completion: @escaping (Result<Void, Error>) -> Void) {
        unsplashService.fetchImages(page: page, perPage: perPage, imageType: imageType) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let photos):
                    self?.statusImages = photos
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
