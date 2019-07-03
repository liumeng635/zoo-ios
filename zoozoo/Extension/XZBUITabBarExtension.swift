//
//  XZB UITabBarExtension.swift
//  YiNain
//
//  Created by 🍎上的豌豆 on 2019/4/10.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

fileprivate let XZBFlag: Int = 666
fileprivate let XZBMSGFlag: Int = 888
extension UITabBar {
   
    
    // MARK:- 显示小红点
    func showBadgOn(index itemIndex: Int, tabbarItemNums: Int = 5) {
        // 移除之前的小红点
        self.removeBadgeOn(index: itemIndex)
        
        // 创建小红点
        let bageView = UIView()
        bageView.tag = itemIndex + XZBFlag
        bageView.layer.cornerRadius = 5
        bageView.backgroundColor = UIColor.colorWithHex(hex: 0xFF583C)
        let tabFrame = self.frame
        
        // 确定小红点的位置
        let percentX: CGFloat = (CGFloat(itemIndex) + 0.59) / CGFloat(tabbarItemNums)
        let x: CGFloat = CGFloat(ceilf(Float(percentX * tabFrame.size.width)))
        let y: CGFloat = CGFloat(ceilf(Float(0.115 * tabFrame.size.height)))
        bageView.frame = CGRect(x: x, y: y, width: 10, height: 10)
        self.addSubview(bageView)
    }
    // MARK:- 隐藏小红点
    func hideBadg(on itemIndex: Int) {
        // 移除小红点
        self.removeBadgeOn(index: itemIndex)
    }
    
    // MARK:- 移除小红点
    fileprivate func removeBadgeOn(index itemIndex: Int) {
        // 按照tag值进行移除
        _ = subviews.map {
            if $0.tag == itemIndex + XZBFlag {
                $0.removeFromSuperview()
            }
        }
    }
    func showBadgNumsOn(index itemIndex: Int, MSGNums: Int ) {
        // 移除之前的小红点
        self.removeBadgeOn(index: itemIndex)
        
        let tabFrame = self.frame
        
        // 确定小红点的位置
        let percentX: CGFloat = (CGFloat(itemIndex) + 0.59) / CGFloat(5)
        let x: CGFloat = CGFloat(ceilf(Float(percentX * tabFrame.size.width)))
        let y: CGFloat = CGFloat(ceilf(Float(0.115 * tabFrame.size.height)))
        // 创建小红点
        
        let bageView = UILabel()
        bageView.font = UIFont.pingFangTextFont(size: 10)
        bageView.textColor = .white
        bageView.textAlignment = .center
        if MSGNums > 99 {
            bageView.text = "99+"
            bageView.frame = CGRect(x: x, y: y, width: 30, height: 20)
        }else if MSGNums > 9{
            bageView.text = "\(MSGNums)"
            bageView.frame = CGRect(x: x, y: y, width: 25, height: 20)
        }else{
            bageView.text = "\(MSGNums)"
            bageView.frame = CGRect(x: x, y: y, width: 20, height: 20)
        }
        bageView.tag = itemIndex + XZBMSGFlag
        bageView.layer.cornerRadius = 10
        bageView.layer.masksToBounds = true
        bageView.backgroundColor = UIColor.colorWithHex(hex: 0xFF583C)
        
        
        self.addSubview(bageView)
    }
    // MARK:- 隐藏小红点数字
    func hideMSGBadg(on itemIndex: Int) {
        // 移除小红点
        self.removeBadgeOn(index: itemIndex)
    }
    // MARK:- 移除小红点数字
    fileprivate func removeMSGBadgeOn(index itemIndex: Int) {
        // 按照tag值进行移除
        _ = subviews.map {
            if $0.tag == itemIndex + XZBMSGFlag {
                $0.removeFromSuperview()
            }
        }
    }
}

// 默认4个tabbarItem
//self.tabBarController?.tabBar.showBadgOn(index: 2)
// 如果不是则用这个方法
// self.tabBarController?.tabBar.showBadgOn(index: Int, tabbarItemNums: CGFloat)

