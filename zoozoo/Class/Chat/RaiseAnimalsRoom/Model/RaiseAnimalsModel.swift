//
//  RaiseAnimalsModel.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/6/24.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class BaseRaiseAnimalsModel: BaseResponse {
    var data = [RaiseAnimalsModel]()
}
class RaiseAnimalsModel: BaseModel {
    var backImage :String?
    var myBackImage :String?
    var isExists :Int = 0
    var latestMsg :String?
    var latestVoiceMsg :String?
    var newMsgCnt :Int = 0
    var animalName :String?
    var petImage :String?
    var myPetImage :String?
    var petNickName :String?
    var petType :Int = 0
    var sex :Int = 0
    var userId :String?
   var constellation :String?
    var accompanyTime :String?//陪伴时间
    var age :Int = 0
    var closeDeg :Int = 0//亲密值
    var latestUpdateId :String?
    var nickname :String?
     var oneKeyCnt = oneKeyCntModel()
    var area :String?
    var voiceFlag :Int = 0
    var voiceIntro :String?
    var voiceTag :String?
    
    var notice : notice?
}

class notice: BaseModel {
    var accompany :String?
    var edu :String?
    var feed :String?
}
class oneKeyCntModel: BaseModel {
    var feed = AlertShowModel()
    var accompany = AlertShowModel()
    var edu = AlertShowModel()
}
class AlertShowModel: BaseModel {
   var dailyCnt :Int = 0
    var todayCnt :Int = 0
    var canDo :Int = 0
}
