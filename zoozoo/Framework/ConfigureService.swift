//
//  ConfigureService.swift
//  zoozoo
//
//  Created by 苹果上的豌豆 on 2019/5/15.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class ConfigureService{
    static let shared: ConfigureService = ConfigureService()
    
    struct Wechat {
        
        static let appid: String = "wx1123d39676dce1f6"
        static let secret: String = "211dd52b3cb208e66ef8300858ff75b4"
    }
    
    static let systemVersion = UIDevice.current.systemVersion
    
    static let bundleVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"]
    
    static let buildVersion = Bundle.main.infoDictionary?["CFBundleVersion"]
    
    static let deviceModel = UIDevice.current.model
    
    fileprivate let queue: DispatchQueue = DispatchQueue(label: "configure.service")
    
    private init() {}
}

extension ConfigureService {
    func start() {
        queue.async(execute: {
            #if DEBUG
            MobClick.setLogEnabled(true)
            UMSocialManager.default().openLog(true)
            #endif
            //友盟
            
            UMAnalyticsConfig.sharedInstance().appKey = GlobalConstants.config.UMAppKey
            MobClick.start(withConfigure: UMAnalyticsConfig.sharedInstance())
            
            UMSocialManager.default().umSocialAppkey = GlobalConstants.config.UMAppKey
            /* 设置微信的appKey和appSecret */
            UMSocialManager.default().setPlaform(.wechatSession,
                                                 appKey:GlobalConstants.config.UMWXAppId,
                                                 appSecret: GlobalConstants.config.UMWXAppSecret,
                                                 redirectURL: GlobalConstants.config.UMShareURL)
//             设置QQ的appKey和appSecret
            UMSocialManager.default().setPlaform(.QQ, appKey: GlobalConstants.config.UMQQAppId,
                                                 appSecret: GlobalConstants.config.UMQQAppKey,
                                                 redirectURL: GlobalConstants.config.UMShareURL)
            /* 设置微博的appKey和appSecret
             * UMSocialManager.default()?.setPlaform(.sina, appKey: UMSINAAppId, appSecret: UMSINAAppKey, redirectURL: UMShareURL)
             */
           
        })
    }
}
