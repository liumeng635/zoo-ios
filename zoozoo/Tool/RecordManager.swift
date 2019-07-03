//
//  RecordManager.swift
//  zoozoo
//
//  Created by 苹果上的豌豆 on 2019/5/20.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit
import AVFoundation

class RecordManager: NSObject {
    static let shared: RecordManager = RecordManager()
    
    var recorder: AVAudioRecorder?
    var player: AVAudioPlayer?
    
    //开始录音
    func beginRecord(filePath : String) {
        let session = AVAudioSession.sharedInstance()
        //设置session类型
        do {
            try session.setCategory(AVAudioSession.Category.playAndRecord)
        } catch let err{
            print("设置类型失败:\(err.localizedDescription)")
        }
        //设置session动作
        do {
            try session.setActive(true)
        } catch let err {
            print("初始化动作失败:\(err.localizedDescription)")
        }
       
        let recordSetting: [String: Any] = [AVSampleRateKey: NSNumber(value: 11025.0),//采样率
            AVFormatIDKey: NSNumber(value: kAudioFormatLinearPCM),//音频格式
            AVLinearPCMBitDepthKey: NSNumber(value: 16),//采样位数
            AVNumberOfChannelsKey: NSNumber(value: 1),//通道数
            AVEncoderAudioQualityKey: NSNumber(value: AVAudioQuality.min.rawValue)//录音质量
        ];
        //开始录音
        do {
            let url = URL(fileURLWithPath: filePath)
            recorder = try AVAudioRecorder(url: url, settings: recordSetting)
            recorder!.prepareToRecord()
            recorder!.record()
            print("开始录音")
        } catch let err {
            print("录音失败:\(err.localizedDescription)")
        }
    }
    
    //结束录音
    func stopRecord() {
        if let recorder = self.recorder {
            if recorder.isRecording {
               
            }else {
               
            }
            recorder.stop()
            self.recorder = nil
        }else {
            print("没有初始化")
        }
    }
    
    //播放
    func play(filePath : String) {
        do {
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: filePath))
           
            player!.play()
        } catch _ {
           
        }
    }
    
    func levels() -> Double{
        recorder?.updateMeters()
        let power = recorder?.averagePower(forChannel: 0) ?? 0
        var aveChannel = pow(10, (0.02 * power))
       
        if (aveChannel <= 0.05){
             aveChannel = 0.05
        }
        if (aveChannel >= 1.0){
            aveChannel = 1.0
        }
        return Double(aveChannel)
    }
}
