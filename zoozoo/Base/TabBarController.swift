//
//  TabBarController.swift
//  zoozoo
//
//  Created by 苹果上的豌豆 on 2019/5/15.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vcArr = [HomeViewController(),RaiseAnimalsViewController(),MineViewController()]
        let tabBarItemTitle = ["首页","消息","我"]
        let tabBarItemImage = ["tab_home","tab_message","tab_me"]
        let tabBarItemselectedImage = ["tab_home_h","tab_message_h","tab_me_h"]
        for i in 0..<vcArr.count {
            addChildViewController(vcArr[i],
                                   title: tabBarItemTitle[i],
                                   image: UIImage(named: tabBarItemImage[i]),
                                   selectedImage: UIImage(named: tabBarItemselectedImage[i]))
        }
    }
    
    
    func addChildViewController(_ childController: UIViewController, title:String?, image:UIImage? ,selectedImage:UIImage?) {
        
        let TabBarLine = UITabBar.appearance()
        TabBarLine.shadowImage = UIImage().getShadowLineImage(ColorLine)
        TabBarLine.backgroundImage = UIImage()
        
        
        childController.title = title
        
        self.tabBar.barTintColor = .white
        childController.tabBarItem.setTitleTextAttributes([kCTFontAttributeName as NSAttributedString.Key:UIFont.init(name: "PingFang-SC-Regular", size: 10)!,NSAttributedString.Key.foregroundColor : ColorTabbarColor], for: .normal)
        childController.tabBarItem.setTitleTextAttributes([kCTFontAttributeName as NSAttributedString.Key:UIFont.init(name: "PingFang-SC-Regular", size: 10)!,NSAttributedString.Key.foregroundColor : ColorTitle], for: .selected)
        
        
        childController.tabBarItem.image = image?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        
        childController.tabBarItem.selectedImage = selectedImage?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        
        
        addChild(NavigationController(rootViewController: childController))
    }
    
}
