//
//  ViewModel.swift
//  Chuckle
//
//  Created by Murray Goodwin on 20/10/2020.
//

import Foundation

protocol ViewModelDelegate: AnyObject {
  func didRetrieveUpdatedJokes()
}

class ViewModel {
  
  static let shared = ViewModel()
  
  // weak var ?
  var delegate: ViewModelDelegate?
  
  var jokesList: [String]? {
    didSet {
      delegate?.didRetrieveUpdatedJokes()
    }
  }
}
