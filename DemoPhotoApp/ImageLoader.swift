//
//  ImageLoader.swift
//  DemoPhotoApp
//
//  Created by Rahul Sharma on 15/04/24.
//


import UIKit

class ImageLoader {
    static let shared = ImageLoader()
    
    private var cache: NSCache<NSString, UIImage>

    
    private init() {
        cache = NSCache()
        cache.countLimit = 10000 // Set a limit on the number of images to cache
    }
    
    func loadImage(from urlString: String, into imageView: UIImageView, completion: @escaping (UIImage?, Error?) -> Void) {
        // Show loader while loading image
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        activityIndicator.center = CGPoint(x: imageView.bounds.width / 2, y: imageView.bounds.height / 2)
        activityIndicator.startAnimating()
        imageView.addSubview(activityIndicator)
        
        // Check if image is already cached
        if let cachedImage = cache.object(forKey: urlString as NSString) {
            activityIndicator.stopAnimating()
            imageView.image = cachedImage
            completion(cachedImage, nil)
            return
        }
        
        // If not cached, download the image
        guard let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, let newImage = UIImage(data: data), error == nil else {
                completion(nil, error)
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
                return
            }
            
            // Cache the downloaded image
            self.cache.setObject(newImage, forKey: urlString as NSString)
            
            DispatchQueue.main.async {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
                imageView.image = newImage
                completion(newImage, nil)
            }
        }
        
        task.resume()
    }
}
