//
//  AnimalModel.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/5/21.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit



class BaseAnimalModel: BaseResponse {
    var data = [AnimalModel]()
}

class AnimalModel: BaseModel {
    var animalName:String?
    var imgUrl:String = ""
    var thumbImageUrl:String?
    var animalType:Int?
    var type:Int?  //0:背景，1:头饰 2：皮肤/身体，3：衣服，4：表情5.动物
    var isSelected : Bool = false
    var storyImage:String?
    
    var background : AnimalModel?
    var body : AnimalModel?
    var cloth : AnimalModel?
    var expression : AnimalModel?
    var head : AnimalModel?
}

class UPDIYAnimalModel: BaseModel {
    var animalName:String = ""
    var petImage :UIImage = UIImage.init()
    var backImage:String = "#8330E1,#7DA8F7"
    var animalType:Int = 1
    var petVoicePath:String = ""
    var VoiceUrl:String = ""
    var storyImage:String = ""
}

class BaseVoiceModel: BaseResponse {
    var data = [VoiceModel]()
}

class VoiceModel: BaseModel {
    var audioPath:String?
    var title:String?
    var useCnt:String?
    var type:String?
    var isSelected : Bool = false
    
    var pitch : Int32 = 0
    var rate : Int32 = 0
    var tempo : Int32 = 0
    
    
}



