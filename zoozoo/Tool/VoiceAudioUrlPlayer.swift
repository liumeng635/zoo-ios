//
//  VoiceAudioUrlPlayer.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/5/21.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit
import AVFoundation

class VoiceAudioUrlPlayer: NSObject {
    static let shared: VoiceAudioUrlPlayer = VoiceAudioUrlPlayer()
    
    var playerItem:AVPlayerItem!
    var audioPlayer:AVPlayer!

    func playAudioUrl(audioUrl: String){
        guard let url = URL(string: audioUrl) else {
            return
        }
        
        self.playerItem = AVPlayerItem.init(url: url)
        self.audioPlayer = AVPlayer.init(playerItem: self.playerItem)
         self.audioPlayer.play()   
    }
 
   
}
