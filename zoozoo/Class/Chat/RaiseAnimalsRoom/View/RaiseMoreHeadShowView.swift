//
//  RaiseMoreHeadShowView.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/6/30.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class RaiseMoreHeadShowView: UIView {

    let moreHeadH = 150 + statusBarH
    var topTexts = ["群体喂养","群体遛弯","群体出题"]
    var topIconsName = ["feeding","play","problem"]
    var container = UIView.init()
    var cancel = UIButton.init()

    var animalsData = [RaiseAnimalsModel]()
    init(animalsData :[RaiseAnimalsModel] ) {
        super.init(frame: screenFrame)
        self.animalsData = animalsData
        topTexts = ["群体喂养","群体遛弯","群体出题"]
        topIconsName = ["feeding","play","problem"]
       
        initSubView()
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func initSubView() {
        self.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(handleGuesture(sender:))))
        self.backgroundColor = .clear
        container.frame = CGRect.init(x: 0, y: -ScreenH, width: ScreenW, height: moreHeadH)
        container.backgroundColor = UIColor.init(white: 0, alpha: 0.3)
        self.addSubview(container)
        
        let rounded = UIBezierPath.init(roundedRect: CGRect.init(origin: .zero, size: CGSize.init(width: ScreenW, height: moreHeadH)), byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize.init(width: 10.0, height: 10.0))
        let shape = CAShapeLayer.init()
        shape.path = rounded.cgPath
        container.layer.mask = shape
        
        let blurEffect = UIBlurEffect.init(style: .dark)
        let visualEffectView = UIVisualEffectView.init(effect: blurEffect)
        visualEffectView.frame = self.bounds
        visualEffectView.alpha = 1.0
        container.addSubview(visualEffectView)
        
        cancel = UIButton.init(type: .custom)
        cancel.frame = CGRect.init(x: ScreenW - 30, y: statusBarH + 20, width: 15, height: 15)
        cancel.setImage(UIImage.init(named: "ic_Close"), for: .normal)
        cancel.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        container.addSubview(cancel)
        
        let itemWidth = (ScreenW - 80*3)/4
        
        for index in 0..<topIconsName.count {
            let item = MoreItem.init(frame: CGRect.init(x: (itemWidth + 80) * CGFloat.init(index) + itemWidth , y: statusBarH + 50, width: 80, height: 80))
            item.icon.image = UIImage.init(named: topIconsName[index])
            item.label.text = topTexts[index]
            item.tag = index
            item.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(onShareItemTap(sender:))))
            
            container.addSubview(item)
        }
        
        
        
        
    }
    
    
    
    
}

extension RaiseMoreHeadShowView {
    
    @objc func onShareItemTap(sender:UITapGestureRecognizer) {
        let index = sender.view?.tag ?? 0
        dismiss()
        //["群体喂养","群体遛弯","群体出题"]跳转上传页面
        var type = RaiseType.feeding
        if index == 0 {
            type = .feeding
        }
        if index == 1 {
            type = .play
        }
        if index == 2 {
            type = .education
        }
        let vc = PublishViewController.init(type: type, dataArr: self.animalsData)
        let nav = NavigationController.init(rootViewController: vc)
        self.XZBCuruntView().present(nav, animated: true, completion: nil)
        
        
        
        
        
    }
    
    @objc func handleGuesture(sender:UITapGestureRecognizer) {
        var point = sender.location(in: container)
        if !(container.layer.contains(point)) {
            dismiss()
            return
        }
        point = sender.location(in: cancel)
        if cancel.layer.contains(point) {
            dismiss()
        }
    }
    
    func show() {
        let window = UIApplication.shared.delegate?.window as? UIWindow
        window?.addSubview(self)
        UIView.animate(withDuration: 0.15, delay: 0.0, options: .curveEaseOut, animations: {
            
            self.container.frame = CGRect.init(x: 0, y: 0, width: ScreenW, height: self.moreHeadH)
        }) { finshed in
        }
    }
    
    @objc func dismiss() {
        UIView.animate(withDuration: 0.15, delay: 0.0, options: .curveEaseIn, animations: {
            self.container.frame = CGRect.init(x: 0, y: -ScreenH, width: ScreenW, height: self.moreHeadH)
        }) { finshed in
            self.removeFromSuperview()
        }
    }

}
