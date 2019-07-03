//
//  RaiseAnimalInfoViewController.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/6/24.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit
import AMPopTip

//白天背景：05:00-19:00
//黑夜背景：19:01-04:59
class RaiseAnimalInfoViewController: BaseViewController {
    lazy var backView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.image=UIImage(named: "Raisebg")
        imageView.frame  = self.view.frame
        return imageView
    }()
    lazy var infoTagView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.image=UIImage(named: "tag")
        imageView.frame  = CGRect.init(x: 40, y: statusBarH, width: 125, height: 140)
        return imageView
    }()
    lazy var infoView: RaiseTagInfoView = {
        let infoView = RaiseTagInfoView.init()
        
        infoView.frame  = CGRect.init(x: 0, y: 80, width: 125, height: 60)
        self.infoTagView.addSubview(infoView)
        return infoView
    }()
    lazy var earthView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.image = UIImage(named: "RaiseSaturn")
        imageView.frame  = CGRect.init(x: -200, y: statusBarH + 10, width: ScreenW + 200, height: ScreenH - statusBarH - 100 - SafeBottomMargin)
        return imageView
    }()
    
    lazy var mountainsView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.image=UIImage(named: "mountains")
        imageView.frame  = CGRect.init(x: 0, y: ScreenH - 200 - SafeBottomMargin, width: ScreenW, height: 200 + SafeBottomMargin)
        return imageView
    }()
    lazy var nextButton : UIButton = {
        
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "next"), for: .normal)
        button.frame  = CGRect.init(x: ScreenW - 15 - 35, y: 0, width: 35, height: 35)
        button.centerY = self.view.centerY
        button.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        return button
    }()
    lazy var previousButton : UIButton = {
        
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "previous"), for: .normal)
        button.frame  = CGRect.init(x: 15, y: 0, width: 35, height: 35)
        button.centerY = self.view.centerY
        button.addTarget(self, action: #selector(previousAction), for: .touchUpInside)
        return button
    }()
    
    lazy var homeButton : UIButton = {
        
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "home"), for: .normal)
        button.frame  = CGRect.init(x: ScreenW - 40 - 20, y: navigationBarHeight + 40, width: 42, height: 49)
        button.addTarget(self, action: #selector(HomeAction), for: .touchUpInside)
        return button
    }()
    
    lazy var strategyButton : UIButton = {
        
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "strategy"), for: .normal)
        button.frame  = CGRect.init(x: ScreenW - 40 - 20, y: homeButton.bottom + 15, width: homeButton.w, height: homeButton.h)
        button.addTarget(self, action: #selector(strategyAction), for: .touchUpInside)
        return button
    }()
    lazy var setButton : UIButton = {
        
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "Raiseset"), for: .normal)
        button.frame  = CGRect.init(x: ScreenW - 40 - 20, y: strategyButton.bottom + 15, width: homeButton.w, height: homeButton.h)
        
       button.addTarget(self, action: #selector(setAction), for: .touchUpInside)
        return button
    }()
    lazy var charm: UIImageView = {
        let imageView = UIImageView.init()
        imageView.image=UIImage(named: "qinmi")
        imageView.frame  = CGRect.init(x: ScreenW/2 - 50, y: setButton.top - 10, width: 15, height: 15)
        
        return imageView
    }()
    lazy var charmView: UIView = {
        let view = UIView.init()
        view.layer.cornerRadius  = 6
        view.layer.masksToBounds = true
        view.layer.borderColor = ColorCharmColor.cgColor
        view.layer.borderWidth = 0.5
        view.backgroundColor = .white
        view.frame  = CGRect.init(x:charm.right + 10, y: charm.top, width: 60, height: 12)
        return view
    }()
    lazy var charmLabel: lineLabel = {
        let label = lineLabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textColor = ColorCharmColor
        label.shadowOffset = CGSize.init(width: 0, height: 0)
        label.text = "20"
        label.frame  = CGRect.init(x:0, y: 0, width: 60, height: 12)
        self.charmView.addSubview(label)
        return label
    }()
    lazy var charmDianView: UIView = {
        let view = UIView.init()
        view.backgroundColor = ColorCharmColor
        view.frame  = CGRect.init(x:0, y: 0, width: 10, height: 12)
        self.charmView.addSubview(view)
        
        return view
    }()
    lazy var sunView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.image = UIImage(named: "sun")
         imageView.isUserInteractionEnabled = true
        imageView.frame  = CGRect.init(x: ScreenW - 150, y: setButton.top + 20, width: 80, height: 80)
         imageView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(sunAction)))
        return imageView
    }()
    lazy var moring: UIImageView = {
        let imageView = UIImageView.init()
        imageView.image = UIImage(named: "morning")
        imageView.isHidden = true
        imageView.frame  = CGRect.init(x: ScreenW - 150, y: setButton.top + 20, width: 80, height: 80)
        return imageView
    }()
    
    lazy var feedingButton : UIButton = {
        
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "Raisefeeding"), for: .normal)
        button.frame  = CGRect.init(x: 20, y: ScreenH - 56 - 25 - SafeBottomMargin, width: 50, height: 56)
        button.addTarget(self, action: #selector(feedAction), for: .touchUpInside)
        return button
    }()
    lazy var playButton : UIButton = {
        
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "Play"), for: .normal)
        button.frame  = CGRect.init(x: feedingButton.right + 25, y: feedingButton.top, width: feedingButton.w, height: feedingButton.h)
        button.addTarget(self, action: #selector(playAction), for: .touchUpInside)
        return button
    }()
    lazy var educationButton : UIButton = {
        
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "education"), for: .normal)
        button.frame  = CGRect.init(x: playButton.right + 25, y: feedingButton.top, width: feedingButton.w, height: feedingButton.h)
       button.addTarget(self, action: #selector(educationAction), for: .touchUpInside)
        return button
    }()
    lazy var RaiseChatButton : UIButton = {
        
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "RaiseChat"), for: .normal)
        button.frame  = CGRect.init(x: ScreenW - 70, y: feedingButton.top, width:feedingButton.w, height: feedingButton.h)
        button.addTarget(self, action: #selector(RaiseChatAction), for: .touchUpInside)
        return button
    }()
    lazy var bodyAniamlsView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.frame  = CGRect.init(x: 0, y:setButton.top + 10, width: ScreenW - 40, height: (ScreenW - 40)/1.1)
        imageView.centerX = self.view.centerX
        return imageView
    }()
    lazy var MSGImageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.image = UIImage.init(named: "airbubbles")
        imageView.isHidden = true
        imageView.isUserInteractionEnabled = true
        imageView.frame  = CGRect.init(x: previousButton.right, y:previousButton.bottom + 30, width: 80, height: 50)
        imageView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(gotoPlayVoice)))
        return imageView
    }()
    lazy var voiceImageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.image = UIImage.init(named: "RaiseVoice")
        imageView.frame  = CGRect.init(x: 15, y:15, width: 15, height: 15)
        self.MSGImageView.addSubview(imageView)
        return imageView
    }()
    
    lazy var voiceLab:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.pingFangTextFont(size: 14)
        label.textColor =  ColorCancleColor
        label.text = "语音"
        label.frame  = CGRect.init(x: voiceImageView.right + 5, y:15, width: 40, height: 15)
        self.MSGImageView.addSubview(label)
        return label
    }()
    var dataArr = [RaiseAnimalsModel]()
    var model = RaiseAnimalsModel()
    var indexPath = 0
    var isSunSelect = false //是否点击了太阳
    init(dataArr :[RaiseAnimalsModel], indexPath:Int) {
        super.init(nibName: nil, bundle: nil)
        self.dataArr  = dataArr
        self.indexPath  = indexPath
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.layer.masksToBounds = true
        self.view.layer.cornerRadius  = 1
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fd_prefersNavigationBarHidden = true
        configUI()
        loadData()
    }
    
    func configUI(){
        self.view.addSubviews([backView,earthView,infoTagView,homeButton,strategyButton,setButton,mountainsView,bodyAniamlsView,sunView,moring,nextButton,previousButton,feedingButton,playButton,educationButton,RaiseChatButton,MSGImageView,charm,charmView,back])
        
       
        RaiseChatAnimation()
        earthroundAnimation()
        sunAnimation()
        bodyAniamlsView.kf.setImage(urlString: self.dataArr[indexPath].petImage)
        
       dayOrNightUpdataUI()
    }

}
extension RaiseAnimalInfoViewController{
    func loadData(){
        RaiseRoomAPI.shared.APPRaiseRoomCultivateInfoURL(success: { (json) in
            if let response = BaseRaiseAnimalsModel.deserialize(from: json as? [String:Any]){
                if  response.code == 200{
                    self.dataArr.removeAll()
                    self.dataArr = response.data
                    self.model = self.dataArr[self.indexPath]
                    self.updateUI()
                    
                }
            }
            
        }) { (error) in
            
        }
    }
    
    func updateUI(){
        self.infoView.model = self.model
        self.charmLabel.text = "\(self.model.closeDeg)"
        self.charmDianView.w = CGFloat((60 * self.model.closeDeg)) / 100
        showNewMSG()
         bodyAniamlsView.kf.setImage(urlString: self.dataArr[indexPath].petImage)
        self.showBottomThirdTips()
        
        if self.dataArr.count < 2 {
            self.nextButton.isHidden = true
            self.previousButton.isHidden = true
        }else{
            self.nextButton.isHidden = false
            self.previousButton.isHidden = false
        }
    }
}
//MARK:白天黑夜的UI更新
extension RaiseAnimalInfoViewController{
    func dayOrNightUpdataUI(){
        
        let currenDay = Date.init().dayAndNight()
        if currenDay {
            backView.image = UIImage.init(named: "Raisebg")
            earthView.image = UIImage.init(named: "RaiseSaturn")
            mountainsView.image = UIImage.init(named: "mountains")
            sunView.image = UIImage.init(named: "sun")
            
        }else{
            backView.image = UIImage.init(named: "bgNight")
            earthView.image = UIImage.init(named: "saturnNight")
            mountainsView.image = UIImage.init(named: "moutainNight")
            sunView.image = UIImage.init(named: "moon")
        }
    }
    
}

 //MARK:各种消息提示和动画
extension RaiseAnimalInfoViewController{
    func showBottomThirdTips(){
        guard let feed = model.notice?.feed else {
            return
        }
        if !feed.isEmpty{
            self.showPopTips(tips: feed, fromButtons: feedingButton)
        }
        
        guard let accompany = model.notice?.accompany else {
            return
        }
        if !accompany.isEmpty{
            self.showPopTips(tips: accompany, fromButtons: playButton)
        }
        
        guard let edu = model.notice?.edu else {
            return
        }
        if !edu.isEmpty{
            self.showPopTips(tips: edu, fromButtons: educationButton)
        }
        
    }
     //MARK:消息提示
    func showNewMSG(){
        if self.model.newMsgCnt == 1 {
            MSGImageView.isHidden = true
        }else{
            MSGImageView.isHidden = false
            if model.latestMsg != nil {
                
               voiceImageView.image = UIImage.init(named: "")
                voiceLab.text = "新消息"
            }
            if model.latestVoiceMsg == nil {
               voiceImageView.image = UIImage.init(named: "RaiseVoice")
                voiceLab.text = "语音"
                
            }
        }
        
        
    }
   
    //MARK:互动按钮波纹雷达动画
    func RaiseChatAnimation(){
        let layer = RaiseChatButton.layer.makeRadarAnimation(showRect: CGRect.init(x: ScreenW - 70, y: feedingButton.top, width:50, height: 50), isRound: true)
        view.layer.insertSublayer(layer, below: RaiseChatButton.layer)
        
        
    }
     //MARK:太阳发光缩放动画
    func sunAnimation(){
        let basicAnimation = CAKeyframeAnimation(keyPath: "transform")
        let scale1 = CATransform3DMakeScale(1.05, 1.05, 1)
        let scale2 = CATransform3DMakeScale(1, 1, 1)
        let scale3 = CATransform3DMakeScale(1.05, 1.05, 1)
        basicAnimation.duration = 3
        basicAnimation.repeatCount = HUGE
        basicAnimation.keyTimes = [0.4,0.7,1]
        basicAnimation.values = [scale1,scale2,scale3]
        
        basicAnimation.isRemovedOnCompletion = false
        
        basicAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        sunView.layer.add(basicAnimation, forKey: nil)
        
    }
    
    //MARK:地球旋转翻转动画
    func earthroundAnimation() {
        
        let basicAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        basicAnimation.duration = 80
        basicAnimation.repeatCount = HUGE
        basicAnimation.keyTimes = [0, 0.5, 0.85, 1]
        basicAnimation.values = [0, CGFloat(Double.pi), CGFloat(Double.pi) * 1.7, CGFloat(Double.pi) * 2]
        
        basicAnimation.isRemovedOnCompletion = false
       
        basicAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        self.earthView.layer.add(basicAnimation, forKey: nil)
        
    }
    

    
    
    //MARK:显示底部三个按钮弹出对话框
    func  showPopTips(tips :String,fromButtons :UIButton){
       
        let imageView = UIImageView(image: UIImage(named: "airbubbles"))
        
        let popFrame = CGRect.init(x: fromButtons.x - 8, y: fromButtons.y + 8, width: 65, height: 35)
        let label = UILabel.init(font: UIFont.pingFangTextFont(size: 14), color: ColorGrayTitle, alignment: .center)
        label.text = tips
        
        let customView = UIView(frame:popFrame)
        customView.backgroundColor = UIColor.clear
        imageView.frame = CGRect(x: 0, y: 0, width: 65, height: 35)
        label.frame = CGRect(x: 5, y: 0, width: 55, height: 20)
        label.center = imageView.center
        
        imageView.addSubview(label)
        customView.addSubview(imageView)
        let RaisePopTip = PopTip.init()
        RaisePopTip.bubbleColor = UIColor.clear
        RaisePopTip.shouldDismissOnTap = true
        RaisePopTip.shouldDismissOnTapOutside = true
        RaisePopTip.frame = popFrame
        RaisePopTip.show(customView: customView, direction: .up, in: self.view, from: popFrame)
        
    }
    
    //MARK:早安和晚安
    func  sunNightshowPopTips(type :Int){
        sunView.layer.removeAllAnimations()
        self.sunView.alpha = 1
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.sunView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.sunView.alpha = 0
        }) { (finish) in
            self.sunView.isHidden = true
            self.moring.isHidden = false
              self.moring.image = UIImage.init(named: type == 1 ? "morning" : "night")
            self.moring.alpha = 0
            self.moring.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                self.moring.alpha = 1
                self.moring.transform = .identity
            }) { (finish) in
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
                        self.sunView.alpha = 1
                        self.moring.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                        self.moring.alpha = 0
                    }) { (finish) in
                        self.isSunSelect = false
                        self.moring.isHidden = true
                        self.moring.transform = .identity
                        self.sunView.transform = .identity
                        self.sunView.isHidden = false
                        self.sunAnimation()
                    }
                }
            }
            
           
        }
        
    }
    func sunNightRequestAPI(type :Int){
        guard let uid = model.userId else {
            return
        }
        ChatRoomAPI.shared.APPMoringNightURL(beUserId: uid, msgType: type, success: { (json) in}) { (error) in}
    }

}
extension RaiseAnimalInfoViewController {
    
    @objc private func gotoPlayVoice(){
       
        guard let voiceUrl = self.model.voiceIntro else { return }
        VoiceAudioUrlPlayer.shared.playAudioUrl(audioUrl: voiceUrl)
    }
    @objc private func sunAction(){
        if isSunSelect {
            return
        }
        self.isSunSelect = true
        self.dayOrNightUpdataUI()

        if Date.init().dayMoring() {
            self.sunNightshowPopTips(type: 0)
             self.sunNightRequestAPI(type: 15)
        }
        if Date.init().dayNight() {
            self.sunNightshowPopTips(type: 1)
            self.sunNightRequestAPI(type: 16)
        }
       
    }
    //Home
    @objc private func HomeAction(){
         guard let uid = self.model.userId else { return }
        let vc = PageSpaceViewController.init(userID: uid)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //攻略
    @objc private func strategyAction(){
       RaiseStrategyView.init().show()
    }
    
    //设置
    @objc private func setAction(){
       
        let view = RaiseSettingShowView.init(model: self.model)
         view.show()
    }
    
    //喂养
    @objc private func feedAction(){
        let view = RaiseAlertShowView.init(model: self.model, type: .feeding)
        view.RaiseAlertShowSuccessBlcok = {[weak self] in
            self?.loadData()
        }
        view.show()
    }
    //陪玩
    @objc private func playAction(){
        let view = RaiseAlertShowView.init(model: self.model, type: .play)
        view.RaiseAlertShowSuccessBlcok = {[weak self] in
            self?.loadData()
        }
        view.show()
    }
      //教育
    @objc private func educationAction(){
        let view = RaiseAlertShowView.init(model: self.model, type: .education)
        view.RaiseAlertShowSuccessBlcok = {[weak self] in
            self?.loadData()
        }
        view.show()
    }
    //互动
    @objc private func RaiseChatAction(){
        guard let uid = self.model.userId else { return }
        let vc = ChatRoomViewController.init(userID: uid)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //nextButton,previousButton
    @objc private func nextAction(){
        if self.indexPath == self.dataArr.count {
            self.model = self.dataArr[0]
        }else{
            self.model = self.dataArr[indexPath + 1]
        }
        self.updateUI()
    }
   
    @objc private func previousAction(){
        if self.indexPath == 0 {
            self.model = self.dataArr[self.dataArr.count-1]
        }else{
            self.model = self.dataArr[indexPath - 1]
        }
        self.updateUI()
    }
    
    //动物
    @objc private func bodyAnimalsAction(){
        
    }
}
