//
//  Extensions.swift
//  DemoPhotoApp
//
//  Created by Rahul Sharma on 15/04/24.
//

import UIKit

extension UICollectionViewCell {
    static func reuseIdentifier() -> String {
        return String(describing: Self.self)
    }
}
