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
     
    for joke in 0..<json["value"].count {
            
      if let jokeText = json["value"][joke]["joke"].string {
        jokesList.append(jokeText)
      }
    }
    
    guard jokesList.count > 0 else {
      fatalError("No valid joke text was found in the data returned.")
    }
    
    let viewModel = ViewModel.shared
    viewModel.jokesList = jokesList
  }
}
