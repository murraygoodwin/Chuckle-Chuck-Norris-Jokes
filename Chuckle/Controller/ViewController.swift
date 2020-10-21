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
  var numberOfJokesToRetrieve = 5
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel.delegate = self
    collectionView.dataSource = self
    collectionView.delegate = self
    
    excludeExplicitJokes = excludeExplicitJokesSwitch.isOn ? true : false
    numberOfJokesToRetrieve = Int(numberOfJokesSlider.value)
    numberOfJokesSlider.value = Float(numberOfJokesToRetrieve)
    updateNumberOfJokesLabelText()
    
    navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Bangers-Regular", size: 34)!, NSAttributedString.Key.foregroundColor: UIColor(named: "Colour4") ?? .white]
  
  }
   
  func updateNumberOfJokesLabelText() {
    switch numberOfJokesToRetrieve {
    case 1:
      numberOfJokesLabel.text = "Get \(numberOfJokesToRetrieve) joke"
    default:
      numberOfJokesLabel.text = "Get \(numberOfJokesToRetrieve) jokes"
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
    SoundEngine.shared.playSound(sound: "Chop")
    collectionView.reloadData()    
  }
}

// MARK: - CollectionView Delegate
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if viewModel.jokesList != nil {
      return viewModel.jokesList!.count
    } else {
      return 1
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
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
    
    let scaleFactor: CGFloat = 0.8
    
    let screenWidth =
      self.mainBody.frame.size.width * scaleFactor
    let screenHeight = self.mainBody.frame.size.height * scaleFactor
    
          return CGSize(width: screenWidth, height: screenHeight)
      }
  
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//    let cellCount: Int?
//
//    if viewModel.jokesList != nil {
//      cellCount = viewModel.jokesList!.count
//    } else {
//      cellCount = 1
//    }
//
//    let cellSpacing = 20
//    let cellWidth = 200
//
//      let totalCellWidth = cellWidth * cellCount!
//      let totalSpacingWidth = cellSpacing * (cellCount! - 1)
//
//      let leftInset = (self.mainBody.frame.size.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
//      let rightInset = leftInset
//
//      return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
//  }
  
}
