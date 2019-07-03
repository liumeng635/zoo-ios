//
//  CardChooseAnimal3DView.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/5/31.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit
import SVGAPlayer
class CardChooseAnimal3DView: UIView {
    lazy var backView:UIView = {
        let view = UIView.init()
        
        return view
    }()
    lazy var centerView :UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "3DLabelDesc")
        return imageV
    }()
    lazy var bottomView:UIView = {
        let view = UIView.init()
        return view
    }()
    lazy var backImage:UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "3DCardBack")
        return imageV
    }()
    lazy var DIYImage:UIImageView = {
        let imageV = UIImageView.init()
        imageV.contentMode = .scaleAspectFit
        return imageV
    }()
    lazy var topLabel:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = ColorWhite
        label.text = "已被你抱回家啦"
        
        return label
    }()
    
    lazy var cancelBtn : UIButton = {
        
        let Btn = UIButton.init(type: .custom)
        Btn.layer.cornerRadius  = 30
        Btn.layer.borderColor = ColorTheme.cgColor
        Btn.layer.borderWidth = 1
        Btn.setTitle("继续挑选", for: .normal)
        Btn.setTitleColor(ColorTheme, for: .normal)
        Btn.titleLabel?.font = UIFont.pingFangTextFont(size: 16)
        Btn.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        return Btn
        
    }()
    lazy var sureBtn : UIButton = {
        
        let Btn = UIButton.init(type: .custom)
        Btn.layer.cornerRadius  = 30
        Btn.layer.masksToBounds = true
        Btn.setTitle("去陪TA", for: .normal)
        Btn.setTitleColor(.white, for: .normal)
        Btn.titleLabel?.font = UIFont.pingFangTextFont(size: 16)
        Btn.addTarget(self, action: #selector(sureclick), for: .touchUpInside)
        
        return Btn
        
    }()
    
  
    //背景区域的颜色和透明度
   
    var imageUrl = ""
    var userID = ""
    //渐变层
    var gradientLayer:CAGradientLayer!
    
    //初始化视图
    init(imageUrl : String,userID: String) {
        super.init(frame: screenFrame)
        self.imageUrl = imageUrl
        self.userID = userID
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
        self.backImage.frame = CGRect.init(x: 45, y: navigationBarHeight, width: ScreenW - 90, height: (ScreenW - 90)*1.22)
        
        self.centerView.frame = CGRect.init(x: 45, y: ScreenH, width: ScreenW - 90, height: (ScreenW - 90)/2.67)
        self.bottomView.frame = CGRect.init(x: 0, y: ScreenH, width: ScreenW, height: 60)
        self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.8)
        self.isHidden = true
        self.centerView.isHidden = true
        self.bottomView.isHidden = true
        
        self.addSubviews([backImage,centerView,bottomView])
        backImage.addSubview(DIYImage)
        
        bottomView.addSubviews([cancelBtn,sureBtn])
       
        
        
        DIYImage.snp.makeConstraints { (make) in
            make.top.equalTo(50*ScaleW)
            make.centerX.equalToSuperview()
            make.width.equalTo(ScreenW - 120)
            make.height.equalTo((ScreenW - 120)/1.1)
        }
        
      
        cancelBtn.snp.makeConstraints {(make) in
            make.top.equalToSuperview()
            
            make.left.equalTo((ScreenW - 240 - 30)/2)
            make.width.equalTo(120)
            make.height.equalTo(60)
            
        }
        sureBtn.snp.makeConstraints {(make) in
            make.top.equalToSuperview()
            make.right.equalTo(-(ScreenW - 240 - 30)/2)
            make.width.equalTo(120)
            make.height.equalTo(60)
            
        }
        
        
    }
    //MARK:添加爱心动画
    func addLove(LoveX :CGFloat){
        let player = SVGAPlayer.init()
        player.frame = CGRect.init(x: LoveX, y: self.backImage.bottom - 50, width: 80, height: 120)
        self.addSubview(player)
        
        let parser = SVGAParser.init()
        parser.parse(withNamed: "love1", in: nil, completionBlock: { (videoItem) in
            player.videoItem = videoItem
            player.startAnimation()
        }) { (error) in
            
        }
       
    }
    
    //MARK:卡片翻转动画
    func roundAnimation() {

        let basicAnimation = CABasicAnimation(keyPath: "transform.rotation.y")
        basicAnimation.fromValue = -Double.pi
        basicAnimation.toValue = 0
        basicAnimation.duration = 1
        basicAnimation.repeatCount = 1
        basicAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.backImage.layer.add(basicAnimation, forKey: nil)

    }
   
    
    //MARK:显示
    
    func show(){
        
        self.sureBtn.addButtonGradientLayer()
        self.DIYImage.kf.setImage(urlString: self.imageUrl)
        let window = UIApplication.shared.delegate?.window as? UIWindow
        window?.addSubview(self)
        
        self.alpha = 1.0
        self.isHidden = false
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
            self.roundAnimation()
        }) { (finished) in
            
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut, .beginFromCurrentState], animations: {
                
                self.centerView.isHidden = false
                self.centerView.frame = CGRect.init(x: 45, y: self.backImage.bottom + 10 , width: ScreenW - 90, height: (ScreenW - 90)/2.67)
               
                
                
            }) { (finished) in
//                self.addLove(LoveX: 20)
//                self.addLove(LoveX: self.backImage.right - 50)
                
                UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut, .beginFromCurrentState], animations: {
                    
                    self.bottomView.isHidden = false
                     self.bottomView.frame = CGRect.init(x: 0, y: self.centerView.bottom + 40, width: ScreenW, height: 60)
                }) { (finished) in
                    
                }
                
            }
            
        }
        
        
      
        
      
    }
    @objc func dismiss(){
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
            self.isHidden = true  
        }, completion: { _ in
            self.removeFromSuperview()
        })
        
        
    }
    @objc func sureclick(){
         self.dismiss()
        
       //跳到互动页面
       
        
       
        
    }

}

enum  PetAnimalCardType{
    
    case mineHaveAnimal
    case mineWillAnimal
    case personAnimal
    
}

class PetAnimalCardChooseView: UIView {
    lazy var backView:UIView = {
        let view = UIView.init()
        
        return view
    }()
    lazy var centerView :UIView = {
        let imageV = UIView.init()
        
        return imageV
    }()
    lazy var bottomView:UIView = {
        let view = UIView.init()
        return view
    }()
   let DIYImage = petAnimalCardView.init(type: 0, frame: .zero)
    
    lazy var topLabel:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = ColorTheme
        label.numberOfLines = 0
        return label
    }()
    lazy var detailLabel:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.pingFangTextFont(size: 14)
        label.textColor = ColorTheme
        label.numberOfLines = 0
        return label
    }()
    lazy var bottomLabel:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.pingFangTextFont(size: 10)
        label.textColor = ColorWhite
        label.text = "嗅嗅提示：无论小乖兽有无更新过形象，图鉴都只记录抱它回家的首次形象"
        return label
    }()
    
    lazy var cancelBtn : UIButton = {
        
        let Btn = UIButton.init(type: .custom)
        Btn.layer.cornerRadius  = 30
        Btn.layer.borderColor = ColorTheme.cgColor
        Btn.layer.borderWidth = 1
        Btn.setTitle("访问主页", for: .normal)
        Btn.setTitleColor(ColorTheme, for: .normal)
        Btn.titleLabel?.font = UIFont.pingFangTextFont(size: 16)
        Btn.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        return Btn
        
    }()
    lazy var sureBtn : UIButton = {
        
        let Btn = UIButton.init(type: .custom)
        Btn.layer.cornerRadius  = 30
        Btn.layer.masksToBounds = true
        Btn.setTitle("去陪TA", for: .normal)
        Btn.setTitleColor(.white, for: .normal)
        Btn.titleLabel?.font = UIFont.pingFangTextFont(size: 16)
        Btn.addTarget(self, action: #selector(sureclick), for: .touchUpInside)
        
        return Btn
        
    }()
    lazy var closeBtn : UIButton = {
        
        let Btn = UIButton.init(type: .custom)
        Btn.setImage(UIImage.init(named: "close"), for: .normal)
        Btn.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        
        return Btn
        
    }()
    
    //背景区域的颜色和透明度
    
    var imageDIY = UIImage.init()
    var Model = HandbookModel()
    var type = PetAnimalCardType.mineHaveAnimal
    //渐变层
    var gradientLayer:CAGradientLayer!
    
    //初始化视图
    init(Model: HandbookModel,type: PetAnimalCardType) {
        super.init(frame: screenFrame)
        
        self.Model = Model
        self.type = type
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
        
        let DIYImageWidth = ScreenW - 200*ScaleW
        let DIYImageHeight = DIYImageWidth * 1.6
        self.DIYImage.frame = CGRect.init(x: 100*ScaleW, y: navigationBarHeight + 20, width: DIYImageWidth, height: DIYImageHeight)
        
        self.centerView.frame = CGRect.init(x: 0, y: ScreenH, width: ScreenW, height: 100)
        self.bottomView.frame = CGRect.init(x: 0, y: ScreenH, width: ScreenW, height: 120)
        self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.8)
        self.isHidden = true
        self.centerView.isHidden = true
        self.bottomView.isHidden = true
        
        self.addSubviews([DIYImage,centerView,bottomView,bottomLabel])
       
        centerView.addSubviews([topLabel,detailLabel])
        bottomView.addSubviews([cancelBtn,sureBtn,closeBtn])
        
        
        topLabel.snp.makeConstraints {(make) in
            make.top.equalTo(20)
            make.left.right.equalToSuperview()
            make.height.equalTo(80)
            
        }
//        detailLabel.snp.makeConstraints {(make) in
//            make.top.equalTo(topLabel.snp.bottom).offset(1)
//            make.left.right.equalToSuperview()
//            make.height.equalTo(40)
//
//        }
        bottomLabel.snp.makeConstraints {(make) in
            make.bottom.equalTo(-SafeBottomMargin)
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
            
        }
        
        
        cancelBtn.snp.makeConstraints {(make) in
            make.top.equalToSuperview()
            
            make.left.equalTo((ScreenW - 240 - 30)/2)
            make.width.equalTo(120)
            make.height.equalTo(60)
            
        }
        sureBtn.snp.makeConstraints {(make) in
            make.top.equalToSuperview()
            make.right.equalTo(-(ScreenW - 240 - 30)/2)
            make.width.equalTo(120)
            make.height.equalTo(60)
            
        }
        closeBtn.snp.makeConstraints {(make) in
            make.top.equalTo(sureBtn.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(30)
            
        }
        
        self.DIYImage.model = Model
    }
    
    
    //MARK:卡片翻转动画
    func roundAnimation() {
        
        let basicAnimation = CABasicAnimation(keyPath: "transform.rotation.y")
        basicAnimation.fromValue = -Double.pi
        basicAnimation.toValue = 0
        basicAnimation.duration = 1
        basicAnimation.repeatCount = 1
        basicAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.DIYImage.layer.add(basicAnimation, forKey: nil)
        
    }
    
    
    //MARK:显示
    
    func show(){
        
        self.sureBtn.addButtonGradientLayer()
        
        let window = UIApplication.shared.delegate?.window as? UIWindow
        window?.addSubview(self)
        
        switch type {
        case .mineHaveAnimal:
            topLabel.text = "\(Model.recordTime ?? "")\n\n 你把它抱回家"
//            detailLabel.text = "经过\(Model.developTime ?? "")小时的陪伴你拥有了它"
            break
        case .mineWillAnimal:
            self.cancelBtn.isHidden = true
            sureBtn.snp.remakeConstraints() {(make) in
                make.top.equalToSuperview()
                make.centerX.equalToSuperview()
                make.width.equalTo(120)
                make.height.equalTo(60)
                
            }
            topLabel.text = "\(Model.recordTime ?? "")\n \n你把它抱回家"
//            detailLabel.text = "你们已经相互陪伴了\(Model.developTime ?? "")\n 多多撩它，就能拥有它喔"
            break
        case .personAnimal:
            self.sureBtn.isHidden = true
            cancelBtn.centerX = self.bottomView.centerX
            cancelBtn.setTitle("访问该小乖兽主页", for: .normal)
            topLabel.text = "\(Model.nickname ?? "")\n \(Model.recordTime ?? "")获得该图鉴"
//            detailLabel.isHidden = true
            break
        
        }
        
        
        
        
        self.alpha = 1.0
        self.isHidden = false
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
            self.roundAnimation()
        }) { (finished) in
            
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut, .beginFromCurrentState], animations: {
                
                self.centerView.isHidden = false
                self.centerView.frame = CGRect.init(x: 0, y: self.DIYImage.bottom + 10 , width: ScreenW, height: 100)
            }) { (finished) in
                
                UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut, .beginFromCurrentState], animations: {
                    
                    self.bottomView.isHidden = false
                    self.bottomView.frame = CGRect.init(x: 0, y: self.centerView.bottom + 20, width: ScreenW, height: 120)
                }) { (finished) in
                    
                }
                
            }
            
        }   
    }
    @objc func dismiss(){
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
            self.isHidden = true
        }, completion: { _ in
            self.removeFromSuperview()
        })
        
        
    }
    @objc func sureclick(){
        self.dismiss()
        if type == .personAnimal{
            guard let userId = Model.userId else {
                return
            }
            
            let vc = PageSpaceViewController.init(userID: userId)
            self.XZBCuruntView().navigationController?.pushViewController(vc, animated: true)
        }else{
            //跳到互动页面
        }
        
        
        
    }
    
}
