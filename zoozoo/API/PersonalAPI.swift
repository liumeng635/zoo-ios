//
//  PersonalAPI.swift
//  zoozoo
//
//  Created by 你猜 on 2019/5/30.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class PersonalAPI: NSObject {
    static let shared = PersonalAPI()
}

extension PersonalAPI {
    //
    //MARK  获取个人详细信息
    //
    public func APPGetUserDetailURL(
        success   : @escaping (_ json : Any?)->Void,
        failure   : @escaping (_ error : Error)->Void){
        
        let urlStr = BaseUrlPath + "api/user/user/getUserDetail"
        
        HttpTool.getRequest(urlPath: urlStr, parameters: nil, success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
    }
    
    
    //
    //MARK 我的个人信息
    //
    public func APPGetUserHomeURL(
        success   : @escaping (_ json : Any?)->Void,
        failure   : @escaping (_ error : Error)->Void){
        
        
        let urlStr = BaseUrlPath + "api/user/home/info"
        
        HttpTool.getRequest(urlPath: urlStr, parameters: nil, success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
    }
    
    //
    //MARK 图标任务
    //
    public func APPUserHomeTaskInfoURL(
        success   : @escaping (_ json : [String:Any])->Void,
        failure   : @escaping (_ error : Error)->Void){
        
        
        let urlStr = BaseUrlPath + "api/user/home/taskInfo"
        
        HttpTool.getRequest(urlPath: urlStr, parameters: nil, success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
    }
    
    //
    //MARK 我的主页信息
    //
    public func APPGetUserVisitInfoURL(userId   :  String ,
                                       
                                       success   : @escaping (_ json : Any?)->Void,
                                       failure   : @escaping (_ error : Error)->Void){
        let urlStr = BaseUrlPath + "api/user/home/visitInfo"
        let paraDic =  NSMutableDictionary.init(dictionary:["userId":userId])
        HttpTool.getRequest(urlPath: urlStr, parameters: paraDic as? [String : Any], success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
    }
    //
    //MARK: 宠物图鉴
    //type筛选类型 999全部,666即将获得,其余按照正常宠物类型传值
    //
    public func APPUserAdoptHandbookURL(beUserId   :  String ,
                                        type   : Int ,
                                        pageIndex   : Int ,
                                        success   : @escaping (_ json : Any?)->Void,
                                        failure   : @escaping (_ error : Error)->Void){
        let urlStr = BaseUrlPath + "api/user/userAdopt/handbook"
        let paraDic =  NSMutableDictionary.init(dictionary:["beUserId":beUserId,"type":type,"pageIndex":pageIndex])
        HttpTool.getRequest(urlPath: urlStr, parameters: paraDic as? [String : Any], success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
    }
    
    //
    //MARK zoo资料
    //
    public func APPHomeZooInfoURL(userId   :  String ,
                                  
                                  success   : @escaping (_ json : Any?)->Void,
                                  failure   : @escaping (_ error : Error)->Void){
        let urlStr = BaseUrlPath + "api/user/home/zooInfo"
        let paraDic =  NSMutableDictionary.init(dictionary:["userId":userId])
        HttpTool.getRequest(urlPath: urlStr, parameters: paraDic as? [String : Any], success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
    }
    
    //
    //MARK 获取学校
    //
    public func APPBaseUniversityURL(lastSchoolId   :  String ,
                                     
                                     success   : @escaping (_ json : Any?)->Void,
                                     failure   : @escaping (_ error : Error)->Void){
        let urlStr = BaseUrlPath + "api/user/baseUniversity/info"
        let paraDic =  NSMutableDictionary.init(dictionary:["lastSchoolId":lastSchoolId])
        HttpTool.getRequest(urlPath: urlStr, parameters: paraDic as? [String : Any], success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
    }
    
    //
    //MARK  通过关键字 搜索 学校
    //
    public func APPSearchUniversityURL(word   :  String ,
                                       
                                       success   : @escaping (_ json : Any?)->Void,
                                       failure   : @escaping (_ error : Error)->Void){
        let urlStr = BaseUrlPath + "api/user/baseUniversity/search"
        let paraDic =  NSMutableDictionary.init(dictionary:["word":word])
        HttpTool.getRequest(urlPath: urlStr, parameters: paraDic as? [String : Any], success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
    }
    
    //
    //MARK 获取学院
    //
    public func APPDepartmentURL(schoolId   :  String ,
                                 
                                 success   : @escaping (_ json : Any?)->Void,
                                 failure   : @escaping (_ error : Error)->Void){
        let urlStr = BaseUrlPath + "api/user/department/info"
        let paraDic =  NSMutableDictionary.init(dictionary:["schoolId":schoolId])
        HttpTool.getRequest(urlPath: urlStr, parameters: paraDic as? [String : Any], success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
    }
    
    //
    //MARK - 解除好友关系
    //
    public func APPFriendDeleteURL(friendUserId   : String ,
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
    //MARK  我的好友列表
    //
    public func APPFriendListURL(lastUserId   :  String ,
                                 
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
    //MARK - 喜欢我的/我喜欢的
    //type列表类型 0喜欢我的 1我喜欢的
    //
    public func APPUserLikesURL(   type   : Int ,
                                   lastLikeTime   : String ,
                                   userId   : String ,
                                   success   : @escaping (_ json : Any?)->Void,
                                   failure   : @escaping (_ error : Error)->Void){
        
        
        let urlStr = BaseUrlPath + "api/user/userLike/likes"
        let paraDic =  NSMutableDictionary.init(dictionary:["type":type,"lastLikeTime":lastLikeTime,"userId":userId])
        HttpTool.postRequest(urlPath: urlStr, parameters: paraDic as? [String : Any], success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
    }
    //
    //MARK  统计喜欢我的人数
    //
    public func APPNewLikeCntURL(
                                 success   : @escaping (_ json : Any?)->Void,
                                 failure   : @escaping (_ error : Error)->Void){
        let urlStr = BaseUrlPath + "api/user/userLike/newLikeCnt"
        
        HttpTool.getRequest(urlPath: urlStr, parameters: nil, success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
    }
    
    //
    //MARK - 更换手机号
    //
    public func APPChangePhoneURL( newPhone   : String ,
                                   smsCode   : String ,
                                   
                                   
                                   success   : @escaping (_ json : Any?)->Void,
                                   failure   : @escaping (_ error : Error)->Void){
        
        
        let urlStr = BaseUrlPath + "api/user/user/changePhone"
        let paraDic =  NSMutableDictionary.init(dictionary:["newPhone": newPhone,"smsCode": smsCode])
        HttpTool.postRequest(urlPath: urlStr, parameters: paraDic as? [String : Any], success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
    }
    
    //
    //MARK :随机获取一位高质配音
    //
    public func APPSoundQualityUserURL(
                                 success   : @escaping (_ json : Any?)->Void,
                                 failure   : @escaping (_ error : Error)->Void){
        let urlStr = BaseUrlPath + "api/user/soundQualityUser/randomOne"
       
        HttpTool.getRequest(urlPath: urlStr, parameters: nil, success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
    }
    
    
    
}

//
//MARK:- 用户信息更新
extension PersonalAPI {
   
    public func APPInfoUpdateNickNameURL(nickName :String ,
                                           
                                           success   : @escaping (_ json : Any?)->Void,
                                           failure   : @escaping (_ error : Error)->Void){
        
        
        let urlStr = BaseUrlPath + "api/user/user/info/update"
        
        let paraDic =  NSMutableDictionary.init(dictionary:["nickName":nickName])
        
        HttpTool.postRequest(urlPath: urlStr, parameters: paraDic as? [String : Any], success: { (json) in
            success(json)
        }) { (error) in
            failure(error)
        }
        
    }
}



