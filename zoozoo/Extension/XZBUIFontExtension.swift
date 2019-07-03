//
//  XZBUIFontExtension.swift
//  XZBBaseSwift
//
//  Created by 🍎上的豌豆 on 2018/10/16.
//  Copyright © 2018年 xiao. All rights reserved.
//

import UIKit


extension UIFont {
    
    public class func pingFangSemiboldFont(size: CGFloat) -> UIFont {
        return UIFont.init(name: "PingFang-SC-Semibold", size: size) ?? UIFont.init()
    }
    
    public class func pingFangMediumFont(size: CGFloat) -> UIFont {
        return UIFont.init(name: "PingFang-SC-Medium", size: size) ?? UIFont.init()
    }
    
    public class func pingFangTextFont(size: CGFloat) -> UIFont {
        return UIFont.init(name: "PingFang-SC-Regular", size: size) ?? UIFont.init()
    }
    public class func pingFangLightFont(size: CGFloat) -> UIFont {
        return UIFont.init(name: "PingFang-SC-Light", size: size) ?? UIFont.init()
    }
    public class func pingFangHeavyFont(size: CGFloat) -> UIFont {
        return UIFont.init(name: "PingFang-SC-Heavy", size: size) ?? UIFont.init()
    }
    public class func AppleGothicFont(size: CGFloat) -> UIFont {
        return UIFont.init(name: "AppleGothic", size: size) ?? UIFont.init()
    }
    public class func HelveticaNeueFont(size: CGFloat) -> UIFont {
        return UIFont.init(name: "HelveticaNeue-Light", size: size) ?? UIFont.init()
    }
    
    public class func pingFangBoldFont(size:CGFloat) -> UIFont? {
        return UIFont.init(name: "PingFang-SC-Bold", size: size)
    }
    
}
