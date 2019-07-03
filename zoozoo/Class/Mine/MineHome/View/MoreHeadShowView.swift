//
//  MoreHeadShowView.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/6/18.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class MoreHeadShowView: UIView {

    let moreHeadH = 150 + statusBarH
    var topTexts = ["举报用户","我的主页","返回首页"]
    var topIconsName = ["ic_Report","ic_Home","ic_Home"]
    var container = UIView.init()
    var cancel = UIButton.init()
    var UID = ""
    var nameTitle = ""
    init(UID :String ,nameTitle :String ) {
        super.init(frame: screenFrame)
        self.UID = UID
        self.nameTitle = nameTitle
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

extension MoreHeadShowView {
    
    @objc func onShareItemTap(sender:UITapGestureRecognizer) {
        let index = sender.view?.tag ?? 0
        dismiss()
        //个人空间["举报用户","我的主页","返回首页"]
        if index == 0 {
            let vc = ReportViewController.init(UID: self.UID, name: self.nameTitle)
            self.XZBCuruntView().navigationController?.pushViewController(vc, animated: true)
        }
        
        if index == 1 {
            let vc = PageSpaceViewController.init(userID: GlobalDataStore.shared.currentUser.uid)
            self.XZBCuruntView().navigationController?.pushViewController(vc, animated: true)
        }
        
        if index == 2 {
            self.XZBCuruntView().navigationController?.popToRootViewController(animated: true)
        }
        
        
        
        
        
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

class MoreItem:UIView {
    
    var icon = UIImageView.init()
    var label = UILabel.init()
    init() {
        super.init(frame: .zero)
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
        self.layer.cornerRadius = self.w/2
        self.layer.masksToBounds = true
        self.backgroundColor = ColorTitle
        icon.contentMode = .scaleToFill
        icon.isUserInteractionEnabled = true
        self.addSubview(icon)
        
        label.textColor = UIColor.colorWithHex(hex: 0xB5B5B5)
        label.font = UIFont.pingFangTextFont(size: 12)
        label.textAlignment = .center
        self.addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        icon.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.centerX.equalTo(self)
            make.top.equalTo(self).offset(15)
        }
        label.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(self.icon.snp.bottom).offset(10)
        }
    }
    

}
