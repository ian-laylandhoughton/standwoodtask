//
//  UIImageView+Extension.swift
//  StandwoodTask
//
//  Created by Ian Layland-Houghton on 01/08/2020.
//  Copyright © 2020 Ian Layland-Houghton. All rights reserved.
//

import UIKit

extension UIImageView {
    func load(url: String?) {
        let cache = URLCache.shared
        
        guard let imageString = url, let imageUrl = URL(string: imageString) else {
            self.image = UIImage(named: "PlaceholderImage")
            return
        }
        
        let request = URLRequest(url: imageUrl)
        
        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            self.image = image
        } else {
            self.image = UIImage(named: "PlaceholderImage")
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if let data = data, let response = response, let image = UIImage(data: data) {
                    let cachedData = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cachedData, for: request)
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }).resume()
        }
    }
}

