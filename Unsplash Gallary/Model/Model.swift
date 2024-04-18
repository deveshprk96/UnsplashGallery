//
//  Model.swift
//  Unsplash Gallary
//
//  Created by Devesh Pareek on 17/04/24.
//

import Foundation

struct UnsplashPhoto: Codable {
    let id: String
    let urls: PhotoURLs
}

struct PhotoURLs: Codable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}
