//
//  SchoolsModel.swift
//  zoozoo
//
//  Created by 你猜 on 2019/5/31.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

// 学校
class SchoolsModel: BaseResponse {
    var data = [SchoolsDataModel]()
}

class SchoolsDataModel: BaseModel {
    var id: String?
    var schoolName: String?
}

// 学院
class CollegeModel: BaseResponse {
    var data = [CollegeDataModel]()
}

class CollegeDataModel: BaseModel {
    var id: String?
    var departmentName: String?
}
