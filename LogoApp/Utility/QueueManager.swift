//
//  QueueManager.swift
//  LogoApp
//
//  Created by Jitesh Middha on 12/06/21.
//

import Foundation
class QueueManager {
  
  lazy var dataQueue: OperationQueue = {
    let dataQueue = OperationQueue()
    return dataQueue
  }()
  
  lazy var imageQueue: OperationQueue = {
    let imageQueue = OperationQueue()
    return imageQueue
  }()
  
  // MARK: - Singleton
  static let shared = QueueManager()
  
  
  // MARK: - Addition
  func enqueueDataOperation(_ operation: Operation) {
    dataQueue.addOperation(operation)
  }
  
  func enqueueImageOperation(_ operation: Operation) {
    imageQueue.addOperation(operation)
  }
}
