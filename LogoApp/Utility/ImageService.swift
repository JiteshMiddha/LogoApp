//
//  ImageService.swift
//  LogoApp
//
//  Created by Jitesh Middha on 12/06/21.
//

import UIKit
final class ImageService {
  
  public static let imageCache = NSCache<AnyObject, AnyObject>()
  
  class func getImage(for url: String, completion: @escaping (UIImage?, Error?) -> Void) {
    if let cachedImage = self.imageCache.object(forKey: url as AnyObject) as? UIImage {
      DispatchQueue.main.async {
        completion(cachedImage, nil)
      }
    }
    else {
      let fetchImageOperation = FetchImageOperation(imageURL: url, completion: { (downloadedImage, error) in
        
        if let downloadedImage = downloadedImage {
          self.imageCache.setObject(downloadedImage, forKey: url as AnyObject)
          DispatchQueue.main.async {
            completion(downloadedImage, error)
          }
        }
      })
      QueueManager.shared.enqueueImageOperation(fetchImageOperation)
    }
  }
}
