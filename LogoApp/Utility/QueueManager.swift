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
  
  // MARK: - Singleton
  static let shared = QueueManager()
  
  
  // MARK: - Addition
  func enqueueOperation(_ operation: Operation) {
    dataQueue.addOperation(operation)
  }
}
