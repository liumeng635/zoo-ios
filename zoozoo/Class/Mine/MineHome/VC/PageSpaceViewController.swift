//
//  PageSpaceViewController.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/6/12.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit
import SVGAPlayer


let BottomQiuniuUrl = "?imageMogr2/gravity/Center/crop/!400x560a5-120/format/webp/blur/1x0/quality/75|imageslim"
let PageSpaceBootomH : CGFloat = ScreenH/3.3
let PageSpaceTopH : CGFloat = ScreenH - PageSpaceBootomH
class PageSpaceViewController: BaseViewController {
    var bgImgFrame: CGRect = CGRect(x: 0, y: 0, width: ScreenW, height: PageSpaceTopH)
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenW, height: ScreenH))
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        scrollView.contentSize = CGSize(width:ScreenW,height:0)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        scrollView.backgroundColor = .white
        scrollView.delegate = self
        return scrollView
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView.init(frame: bgImgFrame)
        bgView.backgroundColor = ColorTheme
        return bgView
    }()
  
    lazy var circleView: UIImageView = {
        let imageView=UIImageView.init()
        imageView.contentMode = .scaleAspectFill
         imageView.layer.masksToBounds = true
        imageView.image=UIImage(named: "circle")
        return imageView
    }()
    
    lazy var BackImageView: UIImageView = {
        let imgaeView=UIImageView.init()
        
        imgaeView.contentMode = .scaleAspectFill
        imgaeView.layer.masksToBounds = true
        imgaeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickUserIcon)))
        return imgaeView
    }()
    lazy var bodyimgaeView: UIImageView = {
        let bodyimgaeView=UIImageView.init()
        bodyimgaeView.contentMode = .scaleAspectFit
        bodyimgaeView.isUserInteractionEnabled = true
        bodyimgaeView.isHidden = true
        //        bodyimgaeView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(gotoSelf)))
        return bodyimgaeView
    }()
    lazy var centerTipsView: UIView = {
        let bgView = UIView.init()
        bgView.isHidden = true
        return bgView
    }()
    
    
    lazy var upButton : UIButton = {
        
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "ic_tj"), for: .normal)
        button.addTarget(self, action: #selector(ClickUpAvatorAction), for: .touchUpInside)
        return button
    }()
    lazy var tipsLab:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.pingFangMediumFont(size: 15)
        label.textColor = ColorWhite
        label.text = "上传一张头像吧"
        return label
    }()
    lazy var noUPLab:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.pingFangMediumFont(size: 15)
        label.textColor = ColorWhite
        label.isHidden = true
        label.text = "该用户暂未上传头像"
        return label
    }()
    lazy var moreButton : UIButton = {
        
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: ScreenW - 45, y: statusBarH + 15, width: 30, height: 30)
        button.isHidden = true
        button.setImage(UIImage.init(named: "BarMore")?.render(color: .white), for: .normal)
        button.addTarget(self, action: #selector(ClickMoreAction), for: .touchUpInside)
        return button
    }()
    
    lazy var editBtn : UIButton = {
        
        let Btn = UIButton.init(type: .custom)
        Btn.frame = CGRect.init(x: ScreenW - 80, y: statusBarH + 15, width: 65, height: 30)
        Btn.layer.masksToBounds = true
        Btn.layer.cornerRadius  = 15
        Btn.titleLabel?.font = UIFont.pingFangMediumFont(size: 14)
        Btn.backgroundColor = UIColor.colorWithRGBA(r:23.0, g: 27.0, b: 30.0, alpha: 0.2)
        Btn.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 5)
        Btn.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 0)
        Btn.setTitle("编辑", for: .normal)
        Btn.setTitleColor(ColorWhite, for: .normal)
        Btn.isHidden = true
        Btn.setImage(UIImage.init(named: "mineEdite"), for: .normal)
        Btn.addTarget(self, action: #selector(gotoEdit), for: .touchUpInside)
        
        return Btn
        
    }()
    
    lazy var rightButtonsView: UIView = {
        let bgView = UIView.init()
        return bgView
    }()
    
  
    
    lazy var userImageView: UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "PersionalIocn")
        imageV.layer.cornerRadius  = 25
        imageV.layer.masksToBounds = true
        imageV.contentMode = .scaleAspectFit
        imageV.isUserInteractionEnabled = true
        imageV.layer.borderColor = ColorWhite.cgColor
        imageV.layer.borderWidth = 2
        imageV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickUserIcon)))
        return imageV
    }()
    lazy var secretLab: UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "ic_lock")
        imageV.isHidden = true
        return imageV
    }()
    
    
    lazy var bottomView: UIView = {
        let bgView = UIView.init()
        return bgView
    }()
    lazy var collectButton : UIButton = {
        
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "spaceCollect"), for: .normal)
        button.addTarget(self, action: #selector(ClickCollectAction), for: .touchUpInside)
        return button
    }()
    lazy var loveButton : UIButton = {
        
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "SpaceLove"), for: .normal)
        button.addTarget(self, action: #selector(ClickLoveAction), for: .touchUpInside)
        return button
    }()
    lazy var petChooseButton : UIButton = {
        
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "petChoose"), for: .normal)
        button.addTarget(self, action: #selector(ClickPetChooseAction), for: .touchUpInside)
        return button
    }()
    
    lazy var titleLab:CircleTextView = {
        let label = CircleTextView.init()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = ColorTitle
        return label
    }()
    lazy var voiceButton : UIButton = {
        
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "spaceVoice"), for: .normal)
        button.addTarget(self, action: #selector(playVoice), for: .touchUpInside)
        return button
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
    
    lazy var charmBtn : UIButton = {
        
        let Btn = UIButton.init(type: .custom)
        
        Btn.layer.masksToBounds = true
        Btn.layer.cornerRadius  = 3
        Btn.titleLabel?.font = UIFont.pingFangMediumFont(size: 10)
        Btn.backgroundColor = UIColor.colorWithHex(hex: 0xEA593A)
        Btn.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 5)
        Btn.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 0)
        Btn.setTitleColor(ColorWhite, for: .normal)
        Btn.setImage(UIImage.init(named: "meili"), for: .normal)
        Btn.addTarget(self, action: #selector(ClickCharmAction), for: .touchUpInside)
        return Btn
        
    }()
    lazy var location:UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "location")
        return imageV
    }()
    lazy var cityLab:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.pingFangTextFont(size: 14)
        label.textColor = ColorTitle
        return label
    }()
    lazy var jobLab:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.pingFangTextFont(size: 14)
        label.textColor = ColorTitle
        return label
    }()
    lazy var schoolLab:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.pingFangTextFont(size: 14)
        label.textColor = ColorTitle
        return label
    }()
    lazy var starLoveButton : UIButton = {
        
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "LOVE"), for: .normal)
        button.addTarget(self, action: #selector(ClickStarLoveAction), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    lazy var HomePetButton : UIButton = {
        
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "HomePet"), for: .normal)
        button.addTarget(self, action: #selector(ClickHomePetAction), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    

    var isLoveSelected = false
   
    
    var userID = ""
    
    var Model = PersonPageSpaceModel()
    
    var isUserImageSelected = false
    
    init(userID :String ) {
        super.init(nibName: nil, bundle: nil)
        self.userID  = userID
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        VoiceAudioUrlPlayer.shared.audioPlayer.pause()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.fd_prefersNavigationBarHidden = true
       self.createUI()
  
        loadData()
        
    }
    
    
    
}

extension PageSpaceViewController {
    func loadData(){
     
        PersonalAPI.shared.APPGetUserVisitInfoURL(userId: userID,success: { (json) in
            if let response = BasePersonPageSpaceModel.deserialize(from: json as? [String:Any]){
                if  response.code == 200{
                    self.Model = response.data ?? PersonPageSpaceModel()
                    
                    self.updateUI()
                    
                }
            }
            
        }) { (error) in
            
        }
    }
    
   
    
    
    func updateUI(){
         self.bgView.gradientStringDIYColor(colorsString :Model.backImage ?? "")
        titleLab.text = Model.nickname ?? ""
        
        sex.image = Model.sex == 1 ? UIImage.init(named: "man") : UIImage.init(named: "women")
        
        age.text = "\(Model.age ?? 18)岁"
        constellation.image = UIImage.init(named: Model.constellation ?? "金牛座")
        
        charmBtn.setTitle( "\(Model.charm ?? 10)", for: .normal)
        
        cityLab.text = Model.area ?? "我在哪"
        
        jobLab.text = Model.profession ?? "我是谁"
        
        if Model.schoolName == nil {
            schoolLab.text = "我在干什么"
        }else{
             schoolLab.text = Model.department?.isEmpty == true ? Model.schoolName : "\(Model.schoolName ?? "")/\(Model.department ?? "")"
        }
        let colors = Model.backImage?.components(separatedBy: ",")
        userImageView.backgroundColor = UIColor.init(hexString: colors?.first ?? "#6760D4")
       
        
        //访客模式 1访问自己(主人页面) 2好友访问（宠物页面） 3陌生人访问
        switch Model.visitType {
        case 1:
            editBtn.isHidden = false
            let petUrl = "\(Model.petImage ?? "")\(BottomQiuniuUrl)"
            self.userImageView.kf.setImage(urlString: petUrl)
           
            //是否上传了头像
            if Model.avatar?.isEmpty == true {
                centerTipsView.isHidden = false
                BackImageView.isHidden = true
            }else{
                centerTipsView.isHidden = true
                BackImageView.isHidden = false
                BackImageView.kf.setImage(urlString: Model.avatar)
            }
            break
        case 2:
           
            self.userImageView.kf.setImage(urlString: Model.avatar)
            
            moreButton.isHidden = false
            self.bodyimgaeView.kf.setImage(urlString: Model.petImage)
            self.BackImageView.isHidden = true
            self.bodyimgaeView.isHidden = false

            break
        case 3:
            moreButton.isHidden = false
            secretLab.isHidden = false
            starLoveButton.isHidden = false
            HomePetButton.isHidden = false
            self.userImageView.kf.setImage(urlString: Model.avatar)
            
            let blurEffect = UIBlurEffect(style: .light)
            let blurView = UIVisualEffectView(effect: blurEffect)
            blurView.frame = self.userImageView.bounds
            blurView.alpha = 1
            blurView.layer.cornerRadius  = 25
            blurView.layer.masksToBounds = true
            self.userImageView.addSubview(blurView)
            self.userImageView.bringSubviewToFront(secretLab)
            
            self.bodyimgaeView.kf.setImage(urlString: Model.petImage)
            self.BackImageView.isHidden = true
            self.bodyimgaeView.isHidden = false

            break
        default:
            break
        }
        
   
        
        
    }
    
}
extension PageSpaceViewController {
    func createUI(){
        
//        self.view.addSubview(scrollView)
        self.view.addSubviews([bgView,circleView,BackImageView,bodyimgaeView,centerTipsView,rightButtonsView,noUPLab,bottomView,back,editBtn,moreButton])
        
        
        
        centerTipsView.addSubviews([upButton,tipsLab])
        
        rightButtonsView.addSubviews([userImageView,collectButton,loveButton,petChooseButton])
        
        userImageView.addSubview(secretLab)
       
        bottomView.addSubviews([titleLab,voiceButton,sex,age,constellation,charmBtn,location,cityLab,jobLab,schoolLab,starLoveButton,HomePetButton])
   
        baseUI()
        
        centerTipsViewUI()
        
        rightButtonsViewUI()
        
        bottomViewUI()
        
        animationImage()
    }
    
    
}

extension PageSpaceViewController {
    
    func baseUI(){
        
//        scrollView.snp.makeConstraints() { (make) in
//            make.edges.equalToSuperview()
//        }
        circleView.snp.makeConstraints() { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(PageSpaceTopH)
        }
        BackImageView.snp.makeConstraints() { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(PageSpaceTopH)
        }
        bodyimgaeView.snp.makeConstraints() { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(ScreenW-10)
            make.height.equalTo((ScreenW-10)/1.1)
             make.bottom.equalTo(-PageSpaceBootomH - 50)
        }
        noUPLab.snp.makeConstraints() { (make) in
            make.top.equalTo((PageSpaceTopH - 20)/2)
            make.left.right.equalToSuperview()
            make.height.equalTo(20)
        }
    }
    
    
    func centerTipsViewUI(){
        centerTipsView.snp.makeConstraints() { (make) in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(-PageSpaceBootomH)
        }
        upButton.snp.makeConstraints() { (make) in
            make.center.equalToSuperview()
            make.height.width.equalTo(80)
        }
        tipsLab.snp.makeConstraints() { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(upButton.snp.bottom).offset(10)
            make.height.equalTo(20)
        }
    }
    func rightButtonsViewUI(){
        let rightH = PageSpaceTopH/2
        rightButtonsView.snp.makeConstraints() { (make) in
            make.top.equalTo(rightH)
            make.right.equalToSuperview()
            make.bottom.equalTo(-PageSpaceBootomH)
            make.width.equalTo(75)
        }
        petChooseButton.snp.makeConstraints() { (make) in
            make.right.equalTo(-15)
            make.height.width.equalTo(50)
            make.bottom.equalTo(-15)
        }
        loveButton.snp.makeConstraints() { (make) in
            make.right.equalTo(-15)
            make.height.width.equalTo(50)
            make.bottom.equalTo(petChooseButton.snp.top).offset(-15)
        }
        collectButton.snp.makeConstraints() { (make) in
            make.right.equalTo(-15)
            make.height.width.equalTo(50)
            make.bottom.equalTo(loveButton.snp.top).offset(-15)
        }
        userImageView.snp.makeConstraints() { (make) in
            make.right.equalTo(-15)
            make.height.width.equalTo(50)
            make.bottom.equalTo(collectButton.snp.top).offset(-15)
        }
        secretLab.snp.makeConstraints() { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(25)
        }
      
    }
    
    func bottomViewUI(){
        bottomView.snp.makeConstraints() { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(PageSpaceBootomH)
        }
        
        titleLab.snp.makeConstraints() { (make) in
            make.left.equalTo(15)
            make.top.equalTo(30)
            make.width.equalTo(100)
             make.height.equalTo(20)
        }
        voiceButton.snp.makeConstraints() { (make) in
            make.left.equalTo(titleLab.snp.right).offset(10)
            make.top.equalTo(30)
            make.width.equalTo(55)
            make.height.equalTo(20)
        }
        
        sex.snp.makeConstraints() { (make) in
            make.left.equalTo(15)
            make.top.equalTo(titleLab.snp.bottom).offset(20)
            make.width.equalTo(15)
            make.height.equalTo(15)
        }
        age.snp.makeConstraints() { (make) in
            make.left.equalTo(sex.snp.right).offset(5)
            make.top.equalTo(sex.snp.top)
            make.width.equalTo(30)
            make.height.equalTo(15)
        }
        constellation.snp.makeConstraints() { (make) in
            make.left.equalTo(age.snp.right).offset(5)
            make.top.equalTo(sex.snp.top)
            make.width.equalTo(45)
            make.height.equalTo(15)
        }
        charmBtn.snp.makeConstraints() { (make) in
            make.left.equalTo(constellation.snp.right).offset(5)
            make.top.equalTo(sex.snp.top)
            make.width.equalTo(40)
            make.height.equalTo(15)
        }
        
        location.snp.makeConstraints() { (make) in
            make.left.equalTo(15)
            make.top.equalTo(sex.snp.bottom).offset(20)
            make.width.equalTo(11)
            make.height.equalTo(13)
        }
        cityLab.snp.makeConstraints() { (make) in
            make.left.equalTo(location.snp.right).offset(5)
            make.top.equalTo(location.snp.top)
            make.width.equalTo(60)
            make.height.equalTo(13)
        }
        
        jobLab.snp.makeConstraints() { (make) in
            make.left.equalTo(15)
            make.top.equalTo(cityLab.snp.bottom).offset(20)
            make.width.equalTo(ScreenW/2)
            make.height.equalTo(20)
        }
        schoolLab.snp.makeConstraints() { (make) in
            make.left.equalTo(15)
            make.top.equalTo(jobLab.snp.bottom).offset(20)
            make.width.equalTo(ScreenW/2)
            make.height.equalTo(13)
        }
        starLoveButton.snp.makeConstraints() { (make) in
            make.right.equalTo(-15)
            make.top.equalTo(30)
            make.width.height.equalTo(70)
        }
        HomePetButton.snp.makeConstraints() { (make) in
            make.right.equalTo(starLoveButton.snp.left).offset(-5)
            make.top.equalTo(30)
            make.width.height.equalTo(70)
        }
       

    }
    
   
}
extension PageSpaceViewController {
    // 更新个人详细信息
    private func APPPersonInfoUpdateURL(){
        
        let model = self.Model
        DIYAPI.shared.APPDIYChooseInfoUpdateURL(birthday: "", nickName: model.nickname ?? "", sex: model.sex ?? 1, petImage: "", petNickname: "", petVoice: "", petType: 0, backImage: "", profession: model.profession ?? "", area: model.area ?? "", avatar: model.avatar ?? "", departmentId: "", schoolId: model.schoolId ?? "", voiceIntro: model.voiceIntro ?? "", success: { (json) in
            
            let dic = json as? NSDictionary
            let code = dic?.object(forKey: "code") as? Int
            if code != 200 {
                ShowMessageTool.shared.showMessage("上传失败")
                self.BackImageView.isHidden = true
                self.centerTipsView.isHidden = false
                self.Model.avatar = ""
            }else{
                self.centerTipsView.isHidden = true
                self.BackImageView.isHidden = false
                self.BackImageView.kf.setImage(urlString: self.Model.avatar)
                ShowMessageTool.shared.showMessage("上传成功")
            }
            
            
        }, failure: { (error) in
            ShowMessageTool.shared.showMessage("上传失败")
        })
    }
    
    func animationImage(){
        let basicAnimation = CABasicAnimation(keyPath: "transform.translation.y")
        basicAnimation.fromValue = userImageView.origin.y - 5
        basicAnimation.toValue = userImageView.origin.y + 5
        basicAnimation.duration = 1.5
        basicAnimation.repeatCount = HUGE
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        userImageView.layer.add(basicAnimation, forKey: nil)
    }
    
}
extension PageSpaceViewController {
    @objc private func ClickUpAvatorAction(){
        AvatarManager.sharedManager.showWith(parentViewController: self) { (imageUrl) in
            self.Model.avatar = imageUrl
            self.APPPersonInfoUpdateURL()
        }
    }
    @objc private func ClickHomePetAction(){
        guard let petImage = Model.petImage ,let userId = Model.userId else {
            return
        }
        HomeAPI.shared.APPAdoptAnimalURL(beAdoptedUserId: userId, success: { (json) in
            //code码: 506一种类型的宠物只能领养一个,507 该宠物已经被其他用户领取
//            let code = json["code"] as? Int
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
    @objc private func ClickStarLoveAction(){
        let player = SVGAPlayer.init()
        
        player.frame = CGRect.init(x: ScreenW - 100, y: PageSpaceTopH - 100, width: 100, height: 200)
       
        self.view.addSubview(player)
        
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
        
        if !self.isLoveSelected{
            clickZANHttpRequestAction()
        }
        
        
    }
    private func clickZANHttpRequestAction(){
        guard let userId = Model.userId else {
            return
        }
        HomeAPI.shared.APPUserLikeURL(beLikedUserId: userId, success: { (json) in
            self.isLoveSelected = true
        }) { (error) in
            
        }
    
    }
    @objc private func playVoice(){
        guard let voiceIntro = Model.voiceIntro else {
            return
        }
         VoiceAudioUrlPlayer.shared.playAudioUrl(audioUrl: voiceIntro)
    }
    @objc private func clickUserIcon(){
        switch Model.visitType {
        case 1:
            
            let view = MineCharacterView.init(Model: Model)
            view.show()
            
            break
        case 2:
            
            isUserImageSelected = !isUserImageSelected
            if !isUserImageSelected {
                self.noUPLab.isHidden = true
                self.userImageView.kf.setImage(urlString: Model.avatar)
                self.bodyimgaeView.kf.setImage(urlString: Model.petImage)
                self.BackImageView.isHidden = true
                self.bodyimgaeView.isHidden = false
                
                
            }else{
                if Model.avatar?.isEmpty == true {
                    self.noUPLab.isHidden = false
                    self.BackImageView.isHidden = true
                   
                }else{
                    self.noUPLab.isHidden = true
                    self.BackImageView.kf.setImage(urlString: Model.avatar)
                    self.BackImageView.isHidden = false
                }
                self.bodyimgaeView.isHidden = true
                let petUrl = "\(Model.petImage ?? "")\(BottomQiuniuUrl)"
                
                self.userImageView.kf.setImage(urlString: petUrl)
                
               
            }
            
            
            break
        case 3:
            MineTipsView.init().show()
            
            
            break
        default:
            break
        }
        
        
        
        
    }
     //喜欢我的
    @objc private func ClickCollectAction(){
         //访客模式 1访问自己(主人页面) 2好友访问（宠物页面） 3陌生人访问
        guard let userId = Model.userId, let type = Model.visitType  else {
            return
        }
        let vc = LikesFriendsViewController.init(userID: userId, type: 0 ,isMine : type == 1 ? true : false)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //我喜欢的
    @objc private func ClickLoveAction(){
        guard let userId = Model.userId , let type = Model.visitType else {
            return
        }
        
        let vc = LikesFriendsViewController.init(userID: userId, type: 1,isMine : type == 1 ? true : false)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //宠物图鉴
    @objc private func ClickPetChooseAction(){
        guard let userId = Model.userId, let type = Model.visitType  else {
            return
        }
        let vc = PetAnimalsImageViewController.init(userID: userId, isMine : type == 1 ? true : false)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
   
}

//MARK : 编辑,更多t点击事件
extension PageSpaceViewController{
    @objc private func ClickMoreAction(){
        MoreHeadShowView.init(UID: self.userID, nameTitle: self.Model.nickname ?? "").show()
    }
    
    @objc private func gotoEdit(){
        let VC = PersonalViewController()
        
        VC.changedMineHeadInfoBlock = {[unowned self]  in
            self.loadData()
            
        }
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    //魅力值点击跳转H5
    @objc private func ClickCharmAction(){
        let VC = WordViewController.init(nameTitle: "魅力值")
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
}


extension PageSpaceViewController :UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var frame = self.bgImgFrame
        let offsetY = scrollView.contentOffset.y
        frame.size.height -= offsetY
        frame.origin.y = offsetY
        if offsetY <= 0 {
            frame.size.width = frame.size.height * self.bgImgFrame.size.width / self.bgImgFrame.size.height
            frame.origin.x = (self.view.frame.size.width - frame.size.width) / 2
        }
        self.bgView.frame = frame
    }
}
