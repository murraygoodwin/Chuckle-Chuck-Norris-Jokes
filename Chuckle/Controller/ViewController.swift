//
//  ViewController.swift
//  Chuckle
//
//  Created by Murray Goodwin on 20/10/2020.
//

import UIKit

final class ViewController: UIViewController {
  
  @IBOutlet weak var numberOfJokesSlider: UISlider!
  @IBOutlet weak var excludeExplicitJokesSwitch: UISwitch!
  @IBOutlet weak var numberOfJokesLabel: UILabel!
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var mainBody: UIView!
  @IBOutlet weak var controlsPanel: UIView!

  let soundEngine = SoundEngine()
  let viewModel = ViewModel()
  
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
  private func updateUI(for mode: ViewState) {
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }
      
      switch mode {
      case .initialLoad:
        self.excludeExplicitJokes = self.excludeExplicitJokesSwitch.isOn ? true : false
        self.numberOfJokesSlider.value = Float(self.numberOfJokesToRetrieve)
        self.updateNumberOfJokesLabelText()
        
        if let navigationBar = self.navigationController?.navigationBar {
          let firstFrame = CGRect(x: 0, y: 0, width: navigationBar.frame.width, height: navigationBar.frame.height)
          
          let titleLabel = CustomUILabel(frame: firstFrame)
          titleLabel.text = "CHUCKLE"
          titleLabel.font = UIFont(name: "Bangers-Regular", size: 34)!
          titleLabel.textColor = UIColor(named: "Colour4") ?? .white
          titleLabel.textAlignment = .center
          navigationBar.addSubview(titleLabel)
        }
        
        self.controlsPanel.layer.shadowColor = UIColor.black.cgColor
        self.controlsPanel.layer.shadowOpacity = 1
        self.controlsPanel.layer.shadowOffset = .zero
        self.controlsPanel.layer.shadowRadius = 10
        
      case .afterUpdate:
        self.collectionView.reloadData()
        self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: true)
      }
    }
  }
  
  private func updateNumberOfJokesLabelText() {
    numberOfJokesLabel.text = "Get \(numberOfJokesToRetrieve) joke"
    if numberOfJokesToRetrieve > 1 {
      numberOfJokesLabel.text = numberOfJokesLabel.text! + "s"
    }
  }
  
  // MARK: - User Actions
  @IBAction private func hitMeButtonTapped(_ sender: UIButton) {
    
    let apiEngine = APIEngine()
    
    apiEngine.downloadJokesAsJSON(numberOfJokes: numberOfJokesToRetrieve,
                                  excludeExplicitJokes: excludeExplicitJokes) { [weak self] (data) in
      
      guard let self = self, let data = data else { return }
      
      let jsonParser = JSONParser()
      self.viewModel.jokesList = jsonParser.parseJSON(data: data)
    }
  }
  
  @IBAction private func explicitJokesSwitchIsChanged(_ sender: UISwitch) {
    excludeExplicitJokes = excludeExplicitJokesSwitch.isOn ? true : false
  }
  
  @IBAction private func numberOfJokesSliderChanged(_ sender: UISlider) {
    numberOfJokesToRetrieve = Int(sender.value)
    updateNumberOfJokesLabelText()
  }
}

// MARK: - New Jokes Received
extension ViewController: ViewModelDelegate {
  func didRetrieveUpdatedJokes() {
    soundEngine.playSound(sound: "Chop")
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
    
    // TODO: I'd like to incorporate dynamic resizing for the font for extra long jokes. For now, I've just set the font size to be quite small, but I would prefer them to all scale individually.
    
    cell.layer.cornerRadius = 20.0
    
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
