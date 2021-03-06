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

final class ViewModel {
  
  weak var delegate: ViewModelDelegate?
  
  var jokesList: [String]? {
    didSet {
      delegate?.didRetrieveUpdatedJokes()
    }
  }
}
