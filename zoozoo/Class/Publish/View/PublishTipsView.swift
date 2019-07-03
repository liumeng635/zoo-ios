//
//  PublishTipsView.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/6/30.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class PublishTipsView: UIView {
    lazy var backView:UIView = {
        let view = UIView.init()
        view.backgroundColor = .clear
        return view
    }()
    lazy var whiteView:UIView = {
        let view = UIView.init()
        view.backgroundColor = .white
        view.layer.cornerRadius  = 10
        view.layer.masksToBounds = true
        backView.addSubview(view)
        return view
    }()
    lazy var imageV : UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "publishLove")
        backView.addSubview(imageV)
        return imageV
        }()
    lazy var topLabel : UILabel = {
        let Label = UILabel.init()
        Label.font = UIFont.boldSystemFont(ofSize: 18)
        Label.textColor = ColorTitle
        Label.textAlignment = .center
        Label.frame = CGRect.init(x: 0, y: 50, width:  ScreenW - 70, height: 30)
        whiteView.addSubview(Label)
        return Label
        }()
    lazy var qinmiLabel : UILabel = {
        let Label = UILabel.init()
        Label.font = UIFont.pingFangTextFont(size: 15)
        Label.textColor = ColorTheme
        Label.textAlignment = .center
        Label.text = "亲密值+10"
        Label.frame = CGRect.init(x: 0, y: topLabel.bottom + 10, width:  ScreenW - 70, height: 20)
        whiteView.addSubview(Label)
        return Label
        }()
    lazy var deLabel : UILabel = {
        [unowned self] in
        let Label = UILabel.init()
        Label.font = UIFont.pingFangTextFont(size: 15)
        Label.textColor = ColorGrayTitle
        Label.textAlignment = .center
        Label.numberOfLines = 0
         Label.frame = CGRect.init(x: 0, y: qinmiLabel.bottom + 10, width:  ScreenW - 70, height: 20)
        whiteView.addSubview(Label)
        return Label
        }()
    var type = RaiseType.feeding
    var isNomal = true
    init(type :RaiseType,isNomal :Bool) {
        super.init(frame: screenFrame)
        self.type = type
        self.isNomal = isNomal
         initSubView()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func initSubView(){
        
        self.frame = CGRect.init(x: 0, y: 0, width: ScreenW, height: ScreenH)
        self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.8)
        self.addSubview(backView)
        backView.alpha = 0
        self.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(dismiss)))
        
        
        
        if isNomal {
            self.createTypeUI()
        }else{
            self.createOtherTypeUI()
        }
    }
    func createTypeUI(){
       backView.frame = CGRect.init(x: 35, y: 0, width: ScreenW - 70, height: 200)
        backView.centerY = self.centerY - 40
         whiteView.frame = CGRect.init(x: 0, y: 40, width: ScreenW - 70, height:160)
        imageV.frame = CGRect.init(x: (ScreenW - 70)/2 - 55, y: 0, width: 110, height: 80)
    
    
        switch self.type {
        case .feeding:
            topLabel.text = "喂养成功！"
            deLabel.text = "能与你共享美食，真开心~"
        case .play:
            topLabel.text = "遛弯成功！"
            deLabel.text = "有你陪着我的感觉真好~"
        case .education:
            topLabel.text = "出题成功！"
           deLabel.text = "继续加油喔，看好你！"
        }
        
    }
    func createOtherTypeUI(){
        backView.frame = CGRect.init(x: 35, y: 0, width: ScreenW - 70, height: 240)
        backView.centerY = self.centerY - 40
        
        whiteView.frame = CGRect.init(x: 0, y: 40, width: ScreenW - 70, height:200)
        deLabel.frame = CGRect.init(x: 0, y: qinmiLabel.bottom + 10, width: whiteView.w, height: 60)
        imageV.frame = CGRect.init(x: (ScreenW - 70)/2 - 55, y: 0, width: 110, height: 80)
        
        imageV.image = UIImage.init(named: "publishok")
        qinmiLabel.text = "亲密值+5"
        switch self.type {
        case .feeding:
            topLabel.text = "喂养成功！"
            deLabel.text = "每天的喂食\n 都是一次相互了解的机会哦~"
        case .play:
            topLabel.text = "串门成功！"
            deLabel.text = "近期的生活照片都可与小乖兽分享\n 了解彼此生活，从遛弯开始"
        case .education:
            topLabel.text = "题目已发送"
            deLabel.text = "每天出个题目做\n 保证脑壳不生锈"
        }
        
    }
    
    //MARK:显示
    
    func show(){
        
        let window = UIApplication.shared.delegate?.window as? UIWindow
        window?.addSubview(self)
        backView.transform = backView.transform.scaledBy(x: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .beginFromCurrentState, animations: {
            self.backView.transform = .identity
            self.backView.alpha = 1
            self.alpha = 1
        }) { (finish) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                 self.dismiss()
            }
           
            
        }
        
        
        
    }
    @objc func dismiss(){
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .beginFromCurrentState, animations: {
            self.backView.transform = self.backView.transform.scaledBy(x: 0.5, y: 0.5)
            self.backView.alpha = 0
            self.alpha = 0
        }) { (finish) in
            self.isHidden = true
            self.removeFromSuperview()
        }
        
        
        
    }


}


class PublishCloseTipsView: BaseShowView {
    
    public  var PublishCloseOutBlcok  : (() -> Void)?
    
    
    lazy var TitleLab:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = ColorTitle
        label.frame = CGRect.init(x: 0, y: 15, width: ScreenW - 70 , height: 30)
        
        return label
    }()
    lazy var close: UIImageView = {
        let arrowView = UIImageView.init()
        arrowView.image = UIImage.init(named: "ic_Close")?.render(color: ColorGrayColor)
        arrowView.frame = CGRect.init(x: self.backView.w - 20, y: 5, width: 10, height: 10)
        return arrowView
    }()
    lazy var deLab:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.pingFangTextFont(size: 15)
        label.textColor = ColorGrayTitle
        label.frame = CGRect.init(x: 0, y: TitleLab.bottom + 10, width: ScreenW - 70 , height: 80)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var cancelBtn:UIButton = {
        let Btn = UIButton.init(type: .custom)
        Btn.layer.cornerRadius  = 22
        Btn.layer.masksToBounds = true
        Btn.layer.borderColor = ColorTheme.cgColor
        Btn.layer.borderWidth = 1
        Btn.setTitleColor(ColorTheme, for: .normal)
        Btn.titleLabel?.font = UIFont.pingFangTextFont(size: 16)
        Btn.addTarget(self, action: #selector(leftAction), for: .touchUpInside)
        Btn.frame = CGRect.init(x: (ScreenW - 70)/2 - 110 - 10, y: deLab.bottom + 20, width: 110 , height: 44)
        return Btn
    }()
    
    lazy var SureBtn:UIButton = {
        let Btn = UIButton.init(type: .custom)
        Btn.layer.cornerRadius  = 22
        Btn.layer.masksToBounds = true
        Btn.setTitleColor(ColorWhite, for: .normal)
        Btn.titleLabel?.font = UIFont.pingFangTextFont(size: 16)
        Btn.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
         Btn.frame = CGRect.init(x: cancelBtn.right + 10, y: cancelBtn.top, width: cancelBtn.w , height: cancelBtn.h)
        return Btn
    }()
    
    lazy var bottomLab:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.pingFangTextFont(size: 12)
        label.textColor = ColorLightTitleColor
        label.frame = CGRect.init(x: 0, y: cancelBtn.bottom + 15, width: ScreenW - 70, height: 15)
        
        return label
    }()
    
    
    
    lazy var outBtn:UIButton = {
        let Btn = UIButton.init(type: .custom)
        Btn.setTitle("退出编辑", for: .normal)
        Btn.setTitleColor(ColorGrayTitle, for: .normal)
        Btn.titleLabel?.font = UIFont.pingFangTextFont(size: 16)
        Btn.addTarget(self, action: #selector(OutAction), for: .touchUpInside)
        Btn.setBackgroundColor(ColorBackGround, forState: .normal)
        Btn.frame = CGRect.init(x: 0, y: 250, width: (ScreenW - 70), height: 50)
        return Btn
    }()
    var type = RaiseType.feeding
    var model = RaiseAnimalsModel()
    init(type :RaiseType,model:RaiseAnimalsModel) {
        super.init(frame: screenFrame)
        self.type = type
        self.model = model
        initSubView()
        ceteateUI()
    }
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubView()
        ceteateUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func  ceteateUI(){
        backView.frame = CGRect.init(x: 35, y: 0, width: ScreenW - 70, height: 300)
        backView.center = self.center
        backView.addSubviews([TitleLab,close,deLab,cancelBtn,SureBtn,bottomLab,outBtn])
        self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.6)
        self.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(dismiss)))
       
        
        SureBtn.addButtonGradientLayer()
        switch self.type {
        case .feeding:
            TitleLab.text = "你的小乖兽好饿呀"
            deLab.text = "喂养它，可以大大增加你们的亲密值喔\n 亲自喂养：+10亲密值\n 一键喂养：+5亲密值"
            cancelBtn.setTitle("一键投食", for: .normal)
            SureBtn.setTitle("亲自喂养", for: .normal)
     
            let feedModel = model.oneKeyCnt.feed
            if feedModel.canDo == 0 {
                canisEnabled()
                bottomLab.text = "今日已一键投食次数：\(feedModel.dailyCnt)/\(feedModel.dailyCnt)"
            }else{
                cancelBtn.isEnabled = true
                bottomLab.text = "今日已一键投食次数：\(feedModel.todayCnt)/\(feedModel.dailyCnt)"
            }
            
        case .play:
            TitleLab.text = "小乖兽想出门嗨一下"
            deLab.text = "带它遛弯，可以大大增加你们的亲密值喔\n 带它遛弯：+10亲密值\n 丢去串门：+20亲密值"
            cancelBtn.setTitle("丢去串门", for: .normal)
            SureBtn.setTitle("带她遛弯", for: .normal)
            let playModel = model.oneKeyCnt.accompany
            if playModel.canDo == 0 {
                canisEnabled()
                bottomLab.text = "今日已丢去串门次数：\(playModel.dailyCnt)/\(playModel.dailyCnt)"
            }else{
                cancelBtn.isEnabled = true
                bottomLab.text = "今日已丢去串门次数：\(playModel.todayCnt)/\(playModel.dailyCnt)"
            }
        case .education:
            
            backView.frame = CGRect.init(x: 35, y: 0, width: ScreenW - 70, height: 300)
            backView.center = self.center
            deLab.frame = CGRect.init(x: 0, y: TitleLab.bottom + 10, width: self.backView.w , height: 100)
            TitleLab.text = "不能输在起跑线上"
            deLab.text = "上传你的学习照/工作照，它就可以学习咯\n 可以大大增加你们的亲密值喔\n 我来教育：+10亲密值\n 一键出题：+5亲密值"
            cancelBtn.setTitle("一键出题", for: .normal)
            SureBtn.setTitle("我来教育", for: .normal)
            let eduModel = model.oneKeyCnt.edu
            if eduModel.canDo == 0 {
                canisEnabled()
                bottomLab.text = "今日已一键出题次数：\(eduModel.dailyCnt)/\(eduModel.dailyCnt)"
            }else{
                cancelBtn.isEnabled = true
                bottomLab.text = "今日已一键出题次数：\(eduModel.todayCnt)/\(eduModel.dailyCnt)"
            }
        }
        
    }
    func canisEnabled(){
        cancelBtn.layer.borderColor = ColorLightTitleColor.cgColor
        cancelBtn.setTitleColor(ColorLightTitleColor, for: .normal)
        cancelBtn.isEnabled = false
    }
    @objc func OutAction(){
        dismiss()
        self.PublishCloseOutBlcok?()
    }
    @objc func leftAction(){
       
        var num = 0
        switch self.type {
        case .feeding:
            num = 1
        case .play:
           num = 2
        case .education:
            num = 3
        }
        
        let arr = ["一键喂食","一键遛弯","一键教育"]
        guard let uid = model.userId else {
            ShowMessageTool.shared.showMessage("\(arr[num - 1])失败")
            return
        }
        
        ChatRoomAPI.shared.APPMoringNightURL(beUserId: uid, msgType: num, success: { (json)in
            let dic = json as? NSDictionary
            let code = dic?.object(forKey: "code") as? Int
            if code == 200 {
                PublishTipsView.init(type: self.type, isNomal: false).show()
                self.dismiss()
                self.PublishCloseOutBlcok?()
            }else{
                ShowMessageTool.shared.showMessage("\(arr[num - 1])失败")
            }
        }) { (error) in
            ShowMessageTool.shared.showMessage("\(arr[num - 1])失败")
        }
    }
    
}
