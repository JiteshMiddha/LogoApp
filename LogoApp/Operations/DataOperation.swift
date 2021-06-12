//
//  DataOperation.swift
//  LogoApp
//
//  This is base class of any data operation.
//
//  Created by Jitesh Middha on 12/06/21.
//

import Foundation
class DataOperation<Decode: Codable> : Operation {
  
  typealias CompletionType = (Result<Decode, CustomError>) -> Void
  
  private let completion: CompletionType
  private let fileName: String
  
  // MARK: Initialization
  init(fileName: String, completion: @escaping CompletionType) {
    self.fileName = fileName
    self.completion = completion
    super.init()
    self.name = "DataOperation"
  }
  
  private func fetchDataFromFile(fileName: String) throws -> Data? {
    
    if let bundlePath = Bundle.main.path(forResource: fileName, ofType: "json"),
       let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
      return jsonData
    }
    
    return nil
  }
  
  private func parse(jsonData: Data) throws -> Decode {
    let decoder = JSONDecoder()
    let parsedObject = try decoder.decode(Decode.self, from: jsonData)
    
    return parsedObject
  }
  
  // MARK: Override
  override func main() {
    var data: Data?
    do {
      data = try self.fetchDataFromFile(fileName: self.fileName)
    } catch {
      self.completion(.failure(.readError))
      return
    }
    
    guard let jsonData = data else {
      self.completion(.failure(.noData))
      return
    }
    
    do {
      let parsedObject = try self.parse(jsonData: jsonData)
      self.completion(.success(parsedObject))
    } catch {
      // Parsing Error
      self.completion(.failure(.parsingError))
      return
    }
    
    guard self.isCancelled == false else { return }
  }
}
