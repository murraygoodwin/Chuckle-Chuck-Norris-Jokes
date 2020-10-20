//
//  ViewModel.swift
//  Chuckle
//
//  Created by Murray Goodwin on 20/10/2020.
//

import Foundation

struct ViewModel {
  
  static let shared = ViewModel(jokesList: [])
  
  var jokesList: [String] {
    didSet {
      print("Got some new jokes.")
    }
  }
}
