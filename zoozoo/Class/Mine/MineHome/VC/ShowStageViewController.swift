//
//  ShowStageViewController.swift
//  zoozoo
//
//  Created by 你猜 on 2019/6/10.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class ShowStageViewController: UIViewController {
    
    lazy var topView:UIView = {
        let View = UIView.init()
        View.backgroundColor = UIColor.clear
        return View
    }()
    
    lazy var editeBtn:editeButton = {
        let Btn = editeButton.init(type: .custom)
        Btn.setTitle("编辑", for: .normal)
        Btn.addTarget(self, action: #selector(edite), for: .touchUpInside)
        Btn.backgroundColor = UIColor.red
        return Btn
    }()
    
    lazy var iconimgaeView: UIImageView = {
        let imgaeView=UIImageView.init()
        imgaeView.image=UIImage(named: "Showiocn")
        imgaeView.isUserInteractionEnabled = true
        imgaeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(iocnAction)))
        return imgaeView
    }()
    
    lazy var starimgaeView: UIImageView = {
        let imgaeView=UIImageView.init()
        imgaeView.image=UIImage(named: "ShowStar")
        imgaeView.isUserInteractionEnabled = true
        imgaeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(starAction)))
        return imgaeView
    }()
    
    lazy var loveimgaeView: UIImageView = {
        let imgaeView=UIImageView.init()
        imgaeView.image=UIImage(named: "ShowLove")
        imgaeView.isUserInteractionEnabled = true
        imgaeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(loveAction)))
        return imgaeView
    }()
    
    lazy var handbookView: UIImageView = {
        let imgaeView=UIImageView.init()
        imgaeView.image=UIImage(named: "ShowHook")
        imgaeView.isUserInteractionEnabled = true
        imgaeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handbookAction)))
        return imgaeView
    }()
    
    lazy var downView:UIView = {
        let View = UIView.init()
        View.backgroundColor = UIColor.clear
        return View
    }()
    
    lazy var titleLab:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.pingFangBoldFont(size: 20)
        label.textColor = ColorMinePolicyTitle
        label.text = "知否知否"
        return label
    }()
    
    lazy var Voiceimage:UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "ShowVoice")
        return imageV
    }()
    
    lazy var Seximage:UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "FriendsWo")
        return imageV
    }()
    
    lazy var ageLab:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.pingFangMediumFont(size: 14)
        label.textColor = ColorMinePolicyTitle
        label.text = "24岁"
        return label
    }()
    
    lazy var constellationimage:UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "Sconstellation")
        return imageV
    }()
    
    lazy var loveBack:UIView = {
        let view = UIView.init()
        view.backgroundColor = UIColor.colorWithRGBA(r: 68, g: 204, b: 192, alpha: 1)
        view.layer.cornerRadius = 2
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var loveimage:UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "MineShowT")
        return imageV
    }()
    
    lazy var loveinum:UILabel = {
        let Lab = UILabel.init()
        Lab.textAlignment = NSTextAlignment.center
        Lab.textColor = ColorWhite
        Lab.font = UIFont.pingFangMediumFont(size: 10)
        Lab.text = "999"
        return Lab
    }()
    
    lazy var Locationimage:UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "ShowLocation")
        return imageV
    }()
    
    lazy var cityLab:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.pingFangMediumFont(size: 14)
        label.textColor = ColorMinePolicyTitle
        label.text = "武汉"
        return label
    }()
    
    
    lazy var OccupationLab:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.pingFangMediumFont(size: 14)
        label.textColor = ColorMinePolicyTitle
        label.text = "互联网/UED设计师"
        return label
    }()
    
    lazy var SchoolLab:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.pingFangMediumFont(size: 14)
        label.textColor = ColorMinePolicyTitle
        label.text = "武汉工程大学/机电工程专业"
        return label
    }()
    

    // 编辑
    @objc private func edite (){
        
    }
    
    // iocn
    @objc private func iocnAction (){
        let createView = PersonalShowTimeView.init(qualifications: 1) // 0 无 1有 权限
        createView.Show()
    }
    
    // star
    @objc private func starAction (){
        
    }
    
    // love
    @objc private func loveAction (){
        
    }
    
    // hook
    @objc private func handbookAction (){
        
    }
    
    
    /// 进入个人真实资料
    @objc private func Tolove(button:UIButton){
        switch button.tag {
        case 1:// 喜欢我
            print(button.tag)
        case 2:// 我喜欢
            print(button.tag)
        default: //图鉴
            APPUserAdoptHandbookURL()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        createUI()
    }
    
    func createUI(){
        self.view.addSubview(topView)
        self.topView.addSubviews([iconimgaeView,starimgaeView,loveimgaeView,handbookView])
        self.view.addSubview(downView)
    self.downView.addSubviews([titleLab,Voiceimage,Seximage,ageLab,constellationimage,loveBack,Locationimage,cityLab,OccupationLab,SchoolLab])
        
        self.loveBack.addSubviews([loveimage,loveinum])
        
        topView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(100)
            make.height.equalTo(60)
            make.top.equalTo(200)
        }
        
        iconimgaeView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(100)
            make.height.equalTo(60)
            make.top.equalTo(200)
        }
        
        loveimgaeView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(100)
            make.height.equalTo(60)
            make.top.equalTo(200)
        }
        
        handbookView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(100)
            make.height.equalTo(60)
            make.top.equalTo(200)
        }
        
        handbookView.snp.makeConstraints { (make) in
            
        }
        
        
    }
    
}


extension ShowStageViewController{
    
    
    // 宠物图鉴
    private func APPUserAdoptHandbookURL(){
        //        guard let phone = self.phoneTextField.text else {
        //            return
        //        }
        
        PetsAPI.shared.APPUserAdoptHandbookURL(lastTime: "", type: 1, success: { (json) in
            if let response = AdoptHandbookModel.deserialize(from: json as? [String:Any]){
                
                if response.code == 200 {
                    
                }else{
                    ShowMessageTool.shared.showMessage("获取好友列表失败")
                }
            }
            
        }) { (error) in
            ShowMessageTool.shared.showMessage("获取宠物图鉴失败")
        }
        
    }
    
}



