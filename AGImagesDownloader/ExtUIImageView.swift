//
//  ExtUIImageView.swift
//  AGImagesDownloader
//
//  Created by Antonio González Hidalgo on 28/01/2019.
//  Copyright © 2019 Antonio González Hidalgo. All rights reserved.
//

import UIKit

public extension UIImageView {

    /// Download an image from URL or load from internal cache
    ///
    /// - Parameter url: URL of the image to download.
    public func loadImageFromCache(url:URL){
        print(url.lastPathComponent)
        loadImageFromCache(filename: url.lastPathComponent, url: url)
    }
    
    /// Download an image from URL or load from internal cache
    ///
    /// - Parameters:
    ///   - filename: The filename of the image to store in internal cache.
    ///   - url: URL of the image to download.
    public func loadImageFromCache(filename:String, url:URL) {
        
        let imagesCache = AGImageCache.shared
        
        //The AGImageCache has the local copy of the image
        if let localImage = imagesCache.loadFromLocalCache(filename: filename) {
        
            self.image = localImage
            
        //The AGImageCache doesn't have a local copy and it needs to download
        }else{
            
            let activity = UIActivityIndicatorView(frame: self.bounds)
            activity.color = UIColor.black
            self.addSubview(activity)
            activity.startAnimating()
            self.image = nil
            
            imagesCache.downloadImage(filename: filename, url: url) { image in
                DispatchQueue.main.async {
                    self.image = image
                    activity.stopAnimating()
                    activity.removeFromSuperview()
                }
            }
            
        }
        
    }

}
