//
//  ChooseSoundIntroViewController.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/6/9.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit
import SwiftyJSON
import Qiniu

enum ChooseSoundType {
    
    case luoli
    
    case yujie
    
    case uncle
   
    case normal
    
}
class ChooseSoundIntroViewController: BaseViewController {
    
    lazy var backImage:UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "circle")
        
        return imageV
    }()
    lazy var topLabel:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = ColorWhite
        label.text = "可选变声"
        
        return label
    }()
    lazy var luoli:UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "img_luoli")
        imageV.isUserInteractionEnabled = true
       
        let TapGesture = UITapGestureRecognizer(target: self, action: #selector(self.PlaySoundClick(_:)))
        imageV.tag = 1001
        imageV.addGestureRecognizer(TapGesture)
        return imageV
    }()
    lazy var luoliLabel:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = ColorTitle
        label.text = "萝莉音"
        
        return label
    }()
    lazy var yujieLabel:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = ColorTitle
        label.text = "御姐音"
        
        return label
    }()
    lazy var uncleLabel:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = ColorTitle
        label.text = "大叔音"
        
        return label
    }()
    lazy var yujie:UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "img_yujie")
        imageV.isUserInteractionEnabled = true
        
        let TapGesture = UITapGestureRecognizer(target: self, action: #selector(self.PlaySoundClick(_:)))
        imageV.addGestureRecognizer(TapGesture)
        imageV.tag = 1002
        return imageV
    }()
    lazy var uncle:UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "img_dashu")
        imageV.isUserInteractionEnabled = true
        
        let TapGesture = UITapGestureRecognizer(target: self, action: #selector(self.PlaySoundClick(_:)))
        imageV.addGestureRecognizer(TapGesture)
        imageV.tag = 1003
        return imageV
    }()
    lazy var closeBtn : XZBShareButtonExt = {
        
        let Btn = XZBShareButtonExt.init(type: .custom)
        Btn.setImage(UIImage.init(named: "ic_x"), for: .normal)
        Btn.setTitle("重录", for: .normal)
        Btn.setTitleColor(ColorWhite, for: .normal)
       
        Btn.titleLabel?.font = UIFont.pingFangTextFont(size: 14)
        Btn.addTarget(self, action: #selector(close), for: .touchUpInside)
        
        return Btn
        
    }()
    lazy var playBtn : XZBShareButtonExt = {
        
        let Btn = XZBShareButtonExt.init(type: .custom)
        Btn.setImage(UIImage.init(named: "ic_st"), for: .normal)
        Btn.setTitle("试听", for: .normal)
        Btn.setTitleColor(ColorWhite, for: .normal)
        Btn.titleLabel?.font = UIFont.pingFangTextFont(size: 14)
        Btn.addTarget(self, action: #selector(playVoice), for: .touchUpInside)
        return Btn
        
    }()
    lazy var sureBtn : XZBShareButtonExt = {
        
        let Btn = XZBShareButtonExt.init(type: .custom)
        Btn.setImage(UIImage.init(named: "ic_check"), for: .normal)
        Btn.setTitle("完成", for: .normal)
        Btn.setTitleColor(ColorWhite, for: .normal)
        
        Btn.titleLabel?.font = UIFont.pingFangTextFont(size: 14)
        Btn.addTarget(self, action: #selector(sure), for: .touchUpInside)
        return Btn
        
    }()
    lazy var timeLabel:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor =  ColorWhite
        label.isHidden = true
        return label
    }()
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.deleteSoundPath()
    }
    var titles = ["萝莉","御姐","大叔"]
    var pitch = [12,3,-7]
    var rate = [0,0,0]
    var tempo = [0,0,0]
    var dataArr = [VoiceModel]()
    let uploadManage = QNUploadManager()
    var option : QNUploadOption!
    var DIYVoice = ""
    var times = 3
    var SoundChooseNomal = true
    var timer : Timer?
    var Times = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addBackViewGradientLayer()
        fd_prefersNavigationBarHidden = true
        createUI()
    }
    
    
    
}
//MARK:初始化布局
extension ChooseSoundIntroViewController {
    func createUI(){
        self.view.addSubviews([back,backImage,topLabel,luoli,yujie,uncle,closeBtn,playBtn,sureBtn,timeLabel])

        luoli.addSubview(luoliLabel)
        yujie.addSubview(yujieLabel)
        uncle.addSubview(uncleLabel)
        
        layoutUI()
        loadData()
        
    }
    
    func layoutUI(){
        let ImageW = (ScreenW - 60)/3
        let buttonW = (ScreenW - 70*3 - 10)/3
        backImage.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        topLabel.snp.makeConstraints { (make) in
            make.top.equalTo(back.snp_bottom).offset(40)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(30)
        }
        luoli.snp.makeConstraints { (make) in
            make.top.equalTo(topLabel.snp_bottom).offset(50)
            make.left.equalTo(15)
            make.width.equalTo(ImageW)
            make.height.equalTo(ImageW*1.5)
        }
        yujie.snp.makeConstraints { (make) in
            make.top.equalTo(luoli.snp_top)
            make.centerX.equalToSuperview()
            make.width.equalTo(ImageW)
            make.height.equalTo(ImageW*1.5)
        }
        uncle.snp.makeConstraints { (make) in
            make.top.equalTo(luoli.snp_top)
            make.right.equalTo(-15)
            make.width.equalTo(ImageW)
            make.height.equalTo(ImageW*1.5)
        }
        luoliLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(20)
            make.bottom.equalTo(-30)
        }
        yujieLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(20)
            make.bottom.equalTo(-30)
        }
        uncleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(20)
            make.bottom.equalTo(-30)
        }
        playBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(-SafeBottomMargin - 40)
            make.centerX.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(120)
        }
        closeBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(playBtn.snp_bottom)
            make.right.equalTo(playBtn.snp_left).offset(-buttonW)
            
            make.width.equalTo(70)
            make.height.equalTo(120)
        }
        sureBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(playBtn.snp_bottom)
            make.left.equalTo(playBtn.snp_right).offset(buttonW)
            
            make.width.equalTo(70)
            make.height.equalTo(120)
        }
        timeLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(playBtn.snp_top).offset(-25)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(20)
        }
        
    }
    
  

}
extension ChooseSoundIntroViewController{
    func playAudioWithPath(model : VoiceModel){
        let path = CWRecorder.shareInstance()?.recordPath
        
        let data = NSData.init(contentsOfFile: path!)
        
        let config = MySountTouchConfig.init(sampleRate: 11025, tempoChange: model.tempo  , pitch: model.pitch , rate: model.rate)
        
        
        let soundTouch = SoundTouchOperation.init(target: self, action: #selector(playVoiceChange(path :)), sound:config , soundFile: data as Data?)
        let queue = OperationQueue()
        //设置最大并发数
        queue.maxConcurrentOperationCount = 1
        queue.cancelAllOperations()
        queue.addOperation(soundTouch!)
        
    }
    
    //变声播放
    @objc private func playVoiceChange(path :String){
        
        CWAudioPlayer.shareInstance()?.playAudio(with: path)
    }
    func loadData(){
        for i in 0..<titles.count {
            let model = VoiceModel.init()
            model.title = titles[i]
            model.pitch = Int32(pitch[i])
            model.rate = Int32(rate[i])
            model.tempo = Int32(tempo[i])
            self.dataArr.append(model)
        }
    }
    
    private func startTimer(){
        timeLabel.isHidden = false
        Times = 0
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerRun), userInfo: nil, repeats: true)
        }
        timer?.fireDate = Date.distantPast
        
    }
    @objc private func timerRun(){
        
        timeLabel.text = "00:0\(Times)"
        if Times == times {
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
        
    }

}
extension ChooseSoundIntroViewController {
    //选择变声类型
    @objc private func PlaySoundClick(_ gest: UITapGestureRecognizer){
        let index =  gest.view?.tag ?? 0
        self.playAudioWithPath(model: self.dataArr[index - 1001])
        self.SoundChooseNomal = false
        self.startTimer()
    }
   
     //原声播放
    @objc private func playVoice(){
        guard let path = CWRecorder.shareInstance()?.recordPath else {
            return
        }
        self.SoundChooseNomal = true
        self.playVoiceChange(path: path)
        self.startTimer()
    }
    @objc private func sure(){
       
        let path = CWRecorder.shareInstance()?.recordPath
        if self.SoundChooseNomal == true{
            self.GetAPPQiNiuTokenUpVoice(path: path ?? "")
            
        }else{
             let SoundPath = CWFlieManager.getPlaySoundTouchSavePath(withFileName: CWRecorder.shareInstance()?.recordPath.docuPath())
            
            self.GetAPPQiNiuTokenUpVoice(path: SoundPath ?? "")
        }
        
     
        
    }
     //更新上传音频接口
    func updateVoicePersonIntro(voiceUrl :String){
        LoginAPI.shared.APPInfoUpdateVoiceIntroURL(voiceIntro: voiceUrl, success: { (json) in
            let dic = json as? NSDictionary
            let code = dic?.object(forKey: "code") as? Int
            if code == 200 {
                self.close()
                NotificationCenter.default.post(name: DIYVioceNotification, object: nil,userInfo:nil)
            }else{
                 ShowMessageTool.shared.showMessage("音频更新失败")
            }
        }) { (error) in
             ShowMessageTool.shared.showMessage("音频更新失败")
        }
    }
    
    
    // MARK: - 上传音频
    func GetAPPQiNiuTokenUpVoice(path :String){
        let urlStr = BaseUrlPath + RequestGetPublicTokenUrl
        
        HttpTool.getRequest(urlPath: urlStr, parameters: nil, success: { (json) in
            let dic = JSON(json)
            if dic["code"] == 200 {
                if let Token = dic["data"].string {
                    let voicekey =  UUID().uuidString + ".wav"
                    self.uploadManage?.putFile(path, key: voicekey, token: Token, complete: { (info, key, resp) in
                        if info?.statusCode == 200 {
                            
                            let voiceURL = "\(BaseImageURL)\(key ?? "")"
                            ZLog(voiceURL)
                            GlobalDataStore.shared.currentUser.voiceIntro = voiceURL
                            GlobalDataStore.shared.currentUser.saveToLocal()
                            self.updateVoicePersonIntro(voiceUrl: voiceURL)

                        }else{
                            ShowMessageTool.shared.showMessage("声音上传失败")
                        }
                    }, option: self.option)
                    
                }
                
            }else{
                 ShowMessageTool.shared.showMessage("声音上传失败")
            }
        }) { (error) in
             ShowMessageTool.shared.showMessage("声音上传失败")
        }
        
        
    }
    
    //重录
    @objc private func close(){

        self.navigationController?.popViewController(animated: true)
    }
   // 删除音频
    func deleteSoundPath(){
        CWRecorder.shareInstance()?.deleteRecord()
        let path = CWRecorder.shareInstance()?.recordPath
        CWFlieManager.removeFile(path)
        
        CWFlieManager.removeFile(CWFlieManager.soundTouchSavePath(withFileName: path?.docuPath()))
        
      
    }
}
