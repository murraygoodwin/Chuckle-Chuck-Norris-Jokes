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
  @IBOutlet weak var mainBody: UIView!
  
  let viewModel = ViewModel.shared
  
  var excludeExplicitJokes = true
  var numberOfJokesToRetrieve = 10
  
  let cardInsets: CGFloat = 60.0
  var cardWidth: CGFloat {
    get { self.mainBody.frame.size.width - cardInsets
    }
  }
  
  enum ViewState {
    case initialLoad
    case afterUpdate
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.delegate = self
    collectionView.dataSource = self
    collectionView.delegate = self
    updateUI(for: .initialLoad)
    }
  
  // MARK: - UI Updates
  func updateUI(for mode: ViewState) {
    switch mode {
    case .initialLoad:
      excludeExplicitJokes = excludeExplicitJokesSwitch.isOn ? true : false
      numberOfJokesSlider.value = Float(numberOfJokesToRetrieve)
      updateNumberOfJokesLabelText()
      
      navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Bangers-Regular", size: 34)!, NSAttributedString.Key.foregroundColor: UIColor(named: "Colour4") ?? .white]
      
    case .afterUpdate:
      collectionView.reloadData()
    }
  }
  
  func updateNumberOfJokesLabelText() {
    numberOfJokesLabel.text = "Get \(numberOfJokesToRetrieve) joke"
    if numberOfJokesToRetrieve > 1 {
      numberOfJokesLabel.text = numberOfJokesLabel.text! + "s"
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

// MARK: - New Jokes Received
extension ViewController: ViewModelDelegate {
  func didRetrieveUpdatedJokes() {
    SoundEngine.shared.playSound(sound: "Chop")
    updateUI(for: .afterUpdate)
  }
}

// MARK: - CollectionView Delegate
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    if viewModel.jokesList != nil {
      return viewModel.jokesList!.count
    } else {
      return 1
    }
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "jokeCell", for: indexPath) as! JokeCollectionViewCell
        
    if viewModel.jokesList != nil {
      cell.jokeLabel.text = viewModel.jokesList![indexPath.row]
    } else {
      cell.jokeLabel.text = "Chuck Norris is always ready..."
    }
    
    cell.layer.cornerRadius = 20.0
    cell.layer.shadowOffset = CGSize(width: 2.0, height: 4.0)
    cell.layer.shadowRadius = 2.0
    cell.layer.shadowColor = UIColor.gray.cgColor
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let cardHeight = self.mainBody.frame.size.height - 100.0
    return CGSize(width: cardWidth, height: cardHeight)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

      return UIEdgeInsets(top: 0, left: cardInsets / 2, bottom: 0, right: cardInsets / 2)
  }
}
