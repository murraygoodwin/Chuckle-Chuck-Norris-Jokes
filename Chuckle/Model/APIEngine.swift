//
//  APIEngine.swift
//  Chuckle
//
//  Created by Murray Goodwin on 20/10/2020.
//

import Foundation
import Alamofire

struct APIEngine {
  
  func downloadJokesAsJSON(numberOfJokes: Int, excludeExplicitJokes: Bool) {
    
    guard numberOfJokes > 0 else {
      fatalError("Zero jokes were requested for download.")
    }
        
    let baseURL = "https://api.icndb.com/jokes/random/"
    var urlString = baseURL + String(numberOfJokes)
    
    if excludeExplicitJokes {
      urlString = urlString + "?exclude=[explicit]"
    }
    
    AF.request(urlString).validate().responseJSON(completionHandler: { (response) in
      
      switch response.result {
      case .success:
        let jsonParser = JSONParser()
        if let data = response.data {
          jsonParser.parseJSON(data: data)
        }
        
      case .failure:
        if let error = response.error {
          
          //TODO: Improve handling of this error (e.g. more user-friendly error messaging).
        fatalError("\(error.localizedDescription)")
        }
      }
    })
  }
}
