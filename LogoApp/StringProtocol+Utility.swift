//
//  StringProtocol+Utility.swift
//  LogoApp
//
//  Created by Jitesh Middha on 12/06/21.
//

import Foundation
extension StringProtocol {
    subscript(_ offset: Int)                     -> Element     { self[index(startIndex, offsetBy: offset)] }
}
