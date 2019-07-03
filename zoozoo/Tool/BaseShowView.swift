//
//  BaseShowView.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/6/18.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit


//所有提示弹窗基础动画继承这个View
class BaseShowView: UIView {
    lazy var backView:UIView = {
        let view = UIView.init()
        view.backgroundColor = .white
        view.layer.cornerRadius  = 10
        view.layer.masksToBounds = true
        return view
    }()
   
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


enum  AlertShowType{
    
    case nomal
    
}

class AlertShowSureOrCancleView: BaseShowView {
    
    public  var sureAlertClickBlock : (()->Void)?
    
    
    lazy var TitleLab:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = ColorTitle
        label.text = "暂未上传"
        label.numberOfLines = 0
        return label
    }()
    lazy var deLab:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.pingFangTextFont(size: 15)
        label.textColor = ColorGrayTitle
        label.text = "有人与你分享生活里的小确幸\n 是一件开心的事。"
        label.numberOfLines = 0
        return label
    }()
    lazy var cancelBtn:UIButton = {
        let Btn = UIButton.init(type: .custom)
        Btn.layer.cornerRadius  = 22
        Btn.layer.masksToBounds = true
        Btn.layer.borderColor = ColorTheme.cgColor
        Btn.layer.borderWidth = 1
        Btn.setTitle("退出编辑", for: .normal)
        Btn.setTitleColor(ColorTheme, for: .normal)
        Btn.titleLabel?.font = UIFont.pingFangTextFont(size: 16)
        Btn.addTarget(self, action: #selector(SureAction), for: .touchUpInside)
        return Btn
    }()
    
    lazy var SureBtn:UIButton = {
        let Btn = UIButton.init(type: .custom)
        Btn.layer.cornerRadius  = 22
        Btn.layer.masksToBounds = true
        Btn.setTitle("继续上传", for: .normal)
        Btn.setTitleColor(ColorWhite, for: .normal)
        Btn.titleLabel?.font = UIFont.pingFangTextFont(size: 16)
        Btn.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        return Btn
    }()
  
    var showType = AlertShowType.nomal
    
    init(showType :AlertShowType) {
        super.init(frame: screenFrame)
        self.showType = showType
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
         backView.addSubviews([TitleLab,deLab,cancelBtn,SureBtn])
        
        self.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(dismiss)))
        backView.frame = CGRect.init(x: 35, y: 0, width: ScreenW - 70, height: 200)
         backView.center = self.center
        TitleLab.frame = CGRect.init(x: 15, y: 20, width: ScreenW - 100, height: 30)
       
        deLab.frame = CGRect.init(x: 15, y: TitleLab.bottom + 10, width: ScreenW - 100, height: 60)
        
      
        let buttonW = (ScreenW - 70)/2
        cancelBtn.snp.makeConstraints { (make) in
            make.left.equalTo(buttonW - 120)
            make.width.equalTo(110)
            make.height.equalTo(44)
            make.bottom.equalTo(-20)
        }
        SureBtn.snp.makeConstraints { (make) in
            make.left.equalTo(cancelBtn.snp.right).offset(20)
            make.width.height.bottom.equalTo(cancelBtn)
        }
        
        SureBtn.addButtonGradientLayer()
    }
   
    
    @objc func SureAction(){
        dismiss()
        self.sureAlertClickBlock?()
        
        
    }
    
}


//MARK:解除关系的弹窗
class AlertOverRelationshipView: BaseShowView {
    
    public  var overRelationshipAlertClickBlock : (()->Void)?
    
    
    lazy var TitleLab:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = ColorTitle
        label.numberOfLines = 0
        label.text = "解除关系等同于拉黑\n 你确认要与 上楼 解除关系吗?"
        return label
    }()
    
    lazy var topLab:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = ColorTitle
        label.text = "解除关系"
        return label
    }()
    lazy var deLab:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.pingFangTextFont(size: 15)
        label.textColor = ColorGrayTitle
        label.text = "你确认要与TA解除关系吗？"
        
        return label
    }()
    
    lazy var cancelBtn:UIButton = {
        let Btn = UIButton.init(type: .custom)
        Btn.layer.cornerRadius  = 22
        Btn.layer.masksToBounds = true
        Btn.layer.borderColor = ColorTheme.cgColor
        Btn.layer.borderWidth = 1
        Btn.setTitle("解除关系", for: .normal)
        Btn.setTitleColor(ColorTheme, for: .normal)
        Btn.titleLabel?.font = UIFont.pingFangTextFont(size: 16)
        Btn.addTarget(self, action: #selector(SureAction), for: .touchUpInside)
        return Btn
    }()
    
    lazy var SureBtn:UIButton = {
        let Btn = UIButton.init(type: .custom)
        Btn.layer.cornerRadius  = 22
        Btn.layer.masksToBounds = true
        Btn.setTitle("取消", for: .normal)
        Btn.setTitleColor(ColorWhite, for: .normal)
        Btn.titleLabel?.font = UIFont.pingFangTextFont(size: 16)
        Btn.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        return Btn
    }()
  
   
    var nameTitle = ""
    init(nameTitle :String) {
        super.init(frame: screenFrame)
        self.nameTitle = nameTitle
        initSubView()
        ceteateUI()
    }
    init() {
        super.init(frame: screenFrame)
        
        initSubView()
        ceteateRaiseOverUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubView()
        ceteateUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func  ceteateRaiseOverUI(){
        backView.addSubviews([topLab,deLab,cancelBtn,SureBtn])
        
        backView.frame = CGRect.init(x: 35, y: 0, width: ScreenW - 70, height: 160)
        backView.center = self.center
        topLab.frame = CGRect.init(x: 15, y: 20, width: ScreenW - 100 , height: 30)
         deLab.frame = CGRect.init(x: 15, y: 60, width: ScreenW - 100 , height: 20)
        let buttonW = (ScreenW - 70)/2
        cancelBtn.snp.makeConstraints { (make) in
            make.left.equalTo(buttonW - 120)
            make.width.equalTo(110)
            make.height.equalTo(44)
            make.bottom.equalTo(-20)
        }
        SureBtn.snp.makeConstraints { (make) in
            make.left.equalTo(cancelBtn.snp.right).offset(20)
            make.width.height.bottom.equalTo(cancelBtn)
        }
        
        SureBtn.addButtonGradientLayer()
    }
    
    
    
    func  ceteateUI(){
        backView.addSubviews([TitleLab,cancelBtn,SureBtn])
        
        self.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(dismiss)))
        backView.frame = CGRect.init(x: 35, y: 0, width: ScreenW - 70, height: 180)
        backView.center = self.center
        TitleLab.frame = CGRect.init(x: 15, y: 20, width: ScreenW - 100 , height: 60)
        let buttonW = (ScreenW - 70)/2
        cancelBtn.snp.makeConstraints { (make) in
            make.left.equalTo(buttonW - 120)
            make.width.equalTo(110)
            make.height.equalTo(44)
            make.bottom.equalTo(-20)
        }
        SureBtn.snp.makeConstraints { (make) in
            make.left.equalTo(cancelBtn.snp.right).offset(20)
            make.width.height.bottom.equalTo(cancelBtn)
        }
        
        TitleLab.text = "解除关系等同于拉黑\n 你确认要与 \(nameTitle) 解除关系吗?"
        
         SureBtn.addButtonGradientLayer()
    }
   
    
    @objc func SureAction(){
        dismiss()
        self.overRelationshipAlertClickBlock?()
    
    }
    
}


//MARK:怪兽图鉴的弹窗
class AlertAnimalChooseView: BaseShowView {
    
   
    lazy var TitleLab:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = ColorTitle
        label.numberOfLines = 0
        label.text = "每拥有一个亲密值达到100的嗅友\n 你就拥有了一张《乖兽图鉴》\n 邀请朋友来玩，集齐速度加倍"
        return label
    }()
    
    lazy var cancelBtn:UIButton = {
        let Btn = UIButton.init(type: .custom)
        Btn.layer.cornerRadius  = 22
        Btn.layer.masksToBounds = true
        Btn.layer.borderColor = ColorTheme.cgColor
        Btn.layer.borderWidth = 1
        Btn.setTitle("去首页寻找", for: .normal)
        Btn.setTitleColor(ColorTheme, for: .normal)
        Btn.titleLabel?.font = UIFont.pingFangTextFont(size: 16)
        Btn.addTarget(self, action: #selector(HomeAction), for: .touchUpInside)
        return Btn
    }()
    
    lazy var SureBtn:UIButton = {
        let Btn = UIButton.init(type: .custom)
        Btn.layer.cornerRadius  = 22
        Btn.layer.masksToBounds = true
        Btn.setTitle("请好友帮忙", for: .normal)
        Btn.setTitleColor(ColorWhite, for: .normal)
        Btn.titleLabel?.font = UIFont.pingFangTextFont(size: 16)
        Btn.addTarget(self, action: #selector(HelpAction), for: .touchUpInside)
        return Btn
    }()
    var Title = "每拥有一个亲密值达到100的嗅友\n 你就拥有了一张《乖兽图鉴》\n 邀请朋友来玩，集齐速度加倍"
    var H = 200
    init(H :Int,Title :String) {
        super.init(frame: screenFrame)
        self.H = H
        self.Title = Title
        initSubView()
        ceteateUI()
       
    }
  
    init() {
        super.init(frame: screenFrame)
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
        backView.addSubviews([TitleLab,cancelBtn,SureBtn])
        
        self.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(dismiss)))
        backView.frame = CGRect.init(x: 35, y: 0, width: Int(ScreenW - 70), height: H )
        backView.center = self.center
        TitleLab.frame = CGRect.init(x: 15, y: 20, width: Int(ScreenW - 100) , height: H - 120)
        let buttonW = (ScreenW - 70)/2
        cancelBtn.snp.makeConstraints { (make) in
            make.left.equalTo(buttonW - 120)
            make.width.equalTo(110)
            make.height.equalTo(44)
            make.bottom.equalTo(-20)
        }
        SureBtn.snp.makeConstraints { (make) in
            make.left.equalTo(cancelBtn.snp.right).offset(20)
            make.width.height.bottom.equalTo(cancelBtn)
        }
      self.TitleLab.text = self.Title
        SureBtn.addButtonGradientLayer()
    }
 
    @objc func HomeAction(){
        dismiss()
       self.XZBCuruntView().navigationController?.popToRootViewController(animated: true)
        
    }
    @objc func HelpAction(){
        dismiss()
        
        
        ShareView.init(shareImage: GlobalDataStore.shared.currentUser.petImage, type: .mineShare).show()
    }
}


