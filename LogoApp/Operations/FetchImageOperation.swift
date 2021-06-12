//
//  FetchImageOperation.swift
//  LogoApp
//
//  Created by Jitesh Middha on 12/06/21.
//

import UIKit
final class FetchImageOperation: Operation {
  
  private let completion: (UIImage?, Error?) -> ()
  private let imageURL: URL
  
  init(imageURL: String, size: CGSize = CGSize.zero, completion: @escaping (UIImage?, Error?) -> Void) {
    
    self.completion = completion
    self.imageURL = URL(string: imageURL)!
    
    super.init()
    self.name = "Image Operation"
  }
  
  
  override func main() {
    
    let task = URLSession(configuration: .default).dataTask(with: imageURL) { (data, response, error) in
      guard error == nil else {
        print("error: \(String(describing: error))")
        return
      }
      guard response != nil else {
        print("no response")
        self.completion(nil, error)
        return
      }
      guard data != nil else {
        print("no data")
        self.completion(nil, error)
        return
      }
      self.completion(UIImage(data: data!), nil)
    }
    task.resume()
    
  }
}
