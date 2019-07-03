//
//  AnimationExtension.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/6/25.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

extension CALayer {
    
    func makeRadarAnimation(showRect: CGRect, isRound: Bool) -> CALayer {
        // 1. 一个动态波
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = showRect
        // showRect 最大内切圆
        shapeLayer.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: showRect.width, height: showRect.height)).cgPath
        shapeLayer.fillColor = UIColor.white.cgColor    //波纹颜色
        shapeLayer.opacity = 0.0    // 默认初始颜色透明度
          
        // 2. 创建动画组 from -> to 透明比例过渡
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = NSNumber(floatLiteral: 1.0)  // 开始透明度
        opacityAnimation.toValue = NSNumber(floatLiteral: 0)      // 结束时透明底
        
        // 3. 波纹动画 起始大小
        let scaleAnimation = CABasicAnimation(keyPath: "transform")
        if isRound {
            scaleAnimation.fromValue = NSValue.init(caTransform3D: CATransform3DScale(CATransform3DIdentity, 1.0, 1.0, 0))      // 缩放起始大小
        } else {
            scaleAnimation.fromValue = NSValue.init(caTransform3D: CATransform3DScale(CATransform3DIdentity, 1.5, 1.5, 0))      // 缩放起始大小
        }
        scaleAnimation.toValue = NSValue.init(caTransform3D: CATransform3DScale(CATransform3DIdentity, 2.0, 2.0, 0))      // 缩放结束大小
        
        // 4. 定义波的运行时间
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [opacityAnimation, scaleAnimation]  //引用opacityAnimation 和 scaleAnimation
        animationGroup.duration = 3.0       // 动画执行时间
        animationGroup.repeatCount = HUGE   // 最大重复
        animationGroup.autoreverses = false
        
       
        shapeLayer.add(animationGroup, forKey: "radarAnimation")  //radarAnimation
        
        // 5. 需要重复的动态波，数量，缩放起始点
        let replicator = CAReplicatorLayer()
        replicator.frame = shapeLayer.bounds
        replicator.instanceCount = 4
        replicator.instanceDelay = 1.0
        replicator.addSublayer(shapeLayer)
        
        return replicator
    }
    
}

extension UIBezierPath {
    func createBezierPath(cornerRadius:CGFloat, width:CGFloat, height:CGFloat) -> UIBezierPath {
        let bezierPath = UIBezierPath.init()
        bezierPath.move(to: CGPoint.init(x: 0, y: cornerRadius))
        bezierPath.addArc(withCenter: CGPoint.init(x: cornerRadius, y: cornerRadius), radius: cornerRadius, startAngle: .pi, endAngle: -.pi / 2, clockwise: true)
        bezierPath.addLine(to: CGPoint.init(x: cornerRadius + width, y: 0))
        bezierPath.addArc(withCenter: CGPoint.init(x: cornerRadius + width, y: cornerRadius), radius: cornerRadius, startAngle: -.pi/2, endAngle: 0, clockwise: true)
        bezierPath.addLine(to: CGPoint.init(x: cornerRadius + width + cornerRadius, y: cornerRadius + height))
        bezierPath.addArc(withCenter: CGPoint.init(x: cornerRadius + width, y: cornerRadius + height), radius: cornerRadius, startAngle: 0, endAngle: .pi/2, clockwise: true)
        bezierPath.addLine(to: CGPoint.init(x: cornerRadius + cornerRadius/4, y: cornerRadius + height + cornerRadius))
        bezierPath.addArc(withCenter: CGPoint.init(x: cornerRadius + cornerRadius/4, y: cornerRadius + height), radius: cornerRadius, startAngle: .pi/2, endAngle: .pi, clockwise: true)
        bezierPath.addLine(to: CGPoint.init(x: cornerRadius/4, y: cornerRadius + cornerRadius/4))
        bezierPath.addArc(withCenter: CGPoint.init(x: 0, y: cornerRadius + cornerRadius/4), radius: cornerRadius/4, startAngle: 0, endAngle: -.pi/2, clockwise: false)
        return bezierPath
    }
}
