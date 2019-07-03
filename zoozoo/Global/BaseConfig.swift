//
//  BaseConfig.swift
//  zoozoo
//
//  Created by 苹果上的豌豆 on 2019/5/15.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class BaseConfig: NSObject {
    static let shared: BaseConfig = BaseConfig()
    
    //MARK:- 全局变量审核中
    public var checking      : Bool   = false
    
    /** App URL*/
    public var appURL       : String = "https://itunes.apple.com/cn/app/id1464121831?mt=8"
    
    /** AnimalType*/
    public var AnimalType      = 1
    
    /** 设备号*/
    public var Device : String {
        get{
            
            let DeviceStr = "\(UIDevice.current.modelName)_\(UIDevice.current.systemVersion)"
            return DeviceStr
        }
    }
    
    /*唯一识别码 UDID*/
    public var UDID : String {
        get{
            var UDIDStr = UIDevice.current.identifierForVendor?.uuidString
            if UDIDStr == ""  {
                UDIDStr = " "
            }
            return UDIDStr ?? ""
        }
    }
}
