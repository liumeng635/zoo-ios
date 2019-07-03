//
//  APPIconModel.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/6/21.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit
import HandyJSON

class APPIconModel: BaseResponse {
    var data : APPIconTackModel?
}

class APPIconTackModel: BaseModel {
    var continueDays: Int?
    var isCompleted: Int?
    var firstPetType: Int?
    var friendCnt: APPIconFriendCnt?
    var APPIconSelect: Bool = false
}

class APPIconSelectModel: BaseModel {
    var APPIconName = "嗅嗅"
    var APPIconImage = "zoo"
    var isCompleted = 0
    var continueDays = 0
    var friendCnt = 0
    var systemGift : Bool = false
    var APPIconSelect: Bool = true
}

class APPIconFriendCnt: BaseModel {
    //熊,兔,猫,狮子,独角兽,考拉,猫头鹰,嘤嘤怪,龙,狗,猴,虎
    var bear :Int = 0
    var rabbit :Int = 0
    var cat :Int = 0
    var lion :Int = 0
    var monster :Int = 0
    var kaola :Int = 0
    var owl :Int = 0
    var yin :Int = 0
    var dragon :Int = 0
    var dog :Int = 0
    var monkey :Int = 0
    var tiger :Int = 0
    func mapping(mapper: HelpingMapper) {
        // 指定 a 字段用 "1" 去解析
        mapper.specify(property: &bear, name: "1")
        mapper.specify(property: &rabbit, name: "2")
        mapper.specify(property: &cat, name: "3")
        mapper.specify(property: &lion, name: "4")
        mapper.specify(property: &monster, name: "5")
        mapper.specify(property: &kaola, name: "6")
        mapper.specify(property: &owl, name: "7")
        mapper.specify(property: &yin, name: "8")
        mapper.specify(property: &dragon, name: "9")
        mapper.specify(property: &dog, name: "10")
        mapper.specify(property: &monkey, name: "11")
        mapper.specify(property: &tiger, name: "12")
    }
    
}

