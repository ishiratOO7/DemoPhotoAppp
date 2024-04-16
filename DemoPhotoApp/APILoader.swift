//
//  APILoader.swift
//  DemoPhotoApp
//
//  Created by Rahul Sharma on 16/04/24.
//

import UIKit

class APILoader {
    static let shared = APILoader()
    
    private var loaderView: UIView?
    
    private init() {}
    
    func showLoader() {
        DispatchQueue.main.async {
            let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            
            self.loaderView = UIView(frame: keyWindow?.bounds ?? .zero)
            self.loaderView?.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            let activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator.color = .white
            activityIndicator.center = self.loaderView!.center
            activityIndicator.startAnimating()
            
            self.loaderView?.addSubview(activityIndicator)
            keyWindow?.addSubview(self.loaderView!)
        }
    }
    
    func hideLoader() {
        DispatchQueue.main.async { [weak self] in
            self?.loaderView?.removeFromSuperview()
            self?.loaderView = nil
        }
    }
}
