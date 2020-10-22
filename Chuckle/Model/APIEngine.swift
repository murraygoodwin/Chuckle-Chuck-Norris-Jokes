//
//  APIEngine.swift
//  Chuckle
//
//  Created by Murray Goodwin on 20/10/2020.
//

import Foundation
import Alamofire

struct APIEngine {
  
  func downloadJokesAsJSON(numberOfJokes: Int, excludeExplicitJokes: Bool, completion: @escaping (Data?) -> Void) {
    
    guard numberOfJokes > 0 else {
      fatalError("Zero jokes were requested for download.")
    }
    
    let baseURL = "https://api.icndb.com/jokes/random/"
    var urlString = baseURL + String(numberOfJokes)
    
    if excludeExplicitJokes {
      urlString = urlString + "?exclude=[explicit]"
    }
    
    var returnedData: Data?
    
    AF.request(urlString).validate().responseJSON { (response) in
      
      switch response.result {
      case .failure:
        if let error = response.error {
          
          //FIXME: Ideally I would include better handling of these errors, but they seem very low risk.
          fatalError("\(error)")
        }
        
      case .success:
        if let data = response.data {
          returnedData = data
        } else {
          
          //FIXME: Ideally I would include better handling of these errors, but they seem very low risk.
          fatalError("The HTTP request was successful, but no data was returned.")
        }
      }
      completion(returnedData)
    }
  }
}
