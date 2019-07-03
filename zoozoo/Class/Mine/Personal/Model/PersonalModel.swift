//
//  PersonalModel.swift
//  zoozoo
//
//  Created by 你猜 on 2019/6/2.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit


// 用户详细信息
class PersonalModel: BaseResponse {
    var data : userModel?
}

class PersonalDetailModel: BaseModel {
    var area: String?
    var avatar: String?
    var backImage: String?
    var birthday: String?
    var constellation: String?
    var departmentId: String?
    var departmentName: String?
    var id: String?
    var nickname: String?
    var petImage: String?
    var petNickname: String?
    var petVoice: String?
    var phone: String?
    var profession: String?
    var schoolId: String?
    var schoolName: String?
    var sex: Int?
    var voiceIntro: String?
    var canUpdateBirth: Int?
}


// 职业
class ProfessionModel: BaseResponse {
    var data = [ProfessionDetailModel]()
}

class ProfessionDetailModel: BaseResponse {
    var codeKey:String?
    var codeType:String?
    var codeValue:String?
}


class BasePersonalSoundIntroModel: BaseResponse {
    var data : PersonalSoundIntroModel?
}
class PersonalSoundIntroModel: BaseModel {
    var avatar: String?
    var age: Int?
    var constellation: String?
    var content: String?
    var nickname: String?
    var sex: Int?
    var title: String?
    var userId: String?
    var voiceIntro: String?
}
