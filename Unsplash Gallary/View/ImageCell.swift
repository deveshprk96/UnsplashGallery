//
//  ImageCell.swift
//  Unsplash Gallary
//
//  Created by Devesh Pareek on 17/04/24.
//

import Foundation
import UIKit

class ImageCell: UICollectionViewCell {
   
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    // MARK: - Properties
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.center = self.contentView.center
        return indicator
    }()
}

// MARK: - UI Setup
extension ImageCell {
    private func setupUI() {
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2 - 20),
            imageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2 - 20)

        ])
    }
}
