//
//  APIEngine.swift
//  Chuckle
//
//  Created by Murray Goodwin on 20/10/2020.
//

import Foundation
import Alamofire

struct APIEngine {
  
  func downloadJokesAsJSON(numberOfJokes: Int) {
    
    guard numberOfJokes > 0 else {
      fatalError("Zero jokes were requested for download.")
    }
    
    let baseURL = "https://api.icndb.com/jokes/random/"
    let urlString = baseURL + String(numberOfJokes) + "?exclude=[explicit]"
    
    AF.request(urlString).responseJSON(completionHandler: { (response) in
            
      let jsonParser = JSONParser()
      if let data = response.data {
        jsonParser.parseJSON(data: data)
      }
    })
  }
}
