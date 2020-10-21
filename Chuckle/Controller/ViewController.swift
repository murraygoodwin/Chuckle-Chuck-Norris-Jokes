//
//  ViewController.swift
//  Chuckle
//
//  Created by Murray Goodwin on 20/10/2020.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var numberOfJokesSlider: UISlider!
  @IBOutlet weak var excludeExplicitJokesSwitch: UISwitch!
  @IBOutlet weak var numberOfJokesLabel: UILabel!
  @IBOutlet weak var collectionView: UICollectionView!
  
  let viewModel = ViewModel.shared
  
  var excludeExplicitJokes = true
  var numberOfJokesToRetrieve = 5
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel.delegate = self
    collectionView.dataSource = self
    
    excludeExplicitJokes = excludeExplicitJokesSwitch.isOn ? true : false
    numberOfJokesToRetrieve = Int(numberOfJokesSlider.value)
    numberOfJokesSlider.value = Float(numberOfJokesToRetrieve)
    updateNumberOfJokesLabelText()
  }
   
  func updateNumberOfJokesLabelText() {
    switch numberOfJokesToRetrieve {
    case 1:
      numberOfJokesLabel.text = "Get \(numberOfJokesToRetrieve) joke."
    default:
      numberOfJokesLabel.text = "Get \(numberOfJokesToRetrieve) jokes."
    }
  }
  
  // MARK: - User Actions
  @IBAction func hitMeButtonTapped(_ sender: UIButton) {
     
    let apiEngine = APIEngine()
    apiEngine.downloadJokesAsJSON(numberOfJokes: numberOfJokesToRetrieve,
                                  excludeExplicitJokes: excludeExplicitJokes)
  }
  
  @IBAction func explicitJokesSwitchIsChanged(_ sender: UISwitch) {
    excludeExplicitJokes = excludeExplicitJokesSwitch.isOn ? true : false
  }
  
  @IBAction func numberOfJokesSliderChanged(_ sender: UISlider) {
    numberOfJokesToRetrieve = Int(sender.value)
    updateNumberOfJokesLabelText()
  }
}

// MARK: - ViewModel Delegate
extension ViewController: ViewModelDelegate {
  
  func didRetrieveUpdatedJokes() {
    print(viewModel.jokesList?.count)
    collectionView.reloadData()    
  }
}

// MARK: - CollectionView DataSource
extension ViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if viewModel.jokesList != nil {
      return viewModel.jokesList!.count
    } else {
      return 1
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "jokeCell", for: indexPath)
  
  return cell
  }
}
