//
//  XZBUIButtonExtension.swift
//  XZBBaseSwift
//
//  Created by 🍎上的豌豆 on 2018/10/16.
//  Copyright © 2018年 xiao. All rights reserved.
//

import UIKit

extension UIButton {
    
    
    public convenience init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat, target: AnyObject, action: Selector) {
        self.init(frame: CGRect(x: x, y: y, width: w, height: h))
        addTarget(target, action: action, for: UIControl.Event.touchUpInside)
    }
    
    
    public func setBackgroundColor(_ color: UIColor, forState: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()?.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setBackgroundImage(colorImage, for: forState)
    }
    
}
class RaiseButtonExt: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        
        // 设置imageView
        imageView?.contentMode = .center
        // 设置tilte
        titleLabel?.textAlignment = .center
        // 设置imageView
        imageView?.frame = CGRect(x: (self.frame.width - 30)/2, y: 0, width: 30 , height: 30)
        // 设置title
        titleLabel?.frame = CGRect(x: 0, y: 35, width: self.frame.width, height: 15)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
}
class RaiseSettingButtonExt: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        
        // 设置imageView
        imageView?.contentMode = .center
        // 设置tilte
        titleLabel?.textAlignment = .center
        // 设置imageView
        imageView?.frame = CGRect(x: (self.frame.width - 25)/2, y: 10, width: 25 , height: 25)
        // 设置title
        titleLabel?.frame = CGRect(x: 0, y: 35, width: self.frame.width, height: 15)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
}


class XZBUIButtonExt: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        
        // 设置imageView
        imageView?.contentMode = .center
        // 设置tilte
        titleLabel?.textAlignment = .center
        // 设置imageView
        imageView?.frame = CGRect(x: 0, y: 0, width: self.frame.width , height: self.frame.height - 25)
        // 设置title
        titleLabel?.frame = CGRect(x: 0, y: self.frame.height - 25, width: self.frame.width, height: 20)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
}

// 图片在左 文字在右
class XZBUIButtonImgLTextR: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.masksToBounds = true
        self.layer.cornerRadius  = 30
        self.titleLabel?.font = UIFont.pingFangTextFont(size: 15)
        self.backgroundColor = ColorWhite
        self.setTitleColor(UIColor.colorWithRGBA(r:182.0, g: 182.0, b: 182.0, alpha: 1), for: .normal)
        self.setImage(UIImage.init(named: "SexUnSelection"), for: .normal)
        self.setImage(UIImage.init(named: "SexSelection"), for: .selected)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupLayout() {
        // 设置imageView
        imageView?.contentMode = .center
        // 设置tilte
        titleLabel?.textAlignment = .center
        // 设置imageView
        imageView?.frame = CGRect(x: self.frame.width/4, y: self.frame.height/4, width: self.frame.height/2 , height: self.frame.height/2)
        // 设置title
        titleLabel?.frame = CGRect(x: self.frame.width/2, y: 0, width: self.frame.width/4, height: self.frame.height)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
}




class XZBShareButtonExt: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        
        // 设置imageView
        imageView?.contentMode = .center
        // 设置tilte
        titleLabel?.textAlignment = .center
        // 设置imageView
        imageView?.frame = CGRect(x: 0, y: 0, width: self.frame.width , height: self.frame.height - 40)
        // 设置title
        titleLabel?.frame = CGRect(x: 0, y: self.frame.height - 40, width: self.frame.width, height: 20)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupLayout()
    }
    func startAnimation(delayTime:TimeInterval) {
        let originalFrame = self.frame
        self.frame = CGRect.init(origin: CGPoint.init(x: originalFrame.minX, y: 35), size: originalFrame.size)
        UIView.animate(withDuration: 0.9, delay: delayTime, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: {
            self.frame = originalFrame
        }) { finished in
        }
    }
    
}

//MARK: -定义button相对label的位置
public enum XZBButtonEdgeInsetsStyle {
    case Top
    case Left
    case Right
    case Bottom
}

public extension UIButton {
    
    func layoutButton(style: XZBButtonEdgeInsetsStyle, imageTitleSpace: CGFloat) {
        //得到imageView和titleLabel的宽高
        let imageWidth = self.imageView?.frame.size.width
        let imageHeight = self.imageView?.frame.size.height
        
        var labelWidth: CGFloat! = 0.0
        var labelHeight: CGFloat! = 0.0
        
        labelWidth = self.titleLabel?.intrinsicContentSize.width
        labelHeight = self.titleLabel?.intrinsicContentSize.height
        
        //初始化imageEdgeInsets和labelEdgeInsets
        var imageEdgeInsets: UIEdgeInsets = .zero
        var labelEdgeInsets: UIEdgeInsets = .zero
        
        //根据style和space得到imageEdgeInsets和labelEdgeInsets的值
        switch style {
        case .Top:
            //上 左 下 右
            imageEdgeInsets = UIEdgeInsets(top: -labelHeight-imageTitleSpace/2, left: 0, bottom: 0, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!, bottom: -imageHeight!-imageTitleSpace/2, right: 0)
            break;
            
        case .Left:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -imageTitleSpace/2, bottom: 0, right: imageTitleSpace)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: imageTitleSpace/2, bottom: 0, right: -imageTitleSpace/2)
            break;
            
        case .Bottom:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight!-imageTitleSpace/2, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: -imageHeight!-imageTitleSpace/2, left: -imageWidth!, bottom: 0, right: 0)
            break;
            
        case .Right:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth+imageTitleSpace/2, bottom: 0, right: -labelWidth-imageTitleSpace/2)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!-imageTitleSpace/2, bottom: 0, right: imageWidth!+imageTitleSpace/2)
            break;
            
        }
        
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
        
    }
}


extension Array {
    subscript(i1: Int, i2: Int, rest: Int...) -> [Element] {
        get {
            var result: [Element] = [self[i1], self[i2]]
            for index in rest {
                result.append(self[index])
            }
            return result
        }
        
        set (values) {
            for (index, value) in zip([i1, i2] + rest, values) {
                self[index] = value
            }
        }
    }
}

// 给button添加下划线
class BottonLineBtn: UIButton {
    override func draw(_ rect: CGRect) {
        guard let titleLabel = self.titleLabel else {
            return
        }
        let textRect: CGRect = titleLabel.frame
        let contextRef: CGContext = UIGraphicsGetCurrentContext()!
        let descender: CGFloat = titleLabel.font.descender
        contextRef.setStrokeColor(titleLabel.textColor.cgColor)
        contextRef.move(to: CGPoint(x: textRect.origin.x, y: textRect.origin.y + textRect.size.height + descender + 4))
        contextRef.addLine(to: CGPoint(x: textRect.origin.x + textRect.size.width, y: textRect.origin.y + textRect.size.height + descender + 4))
        contextRef.closePath()
        contextRef.strokePath()
    }
    
}
