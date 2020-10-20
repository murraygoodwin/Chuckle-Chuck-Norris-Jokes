//
//  ViewController.swift
//  Chuckle
//
//  Created by Murray Goodwin on 20/10/2020.
//

import UIKit

class ViewController: UIViewController {

  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let apiEngine = APIEngine()
    
    apiEngine.downloadJokesAsJSON(numberOfJokes: 2)
      
  }


}

