//
//  VoiceIntroViewController.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/6/9.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class VoiceIntroViewController: BaseViewController {
   
    lazy var backImage:UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "circle")
       
        return imageV
    }()
    lazy var cardImage:UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "bg_card")
        imageV.isUserInteractionEnabled = true
        return imageV
    }()
    lazy var centerImage:UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "bg_card")
//        imageV.backgroundColor = .white
//        imageV.layer.cornerRadius = 10.0
//        imageV.layer.masksToBounds = true
        imageV.isUserInteractionEnabled = true
        return imageV
    }()
    lazy var topLabel:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = ColorWhite
        label.text = "用声音介绍你"
        
        return label
    }()
    lazy var content:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = ColorTitle
        label.numberOfLines = 2
        return label
    }()
    lazy var titleLabel:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.pingFangTextFont(size: 13)
        label.textColor = ColorTitle
        return label
    }()
    lazy var avatar:UIImageView = {
        let ImageView  = UIImageView.init()
        ImageView.layer.cornerRadius = 25.0
        ImageView.layer.masksToBounds = true
        return ImageView
    }()
    lazy var nameLabel:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = ColorTitle
        return label
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
    lazy var playBtn : UIButton = {
        
        let Btn = UIButton.init(type: .custom)
        Btn.setImage(UIImage.init(named: "ic_bf"), for: .normal)
         Btn.setImage(UIImage.init(named: "playIng"), for: .selected)
        Btn.addTarget(self, action: #selector(playVoice), for: .touchUpInside)
        return Btn
        
    }()
    lazy var RecordBtn:UIButton = {
        let Btn = UIButton.init(type: .custom)
        Btn.setImage(UIImage.init(named: "ic_luyin"), for: .normal)
        Btn.addTarget(self, action: #selector(startTimer), for: .touchDown)
        Btn.addTarget(self, action: #selector(endRecord), for: .touchUpInside)
        
        Btn.addTarget(self, action: #selector(endRecord), for: .touchUpOutside)
        
        return Btn
    }()
   
    lazy var tips:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.pingFangMediumFont(size: 12)
        label.textColor =  ColorWhite
        label.text = "按住录音按钮，即可开始录制"
        return label
    }()
    lazy var timeLabel:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor =  ColorWhite
        label.isHidden = true
        return label
    }()
    lazy var progress:CircleProgress = {
        let progress = CircleProgress.init()
        progress.isHidden = true
        return progress
    }()
     var SoundModel = PersonalSoundIntroModel()
    var timer : Timer?
    var Times = 10
    
    var playerItem:AVPlayerItem!
    var audioPlayer:AVPlayer!
    
    private var direction = ContainerDragDirection.ContainerDragDefaults
    private var xCenter: CGFloat = 0.0
    private var yCenter: CGFloat = 0.0
    private var originalPoint = CGPoint.zero
    private var cardCenter = CGPoint.zero
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addBackViewGradientLayer()
        fd_prefersNavigationBarHidden = true
        createUI()
        loadData()
    }
    
    
    deinit {
       
        NotificationCenter.default.removeObserver(self)
    }
    
   

}
extension VoiceIntroViewController {
    //MARK:移动卡片
    func panGesturemMoveFinishOrCancle(cardView :UIImageView, direction :ContainerDragDirection , scale :CGFloat ,isDisappear :Bool ,index :Int){
        if isDisappear{
            var finishPoint = CGPoint.zero
            if direction == .ContainerDragLeft {
                finishPoint = CGPoint.init(x: -ScreenW, y: -ScreenW/scale + self.cardCenter.y)
            }else if direction == .ContainerDragRight{
                finishPoint = CGPoint.init(x: 2*ScreenW, y: 2 * ScreenW/scale + self.cardCenter.y)
            }else{
                finishPoint = self.originalPoint
            }
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveLinear , .allowUserInteraction], animations: {
                
                cardView.center = finishPoint
            }) { (finished) in
                
              
                cardView.removeFromSuperview()
               self.loadData()
                
            }
            
            
        }else{
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: [], animations: {
                cardView.center = self.originalPoint
                self.view.transform = CGAffineTransform(rotationAngle: 0)
                
            })
        }
    }
    
    //拖动手势
    @objc private func handlePanGesture(_ pan: UIPanGestureRecognizer) {
       
       
            let handleCardView = pan.view!
            xCenter = pan.translation(in: self.view).x
            yCenter = pan.translation(in: self.view).y
            switch pan.state{
                
            case .began:
                originalPoint = self.centerImage.center
                break
            case .changed:
                
                
                handleCardView.center = CGPoint.init(x: handleCardView.center.x + xCenter, y: handleCardView.center.y + yCenter)
      
                pan.setTranslation(.zero, in: self.view)
                
                
                break
            case .ended :
                
                
                if handleCardView.center.x < self.cardCenter.x {
                    self.direction = .ContainerDragLeft
                }else if handleCardView.center.x > self.cardCenter.x{
                    self.direction = .ContainerDragRight
                }else{
                    self.direction = .ContainerDragDefaults
                }
                let horizionSliderRate = (handleCardView.center.x - self.cardCenter.x) / self.cardCenter.x
                
                let moveY = handleCardView.center.y  - self.cardCenter.y
                let moveX = handleCardView.center.x - self.cardCenter.x
                self.panGesturemMoveFinishOrCancle(cardView: handleCardView as! UIImageView, direction: self.direction, scale: moveX/moveY, isDisappear: abs(horizionSliderRate)>1, index: pan.view?.tag ?? 0)
                
                break
            case .cancelled:
                break
            case .failed:
                break
            case .possible:
                break
            }
            
            
        }
        
    
}
//MARK:初始化布局
extension VoiceIntroViewController {
    func createUI(){
        self.view.addSubviews([back,cardImage,backImage,topLabel,progress,RecordBtn,tips,timeLabel])
        
        
        layoutUI()
        
        
        
    }
    
    func addCardUI(){
        self.view.addSubview(centerImage)
        self.cardCenter = self.view.center
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(_:)))
        centerImage.addGestureRecognizer(panGesture)
        centerImage.addSubviews([content,titleLabel,avatar,nameLabel,sex,constellation,age,playBtn])
        
        centerImage.snp.makeConstraints { (make) in
            make.top.equalTo(topLabel.snp_bottom).offset(25)
            make.centerX.equalToSuperview()
            make.width.equalTo(ScreenW - 100)
            make.height.equalTo((ScreenW - 100)*1.2)
        }
        content.snp.makeConstraints { (make) in
            make.top.equalTo(60)
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(50)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(content.snp_bottom).offset(20)
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(20)
        }
        avatar.snp.makeConstraints { (make) in
            make.bottom.equalTo(-50)
            make.left.equalTo(30)
            make.width.height.equalTo(50)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(avatar.snp_top)
            make.left.equalTo(avatar.snp_right).offset(10)
            make.right.equalTo(-80)
            make.height.equalTo(20)
        }
        sex.snp.makeConstraints { (make) in
            make.bottom.equalTo(avatar.snp_bottom)
            make.left.equalTo(avatar.snp_right).offset(10)
            make.height.width.equalTo(15)
        }
        age.snp.makeConstraints { (make) in
            make.bottom.equalTo(avatar.snp_bottom)
            make.left.equalTo(sex.snp_right).offset(10)
            make.height.equalTo(15)
            make.width.equalTo(30)
        }
        constellation.snp.makeConstraints { (make) in
            make.bottom.equalTo(avatar.snp_bottom)
            make.left.equalTo(age.snp_right).offset(10)
            make.height.equalTo(15)
            make.width.equalTo(45)
        }
        playBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(-50)
            make.right.equalTo(-15)
            make.width.height.equalTo(50)
        }
    }
    
    
    
    func layoutUI(){
        backImage.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        cardImage.snp.makeConstraints { (make) in
            make.top.equalTo(topLabel.snp_bottom).offset(25)
            make.centerX.equalToSuperview()
            make.width.equalTo(ScreenW - 100)
            make.height.equalTo((ScreenW - 100)*1.2)
        }
        topLabel.snp.makeConstraints { (make) in
            make.top.equalTo(back.snp_bottom).offset(30)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(30)
        }
       
        tips.snp.makeConstraints { (make) in
            make.bottom.equalTo(-SafeBottomMargin - 25)
            make.left.right.equalToSuperview()
            make.height.equalTo(20)
        }
        RecordBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(tips.snp_top).offset(-20)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(80)
        }
        progress.snp.makeConstraints { (make) in
            make.bottom.equalTo(tips.snp_top).offset(-10)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(100)
        }

        timeLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(RecordBtn.snp_top).offset(-20)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(20)
        }
        
        
    }

}
//MARK:数据
extension VoiceIntroViewController {
    func loadData(){
        PersonalAPI.shared.APPSoundQualityUserURL(success: { (json) in
            if let response = BasePersonalSoundIntroModel.deserialize(from: json as? [String:Any]){
                if response.code == 200 {
                    self.addCardUI()
                    self.SoundModel = response.data ?? PersonalSoundIntroModel()
                    self.SetModelData(model: self.SoundModel)
                   
                }else{
                    ShowMessageTool.shared.showMessage("请求失败")
                }
            }
        
        
        }) { (error) in
            
        }
    }
    
    func SetModelData(model : PersonalSoundIntroModel){
        self.content.text = model.content
        self.titleLabel.text = model.title
        if model.sex == 1 {
            self.sex.image = UIImage.init(named: "man")
        }else{
            self.sex.image = UIImage.init(named: "woman")
        }
        self.age.text = "\(model.age ?? 18)岁"
        self.nameLabel.text = model.nickname
        self.constellation.image = UIImage.init(named: model.constellation ?? "金牛座")
        self.avatar.kf.setImage(urlString: model.avatar)
    }
}
//MARK:录音时长记录
extension VoiceIntroViewController {
    @objc private func startTimer(){
        timeLabel.isHidden = false
        self.topLabel.text = "正在录制..."
        Times = 0
       self.startRecorde()
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerRun), userInfo: nil, repeats: true)
        }
        timer?.fireDate = Date.distantPast
        
        self.progress.isHidden = false
        self.progress.progress = 1
    }
    
  
    
    
    @objc private func timerRun(){
       
        timeLabel.text = "00:0\(Times)"
        if Times == 10 {
            TimeBackUI()
        }else{
            Times = Times + 1
        }
        
      
        
    }
    
    func TimeBackUI(){
        Times = 0
        timer?.invalidate()
        timer    = nil
        timeLabel.isHidden = true
        self.topLabel.text = "用声音介绍你"
        
        self.progress.isHidden = true
        self.progress.progress = 0
    }
   
    private func startRecorde(){
       
        CWRecorder.shareInstance()?.beginRecord(withRecordPath: CWFlieManager.filePath())
    }
    
    @objc private func endRecord(){
       
        
        CWRecorder.shareInstance()?.endRecord()
        if Times  > 2 && Times <= 10{
          TimeBackUI()
            
            let vc = ChooseSoundIntroViewController()
            vc.times = Times
            self.navigationController?.pushViewController(vc, animated: false)
        }else{
            TimeBackUI()
            
            CWRecorder.shareInstance()?.deleteRecord()
            let path = CWRecorder.shareInstance()?.recordPath
            CWFlieManager.removeFile(path)
            ShowMessageTool.shared.showMessage("录制时间过短")
        }
        
        
    }
    
    
    @objc private func playVoice(){
        guard let url = self.SoundModel.voiceIntro else {
            return
        }
        
        self.playBtn.isSelected = !self.playBtn.isSelected
        self.playAudioUrl(audioUrl: url)
        if !self.playBtn.isSelected {
            self.audioPlayer.pause()
        }else{
            self.audioPlayer.play()
        }
    }
    
    func playAudioUrl(audioUrl: String){
        guard let url = URL(string: audioUrl) else {
            return
        }
        
        self.playerItem = AVPlayerItem.init(url: url)
        self.audioPlayer = AVPlayer.init(playerItem: self.playerItem)
        self.audioPlayer.play()
        
        NotificationCenter.default.addObserver(self, selector: #selector(playToEndTime), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        
    }
    @objc func playToEndTime(){
       self.playBtn.isSelected = false
    }
    
    
}
