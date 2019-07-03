//
//  HomeAPI.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/5/27.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class HomeAPI: NSObject {

    static let shared = HomeAPI()
}
extension HomeAPI {
    
    
    //
    //MARK:-随机获取宠物信息
    //
    public func APPGetHomeRandomPetURL(
        success   : @escaping (_ json : Any?)->Void,
        failure   : @escaping (_ error : Error)->Void){
        
        
        let urlStr = BaseUrlPath + "api/user/index/randomPet"
        
        HttpTool.getRequest(urlPath: urlStr, parameters: nil, success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
    }
    //
    //MARK:-点赞/比心
    //
    public func APPUserLikeURL(beLikedUserId   : String ,
                                     
                                     success   : @escaping (_ json : Any?)->Void,
                                     failure   : @escaping (_ error : Error)->Void){
        
        
        let urlStr = BaseUrlPath + "api/user/userLike/like"
        let paraDic =  NSMutableDictionary.init(dictionary:["beLikedUserId":beLikedUserId])
        HttpTool.postRequest(urlPath: urlStr, parameters: paraDic as? [String : Any], success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
    }
    //
    //MARK:-取消点赞
    //
    public func APPUserLikeCancelURL(beLikedUserId   : String ,
                                     likeUserId : String ,
                               success   : @escaping (_ json : Any?)->Void,
                               failure   : @escaping (_ error : Error)->Void){
        
        
        let urlStr = BaseUrlPath + "api/user/userLike/cancel"
        let paraDic =  NSMutableDictionary.init(dictionary:["beLikedUserId":beLikedUserId,"likeUserId":likeUserId])
        HttpTool.postRequest(urlPath: urlStr, parameters: paraDic as? [String : Any], success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
    }
    //
    //MARK:-领养
    //
    public func APPAdoptAnimalURL(beAdoptedUserId   : String ,
                               
                               success   : @escaping (_ json : [String:Any])->Void,
                               failure   : @escaping (_ error : Error)->Void){
        
        
        let urlStr = BaseUrlPath + "api/user/userAdopt/adopt"
        let paraDic =  NSMutableDictionary.init(dictionary:["beAdoptedUserId":beAdoptedUserId])
        HttpTool.postRequest(urlPath: urlStr, parameters: paraDic as? [String : Any], success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
    }
}
