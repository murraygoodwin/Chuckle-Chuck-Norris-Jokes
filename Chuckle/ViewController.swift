//
//  ViewController.swift
//  Chuckle
//
//  Created by Murray Goodwin on 20/10/2020.
//

import UIKit

class ViewController: UIViewController, ViewModelDelegate {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let viewModel = ViewModel.shared
    viewModel.delegate = self
    
    let apiEngine = APIEngine()
    apiEngine.downloadJokesAsJSON(numberOfJokes: 2)
    
  }
  
  func didRetrieveUpdatedJokes() {
    updateUI()
  }
  
  func updateUI() {
    print("EVERYTHING WORKED!")
  }
}

