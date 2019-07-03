//
//  XZBUILabelExtension.swift
//  XZBBaseSwift
//
//  Created by 🍎上的豌豆 on 2018/10/16.
//  Copyright © 2018年 xiao. All rights reserved.
//

import UIKit

extension UILabel {
    
    /// EZSE: Initialize Label with a font, color and alignment.
    public convenience init(font: UIFont, color: UIColor, alignment: NSTextAlignment) {
        self.init()
        self.font = font
        self.textColor = color
        self.textAlignment = alignment
    }

}
// 给UILabel描边,描边是字体颜色
class lineLabel: UILabel {
    override func drawText(in rect: CGRect) {
        let shadowOffset = self.shadowOffset
        let textColor = self.textColor
    
        let Context = UIGraphicsGetCurrentContext()!
        Context.setLineWidth(1)
        Context.setLineJoin(.round)
        Context.setTextDrawingMode(.stroke)
        self.textColor = textColor
        super.drawText(in: rect)
    
        Context.setTextDrawingMode(.fill)
        self.textColor = UIColor.white
        self.shadowOffset = CGSize(width: CGFloat(0), height:CGFloat(0))
        super.drawText(in: rect)
        self.shadowOffset = shadowOffset
    

    }
    
}
// 给UILabel描边,描边是白色
class lineWhiteLabel: UILabel {
    override func drawText(in rect: CGRect) {
        let shadowOffset = self.shadowOffset
        let textColor = self.textColor
        
        let Context = UIGraphicsGetCurrentContext()!
        Context.setLineWidth(1)
        Context.setLineJoin(.round)
        Context.setTextDrawingMode(.stroke)
        self.textColor = UIColor.white
        super.drawText(in: rect)
        
        Context.setTextDrawingMode(.fill)
        self.textColor = textColor
        self.shadowOffset = CGSize(width: CGFloat(0), height:CGFloat(0))
        super.drawText(in: rect)
        self.shadowOffset = shadowOffset
        
        
    }
    
}
