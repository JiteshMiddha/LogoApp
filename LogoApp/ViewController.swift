//
//  ViewController.swift
//  LogoApp
//
//  Created by Jitesh Middha on 12/06/21.
//

import UIKit

class ViewController: UIViewController {
  
  private var logos: [Logo] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    fetchLogos()
  }
  
  
  func fetchLogos() {
    let fetchOperation = FetchLogosOperation { [weak self] result in
      
      guard let this = self else {
        return
      }
      switch result {
      case .success(let logos):
        print("\(logos.count) items fetched.")
        this.logos = logos
        
      //          DispatchQueue.main.async {
      //              this.tableView.reloadData()
      //          }
      case .failure(let error):
        print(error.errorMessage)
      }
    }
    QueueManager.shared.enqueueOperation(fetchOperation)
  }
}

