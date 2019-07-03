//
//  BaseAPI.swift
//  zoozoo
//
//  Created by 苹果上的豌豆 on 2019/5/15.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

//七牛域名
let BaseImageURL           = "http://pqnvgokz6.bkt.clouddn.com/"
// 七牛公有仓库:
let RequestGetPublicTokenUrl           = "api/file/file/get/public/token"


//后台地址

let BaseUrlPath : String = GlobalConstants.config.scheme + GlobalConstants.config.host + "/"


class BaseAPI: NSObject {
    static let shared = BaseAPI()
}
extension BaseAPI {
    
    //
    //MARK:- 检测是否敏感词
    public func APPSensitiveWordURL(word :String ,
                                    
                                    
                                    success   : @escaping (_ json : Any?)->Void,
                                    failure   : @escaping (_ error : Error)->Void){
        
        
        let urlStr = BaseUrlPath + "api/user/words/isSensitiveWord"
        
        let paraDic =  NSMutableDictionary.init(dictionary:["word":word])
        
        HttpTool.getRequest(urlPath: urlStr, parameters: paraDic as? [String : Any], success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
    }
    
    //
    //MARK:- 用户举报接口
    public func APPReportURL(content :String ,
                                    beReportUserId :String ,
                                    
                                    success   : @escaping (_ json : Any?)->Void,
                                    failure   : @escaping (_ error : Error)->Void){
        
        
        let urlStr = BaseUrlPath + "api/user/userReport/save"
        
        let paraDic =  NSMutableDictionary.init(dictionary:["beReportUserId":beReportUserId,"content":content])
        
        HttpTool.postRequest(urlPath: urlStr, parameters: paraDic as? [String : Any], success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
    }
    
    //
    //MARK:- 每日登录登记
    public func APPUserDailyLoginURL(
                             success   : @escaping (_ json : Any?)->Void,
                             failure   : @escaping (_ error : Error)->Void){
        
        
        let urlStr = BaseUrlPath + "api/user/userDailyLogin/save"
        
      
        HttpTool.postRequest(urlPath: urlStr, parameters: nil, success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
    }
    
    
    //
    //MARK:- 查询一类值集合
    //
    public func APPGetValuesURL(codeType :String ,
                                
                                
                                success   : @escaping (_ json : Any?)->Void,
                                failure   : @escaping (_ error : Error)->Void){
        
        
        let urlStr = BaseUrlPath + "api/system/sysCode/getValues"
        let paraDic =  NSMutableDictionary.init(dictionary:["codeType":codeType])
        HttpTool.getRequest(urlPath: urlStr, parameters: paraDic as? [String : Any], success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
    }
    
}
