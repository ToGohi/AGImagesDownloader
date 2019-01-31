//
//  AGImageCache.swift
//  AGImagesDownloader
//
//  Created by Antonio González Hidalgo (Monqi) on 28/01/2019.
//  Copyright © 2019 Antonio González Hidalgo. All rights reserved.
//

import UIKit

internal class AGImageCache {

    static let shared = AGImageCache()
    
    init() {}
    
    /// Return an UIImage with content of the filename loaded.
    ///
    /// - Parameter file: the image filename to load
    /// - Returns: return an image (or not)
    func loadFromLocalCache(filename:String) -> UIImage? {
        let path = getPath(filename: filename)
        if FileManager.default.fileExists(atPath: path) {
            return UIImage(contentsOfFile: path)
        }else{
            return nil
        }
    }
    
    /// Delete all the images storages on local storage
    func deleteAllPhotos() {
        do{
            let folder = try FileManager.default.contentsOfDirectory(atPath: NSTemporaryDirectory())
            try folder.forEach { filename in try FileManager.default.removeItem(atPath: getPath(filename: filename)) }
        }catch{
            debugPrint("#ERROR Deleting the file \(error)")
        }
    }
    
    
    /// To download an image from URL. The image will storage with a specific filename
    /// to recover it from the local cache.
    ///
    /// - Parameters:
    ///   - filename: The filename of the image in the local cache.
    ///   - url: URL from download the image.
    ///   - completion: Block to execute when download has finished.
    func downloadImage(filename: String, url: URL, completion: @escaping (UIImage?) -> ()) {
        
        getDataFromUrl(url: url) { (data, response, error) in
            
            guard let data = data, error == nil else { return }
            
            //If data is minus the 1Kb.... it's a invalid image
            if data.count < 1024 {
                
                completion(nil)
                
            }else{
                if !self.saveImage(data: data, filename: filename){
                    debugPrint("Error saving the image \(filename)")
                    completion(nil)
                }else{
                    completion(UIImage(data: data))
                }
            }
        }
        
    }
    
    
    
    
    //MARK: - Private methods
    
    /// Get the full path of the filename
    ///
    /// - Parameter file: filename
    /// - Returns: String with full path of the file
    private func getPath(filename:String)->String {
        if filename.count <= 0 {
            fatalError("You are trying to load/save a file without filename")
        }
        return "\(NSTemporaryDirectory())\(filename)"
    }
    
    
    
    /// Function to create a DataTask to download image from web
    ///
    /// - Parameters:
    ///   - url: image's url to download
    ///   - completion: completion block to execute when download has been completed
    private func getDataFromUrl(url: URL,
                                completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            completion(data, response, error)
        
            }.resume()
    }
    
    
    
    /// Save data (Image) to local storage
    ///
    /// - Parameters:
    ///   - data: Image's data
    ///   - filename: filename to store
    /// - Returns: true if file has been saved in local storage
    private func saveImage(data: Data, filename:String) -> Bool {
        let path = URL(fileURLWithPath: getPath(filename: filename))
        do {
            try data.write(to: path)
        }catch{
            return false
        }
        return true
    }

}
