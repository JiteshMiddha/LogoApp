//
//  ViewController.swift
//  LogoApp
//
//  Created by Jitesh Middha on 12/06/21.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var logoImageView: UIImageView!
  @IBOutlet weak var charactersCollectionView: UICollectionView!
  @IBOutlet weak var nextButton: UIButton!
  
  private var logos: [Logo] = []
  private var currentIndex: Int = 0
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    charactersCollectionView.dataSource = self
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
        
        DispatchQueue.main.async {
          this.charactersCollectionView.reloadData()
        }
      case .failure(let error):
        print(error.errorMessage)
      }
    }
    QueueManager.shared.enqueueOperation(fetchOperation)
  }
  
  
//  func configureStackView() {
//    let MAX_CHARS = 8
//
//    let hStack = UIStackView()
//    hStack.axis = NSLayoutConstraint.Axis.horizontal
//    hStack.distribution  = UIStackView.Distribution.equalSpacing
//    hStack.alignment = UIStackView.Alignment.center
//    hStack.spacing   = 16.0
//
//    let currentLogo = logos[currentIndex]
//    guard let name = currentLogo.name else {
//      return
//    }
//    var chars = [Character](name)
//
//    for i in 0..<chars.count {
//      let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
//      button.setTitle("\(chars[i])", for: .normal)
//      hStack.addSubview(button)
//    }
//
//    charactersContainerStackView.addSubview(hStack)
//  }
}

extension ViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    let currentLogo = logos[currentIndex]
    return currentLogo.name?.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCell.CellId, for: indexPath) as! CharacterCell
    let currentLogo = logos[currentIndex]
    
    cell.textLabel.text = (currentLogo.name != nil) ? String(describing: currentLogo.name![indexPath.item]) : ""
    
    return cell
  }
}

extension StringProtocol {
    subscript(_ offset: Int)                     -> Element     { self[index(startIndex, offsetBy: offset)] }
}
