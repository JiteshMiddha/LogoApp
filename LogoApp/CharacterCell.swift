//
//  CharacterCell.swift
//  LogoApp
//
//  Created by Jitesh Middha on 12/06/21.
//

import UIKit

enum CellState {
  case selected, notSelected
}
class CharacterCell: UICollectionViewCell {
  static let CellId = "CharacterCell"
  @IBOutlet weak var textLabel: UILabel!
  @IBOutlet weak var selectionIndexLabel: UILabel!
  
  var selectionIndex: Int?
  var state: CellState = .notSelected
}
