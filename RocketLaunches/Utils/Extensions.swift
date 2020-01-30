//
//  Extensions.swift
//  RocketLaunches
//
//  Created by Stephen Dowless on 1/30/20.
//  Copyright © 2020 Stephan Dowless. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIViewController {
    func presentAlertController(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension UIImageView {
    func loadImage(withUrl url: String) {
        if let image = imageCache.object(forKey: url as NSString) {
            self.image = image
        } else {
            guard let imageUrl = URL(string: url) else { return }
            
            Service.shared.fetchImage(withUrl: imageUrl, completion: { self.image = $0 })
        }
    }
}
