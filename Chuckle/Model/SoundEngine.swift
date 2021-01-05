//
//  SoundEngine.swift
//  ColourMatch
//
//  Created by Murray Goodwin on 27/05/2020.
//  Copyright © 2020 Murray Goodwin. All rights reserved.
//

import AVFoundation

final class SoundEngine {
  
  var soundPlayer: AVAudioPlayer!
  
  func playSound(sound: String) {
    
    if let url = Bundle.main.url(forResource: sound, withExtension: "m4a") {
      
      do {
        soundPlayer = try AVAudioPlayer(contentsOf: url)
      } catch {
        fatalError("AVAudioPlayer error.")
      }
      soundPlayer.play()
    }
  }
}
