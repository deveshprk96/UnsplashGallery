//
//  ViewController.swift
//  Unsplash Gallary
//
//  Created by Devesh Pareek on 17/04/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var statusCollectionView: UICollectionView!
    @IBOutlet weak var gallaryCollectionView: UICollectionView!
    
    let imageGridViewModel = ImageGridViewModel()
    var currentPage = 1
    var isLoading = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionViews()
        fetchImages(page: currentPage)
    }

    private func setupCollectionViews() {
        statusCollectionView.dataSource = self
        gallaryCollectionView.dataSource = self
    }
    
    private func fetchImages(page: Int) {
        imageGridViewModel.fetchStatusImages(page: 2, perPage: 15, imageType: "trending") { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.statusCollectionView.reloadData()
                case .failure(let error):
                    print("Error fetching images: \(error.localizedDescription)")
                }
            }
        }
        
        guard !isLoading else { return }
        isLoading = true
        
        imageGridViewModel.fetchImages(page: page, perPage: 30, imageType: "popular") { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success:
                    self?.gallaryCollectionView.reloadData()
                case .failure(let error):
                    print("Error fetching images: \(error.localizedDescription)")
                }
            }
        }
    }

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == statusCollectionView {
            return imageGridViewModel.statusImages.count
        } else if collectionView == gallaryCollectionView {
            return imageGridViewModel.images.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == statusCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StatusCell", for: indexPath) as? StatusCell else {
                fatalError("Unable to dequeue StatusCell")
            }
            if imageGridViewModel.images.count > 0{
                let imageUrl = imageGridViewModel.statusImages[indexPath.item].urls.regular
                cell.imageView.loadImage(from: imageUrl)
            }
            return cell
        } else if collectionView == gallaryCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCell else {
                fatalError("Unable to dequeue ImageCell")
            }
            
            if imageGridViewModel.images.count > 0{
                let imageUrl = imageGridViewModel.images[indexPath.item].urls.regular
                cell.imageView.loadImage(from: imageUrl)
            }
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == gallaryCollectionView {
            let width = collectionView.bounds.width / 2 - 10
            return CGSize(width: width, height: width)
        } else {
            return CGSize(width: 100, height: 100)
        }
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == gallaryCollectionView {
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            let height = scrollView.frame.size.height
            
            if offsetY > contentHeight - height {
                // Reached bottom, load more images
                currentPage += 1
                fetchImages(page: currentPage)
            }
        }
    }
}

