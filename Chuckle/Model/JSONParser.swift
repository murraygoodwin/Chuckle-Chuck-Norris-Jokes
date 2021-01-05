//
//  JSONParser.swift
//  Chuckle
//
//  Created by Murray Goodwin on 20/10/2020.
//

import Foundation
import SwiftyJSON
import HTMLString

struct JSONParser {
  
  func parseJSON(data: Data) -> [String] {
 
    let json = JSON(data)
    var jokesList: [String] = []
     
    for joke in 0..<json["value"].count {
            
      if let jokeText = json["value"][joke]["joke"].string {
        jokesList.append(jokeText.removingHTMLEntities())
      }
    }
    
    guard jokesList.count > 0 else {
      //FIXME: Ideally I would include better handling of these errors.
      fatalError("No valid joke text was found in the data returned.")
    }
    
    return jokesList
  }
}
