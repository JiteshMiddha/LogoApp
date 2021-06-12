//
//  CustomError.swift
//  LogoApp
//
//  Created by Jitesh Middha on 12/06/21.
//

import Foundation

enum CustomError: Error {
  case readError, noData, parsingError, someError
  
  var errorMessage: String {
    var message: String?
    switch self {
    case .readError:
      message = "Could not read json file."
    case .noData:
      message = "No data found in the json file."
    case .parsingError:
      message = "Could not parse the json."
    case .someError:
      message = "There was some error"
    }
    return message ?? localizedDescription
  }
}
