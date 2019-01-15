//
//  UIImageView+Ext.swift
//  RadioGaGaPlayer
//
//  Created by Roger Pintó Diaz on 1/15/19.
//  Copyright © 2019 Roger Pintó Diaz. All rights reserved.
//

import UIKit

extension UIImageView {

    func getAndCacheImage(stringUrl: String) {
        self.image = nil
        
        if let cachedImage = imageCache.object(forKey: stringUrl as AnyObject) as? UIImage {
            I("URLSession: Found cached image \(stringUrl)")
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: stringUrl) else {
            E("URLSession: Getting url")
            return
        }
        
        I("URLSession: Getting image data")
        
        var dataTask: URLSessionDataTask?
        dataTask = URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, response, error) in
            if error != nil {
                E("URLSession: \(error.debugDescription)")
                return
            }
            
            onMain {
                if let downloadedImage = UIImage(data: data!) {
                    I("URLSession: Downloaded image data")
                    imageCache.setObject(downloadedImage, forKey: stringUrl as AnyObject)
                    self.image = downloadedImage
                }
            }
        }
        dataTask?.resume()
    }
}
