//
//  BaseModel.swift
//  zoozoo
//
//  Created by 苹果上的豌豆 on 2019/5/19.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit
import HandyJSON

class BaseModel: NSObject , HandyJSON{
    required override init() {}
}
class BaseResponse: BaseModel {
    
    var code:Int?
    var message:String?
    
}

