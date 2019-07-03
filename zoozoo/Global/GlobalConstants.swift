//
//  GlobalConstants.swift
//  zoozoo
//
//  Created by 苹果上的豌豆 on 2019/5/15.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

struct GlobalConstants {
    static let config: Config = kDevConfig
    
}
struct Config {
    let scheme: String
    
    let host: String
    
    let dataCollectScheme: String
    
    let dataCollectHost: String
    
    let apiVersion: String
    
    /// 高德开放平台API key
    let aMapApiKey: String
    //高德高德地图SDK appkey
    let aMapSDKKey: String
    // 友盟SDK
    let UMAppKey: String
    let UMShareURL: String
    let UMWXAppId: String
    let UMWXAppSecret: String
    let UMQQAppId: String
    let UMQQAppKey: String
    let UMSINAAppId: String
    let UMSINAAppKey: String
    
    //个推
    let GTAppId: String
    let GTAppKey: String
    let GTAppSecret: String
    
   
}


/// 正式环境
private let kReleaseConfig = Config(
    scheme: "https://",
    host: "duck.app.zhuiyinanian.com",
    dataCollectScheme: "http://",
    dataCollectHost: "bi.duck.app.zhuiyinanian.com",
    apiVersion: "v1",
    aMapApiKey: "028326061a89ffbb3017c4b63253b78f",
    aMapSDKKey: "e5cd9434c68d8201ff4d1bf98581c732",
    UMAppKey: "5cdcd2b60cafb2d852000d89",
    UMShareURL: "https://www.zhuiyinanian.com/",
    UMWXAppId: "wx1123d39676dce1f6",
    UMWXAppSecret: "211dd52b3cb208e66ef8300858ff75b4",
    UMQQAppId: "1109390115",
    UMQQAppKey: "UuR3nVsQrerIf0ya",
    UMSINAAppId: "",
    UMSINAAppKey: "",
    GTAppId: "RgKDKfPCeWAOH0jT1GUkq5",
    GTAppKey: "pK3KLMdEOh9Dpm9sRIVWA2",
    GTAppSecret: "WZnosOXfs67rStXN6gV0P3")


/// 开发/测试环境
private let kDevConfig = Config(
    scheme: "http://",
//    host: "192.168.31.224:9006",
    host: "120.79.11.136:9006",
    dataCollectScheme: "http://",
    dataCollectHost: "54.222.151.76:8990",
    apiVersion: "v1",
    aMapApiKey: "028326061a89ffbb3017c4b63253b78f",
    aMapSDKKey: "e5cd9434c68d8201ff4d1bf98581c732",
    UMAppKey: "5cdcd2b60cafb2d852000d89",
    UMShareURL: "https://www.zhuiyinanian.com/",
    UMWXAppId: "wx1123d39676dce1f6",
    UMWXAppSecret: "211dd52b3cb208e66ef8300858ff75b4",
    UMQQAppId: "1109390115",
    UMQQAppKey: "UuR3nVsQrerIf0ya",
    UMSINAAppId: "",
    UMSINAAppKey: "",
    GTAppId: "d4a243rLQ07Vd4CXPG5ZZ8",
    GTAppKey: "YRLBtFB9IE7wm4lbTGZJs5",
    GTAppSecret: "eg85pOfSao65uHfYl5l5C3")


enum NetworkError: Int {
    case HttpResquestFailed = -1000,UrlResourceFailed = -2000
}
let errorMSG:String = "服务器接口异常"

/** 当前版本 */
let CurrentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String

//来源
let SOURCE: String            = "iOS"


