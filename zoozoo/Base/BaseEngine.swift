//
//  BaseEngine.swift
//  zoozoo
//
//  Created by 苹果上的豌豆 on 2019/5/15.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class BaseEngine: NSObject {
    static let shared: BaseEngine = BaseEngine()
    
    /** 是否登录 */
    var isLogin : Bool {
        get{
            return GlobalDataStore.shared.currentUser.isLogin == 1
        }
    }
    /** 是否第一次安装 */
    var isFirst : Bool {
        get{
            return GlobalDataStore.shared.currentUser.isFirst != 1
        }
    }
    
    public var baseTabBarVC : TabBarController?
    
    public let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    public func goHomeVC(){

        if isLogin {
            goTabHomeVC()
//            if isFirst {
//
//                let vc = UserGuideViewController()
//
//                let nav = NavigationController.init(rootViewController: vc)
//                appDelegate.window?.rootViewController = nav
//            }else{
//
//               goTabHomeVC()
//            }
//
            
        }else{
            
            let loginVC = LoginViewController()
            
            let nav = NavigationController.init(rootViewController:loginVC)
            appDelegate.window?.rootViewController = nav
        }
        
    }
    
    public func goTabHomeVC(){
        let VC = HomeViewController()
        
        let nav = NavigationController.init(rootViewController:VC)
        
//        let menuContrainer = FWSideMenuContainerViewController.container(centerViewController: nav, centerLeftPanViewWidth: 20, centerRightPanViewWidth: 20, leftMenuViewController: MineViewController(), rightMenuViewController: MessegeViewController())
//        menuContrainer.leftMenuWidth = kMenuWidth
//        menuContrainer.rightMenuWidth = kMenuWidth
        appDelegate.window?.rootViewController = nav
    }
    
   
    //MARK:- 本地缓存策略
    public func saveInfo(dic : NSDictionary , key : String){
        
        let path = NSHomeDirectory().appending("/Documents/localData.plist")
        if !FileManager.default.fileExists(atPath: path) {
            NSDictionary.init().write(toFile: path, atomically: true)
        }
        let plistDic = NSMutableDictionary.init(contentsOfFile: path)
        let data = NSKeyedArchiver.archivedData(withRootObject: dic)
        plistDic?.setValue(data, forKey: key)
        plistDic?.write(toFile: path, atomically: true)
    }
    public func fetchInfo(key : String) -> Any? {
        
        let path = NSHomeDirectory().appending("/Documents/localData.plist")
        if !FileManager.default.fileExists(atPath: path) {
            return nil
        }
        let plistDic = NSDictionary.init(contentsOfFile: path)
        let data = plistDic?.value(forKey: key) as? Data
        guard let _ = data else {
            return NSDictionary.init()
        }
        return NSKeyedUnarchiver.unarchiveObject(with: data!)
    }
    //删除音频文件
    public func deleteVoiceFile(){
        let path = CWRecorder.shareInstance()?.recordPath
        CWFlieManager.removeFile(path)
        CWFlieManager.removeFile(CWFlieManager.soundTouchSavePath(withFileName: path?.docuPath()))
    }
    //iOS 10.0触动效果
    public func FeedbackGenerator(){
        
        if #available(iOS 10.0, *) {
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
        }
    }
}
