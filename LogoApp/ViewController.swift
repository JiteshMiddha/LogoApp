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
  @IBOutlet weak var selectedTextLabel: UILabel!
  
  var selectedWords: [String] = []
  
  private var logos: [Logo] = []
  private var currentIndex: Int = 0
  private var currentCharList: String = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    charactersCollectionView.dataSource = self
    charactersCollectionView.delegate = self
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
          this.resetUI()
        }
      case .failure(let error):
        print(error.errorMessage)
      }
    }
    QueueManager.shared.enqueueDataOperation(fetchOperation)
  }
  
  func downloadImage(imageUrl: String, completion: @escaping (_ image: UIImage?)->Void) {
    ImageService.getImage(for: imageUrl) { (image, error) in
      if error != nil {
        // Handle Error
      }
      completion(image)
    }
  }
  
  
  func resetUI() {
    selectedWords = []
    selectedTextLabel.text = ""
    let currentLogo = logos[currentIndex]
    currentCharList = currentLogo.name ?? ""
    
    if currentCharList.count < 16 {
      var newChars = ""
      for i in 0...16-currentCharList.count {
        let element = ["A", "B", "C", "D", "E", "F", "G", "H"].randomElement()
        newChars += element!
      }
      currentCharList += newChars
    }
    currentCharList = String(currentCharList.shuffled())
    if let imageURL = currentLogo.imageUrl {
      self.downloadImage(imageUrl: imageURL) {[weak self] (image) in
        guard let this = self else {
          return
        }
        guard let image = image else {
            return
        }
        this.logoImageView.image = image
        this.charactersCollectionView.reloadData()
      }
    }
  }
  
  @IBAction func didPressNextButton(_ sender: Any) {
    if self.currentIndex == self.logos.count-1 {
      // if last logo, start from first again
      self.currentIndex = 0
    } else {
      self.currentIndex += 1
    }
    resetUI()
  }
  
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    let currentLogo = logos[currentIndex]
    return currentCharList.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCell.CellId, for: indexPath) as! CharacterCell
    let currentLogo = logos[currentIndex]
    cell.state = .notSelected
    cell.contentView.backgroundColor = .systemOrange
    cell.textLabel.text = (currentCharList != nil) ? String(describing: currentCharList[indexPath.item]) : ""
    cell.selectionIndexLabel.text = ""
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let cell: CharacterCell = collectionView.cellForItem(at: indexPath) as! CharacterCell

    if cell.state == .notSelected {
      self.selectedWords.append(cell.textLabel.text ?? "")
      cell.selectionIndex = self.selectedWords.count
      cell.selectionIndexLabel.text = "\(self.selectedWords.count)"
      cell.state = .selected
      cell.contentView.backgroundColor = .lightGray
    } else {
      if let idx = cell.selectionIndex {
        // This would not work - Will need to update all the indices after this index
        self.selectedWords.remove(at: idx-1)
      }
      cell.selectionIndex = nil
      cell.selectionIndexLabel.text = ""
      cell.state = .notSelected
      cell.contentView.backgroundColor = .systemOrange
    }
    let currentLogo = logos[currentIndex]
    self.selectedTextLabel.text = selectedWords.joined()
    
    if currentLogo.name == selectedWords.joined() {
      // TODO: Handle successfull match
      
    }
  }
}

