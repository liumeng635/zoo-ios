//
//  GlobalDataStore.swift
//  zoozoo
//
//  Created by 苹果上的豌豆 on 2019/5/15.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class GlobalDataStore: NSObject {
    static let shared: GlobalDataStore = GlobalDataStore()
    
    /// 当前用户
    public var currentUser: BaseUser = BaseUser()
}
extension GlobalDataStore {
    public func load() {
        currentUser.getCurFromLocal()
    }
}
