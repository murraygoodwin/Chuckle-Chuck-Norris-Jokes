//
//  SoundEngine.swift
//  ColourMatch
//
//  Created by Murray Goodwin on 27/05/2020.
//  Copyright © 2020 Murray Goodwin. All rights reserved.
//

import AVFoundation

class SoundEngine {
  
  static let shared = SoundEngine()
  var soundPlayer: AVAudioPlayer!
  
  func playSound(sound: String) {
    
    if let url = Bundle.main.url(forResource: sound, withExtension: "m4a") {
      soundPlayer = try? AVAudioPlayer(contentsOf: url)
      soundPlayer.play()
    }
  }
}
