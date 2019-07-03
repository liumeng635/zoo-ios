//
//  NavigationController.swift
//  zoozoo
//
//  Created by 苹果上的豌豆 on 2019/5/15.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController ,UINavigationControllerDelegate{
    
    var popDelegate: UIGestureRecognizerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.popDelegate = self.interactivePopGestureRecognizer?.delegate
        self.delegate = self
        self.navigationBarSetting()
    }
    private func navigationBarSetting(){
        navigationBar.tintColor           = .white
        /// 设置导航栏背景颜色
        navigationBar.barTintColor = .white
        
//        navigationBar.isTranslucent = false
        
        ///  设置左右Item的文字和图片颜色 (只能是通过UIBarButtonItem创建的，通过自定义视图的不行)
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage.init().getShadowLineImage(ColorLine) 
        
        /// 设置中间标题字体和颜色
        navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor : ColorNavigationBar,
             NSAttributedString.Key.font: UIFont.init(name: "PingFang-SC-Medium", size: 16)!]


        
    }

   
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        
        if self.children.count > 0 {
            // 如果push进来的不是第一个控制器
            
            let button = UIButton.init(type: .custom)
            let image = UIImage.init(named: "back")!
            button.setImage(image, for: .normal)
            button.frame = CGRect.init(x: 0, y: 0, width: image.size.width, height: image.size.width)

            button.contentHorizontalAlignment = .left
            
            button.addTarget(self, action: #selector(self.back), for: .touchUpInside)
            // 修改导航栏左边的item
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
            
            // 隐藏tabbar
            viewController.hidesBottomBarWhenPushed = true
            
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    @objc private func back(_ sender : UIButton){
        
        self .popViewController(animated: true)
        
    }
    
    
    // MARK: - UINavigationControllerDelegate方法
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if viewController == self.viewControllers[0] {
            self.interactivePopGestureRecognizer!.delegate = self.popDelegate
        }
        else {
            self.interactivePopGestureRecognizer!.delegate = nil
        }
    }

}
