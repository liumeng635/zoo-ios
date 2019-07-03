//
//  LoginUserModel.swift
//  zoozoo
//
//  Created by 苹果上的豌豆 on 2019/5/19.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class BaseLoginUserModel: BaseResponse {
    var data : LoginUserModel?
}

class LoginUserModel: BaseModel {
    var access_token:String?
    var refresh_token:String?
    var token_type:String?
    var isCompleted:Int?
    var user : userModel?
}
class userModel: BaseModel {
    var area:String?
    var avatar : String?
    var backImage:String?
    var birthday : String?
    var constellation:String?
    var id : String?
    var nickname:String?
    var petImage : String?
    var petNickname : String?
    var phone : String?
    var profession : String?
    var sex:Int?
    var unionId : String?
    var username : String?
    var voiceIntro : String?
    var source : String?
    var petType:Int?
    
   
    var departmentId: String?
    var departmentName: String?
    
    var petVoice: String?
    
    var schoolId: String?
    var schoolName: String?
   
    var canUpdateBirth: Int?
}
