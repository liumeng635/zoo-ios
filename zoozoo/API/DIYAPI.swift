//
//  DIYAPI.swift
//  zoozoo
//
//  Created by 苹果上的豌豆 on 2019/5/19.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class DIYAPI: NSObject {
    static let shared = DIYAPI()
}
extension DIYAPI {

    
    //
    //MARK:-随机装扮
    //
    public func APPGetBodyRandomProfileURL(
                                     success   : @escaping (_ json : Any?)->Void,
                                     failure   : @escaping (_ error : Error)->Void){
        
        
        let urlStr = BaseUrlPath + "api/system/petBody/randomProfile"
        
        HttpTool.getRequest(urlPath: urlStr, parameters: nil, success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
    }
    
    //
    //MARK:- DIY动物形象和配音更新
    public func APPDIYChooseInfoUpdateURL(
                                      birthday :String ,
                                      nickName   : String ,
                                      sex   : Int ,
                                      
                                      petImage :String ,
                                      petNickname   : String ,
                                      petVoice   : String ,
                                      petType   : Int ,
                                       backImage   : String ,
                                       
                                      profession   : String ,
                                      area   : String ,
                                      avatar   : String ,
                                      departmentId   : String ,
                                      schoolId   : String ,
                                      voiceIntro   : String ,
                                      
                                      
                                      success   : @escaping (_ json : Any?)->Void,
                                      failure   : @escaping (_ error : Error)->Void){
        
        
        let urlStr = BaseUrlPath + "api/user/user/info/update"
        
        let paraDic =  NSMutableDictionary.init(dictionary:["birthday":birthday,"nickName":nickName,"sex":sex,"petImage":petImage,"petNickname":petNickname,"petVoice":petVoice,"petType":petType == 0 ? "" : petType,"backImage":backImage,"profession":profession,"area":area,"avatar":avatar,"departmentId":departmentId,"schoolId":schoolId,"voiceIntro":voiceIntro])
        
        HttpTool.postRequest(urlPath: urlStr, parameters: paraDic as? [String : Any], success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
        
    }
   
    //
    //MARK:获取动物形象列表
    //
    public func APPGetMainAnimalTypeConfigURL(
        success   : @escaping (_ json : Any?)->Void,
        failure   : @escaping (_ error : Error)->Void){
        
        
        let urlStr = BaseUrlPath + "api/system/animalTypeConfig/config"
        
        HttpTool.getRequest(urlPath: urlStr, parameters: nil, success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
    }
    //
    //MARK:-获取宠物形象
    //
    public func APPGetBodyConfigsURL(animalType   : Int ,
                                     type   : Int ,
                                     success   : @escaping (_ json : Any?)->Void,
                                     failure   : @escaping (_ error : Error)->Void){
        
        
        let urlStr = BaseUrlPath + "api/system/petBody/configs"
        let paraDic =  NSMutableDictionary.init(dictionary:["animalType":animalType,"type":type])
        HttpTool.getRequest(urlPath: urlStr, parameters: paraDic as? [String : Any], success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
    }
    //
    //MARK:- DIY配音   配音类型 1宠物配音 2人物语音介绍
    public func APPDIYSysAudioURL(type :Int ,
                                  
                                          success   : @escaping (_ json : Any)->Void,
                                          failure   : @escaping (_ error : Error)->Void){
        
        
        let urlStr = BaseUrlPath + "api/system/sysAudio/dubbing"
        
        let paraDic =  NSMutableDictionary.init(dictionary:["type":type])
        
        HttpTool.getRequest(urlPath: urlStr, parameters: paraDic as? [String : Any], success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
        
    }
}
