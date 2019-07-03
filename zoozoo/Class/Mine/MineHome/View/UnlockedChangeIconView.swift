//
//  UnunlockedChangeIconView.swift
//  zoozoo
//
//  Created by 你猜 on 2019/6/9.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit
import YYText

class UnlockedChangeIconView: UIView {
    lazy var backView:UIView = {
        let view = UIView.init()
        return view
    }()
    lazy var backIconView:UIImageView = {
        let ImageView  = UIImageView.init()
        ImageView.backgroundColor = UIColor.colorWithHex(hex: 0x6760D4, alpha: 0.4)
        ImageView.layer.cornerRadius = 10
        ImageView.layer.masksToBounds = true
        return ImageView
    }()
    lazy var APPIconView:UIImageView = {
        let ImageView  = UIImageView.init()
        ImageView.layer.cornerRadius = 10
        ImageView.layer.masksToBounds = true
        return ImageView
    }()
    
    lazy var BackImageView: UIImageView = {
        let imgaeView=UIImageView.init()
       
        return imgaeView
    }()
    
    lazy var SecondImageView: UIImageView = {
        let imgaeView=UIImageView.init()
        imgaeView.backgroundColor = .white
        imgaeView.layer.cornerRadius = 10
        imgaeView.layer.masksToBounds = true
        return imgaeView
    }()
    
    lazy var iocnImageView: UIImageView = {
        let imgaeView=UIImageView.init()
        imgaeView.image=UIImage(named: "Windowunlocked")
        return imgaeView
    }()
    
    lazy var TitleLab:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = ColorTitle
        label.text = "解锁新图标"
        return label
    }()
    
    lazy var contentLab:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.pingFangTextFont(size: 15)
        label.textColor = ColorGrayTitle
        label.numberOfLines = 0
        label.text = "拥有3个xx类型的朋友，且亲密值达到100；连续7天登录嗅嗅；完善了你的个人资料 "
        return label
    }()
    
    lazy var friendsNumLab:YYLabel = {
        let Lab = YYLabel.init()
        Lab.numberOfLines = 0
        return Lab
    }()
    
    lazy var landingNumLab:YYLabel = {
        let Lab = YYLabel.init()
        Lab.numberOfLines = 0
        return Lab
    }()
    
    lazy var ImperfectNumLab:YYLabel = {
        let Lab = YYLabel.init()
        
        Lab.numberOfLines = 0
        return Lab
    }()
    lazy var SureImageView:UIButton = {
        let Btn = UIButton.init(type: .custom)
        
        Btn.titleLabel?.font = UIFont.pingFangTextFont(size: 16)
        Btn.layer.cornerRadius = 30
        Btn.layer.masksToBounds = true
        Btn.setTitle("明白了!", for: .normal)
        Btn.setTitleColor(ColorWhite, for: .normal)
        Btn.addTarget(self, action: #selector(self.sureAction), for: .touchUpInside)
        Btn.backgroundColor = UIColor.clear
        return Btn
    }()
    
    lazy var DeleteImageView: UIImageView = {
        let imgaeView=UIImageView.init()
        imgaeView.image=UIImage(named: "changeDel")
        imgaeView.isUserInteractionEnabled = true
        imgaeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(deleView)))
        return imgaeView
    }()
    
    var model = APPIconSelectModel()
    //初始化视图
    init(model:APPIconSelectModel) {
        super.init(frame: screenFrame)
        self.model = model
        initSubView()
    }
    
    func initSubView(){
        self.frame = CGRect.init(x: 0, y: 0, width: ScreenW, height: ScreenH)
        self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.8)
        self.ceteateUI()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubView()
    }
    func loadTextColor(text : String) -> NSMutableAttributedString{
        let text = NSMutableAttributedString.init(string:  text)
        text.yy_font = UIFont.pingFangTextFont(size: 12)
        text.yy_color = ColorGrayTitle
        text.yy_alignment = .center
        let range = NSRange.init(location:0  , length: 1)
        text.yy_setFont(UIFont.boldSystemFont(ofSize: 20), range: range)
        text.yy_setColor(ColorTitle, range: range)
        let range1 = NSRange.init(location:1  , length: 2)
        text.yy_setFont(UIFont.boldSystemFont(ofSize: 18), range: range1)
        text.yy_setColor(ColorTitle, range: range1)
        
        return text
    }
    func loadCompeteTextColor(text : String) -> NSMutableAttributedString{
        let text = NSMutableAttributedString.init(string:  text)
        text.yy_font = UIFont.pingFangTextFont(size: 12)
        text.yy_color = ColorGrayTitle
        text.yy_alignment = .center
        let range = NSRange.init(location:0  , length: 3)
        text.yy_setFont(UIFont.boldSystemFont(ofSize: 18), range: range)
        text.yy_setColor(ColorTitle, range: range)
        
        
        return text
    }
    func  ceteateUI(){
    
        self.addSubviews([BackImageView,backView])
        backView.addSubviews([SecondImageView,backIconView,APPIconView,iocnImageView,TitleLab,contentLab,friendsNumLab,landingNumLab,ImperfectNumLab,SureImageView,DeleteImageView])
        
        backView.frame = CGRect.init(x: 0, y: ScreenH, width: ScreenW, height: ScreenH)
        
        
        BackImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        let secondH = ScreenW > 375 ? ScreenW-70 : ScreenW
        
        SecondImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(35)
            make.right.equalToSuperview().offset(-35)
            make.height.equalTo(secondH)
            make.center.equalToSuperview()
        }
        backIconView.snp.makeConstraints { (make) in
            make.width.height.equalTo(80)
            make.centerX.equalToSuperview()
            make.top.equalTo(SecondImageView.snp_top).offset(-40)
        }
        APPIconView.snp.makeConstraints { (make) in
            make.edges.equalTo(backIconView)
        }
        iocnImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(backIconView)
        }

        TitleLab.snp.makeConstraints { (make) in
            make.width.equalTo(SecondImageView)
            make.height.equalTo(20)
            make.centerX.equalToSuperview()
            make.top.equalTo(iocnImageView.snp_bottom).offset(20)
        }
        
        contentLab.snp.makeConstraints { (make) in
            make.width.equalTo(SureImageView)
            make.centerX.equalToSuperview()
            make.top.equalTo(TitleLab.snp_bottom).offset(10)
            make.height.equalTo(80)
        }
        
        friendsNumLab.snp.makeConstraints { (make) in
            make.left.equalTo(SureImageView.snp_left)
            make.bottom.equalTo(SureImageView.snp.top).offset(-10)
            make.height.width.equalTo(100)
        }
        
        landingNumLab.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.height.width.bottom.equalTo(friendsNumLab)
        }
        
        ImperfectNumLab.snp.makeConstraints { (make) in
            make.right.equalTo(SureImageView.snp_right)
            make.height.width.bottom.equalTo(friendsNumLab)
        }
        
       
        SureImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(SecondImageView.snp_bottom).offset(-20)
            make.height.equalTo(60)
            make.width.equalTo(ScreenW*0.63)
        }
        
        DeleteImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(22)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-SafeBottomMargin-80)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadData(){
        
        contentLab.text = "拥有3个\(model.APPIconName)类型的朋友，且亲密值 达到100；连续7天登录嗅嗅；完 善了你的个人资料 "
        APPIconView.image = UIImage.init(named: self.model.APPIconImage)
        
        friendsNumLab.attributedText = loadTextColor(text: "\(model.friendCnt)/3\n “\(model.APPIconName)”朋友")
        landingNumLab.attributedText = loadTextColor(text: "\(model.continueDays)/7\n 连续登录")
        if model.isCompleted == 1 {
            ImperfectNumLab.attributedText = loadCompeteTextColor(text: "已完善\n 个人资料")
        }else{
            ImperfectNumLab.attributedText = loadCompeteTextColor(text:"未完善\n 个人资料")
        }
    }
    
    func show(){
        let window = UIApplication.shared.delegate?.window as? UIWindow
        window?.addSubview(self)
        loadData()
        SureImageView.addButtonGradientLayer()
        BackImageView.addBackViewGradientLayer()
        
        backIconView.transform = CGAffineTransform(rotationAngle: -(CGFloat.pi / 16))
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
            self.alpha = 1.0
            self.isHidden = false
            self.backView.frame = CGRect.init(x: 0, y: 0, width: ScreenW, height: ScreenH)
        }) { (finished) in
            
        }
    }
    
    @objc func dismiss(){
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: {
            self.backView.frame = CGRect.init(x: 0, y: ScreenH, width: ScreenW, height: ScreenH)
        }) { (finished) in
            self.isHidden = true
            self.removeFromSuperview()
        }
        
    }
    
    
    @objc func deleView() {
        dismiss()
    }
    
    @objc func sureAction() {
        dismiss()
    }
    
}
