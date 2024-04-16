//
//  ViewController.swift
//  DemoPhotoApp
//
//  Created by Rahul Sharma on 15/04/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    fileprivate var page = 1
    fileprivate var viewModel: ViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        //set section inset as per your requirement.
        layout.sectionInset = UIEdgeInsets(top: 2, left: 0, bottom: 2, right: 0)
    
        //set Minimum spacing between 2 items
        layout.minimumInteritemSpacing = 0
        
        //set minimum vertical line spacing here between two lines in collectionview
        layout.minimumLineSpacing = 0
        
        //apply defined layout to collectionview
        collectionView.collectionViewLayout = layout
        
        guard let url = URL(string: AppConfig.baseURL) else {
            return }
        viewModel = ViewModel(apiClient: APIClient(baseURL: url))
        
        collectionView.dataSource = self
        collectionView.delegate = self
        getPhotos()
    }
    
    fileprivate func getPhotos() {
        viewModel?.getPhots(page: page, compilationHandler: { [weak self] status, error in
            if let error = error {
                print("Error fetching photos: \(error)")
                return
            }
    
            if status {
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
        })
    }
}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.photos.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCVCell.reuseIdentifier(), for: indexPath) as? PhotoCVCell,
              let image = viewModel?.photos[indexPath.row].urls?.small else {
            return UICollectionViewCell()
        }
        cell.configure(with: image)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let count = viewModel?.photos.count, count > 0 else { return }
        
        let lastItem = indexPath.item
        if lastItem == count - 2 {
            page += 1
            getPhotos()
        }
    }
}


extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
       // Adjust as needed for spacing between cells and edges
        let availableWidth = collectionViewWidth
        let itemWidth = (availableWidth / 3 ) - 3// Adjust the number of items per row
        
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
}

