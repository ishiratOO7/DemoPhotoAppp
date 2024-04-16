//
//  PhotoCVCell.swift
//  DemoPhotoApp
//
//  Created by Rahul Sharma on 15/04/24.
//

import UIKit

class PhotoCVCell: UICollectionViewCell {
    
    @IBOutlet weak var photoView: UIImageView!
    
    
    func configure(with imageUrl: String) {
        // Load image using ImageLoader
        ImageLoader.shared.loadImage(from: imageUrl, into: photoView) { [weak self] image, error in
            guard let self = self else { return }
            self.photoView.image = image
        }
        
    }
    
}
