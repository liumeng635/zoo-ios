//
//  FriendsAPI.swift
//  zoozoo
//
//  Created by 你猜 on 2019/5/30.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit
import SwiftyJSON
class FriendsAPI: NSObject {
    static let shared = FriendsAPI()
}

extension FriendsAPI {
    //
    //MARK:- 解除好友关系
    //
    public func APPUserFriendDeleteURL(friendUserId   : String ,
                                       success   : @escaping (_ json : Any?)->Void,
                                       failure   : @escaping (_ error : Error)->Void){
        
        
        let urlStr = BaseUrlPath + "api/user/userFriend/delete"
        let paraDic =  NSMutableDictionary.init(dictionary:["friendUserId":friendUserId])
        HttpTool.postRequest(urlPath: urlStr, parameters: paraDic as? [String : Any], success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
    }
    
    
    //
    //MARK: 我的好友列表
    //
    public func APPUserFriendListURL(lastUserId   :  String ,
                                     
                                     success   : @escaping (_ json : Any?)->Void,
                                     failure   : @escaping (_ error : Error)->Void){
        let urlStr = BaseUrlPath + "api/user/userFriend/list"
        let paraDic =  NSMutableDictionary.init(dictionary:["lastUserId":lastUserId])
        HttpTool.getRequest(urlPath: urlStr, parameters: paraDic as? [String : Any], success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
    }
    
    //
    //MARK: 根据手机号添加宠物
    //
    public func APPFriendAddPetByPhoneURL(phone   :  String ,
                                     
                                     success   : @escaping (_ json : Any?)->Void,
                                     failure   : @escaping (_ error : Error)->Void){
        let urlStr = BaseUrlPath + "api/user/friend/addPetByPhone"
        let paraDic =  NSMutableDictionary.init(dictionary:["phone":phone])
        HttpTool.getRequest(urlPath: urlStr, parameters: paraDic as? [String : Any], success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
    }
    
    //
    //MARK: 手机通讯录添加好友
    //
    public func APPQueryByAddrBookURL(phones   : [AddressBookModel]? ,
                                       success   : @escaping (_ json : Any?)->Void,
                                       failure   : @escaping (_ error : Error)->Void){
        
        
        let urlStr = BaseUrlPath + "api/user/friend/queryByAddrBook"
        var arr = [[String:Any]()]
        arr.removeAll()
        phones?.forEach({ (model) in
            if model.cellphone.isEmpty || model.userName.isEmpty{
            }else{
                let dic = ["phone":model.cellphone,"realName":model.userName]
                arr.append(dic)
            }
        })
        
        //转jsonString
//        let jsonData = try! JSONSerialization.data(withJSONObject: arr, options: [])
//
//        guard let jsonStr = String(data: jsonData, encoding: String.Encoding.utf8) else {
//            return
//        }

//         ZLog(jsonStr)

        let paraDic =  NSMutableDictionary.init(dictionary:["phones":arr])
       
        
        HttpTool.postBodyRequest(urlPath: urlStr, parameters: paraDic as? [String : Any], success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
    }
    
   
    
    
}


