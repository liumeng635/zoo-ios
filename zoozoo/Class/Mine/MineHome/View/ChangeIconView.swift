//
//  ChangeIconView.swift
//  zoozoo
//
//  Created by 你猜 on 2019/6/9.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class ChangeIconView: UIView {
    
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
        imgaeView.image=UIImage(named: "LOGO")
        return imgaeView
    }()

    lazy var TitleLab:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = ColorTitle
        label.backgroundColor = UIColor.clear
        label.text = "嗅嗅"
        return label
    }()

    lazy var contentLab:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.pingFangTextFont(size: 15)
        label.textColor =  ColorGrayTitle
        label.text = "默认图标\n 在嗅嗅，找到臭味相投的TA "
        label.numberOfLines = 0
        return label
    }()

  
    
    lazy var SureImageView:UIButton = {
        let Btn = UIButton.init(type: .custom)
       
        Btn.titleLabel?.font = UIFont.pingFangTextFont(size: 16)
        Btn.layer.cornerRadius = 30
        Btn.layer.masksToBounds = true
        Btn.setTitle("使用该图标", for: .normal)
        Btn.setTitleColor(ColorWhite, for: .normal)
        Btn.addTarget(self, action: #selector(self.sureAction), for: .touchUpInside)
        Btn.backgroundColor = UIColor.clear
        return Btn
    }()

    lazy var DeleteImageView: UIImageView = {
        let imgaeView = UIImageView.init()
        imgaeView.image = UIImage(named: "changeDel")
        imgaeView.isUserInteractionEnabled = true
        imgaeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(deleView)))
        return imgaeView
    }()
    
    var IconPathUrl = "duck"
    
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
        ceteateUI()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubView()
    }

    func  ceteateUI(){
        self.addSubviews([BackImageView,backView])
        backView.addSubviews([SecondImageView,backIconView,iocnImageView,TitleLab,contentLab,SureImageView,DeleteImageView])
        
         backView.frame = CGRect.init(x: 0, y: ScreenH, width: ScreenW, height: ScreenH)
        
        BackImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
       
       

        SecondImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(35)
            make.right.equalToSuperview().offset(-35)
            make.height.equalTo(ScreenW-70)
            make.center.equalToSuperview()
        }
        backIconView.snp.makeConstraints { (make) in
            make.width.height.equalTo(80)
            make.centerX.equalToSuperview()
            make.top.equalTo(SecondImageView.snp_top).offset(-40)
        }
        iocnImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(backIconView)
        }

        TitleLab.snp.makeConstraints { (make) in
            make.width.equalTo(SureImageView)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
            make.top.equalTo(iocnImageView.snp_bottom).offset(30)
        }

        contentLab.snp.makeConstraints { (make) in
            make.width.equalTo(SecondImageView)
            make.centerX.equalToSuperview()
            make.top.equalTo(TitleLab.snp_bottom).offset(20)
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
    
    func reloadData(){
        iocnImageView.image = UIImage.init(named: model.APPIconImage)
        if model.systemGift{
            contentLab.text = "你来到嗅嗅的第一天\n 就使用了\(model.APPIconName)作为首个形象\n 我们将此图标送给你\n 希望你玩的开心"
        }else{
            if model.APPIconName == "嗅嗅" {
                contentLab.text = "默认图标\n 在嗅嗅，找到臭味相投的TA "
            }else{
                contentLab.text = "\(model.APPIconName)\n 在嗅嗅，找到臭味相投的TA "
            }
            
        }
    }
    
    func show(){
        let window = UIApplication.shared.delegate?.window as? UIWindow
        window?.addSubview(self)
        SureImageView.addButtonGradientLayer()
        BackImageView.addBackViewGradientLayer()
        
        backIconView.transform = CGAffineTransform(rotationAngle: -(CGFloat.pi / 16))
        reloadData()
       
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
    
     public var changeIconBlock : (()->Void)?
    
    @objc func sureAction() {
        
        self.changeIconBlock?()
        
        dismiss()
        
        
        

        
    }

}

