//
//  VoiceFlieManager.swift
//  zoozoo
//
//  Created by 苹果上的豌豆 on 2019/5/20.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class VoiceFlieManager: NSObject {
    static let shared: VoiceFlieManager = VoiceFlieManager()
    
    
    func FolderPath() -> String{
        let documentDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let path = "\(documentDir)/Voice"
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try  FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            } catch {
                
            }
    
        }
        return path
        
    }
    func soundTouchSavePathFolderPath() -> String{
        let documentDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let path = "\(documentDir)/Voice"
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try  FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            } catch {
                
            }
            
        }
        return path
        
    }
    
}
