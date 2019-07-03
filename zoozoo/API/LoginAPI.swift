//
//  LoginAPI.swift
//  zoozoo
//
//  Created by 苹果上的豌豆 on 2019/5/16.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class LoginAPI: NSObject {
    static let shared = LoginAPI()
}
extension LoginAPI {
    
    //
    //MARK:- 获取手机号的验证码
    //
    public func APPGetMessageCodeLoginURL(cellphone   : String ,
                                          
                                          success   : @escaping (_ json : [String:Any])->Void,
                                          failure   : @escaping (_ error : Error)->Void){
        
        
        let urlStr = BaseUrlPath + "api/user/user/send/verification/code"
        
        let paraDic =  NSMutableDictionary.init(dictionary:["phone":cellphone])
        HttpTool.getRequest(urlPath: urlStr, parameters: paraDic as? [String : Any], success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
    }
    //
    //MARK:- 手机号登录
    //
    public func APPPhoneLoginURL(cellphone   : String ,
                                 smsCode   : String ,
                                 success   : @escaping (_ json : Any?)->Void,
                                 failure   : @escaping (_ error : Error)->Void){
        
        
        let urlStr = BaseUrlPath + "api/user/user/registerAndLogin/phone"
        let paraDic =  NSMutableDictionary.init(dictionary:["phone":cellphone,"smsCode":smsCode])
        HttpTool.postRequest(urlPath: urlStr, parameters: paraDic as? [String : Any], success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
    }
    //
    //MARK:- 微信(授权登录)
    //    登录渠道(微信渠道传入:WeiXin)
    public func APPWechatLoginURL(
        openId   : String ,
        unionId   : String ,
        wechatNickname   : String ,
        wechatSex   : String ,
        wechatPic   : String ,
        city   : String ,
        
        success   : @escaping (_ json : Any?)->Void,
        failure   : @escaping (_ error : Error)->Void){
        
        
        let urlStr = BaseUrlPath + "api/user/user/registerAndLogin/wechat"
        let sex = wechatSex == "男" ? 1 : 0
        let paraDic =  NSMutableDictionary.init(dictionary:["openId":openId,"unionId":unionId,"sex":sex,"area":city,"wxavatar":wechatPic,"wxnickname":wechatNickname])
        
        HttpTool.postRequest(urlPath: urlStr, parameters: paraDic as? [String : Any], success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
        
    }
    
    
    //
    //MARK:- 用户信息更新
    public func APPInfoUpdateLoginURL(birthday :String ,
                                      nickName   : String ,
                                      sex   : Int ,
                                      
                                      success   : @escaping (_ json : Any?)->Void,
                                      failure   : @escaping (_ error : Error)->Void){
        
        
        let urlStr = BaseUrlPath + "api/user/user/info/update"
        
        let paraDic =  NSMutableDictionary.init(dictionary:["birthday":birthday,"nickName":nickName,"sex":sex])
        
        HttpTool.postRequest(urlPath: urlStr, parameters: paraDic as? [String : Any], success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
        
    }
    //
    //MARK:- 用户信息更新
    public func APPInfoUpdateVoiceIntroURL(voiceIntro :String ,
                                      
                                      success   : @escaping (_ json : Any?)->Void,
                                      failure   : @escaping (_ error : Error)->Void){
        
        
        let urlStr = BaseUrlPath + "api/user/user/info/update"
        
        let paraDic =  NSMutableDictionary.init(dictionary:["voiceIntro":voiceIntro])
        
        HttpTool.postRequest(urlPath: urlStr, parameters: paraDic as? [String : Any], success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
        
    }
    
    //
    //MARK:- 随机获取昵称
    public func APPInfoRandomNicknameURL(
        success   : @escaping (_ json : [String:Any])->Void,
        failure   : @escaping (_ error : Error)->Void){
        
        
        let urlStr = BaseUrlPath + "api/system/random/nickname"
        HttpTool.postRequest(urlPath: urlStr, parameters: nil, success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
        
    }
    
}

