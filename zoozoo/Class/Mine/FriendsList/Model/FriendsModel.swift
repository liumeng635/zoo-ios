//
//  FriendsModel.swift
//  zoozoo
//
//  Created by 你猜 on 2019/5/30.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class BaseFriendsModel: BaseResponse {
    var data : FriendsModel?
}

class FriendsModel: BaseModel {
    var currentOwner : FriendsOwnerModel?
    var adminFriend : FriendsOwnerModel?
    var friends = [FriendsOwnerModel]()
}

class FriendsOwnerModel: BaseModel {
    var area:String?
    var avatar:String?
    var backImage:String?
    var closeDeg:Int?
    var isAdopt:Int?
    var nickname:String?
    var petImage:String?
    var petNickname:String?
    var petVoice:String?
    var phone:String?
    var relationType:Int?
    var sex:Int?
    var type:Int?
    var userId:String?
    var voiceIntro:String?
    var msgCnt:Int?
    var latestMsg:String?
    var beFriendTime:String?
}

class  BookFriendsModel: BaseResponse {
    var data = [BookFriendsDataModel]()
}

class  BookFriendsDataModel: BaseResponse {
    var avatar:String?
    var nickname:String?
    var phone:String?
    var status:Int? //0新用户显示邀请按钮 1老用户可以领养 2老用户不可领养
    var userId:String?
}
