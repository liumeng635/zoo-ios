//
//  MineHomeModel.swift
//  zoozoo
//
//  Created by 你猜 on 2019/6/4.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class MineHomeModel: BaseResponse {
    var data : MineHomeDetailModel?
}

class MineHomeDetailModel: BaseModel {
    var backImage: String?
    var friends = [MineHomeFriendsModel]()
    var nickname: String?
    var petImage: String?
    var phone: String?
}

class MineHomeFriendsModel: BaseModel {
    var area: String?
    var avatar: String?
    var backImage: String?
    var closeDeg: Int?
    var isAdopt: Int?
    var nickname: String?
    var petImage: String?
    var petNickname: String?
    var petVoice: String?
    var phone: String?
    var relationType: Int?
    var sex: Int?
    var type: Int?
    var msgCnt: Int?
    var userId: String?
    var voiceIntro: String?
}



