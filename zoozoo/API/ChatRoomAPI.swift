//
//  ChatRoomAPI.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/6/24.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class ChatRoomAPI: NSObject {
    static let shared = ChatRoomAPI()
}

extension ChatRoomAPI {
    //
    //MARK - 互动发送消息 beUserId和msgType为比传
    //消息类型：0普通 1一键喂食 2一键遛弯 3一键教育; 4撒娇 5上传 6提问 7回答问题 8灰体消息 9喂食 10遛弯 11教育 12评论 13点赞 14回复 15早安 16晚安
    //
    public func APPChatRoomMessagePublishURL(parameter : NSMutableDictionary,
                                     
                                   success   : @escaping (_ json : Any?)->Void,
                                   failure   : @escaping (_ error : Error)->Void){
        
        
        let urlStr = BaseUrlPath + "api/user/userMessage/interaction"
        
        HttpTool.postRequest(urlPath: urlStr, parameters: parameter as? [String : Any], success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
       
    }
    public func APPMoringNightURL(beUserId   : String ,
                                      msgType   : Int ,
                                      success   : @escaping (_ json : Any?)->Void,
                                      failure   : @escaping (_ error : Error)->Void){
        
        
        let urlStr = BaseUrlPath + "api/user/userMessage/interaction"
        
        
        let paraDic =  NSMutableDictionary.init(dictionary:["beUserIds":beUserId,"msgType":msgType])
        
        HttpTool.postRequest(urlPath: urlStr, parameters: paraDic as? [String : Any], success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
        
    }
    
    //
    //MARK - 聊天室消息列表
    //
    public func APPChatRoomMessageListURL(beUserId   : String ,
                                          lastMessageId   : String ,
                                      success   : @escaping (_ json : Any?)->Void,
                                      failure   : @escaping (_ error : Error)->Void){
        
        
        let urlStr = BaseUrlPath + "api/user/userMessage/records"
        let paraDic =  NSMutableDictionary.init(dictionary:["beUserId":beUserId,"lastMessageId":lastMessageId])
        
        HttpTool.getRequest(urlPath: urlStr, parameters: paraDic as? [String : Any], success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
        
    }
    //
    //MARK - 聊天室用户头部信息
    //
    public func APPChatRoomUserHeadURL(beUserId   : String ,
                                          
                                          success   : @escaping (_ json : Any?)->Void,
                                          failure   : @escaping (_ error : Error)->Void){
        
        
        let urlStr = BaseUrlPath + "api/user/userMessage/userInfo"
        let paraDic =  NSMutableDictionary.init(dictionary:["beUserId":beUserId])
        
        HttpTool.getRequest(urlPath: urlStr, parameters: paraDic as? [String : Any], success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
        
    }
}
