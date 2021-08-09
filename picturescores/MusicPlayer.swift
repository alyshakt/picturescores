//
//  MusicPlayer.swift
//  picturescores
//
//  Created by Alysha Kester-Terry on 8/8/21.
//

import Foundation
import AVFoundation

class MusicPlayer {
    var artworkTitle = "Not Found"
    static let shared = MusicPlayer()
        var audioPlayer: AVAudioPlayer?
        
    func startBackgroundMusic(artworkTitle: String) {
        let filename = "\(artworkTitle)"
        if let bundle = Bundle.main.path(forResource: filename, ofType: "mp3") {
                let backgroundMusic = NSURL(fileURLWithPath: bundle)
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf:backgroundMusic as URL)
                    guard let audioPlayer = audioPlayer else { return }
                    audioPlayer.numberOfLoops = -1
                    audioPlayer.prepareToPlay()
                    audioPlayer.play()
                } catch {
                    print(error)
                }
            }
    }
 
    func stopBackgroundMusic() {
        guard let audioPlayer = audioPlayer else { return }
        audioPlayer.stop()
    }

}
