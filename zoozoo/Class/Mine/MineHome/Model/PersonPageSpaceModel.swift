//
//  PersonPageSpaceModel.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/6/12.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class BasePersonPageSpaceModel: BaseResponse {
    var data : PersonPageSpaceModel?
}
class PersonPageSpaceModel: BaseModel {
    var userId: String?
    var nickname: String?
    var petNickname: String?
    var area: String?
    var age: Int?
    var sex: Int?
    var constellation: String?
    var charm: Int?
    var voiceIntro: String?
    var schoolId: String?
    var schoolName: String?
    var departmentId: String?
    var department: String?
    var avatar: String?
    var backImage: String?
    var petImage: String?
    var profession: String?
    var visitType: Int? //访客模式 1访问自己(主人页面) 2好友访问（宠物页面） 3陌生人访问
    
}

//喜欢列表model
class BaseUserLikesModel: BaseResponse {
    var data = [UserLikesModel]()
}
class UserLikesModel: BaseModel {
    var type: Int = 0
    var isEach: Int?
    var hasMaster: Int?
    var likeTime: String?
    
    var userId: String?
    var nickname: String?
    var petNickname: String?
    var area: String?
    var age: Int?
    var sex: Int?
    var constellation: String?
    var charm: Int?
    var voiceIntro: String?
    var schoolId: String?
    var schoolName: String?
    var departmentId: String?
    var department: String?
    var avatar: String?
    var backImage: String?
    var petImage: String?
    var profession: String?
    var visitType: Int?
    
}


//宠物图鉴model
class AdoptHandbookModel: BaseResponse {
    var data = [HandbookModel]()
}

class HandbookModel: BaseModel {
    var animalName:String?
    var constellation:String?
    var developTime:String?
    var isDevelop:Int?//是否养成 0即将养成 1已养成
    var petImage:String?
    var petNickname:String?
    var nickname:String?
    var recordTime:String?
    var userId:String?
    var closeDeg:Int?
   
}
