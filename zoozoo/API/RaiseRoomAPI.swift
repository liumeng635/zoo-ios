//
//  RaiseRoomAPI.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/6/24.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class RaiseRoomAPI: NSObject {
    static let shared = RaiseRoomAPI()
}

extension RaiseRoomAPI {
    //
    //MARK  我的小怪兽
    //
    public func APPRaiseRoomPetsListURL(
        success   : @escaping (_ json : Any?)->Void,
        failure   : @escaping (_ error : Error)->Void){
        
        let urlStr = BaseUrlPath + "api/user/interact/pets"
        
        HttpTool.getRequest(urlPath: urlStr, parameters: nil, success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
    }
    
    //
    //MARK  养成页面信息
    //
    public func APPRaiseRoomCultivateInfoURL(
        success   : @escaping (_ json : Any?)->Void,
        failure   : @escaping (_ error : Error)->Void){
        
        let urlStr = BaseUrlPath + "api/user/interact/cultivateInfo"
        
        HttpTool.getRequest(urlPath: urlStr, parameters: nil, success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
    }
    
    //
    //MARK:- 解除领养关系
    //
    public func APPReleaseAdoptURL(beAdoptedUserId   : String ,
                                   releaseReason : String ,
                                   success   : @escaping (_ json : Any?)->Void,
                                   failure   : @escaping (_ error : Error)->Void){
        
        
        let urlStr = BaseUrlPath + "api/user/userAdopt/releaseAdopt"
        let paraDic =  NSMutableDictionary.init(dictionary:["beAdoptedUserId":beAdoptedUserId,"releaseReason":releaseReason])
        HttpTool.postRequest(urlPath: urlStr, parameters: paraDic as? [String : Any], success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
    }
}
