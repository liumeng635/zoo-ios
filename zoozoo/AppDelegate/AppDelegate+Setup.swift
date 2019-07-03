//
//  AppDelegate+Setup.swift
//  zoozoo
//
//  Created by 苹果上的豌豆 on 2019/5/15.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

extension AppDelegate {
    func performSetup(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
    
        
        GlobalDataStore.shared.load()
        // 配置服务
        ConfigureService.shared.start()
        
        BaseEngine.shared.goHomeVC()
        

        
    }
}
