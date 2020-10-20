//
//  JSONParser.swift
//  Chuckle
//
//  Created by Murray Goodwin on 20/10/2020.
//

import Foundation
import SwiftyJSON

struct JSONParser {
  
  func parseJSON(data: Data) {
  let json = JSON(data)
    
    var jokesList: [String] = []
    
    for joke in 0..<json.count {
      if let jokeText = json["value"][joke]["joke"].string {
        debugPrint(jokeText)
        jokesList.append(jokeText)
      }
    }
    var viewModel = ViewModel.shared
    viewModel.jokesList = jokesList
  }
}
