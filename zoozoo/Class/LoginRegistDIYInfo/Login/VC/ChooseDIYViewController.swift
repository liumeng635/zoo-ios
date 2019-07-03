//
//  ChooseDIYViewController.swift
//  zoozoo
//
//  Created by 苹果上的豌豆 on 2019/5/17.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit
import TransitionButton
import SwiftyJSON
import Kingfisher
import Qiniu
class ChooseDIYViewController: BaseViewController {
    
    //透明底色
    lazy var backgroundimgaeView: UIImageView = {
        let imgaeView=UIImageView.init()
        imgaeView.image=UIImage(named: "circle")
        return imgaeView
    }()
    
    lazy var changeBtn:UIButton = {
        let Btn = UIButton.init(type: .custom)
        Btn.setTitle("  随机", for: .normal)
        Btn.setTitleColor(.white, for: .normal)
        Btn.titleLabel?.font = UIFont.pingFangTextFont(size: 12)
        Btn.setImage(UIImage.init(named: "change"), for: .normal)
        Btn.setBackgroundColor(ColorDIYTopBtn, forState: .normal)
        Btn.layer.cornerRadius = 15
        Btn.layer.masksToBounds = true
        Btn.addTarget(self, action: #selector(self.gotoChange), for: .touchUpInside)
        
        return Btn
    }()
    lazy var voiceBtn:UIButton = {
        let Btn = UIButton.init(type: .custom)
        
        Btn.setImage(UIImage.init(named: "voicePlay"), for: .normal)
        Btn.addTarget(self, action: #selector(self.gotoVoice), for: .touchUpInside)
        
        return Btn
    }()
    lazy var backView:UIView = {
        let backView = UIView.init()
        
        return backView
    }()
    lazy var DIYImage:UIImageView = {
        let imageV = UIImageView.init()
       
        return imageV
    }()
    lazy var body:UIImageView = {
        let imageV = UIImageView.init()
        
        return imageV
    }()
    lazy var expression:UIImageView = {
        let imageV = UIImageView.init()
        
        return imageV
    }()
    lazy var cloth:UIImageView = {
        let imageV = UIImageView.init()
       
        return imageV
    }()
    lazy var head:UIImageView = {
        let imageV = UIImageView.init()
        
        return imageV
    }()
    lazy var topLabel:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = ColorTitle
        label.text = "[这是你的ZOOZOO形象]"
        
        return label
    }()
    lazy var secLabel:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.pingFangTextFont(size: 12)
        label.textColor = ColorTitle
        label.text = "它可以保护你的隐私、展现你的个性"
        
        return label
    }()
    lazy var lastLabel:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.pingFangTextFont(size: 12)
        label.textColor = ColorTitle
        label.text = "89%的用户都DIY了自己的形象"
        
        return label
    }()
    lazy var bootomLabel:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.pingFangTextFont(size: 10)
        label.textColor = ColorGrayColor
        label.text = "可以在个人中心随时修改形象哦"
        
        return label
    }()
    lazy var DIYBtn:TransitionButton = {
        let Btn = TransitionButton.init(type: .custom)
        Btn.spinnerColor = .white
        Btn.titleLabel?.font = UIFont.pingFangTextFont(size: 16)
        Btn.cornerRadius = 30
       
        Btn.backgroundColor = UIColor.colorWithHex(hex: 0xFC9A7D)
        Btn.setTitle("我要自己DIY", for: .normal)
        Btn.setTitleColor(ColorWhite, for: .normal)
     
        Btn.addTarget(self, action: #selector(self.gotoDIY), for: .touchUpInside)
        
        return Btn
    }()
    lazy var sureBtn:TransitionButton = {
        let Btn = TransitionButton.init(type: .custom)
        Btn.spinnerColor = .white
        Btn.titleLabel?.font = UIFont.pingFangTextFont(size: 16)
        Btn.cornerRadius = 30
        Btn.setTitle("就选它啦", for: .normal)
        Btn.setTitleColor(ColorWhite, for: .normal)
        Btn.addTarget(self, action: #selector(self.gotoUP), for: .touchUpInside)
        
        return Btn
    }()
    lazy var introduceStroyBTN: UIButton = {
        
        let btn = UIButton.init()
        btn.setImage(UIImage.init(named: "StoryIntroduction"), for: .normal)
        btn.addTarget(self, action: #selector(gotoStory), for: .touchUpInside)
        return btn
    }()
    var UPDIYModel = UPDIYAnimalModel()
    var storyImage = ""
    var PopDisabled = true
    init(PopDisabled :Bool ) {
        super.init(nibName: nil, bundle: nil)
        self.PopDisabled  = PopDisabled
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if PopDisabled{
            self.interactivePopDisabled()
        }
        self.fd_prefersNavigationBarHidden = true
        self.view.backgroundColor = .white
        createLayoutUI()
        
        gotoChange()
        backView.addBackViewGradientLayer()
        
        DIYBtn.gradientColor(CGPoint(x: 1, y: 0), CGPoint(x: 0, y: 1), [UIColor.colorWithHex(hex: 0xF2AB52).cgColor, UIColor.colorWithHex(hex: 0xEF546A)
            .cgColor])
       self.sureBtn.addButtonGradientLayer()
    }
    private func createLayoutUI(){
        self.view.addSubviews([backView,backgroundimgaeView,DIYImage,changeBtn,voiceBtn,topLabel,secLabel,lastLabel,bootomLabel,DIYBtn,sureBtn,introduceStroyBTN])
        
        DIYImage.addSubviews([body,head,expression,cloth])
        
        backgroundimgaeView.snp.makeConstraints { (make) in

            make.edges.equalToSuperview()
        }
        
        backView.snp.makeConstraints {(make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(DIYBackHeight)
            
        }
        changeBtn.snp.makeConstraints {(make) in
            make.top.equalTo(statusBarH + 10)
            make.right.equalTo(-30)
            make.height.equalTo(30)
            make.width.equalTo(70)
            
        }
        voiceBtn.snp.makeConstraints {(make) in
            make.top.equalTo(DIYBackHeight - 50)
            make.right.equalTo(-30)
            make.height.width.equalTo(30)
           
            
        }
        
        DIYImage.snp.makeConstraints {(make) in
            make.top.equalTo(changeBtn.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalTo(ScreenW)
            make.height.equalTo(DIYImageHeight)
            
        }
        body.snp.makeConstraints {(make) in
            make.edges.equalToSuperview()
            
        }
        head.snp.makeConstraints {(make) in
            make.edges.equalToSuperview()
            
        }
        expression.snp.makeConstraints {(make) in
            make.edges.equalToSuperview()
            
        }
        cloth.snp.makeConstraints {(make) in
            make.edges.equalToSuperview()
            
        }
        topLabel.snp.makeConstraints {(make) in
            make.top.equalTo(backView.snp.bottom).offset(30)
           make.left.equalTo(30)
           make.right.equalTo(-30)
            make.height.equalTo(20)
            
        }
        secLabel.snp.makeConstraints {(make) in
            make.top.equalTo(topLabel.snp.bottom).offset(10)
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(20)
            
        }
        lastLabel.snp.makeConstraints {(make) in
            make.top.equalTo(secLabel.snp.bottom).offset(5)
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(20)
            
        }
        
        DIYBtn.snp.makeConstraints {(make) in
            make.top.equalTo(lastLabel.snp.bottom).offset(30)
            
            make.left.equalTo(30)
            make.width.equalTo(ScreenW/2-45)
            make.height.equalTo(60)
            
        }
        sureBtn.snp.makeConstraints {(make) in
            make.top.equalTo(lastLabel.snp.bottom).offset(30)
            make.right.equalTo(-30)
            make.width.equalTo(ScreenW/2-45)
            make.height.equalTo(60)
            
        }
        bootomLabel.snp.makeConstraints {(make) in
            make.bottom.equalTo(-SafeBottomMargin - 20)
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(20)
            
        }
        introduceStroyBTN.snp.makeConstraints { (make) in
            make.width.height.equalTo(35)
            make.left.equalTo(20)
            make.top.equalTo(changeBtn.snp.bottom)
        }
    }

    
}
extension ChooseDIYViewController {
    @objc private func gotoStory(){
        if self.storyImage.isEmpty {
            ShowMessageTool.shared.showMessage("该动物还没有背景故事")
            return
        }
        
        let newImage = self.DIYImage.convertToImage().reSizeImage(reSize: CGSize.init(width: DIYUPImageW, height: DIYUPImageH))
        let view = PopImageView.init(imageUrl: self.storyImage, animalDIYImage: newImage)
        view.show()
    }
    @objc private func gotoChange(){
        
        DIYAPI.shared.APPGetBodyRandomProfileURL(success: { (json) in
          
            let dic = JSON(json ?? [String:Any].self)
            if dic["code"] == 200 {
                if let animalType = dic["data"]["body"]["animalType"].int {
                    self.UPDIYModel.animalType = animalType
                   
                }
                if let voice = dic["data"]["audio"]["audioPath"].string {
                    self.UPDIYModel.VoiceUrl = voice
                    
                }
                if let ColorString = dic["data"]["background"]["imgUrl"].string {
                    self.backView.gradientStringDIYColor(colorsString :ColorString)
                     self.UPDIYModel.backImage = ColorString
                }
                if let body = dic["data"]["body"]["imgUrl"].string {
                    self.body.kf.setImage(urlString: body)
                }
                if let storyImage = dic["data"]["body"]["storyImage"].string {
                    self.storyImage = storyImage
                }
                if let expression = dic["data"]["expression"]["imgUrl"].string {
                    self.expression.kf.setImage(urlString: expression)
                }
                if let cloth = dic["data"]["cloth"]["imgUrl"].string {
                    self.cloth.kf.setImage(urlString: cloth)
                }
                if let head = dic["data"]["head"]["imgUrl"].string {
                    self.head.kf.setImage(urlString: head)
                }
            }
            
        }) { (error) in
            
        }
        
    }
    
}
extension ChooseDIYViewController {
    
    @objc private func gotoUP(){
       self.sureBtn.startAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.sureBtn.stopAnimation()
            let newImage = self.DIYImage.convertToImage().reSizeImage(reSize: CGSize.init(width: DIYUPImageW, height: DIYUPImageH))
            self.UPDIYModel.petImage = newImage
            let vc = ConfirmAnimalsViewController.init(PopDisabled: true)
            vc.animalModel = self.UPDIYModel
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc private func gotoDIY(){
        let vc = DIYBaseChooseViewController.init(PopDisabled: true)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func gotoVoice(){
        VoiceAudioUrlPlayer.shared.playAudioUrl(audioUrl: self.UPDIYModel.VoiceUrl)
    }
}
