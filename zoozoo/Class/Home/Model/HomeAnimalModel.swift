//
//  HomeAnimalModel.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/5/27.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class BaseHomeAnimalModel: BaseResponse {
    var data = [RandomPetsModel]()
    
    
}
class RandomPetsModel: BaseResponse {
    var randomPets = [HomeAnimalModel]()
    var starImage:String?
    
}
class HomeAnimalModel: BaseModel {
    var age:Int?
    var area:String?
    var avatar:String?
    var backImage:String?
    var isLike:Int?
    var nickname:String?
    var petImage:String?
    var petNickname:String?
    var petThumbImage:String?
    var petType:Int?
    var petVoice:String?
    var sex:Int?
    var tag:String?
    var thumbBackImage:String?
    var userId:String?
    var voiceIntro:String?
    var headBackImage:String?
    
}
