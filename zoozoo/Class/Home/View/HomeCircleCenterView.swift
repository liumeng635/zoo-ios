//
//  HomeCircleCenterView.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/5/27.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit
import SVGAPlayer
import AMPopTip

let playerW = VIEWH/2*0.2

@objc protocol HomeCircleCenterViewDelegate: NSObjectProtocol {
    /** 点击事件运动效果**/
    @objc optional func startAnimation(type: Int)
    
    
}

class HomeCircleCenterView: UIView {
    weak var delegate: HomeCircleCenterViewDelegate?
    
    lazy var nameLabel:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = ColorTitle

      
        return label
    }()
    lazy var detailLabel:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.right
        label.font = UIFont.pingFangTextFont(size: 12)
        label.textColor = ColorTitle
       
        
        return label
    }()
    lazy var desLabel:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.pingFangTextFont(size: 14)
        label.textColor = ColorDarkGrayTextColor
        
        
        return label
    }()
    lazy var sex:UIImageView = {
        let sex = UIImageView.init()
        return sex
    }()
    lazy var circle:UIImageView = {
        let circle = UIImageView.init()
        circle.image = UIImage.init(named: "circleBlue")
        return circle
    }()
    
   
    
    lazy var love:UIButton = {
        let Btn = UIButton.init(type: .custom)
        Btn.setImage(UIImage.init(named: "LOVE"), for: .normal)
  
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressLoveClick))
       
         longPress.minimumPressDuration = 1
        Btn.isUserInteractionEnabled = true
        Btn.addGestureRecognizer(longPress)
        Btn.addTarget(self, action: #selector(loveBtnAction), for: .touchUpInside)
       
        return Btn
    }()
    lazy var collect:UIButton = {
        let Btn = UIButton.init(type: .custom)
    
        Btn.setImage(UIImage.init(named: "Collect"), for: .normal)
        Btn.addTarget(self, action: #selector(collectBtnAction), for: .touchUpInside)
       
        return Btn
    }()
    lazy var home:UIButton = {
        let Btn = UIButton.init(type: .custom)
        Btn.setImage(UIImage.init(named: "HOME"), for: .normal)
        Btn.addTarget(self, action: #selector(homeBtnAction), for: .touchUpInside)
        
        return Btn
    }()
   let popTip = PopTip.init()
    
    var isShowPop = false
    
    var zanID = ""
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var model:HomeAnimalModel? {
        didSet{
            
            nameLabel.text = model?.nickname
            detailLabel.text = "\(model?.area ?? "武汉") \(model?.age ?? 18)岁"
           desLabel.text = model?.tag
            
            if model?.sex == 1 {
                sex.image = UIImage.init(named: "man")
            }else{
                sex.image = UIImage.init(named: "women")
            }
            
            love.isSelected = model?.isLike == 0 ? true : false
            
           
        }
    }
    
    func initSubView(){
        self.backgroundColor = ColorBackGround
        self.addShadow(offset: CGSize.init(width: 10, height: 10), radius: 20, color: ColorGrayColor, opacity: 0.8)
        self.addSubviews([circle,nameLabel,detailLabel,sex,desLabel,collect,love,home])
        circle.snp.makeConstraints { (make) in
            make.top.equalTo(-5)
            make.centerX.equalToSuperview()
            make.height.equalTo(100*ScaleW)
            make.width.equalTo(ScreenW)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(40)
            make.left.right.equalToSuperview()
            make.height.equalTo(20)
        }
        
        detailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp_bottom).offset(10)
            make.right.equalTo(-VIEWH * CGFloat(PROPORTION)/2 + 20)
            make.left.equalTo(50)
            make.height.equalTo(20)
        }
        sex.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp_bottom).offset(10)
            make.left.equalTo(detailLabel.snp_right).offset(8)
            make.height.width.equalTo(20)
        }
        
        
        desLabel.snp.makeConstraints { (make) in
            make.top.equalTo(detailLabel.snp_bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(20)
        }
        
        collect.snp.makeConstraints { (make) in
            make.top.equalTo(desLabel.snp_bottom).offset(30)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(85)
        }
        love.snp.makeConstraints { (make) in
            make.top.equalTo(desLabel.snp_bottom).offset(30)
            make.right.equalTo(collect.snp_left).offset(-30)
            make.height.width.equalTo(64)
        }
        home.snp.makeConstraints { (make) in
            make.top.equalTo(desLabel.snp_bottom).offset(30)
            make.left.equalTo(collect.snp_right).offset(30)
            make.height.width.equalTo(64)
        }
        
       
        
        
    }
    

}
extension HomeCircleCenterView {
    @objc func loveBtnAction () {
        if isShowPop {
            dissmissPopTips()
            return
        }
        
        isShowPop = false
       
         let player = SVGAPlayer.init()
        
        player.frame = CGRect.init(x: ScreenW/2 - playerW/2, y: CircleViewY, width: playerW, height: playerW + 20)
        let window = UIApplication.shared.delegate?.window as? UIWindow
        window?.addSubview(player)
        
       let parser = SVGAParser.init()
        let num = arc4random() % 4
        parser.parse(withNamed: "love\(num + 1)", in: nil, completionBlock: { (videoItem) in
            player.videoItem = videoItem
            player.startAnimation()
        }) { (error) in
            
        }
        player.loops = 1
        player.clearsAfterStop = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            player.stopAnimation()
            player.isHidden = true
            player.removeFromSuperview()
        }
        
        if self.zanID.isEmpty || self.zanID != model?.userId ?? ""{
            clickZANHttpRequestAction()
        }
      
        
    }
    private func clickZANHttpRequestAction(){
        HomeAPI.shared.APPUserLikeURL(beLikedUserId: model?.userId ?? "", success: { (json) in
            self.zanID = self.model?.userId ?? ""
        }) { (error) in
            
        }
    }
    
    @objc func longPressLoveClick() {
        
        
        if !isShowPop {
            self.showPopTips()
        }
    
        
    }
    func  showPopTips(){
        BaseEngine.shared.FeedbackGenerator()
        let imageView = UIImageView(image: UIImage(named: "loveCircle"))
        imageView.isUserInteractionEnabled = true
        let smile = UIButton.init(type: .custom)
        let smileImage = UIImage(named: "smile")!
        smile.setImage(smileImage, for: .normal)
        smile.addTarget(self, action: #selector(self.SmileAction), for: .touchUpInside)
        let gift = UIButton.init(type: .custom)
        let giftImage = UIImage(named: "gift")!
        gift.setImage(giftImage, for: .normal)
        gift.addTarget(self, action: #selector(self.giftAction), for: .touchUpInside)
        let popFrame = CGRect.init(x: love.x - imageView.w/2 + love.w/2 , y: love.y + 20 , width: imageView.frame.width, height: imageView.frame.height)
        
        let customView = UIView(frame:popFrame)
        customView.isUserInteractionEnabled = true
        customView.backgroundColor = UIColor.clear
        imageView.frame = CGRect(x: 0, y: 0, width: imageView.frame.width, height: imageView.frame.height)
        smile.frame = CGRect(x: imageView.center.x - 10 - smileImage.size.width, y: 0, width: smileImage.size.width, height: smileImage.size.height)
        smile.centerY = imageView.centerY - smile.frame.height/2 + 5
        gift.frame = CGRect(x: imageView.center.x + 10, y: 0, width: giftImage.size.width, height: giftImage.size.height)
        gift.centerY = imageView.centerY - gift.frame.height/2 + 5
        imageView.addSubview(smile)
        imageView.addSubview(gift)
        customView.addSubview(imageView)
        popTip.bubbleColor = UIColor.clear
        popTip.shouldDismissOnTap = false
        popTip.shouldDismissOnTapOutside = false
        popTip.frame = popFrame
        popTip.show(customView: customView, direction: .up, in: self, from: popFrame)
        self.isShowPop = true
    }
    func dissmissPopTips(){
        popTip.hide()
        isShowPop = false
    }
    @objc func SmileAction(){
        dissmissPopTips()
        
        self.delegate?.startAnimation?(type: 0)
    }
    @objc func giftAction(){
        dissmissPopTips()
       
        self.delegate?.startAnimation?(type: 1)
    }
    
    
    //领养
    @objc func collectBtnAction() {
        guard let petImage = model?.petImage ,let userId = model?.userId else {
            return
        }
        
        HomeAPI.shared.APPAdoptAnimalURL(beAdoptedUserId: userId, success: { (json) in
            //code码: 506一种类型的宠物只能领养一个,507 该宠物已经被其他用户领取
            let data = json["data"] as? NSDictionary
            let code = data?.object(forKey: "code") as? Int
            
            if code == 1 {
                let chooseView = CardChooseAnimal3DView.init(imageUrl: petImage, userID: userId)
                chooseView.show()
            }else if code == 506 {
               
                SystemTipsView.init(title: "留点机会给别人吧", deTitle: "你当前已拥有一个果冻熊好友\n 先去抱抱其他种类的朋友", H: 120).show()
     
            }else if code == 507 {
                SystemTipsView.init().show()  
            }else if code == 508 {
                SystemTipsView.init().show()
            }
            else{
                ShowMessageTool.shared.showMessage("领养失败")
               
            }
        }) { (error) in
             ShowMessageTool.shared.showMessage("领养失败")
        }
        
        
        
        
      
    }
    @objc func homeBtnAction () {
        guard let userId = model?.userId else {
            return
        }

        let vc = PageSpaceViewController.init(userID: userId)
        
        self.XZBCuruntView().navigationController?.pushViewController(vc, animated: true)
    }
}
