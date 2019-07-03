//
//  MineCharacterView.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/6/13.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class MineCharacterView: UIView {

    lazy var backView:UIView = {
        let view = UIView.init()
        
        return view
    }()
    lazy var circleView: UIImageView = {
        let imgaeView=UIImageView.init()
        imgaeView.contentMode = .scaleAspectFill
        imgaeView.image=UIImage(named: "circle")
        return imgaeView
    }()
    lazy var topLabel:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = ColorWhite
        label.text = "我的嗅嗅形象"
        
        return label
    }()
    lazy var nameLabel:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = ColorWhite
        return label
    }()
    
    lazy var DIYImage:UIImageView = {
        let imageV = UIImageView.init()
        imageV.contentMode = .scaleAspectFit
        return imageV
    }()
    
    lazy var sex:UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "man")
        return imageV
    }()
    
    lazy var age:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.pingFangTextFont(size: 10)
        label.textColor = ColorWhite
        label.backgroundColor = ColorTheme
        label.layer.cornerRadius = 3.0
        label.layer.masksToBounds = true
        return label
    }()
    lazy var constellation:UIImageView = {
        let imageV = UIImageView.init()
        return imageV
    }()
    
    
    lazy var share : UIButton = {
        
        let Btn = UIButton.init(type: .custom)
       
        Btn.setImage(UIImage.init(named: "share"), for: .normal)
        Btn.addTarget(self, action: #selector(gotoShare), for: .touchUpInside)
        
        return Btn
        
    }()
    
    
    
    lazy var editBtn : UIButton = {
        
        let Btn = UIButton.init(type: .custom)
        Btn.layer.masksToBounds = true
        Btn.layer.cornerRadius  = 20
        Btn.titleLabel?.font = UIFont.pingFangMediumFont(size: 14)
        Btn.backgroundColor = UIColor.colorWithRGBA(r:23.0, g: 27.0, b: 30.0, alpha: 0.2)
        Btn.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 5)
        Btn.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 0)
        Btn.setTitle("编辑形象", for: .normal)
        Btn.setTitleColor(ColorWhite, for: .normal)
        Btn.setImage(UIImage.init(named: "mineEdite"), for: .normal)
        Btn.addTarget(self, action: #selector(gotoEdit), for: .touchUpInside)
        
        return Btn
        
    }()
    
    //背景区域的颜色和透明度
    
    
    var Model = PersonPageSpaceModel()
    
    //初始化视图
    init(Model : PersonPageSpaceModel) {
        super.init(frame: screenFrame)
        self.Model = Model
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
        self.backView.frame = CGRect.init(x: 0, y: ScreenH, width: ScreenW, height: ScreenH/1.3)
        self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.8)
        self.isHidden = true
        self.addSubview(backView)
        backView.addSubviews([circleView,topLabel,share,DIYImage,nameLabel,age,sex,constellation,editBtn])
        
        circleView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        share.snp.makeConstraints { (make) in
            make.top.equalTo(25)
            make.right.equalTo(-15)
            make.height.width.equalTo(25)
        }
        topLabel.snp.makeConstraints { (make) in
            make.top.equalTo(25)
            make.left.right.equalToSuperview()
            make.height.equalTo(20)
        }
        DIYImage.snp.makeConstraints { (make) in
            make.top.equalTo(topLabel.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.width.equalTo(ScreenW - 80)
            make.height.equalTo((ScreenW - 80)/1.1)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(DIYImage.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(20)
        }
        sex.snp.makeConstraints() { (make) in
            make.left.equalTo(ScreenW/2 - 18)
            make.top.equalTo(nameLabel.snp.bottom).offset(15)
            make.width.equalTo(15)
            make.height.equalTo(15)
        }
        age.snp.makeConstraints() { (make) in
            make.right.equalTo(sex.snp.left).offset(-5)
            make.top.equalTo(sex.snp_top)
            make.width.equalTo(30)
            make.height.equalTo(15)
        }
        
        constellation.snp.makeConstraints() { (make) in
            make.left.equalTo(sex.snp.right).offset(5)
            make.top.equalTo(sex.snp_top)
            make.width.equalTo(45)
            make.height.equalTo(15)
        }
        
        editBtn.snp.makeConstraints() { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(sex.snp_bottom).offset(20)
            make.width.equalTo(130)
            make.height.equalTo(40)
        }
        
        
        self.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(dismiss)))
    }
    
    
    //MARK:显示
    
    func show(){
        
        
        let maskPath = UIBezierPath(roundedRect: backView.bounds, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width:10, height:10))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = backView.bounds
        maskLayer.path = maskPath.cgPath
        backView.layer.mask = maskLayer
        
        if Model.backImage?.isEmpty == true || Model.backImage == nil{
            backView.addBackViewGradientLayer()
        }else{
            backView.gradientStringDIYColor(colorsString :Model.backImage ?? "")
        }
        nameLabel.text = Model.petNickname
        sex.image = Model.sex == 1 ? UIImage.init(named: "man") : UIImage.init(named: "women")
        
        age.text = "\(Model.age ?? 18)岁"
        constellation.image = UIImage.init(named: Model.constellation ?? "金牛座")
       
        self.DIYImage.kf.setImage(urlString: Model.petImage)
        let window = UIApplication.shared.delegate?.window as? UIWindow
        window?.addSubview(self)
        
        self.alpha = 1.0
        self.isHidden = false
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut, .beginFromCurrentState], animations: {
            self.backView.frame = CGRect.init(x: 0, y: ScreenH - ScreenH/1.3, width: ScreenW, height: ScreenH/1.3)
            
        }) { (finished) in
            
        }
        
        
        
        
    }
    @objc func dismiss(){
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
            self.isHidden = true
            self.backView.frame = CGRect.init(x: 0, y: ScreenH, width: ScreenW, height: ScreenH/1.3)
            
        }, completion: { _ in
            
            self.removeFromSuperview()
        })
        
        
    }
    @objc func gotoEdit(){
        dismiss()
        
        let vc = DIYBaseChooseViewController.init(PopDisabled: false)
        self.XZBCuruntView().navigationController?.pushViewController(vc, animated: true)
    }
    @objc func gotoShare(){
       
        ShareView.init(shareImage: Model.petImage ?? "", type: .mineShare).show()
    }
    
}
