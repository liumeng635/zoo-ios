//
//  AudioPlayer.swift
//  zoozoo
//
//  Created by 苹果上的豌豆 on 2019/5/20.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit
import AVFoundation

class AudioPlayer: NSObject {
    static let shared: AudioPlayer = AudioPlayer()
    /** 音频播放器 */
    var player = AVAudioPlayer.init()
    
    func playAudio(audioPath: String){

        // 设置为扬声器播放
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch _ {
            
        }
        
       
        
        HttpTool.getRequest(urlPath: audioPath, parameters: nil, success: { (json) in
            ZLog(json)
        }) { (error) in
            
        }
        
//        do{
//            
//            try self.player = AVAudioPlayer.init(data: <#T##Data#>)
//        }
//        catch{
//            print("error")
//          
//        }
        
       self.player.prepareToPlay()
        self.player.play()
    
        
    }
    
    func resumeCurrentAudio(){
        self.player.play()
    }
    
    func pauseCurrentAudio(){
        self.player.pause()
    }
    
    func stopCurrentAudio(){
        self.player.stop()
    }
    func progress() -> CGFloat{
        return CGFloat(self.player.currentTime / self.player.duration)
    }
   
   

}
