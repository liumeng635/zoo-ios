//
//  BaseUser.swift
//  zoozoo
//
//  Created by 苹果上的豌豆 on 2019/5/15.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class BaseUser: NSObject {
    /** 是否登录状态 */
    public var isLogin : Int = 0
    
    /** 是否第一次安装 */
    public var isFirst      : Int = 0
    
    /** 是否为老用户 */
    public var isOldUser      : Int = 0
    /** uid 默认值0 */
    public var uid: String = "0"
    
    /**微信QQ unionId 默认值0 */
    public var unionId      : String = "0"
    
 
    /** key */
    public var key   : String = "0"
    
    /** uid 默认值0 */
    public var channel      : String = "iphone"
    
    /** password */
    public var password    : String = "0"
    
    /** name */
    public var username : String = ""
    
    /** phone */
    public var phone    : String = ""
    
    /** avatar */
    public var avatar   : String = ""
    
    /** area */
    public var area   : String = ""
    
    /** age */
    public var birthday   : String = ""
    
   
    public var backImage   : String = ""
   
    public var petImage   : String = ""
   
    public var petNickname   : String = ""
  
    public var petType   :  Int = 1
    
    public var petVoice   : String = ""
    
    
    public var sex   : Int = 1
    
    public var voiceIntro   : String = ""
   
    var petAvatar : String {
        get{
            return "\(self.petImage)\(BottomQiuniuUrl)"
        }
    }
    
    public func saveToLocal(){
        
        UserDefaults.standard.set(uid,      forKey: "id")
        UserDefaults.standard.set(key,      forKey: "key")
        UserDefaults.standard.set(username, forKey: "nickname")
        UserDefaults.standard.set(phone,    forKey: "phone")
        UserDefaults.standard.set(password,   forKey: "password")
        UserDefaults.standard.set(avatar,   forKey: "avatar")
        UserDefaults.standard.set(area,   forKey: "area")
        UserDefaults.standard.set(birthday,   forKey: "birthday")
        UserDefaults.standard.set(sex,   forKey: "sex")
        UserDefaults.standard.set(channel,   forKey: "channel")
      UserDefaults.standard.set(voiceIntro,   forKey: "voiceIntro")
        
        UserDefaults.standard.set(isLogin,   forKey: "isLogin")
        UserDefaults.standard.set(isFirst,   forKey: "isFirst")
        UserDefaults.standard.set(unionId,   forKey: "unionId")
        UserDefaults.standard.set(isOldUser,   forKey: "isOldUser")
        
        UserDefaults.standard.set(backImage,   forKey: "backImage")
        UserDefaults.standard.set(petImage,   forKey: "petImage")
        UserDefaults.standard.set(petVoice,   forKey: "petVoice")
        UserDefaults.standard.set(petType,   forKey: "petType")
        UserDefaults.standard.set(petNickname,   forKey: "petNickname")
        
      
    }
    public func getCurFromLocal(){
        
        self.uid = UserDefaults.standard.value(forKey: "id") as? String ?? self.uid
        self.key = UserDefaults.standard.value(forKey: "key") as? String ?? self.key
        self.password = UserDefaults.standard.value(forKey: "password") as? String ?? self.password
        self.username = UserDefaults.standard.value(forKey: "nickname") as? String ?? self.username
        self.phone = UserDefaults.standard.value(forKey: "phone") as? String ?? self.phone
        
        self.avatar = UserDefaults.standard.value(forKey: "avatar") as? String ?? self.avatar
        self.area = UserDefaults.standard.value(forKey: "area") as? String ?? self.area
        self.birthday = UserDefaults.standard.value(forKey: "age") as? String ?? self.birthday
        self.sex = UserDefaults.standard.value(forKey: "sex") as? Int ?? self.sex
         self.voiceIntro = UserDefaults.standard.value(forKey: "voiceIntro") as? String ?? self.voiceIntro
        self.channel = UserDefaults.standard.value(forKey: "channel") as? String ?? self.channel

        self.isFirst = UserDefaults.standard.value(forKey: "isFirst") as? Int ?? self.isFirst
        self.isLogin = UserDefaults.standard.value(forKey: "isLogin") as? Int ?? self.isLogin
        
        self.isOldUser = UserDefaults.standard.value(forKey: "isOldUser") as? Int ?? self.isOldUser
        
        self.backImage = UserDefaults.standard.value(forKey: "backImage") as? String ?? self.backImage
        
        self.petImage = UserDefaults.standard.value(forKey: "petImage") as? String ?? self.petImage
        
        self.petType = UserDefaults.standard.value(forKey: "petType") as? Int ?? self.petType
        
        self.petNickname = UserDefaults.standard.value(forKey: "petNickname") as? String ?? self.petNickname
        
        self.petVoice = UserDefaults.standard.value(forKey: "petVoice") as? String ?? self.petVoice
        
    
    }
    
    public func loadLoginData(model :userModel){
        self.uid = model.id ?? self.uid
        self.unionId = model.unionId ?? self.unionId
        self.username = model.username ?? self.username
        self.phone = model.phone ?? self.phone
        self.sex = model.sex ?? self.sex
        self.avatar = model.avatar ?? self.avatar
        self.area = model.area ?? self.area
        self.birthday = model.birthday ?? self.birthday
        self.voiceIntro = model.voiceIntro ?? self.voiceIntro
         self.petImage = model.petImage ?? self.petImage
         self.petNickname = model.petNickname ?? self.petNickname
         self.backImage = model.backImage ?? self.backImage
         self.petType = model.petType ?? self.petType
        self.channel = model.source ?? self.channel
    }
}

