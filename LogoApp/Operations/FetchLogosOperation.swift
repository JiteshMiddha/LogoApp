//
//  FetchLogosOperation.swift
//  LogoApp
//
//  Created by Jitesh Middha on 12/06/21.
//

import Foundation
// Subclassing from DataOperation with <[Logo]> as return type for successful response.
final class FetchLogosOperation: DataOperation<[Logo]> {
  
  private let fileName: String = "LogoData"
  
  init(completion: @escaping CompletionType) {
    super.init(fileName: fileName, completion: completion)
    self.name = "FetchLogoOperation"
  }
}
