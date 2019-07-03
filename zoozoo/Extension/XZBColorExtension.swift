//
//  XZBColorExtension.swift
//  XZBBaseSwift
//
//  Created by 🍎上的豌豆 on 2018/10/16.
//  Copyright © 2018年 xiao. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func colorWithRGBA(r:CGFloat,g:CGFloat,b:CGFloat,alpha:CGFloat) -> UIColor{
        
        return self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
    static func colorWithRGB(r:CGFloat,g:CGFloat,b:CGFloat) -> UIColor{
        
        return colorWithRGBA(r: r, g: g, b: b, alpha: 1)
    }
    
    static func colorWithHex(hex : Int) -> UIColor {
        return UIColor.colorWithHex(hex: hex, alpha: 1)
    }
    
    static func colorWithHex(hex : Int , alpha : CGFloat) -> UIColor{
        return UIColor.init(red: CGFloat((hex >> 16) & 0xFF)/255.0 , green: CGFloat((hex >> 8) & 0xFF)/255.0 , blue: CGFloat(hex & 0xFF)/255.0 , alpha: alpha)
    }
    
   static func randomColor() -> UIColor {
    return colorWithRGB(r: CGFloat(arc4random_uniform(256)),
                        g: CGFloat(arc4random_uniform(256)),
                        b: CGFloat(arc4random_uniform(256)))
    }
    
    // 颜色16 进制 转换  样式 #5B5B5B
    static func UIColorFromRGB(color_vaule : String , alpha : CGFloat = 1) -> UIColor {
        
        if color_vaule.isEmpty {
            return UIColor.clear
        }
        
        var cString = color_vaule.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        
        if cString.count == 0 {
            return UIColor.clear
        }
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        if cString.count < 6 && cString.count != 6 {
            
            return UIColor.clear
        }
        
        let value = "0x\(cString)"
        
        let scanner = Scanner(string:value)
        
        var hexValue : UInt64 = 0
        //查找16进制是否存在
        if scanner.scanHexInt64(&hexValue) {
//            print(hexValue)
            let redValue = CGFloat((hexValue & 0xFF0000) >> 16)/255.0
            let greenValue = CGFloat((hexValue & 0xFF00) >> 8)/255.0
            let blueValue = CGFloat(hexValue & 0xFF)/255.0
            return UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: alpha)
        }else{
            return UIColor.clear
        }
    }
    
    func image() -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(self.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
}

extension UIColor {
    //左右渐变
    public class func setGradualLeftToRightColor(view:UIView,fromColor:UIColor,toCololr:UIColor,loactions:[NSNumber]=[0.5,0.0]) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        //  创建渐变色数组，需要转换为CGColor颜色
        gradientLayer.colors = [fromColor.cgColor,toCololr.cgColor]
        //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint =  CGPoint(x: 1, y: 0)
        //  设置颜色变化点，取值范围 0.0~1.0
        gradientLayer.locations = loactions
        return gradientLayer
    }
    
    public class func setGradualChangingColor(view:UIView,fromColor:UIColor,toCololr:UIColor,loactions:[NSNumber]=[0,0.5]) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        //  创建渐变色数组，需要转换为CGColor颜色
        gradientLayer.colors = [fromColor.cgColor,toCololr.cgColor]
        //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint =  CGPoint(x: 0, y: 1)
        //  设置颜色变化点，取值范围 0.0~1.0
        gradientLayer.locations = loactions
        return gradientLayer
    }
}


extension UIColor{
    
    public static func gh_hexColor(_ hexColor : Int64) -> UIColor {
        
        let red = ((CGFloat)((hexColor & 0xFF0000) >> 16))/255.0;
        let green = ((CGFloat)((hexColor & 0xFF00) >> 8))/255.0;
        let blue = ((CGFloat)(hexColor & 0xFF))/255.0;
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    public convenience init?(hex : String, alpha : CGFloat = 1.0) {
        
        // 0xff0000
        // 1.判断字符串的长度是否符合
        guard hex.count >= 6 else {
            return nil
        }
        
        // 2.将字符串转成大写
        var tempHex = hex.uppercased()
        
        // 3.判断开头: 0x/#/## 截取字符串
        if tempHex.hasPrefix("0X") || tempHex.hasPrefix("##") {
            tempHex = (tempHex as NSString).substring(from: 2)
        }
        if tempHex.hasPrefix("#") {
            tempHex = (tempHex as NSString).substring(from: 1)
        }
        // 4.分别取出RGB
        // FF --> 255
        var range = NSRange(location: 0, length: 2)
        let rHex = (tempHex as NSString).substring(with: range)
        range.location = 2
        let gHex = (tempHex as NSString).substring(with: range)
        range.location = 4
        let bHex = (tempHex as NSString).substring(with: range)
        
        // 5.将十六进制转成数字 emoji表情 扫描器
        var r : UInt32 = 0, g : UInt32 = 0, b : UInt32 = 0
        Scanner(string: rHex).scanHexInt32(&r)
        Scanner(string: gHex).scanHexInt32(&g)
        Scanner(string: bHex).scanHexInt32(&b)
        self.init(r : CGFloat(r), g : CGFloat(g), b : CGFloat(b))
    }
    convenience init(hexString:String){
        //处理数值
        var cString = hexString.uppercased().trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        let length = (cString as NSString).length
        //错误处理
        if (length < 6 || length > 7 || (!cString.hasPrefix("#") && length == 7)){
            //返回whiteColor
            self.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
            return
        }
        
        if cString.hasPrefix("#"){
            cString = (cString as NSString).substring(from: 1)
        }
        
        //字符chuan截取
        var range = NSRange()
        range.location = 0
        range.length = 2
        
        let rString = (cString as NSString).substring(with: range)
        
        range.location = 2
        let gString = (cString as NSString).substring(with: range)
        
        range.location = 4
        let bString = (cString as NSString).substring(with: range)
        
        //存储转换后的数值
        var r:UInt32 = 0,g:UInt32 = 0,b:UInt32 = 0
        //进行转换
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        //根据颜色值创建UIColor
        self.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1.0)
    }
    public class func gh_randomColor() -> UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
    
    // 在extension中给系统的类扩充构造函数,只能扩充`便利构造函数`
    // 1、构造函数加 加 convenience
    // 2、必须调用 self.init
    public convenience init(r : CGFloat, g : CGFloat, b : CGFloat, alpha : CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
}
