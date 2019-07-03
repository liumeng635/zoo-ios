//
//  AuthorityTool.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/6/16.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit
import Photos
import Contacts

class AuthorityTool: NSObject {

    static func authorizeToAlbum(completion:@escaping (Bool)->Void) {
        if PHPhotoLibrary.authorizationStatus() == .denied {
            //拒绝授权
            completion(false)
        } else if PHPhotoLibrary.authorizationStatus() == .authorized {
            //已授权
            completion(true)
        } else if PHPhotoLibrary.authorizationStatus() == .notDetermined{
            //请求授权
            PHPhotoLibrary.requestAuthorization({ (status) in
                if status == .authorized {
                    completion(true)
                } else {
                    completion(false)
                }
            })
        }
    }
    
    static func authorizeToMicrophone(completion:@escaping (Bool) -> Void){
        
        let recordingSession = AVAudioSession.sharedInstance()
        switch recordingSession.recordPermission{
        case AVAudioSession.RecordPermission.granted:
            //已授权
            completion(true)
            break
        case AVAudioSession.RecordPermission.denied:
            //拒绝授权
            completion(false)
            break
        case AVAudioSession.RecordPermission.undetermined:
            //请求授权
            recordingSession.requestRecordPermission() { allowed in
                DispatchQueue.main.async {
                    if allowed {
                        completion(true)
                    } else {
                        completion(false)
                    }
                }
            }
        }
    }
    
    static func authorizeToContaces(completion:@escaping (Bool)->Void) {
        if CNContactStore.authorizationStatus(for: .contacts) == .authorized {
            //已授权
            completion(true)
        } else if CNContactStore.authorizationStatus(for: .contacts) == .denied {
            //拒绝授权
            completion(false)
        } else if CNContactStore.authorizationStatus(for: .contacts) == .notDetermined{
            //请求授权
            CNContactStore().requestAccess(for: .contacts) { (isRight, error) in
                if isRight {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }

}



