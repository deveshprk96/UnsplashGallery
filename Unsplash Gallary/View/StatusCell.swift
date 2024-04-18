//
//  StatusCell.swift
//  Unsplash Gallary
//
//  Created by Devesh Pareek on 17/04/24.
//

import Foundation
import UIKit

class StatusCell: UICollectionViewCell {
    
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
        imageView.layer.cornerRadius = 50
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.red.cgColor
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
extension StatusCell {
    private func setupUI() {
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
//            imageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
//            imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
//            imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
//            imageView.widthAnchor.constraint(equalTo: self.contentView.heightAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}
