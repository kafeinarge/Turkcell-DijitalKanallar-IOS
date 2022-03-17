//
//  UIImageView+Helpers.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 13.03.2022.
//

import UIKit

public extension UIImageView {
    
    func loadImage(urlString: String) {
        
        if let cacheImage = app.imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cacheImage
            return
        }
        
        guard let url = URL(string: urlString) else {
            #if DEBUG
            print("Couldn't find image url")
            #endif
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                #if DEBUG
                print("Couldn't download image: ", error)
                #endif
                return
            }
            
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            
            app.imageCache.setObject(image, forKey: urlString as AnyObject)
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
    
    func setRoundFrame() {
        self.layer.cornerRadius = 8.0
        self.clipsToBounds = true
    }
}

