//
//  ChatRoomModel.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/6/24.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class BaseChatRoomModel: BaseResponse {
    var data = [ChatRoomModel]()
}

class ChatRoomModel: BaseResponse {
    var headModel = RaiseAnimalsModel()
    var content :String = ""
    var id :String = "0"
    var isMaster :Int = 1
    var createTime :String?
    var petImage :String?
    var imgUrls = [PhotoModel]()
    var isAnswered :Int = 0
    var isRight :Int = 0
    var msgType :Int = 0
    var question :eduModel?
    var questionId :String?
    var toUserId :String?
    var userId :String?
    var vedioUrl :String?
    var voiceUrl :String?
}

class ChatRoomHeadModel: BaseResponse {
    var data : RaiseAnimalsModel?
}

class PhotoModel: BaseResponse {
    var originUrl :String = ""
    var thumbUrl :String = ""
}
class eduModel: BaseResponse {
    var answer :String = ""
    var id :String = ""
    var question :String = ""
    var option = [optionModel]()
}
class optionModel: BaseResponse {
    var option :String = ""
   
}

