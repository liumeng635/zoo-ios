//
//  DIYRecordVoiceView.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/5/22.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit
import YYText
class DIYRecordVoiceView: UIView {
    
    public  var ShowRecordVoiceViewBlock : (()->Void)?
    lazy var playBtn:UIButton = {
        let Btn = UIButton.init(type: .custom)
        Btn.setImage(UIImage.init(named: "aio_voiceChange_icon"), for: .normal)
        Btn.addTarget(self, action: #selector(startCountDownTimer), for: .touchDown)
        Btn.addTarget(self, action: #selector(endRecord), for: .touchUpInside)
        
        Btn.addTarget(self, action: #selector(endRecord), for: .touchUpOutside)

        return Btn
    }()
   
    lazy var timeLabel:YYLabel = {
        let Lab = YYLabel.init()
        Lab.isUserInteractionEnabled = true
        Lab.numberOfLines = 0
        Lab.isHidden = true
        return Lab
    }()
    lazy var recordTimeLabel:YYLabel = {
        let Lab = YYLabel.init()
        Lab.isUserInteractionEnabled = true
        
        Lab.numberOfLines = 0
        Lab.isHidden = true
        return Lab
    }()
    lazy var tips:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.pingFangTextFont(size: 12)
        label.textColor =  ColorGrayColor
        return label
    }()
    
    var canRecord  = false
    var timer : Timer?
    var Times = 2
    var recordtimer : Timer?
    var recordTimes = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
        self.tips.text = "长按录制按钮进行录制"
        
    }
    func setupUI() {
        self.backgroundColor = .white
        self.addSubview(playBtn)
        self.addSubview(timeLabel)
        self.addSubview(recordTimeLabel)
        self.addSubview(tips)
        
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.left.right.equalToSuperview()
            
            make.height.equalTo(20)
        }
        recordTimeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.left.right.equalToSuperview()
            
            make.height.equalTo(20)
        }
        playBtn.snp.makeConstraints { (make) in
            make.top.equalTo(60)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(70)
            
        }
        tips.snp.makeConstraints { (make) in
            make.top.equalTo(playBtn.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.height.equalTo(20)
        }
        
    }
    
    func loadTextColor(text : String, length
        :Int) -> NSMutableAttributedString{
        let text = NSMutableAttributedString.init(string:  text)
        text.yy_font = UIFont.pingFangTextFont(size: 14)
        text.yy_color = ColorGrayColor
        text.yy_alignment = .center
        let range = NSRange.init(location:0  , length: length)
        text.yy_setColor(UIColor.colorWithHex(hex: 0xFC9A7D), range: range)
        return text
    }
    @objc private func startCountDownTimer(){
        startTimer()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
}
//MARK:倒计时准备录音事件
extension DIYRecordVoiceView {
    
    
    private func startTimer(){
        timeLabel.isHidden = false
        self.tips.text = "建议使用简短发音：啊、嗯、哼"
        Times = 2
        canRecord = false
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerRun), userInfo: nil, repeats: true)
        }
        timer?.fireDate = Date.distantPast
    }
    @objc private func timerRun(){
        timeLabel.attributedText = loadTextColor(text: "\(Times)S后开始录制", length: 1)
        if Times == 0 {
            Times = 2
            canRecord = true
            timer?.invalidate()
            timer    = nil
            timeLabel.isHidden = true
            recordTimeLabel.isHidden = false
            startRecorde()
            
        }
        
        Times = Times - 1
    }
    
    
}
//MARK:录音时长记录
extension DIYRecordVoiceView {
    
    private func startRecordTimer(){
        recordTimeLabel.isHidden = false
        
        if  recordtimer == nil {
            recordtimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.RecordtimerRun), userInfo: nil, repeats: true)
        }
        recordtimer?.fireDate = Date.distantPast
    }
    @objc private func RecordtimerRun(){
        recordTimeLabel.attributedText = loadTextColor(text: "00:0\(recordTimes)录制中", length: 5)
        if recordTimes == 5 {
            MaxEndRecord()
        }
        recordTimes = recordTimes + 1
        
    }
}
extension DIYRecordVoiceView {
    func showVoiceChangeView(){
       self.ShowRecordVoiceViewBlock?()
        
    }
    func removeRecordtimer(){
        canRecord = false
        recordtimer?.invalidate()
        recordtimer    = nil
        recordTimeLabel.isHidden = true
        recordTimes = 0
    }
    func removeTimer(){
        timer?.invalidate()
        timer    = nil
        timeLabel.isHidden = true
        Times = 2
        self.tips.text = "长按录制按钮进行录制"
    }
    func MaxEndRecord(){
        
        CWRecorder.shareInstance()?.endRecord()
        self.showVoiceChangeView()
        removeRecordtimer()

        
    }
    
    @objc private func startRecorde(){
        startRecordTimer()
        CWRecorder.shareInstance()?.beginRecord(withRecordPath: CWFlieManager.filePath())
    }
    
    @objc private func endRecord(){
        if !canRecord {
            removeTimer()
            return;
        }

        CWRecorder.shareInstance()?.endRecord()
        if recordTimes > 1 {
            removeRecordtimer()
            showVoiceChangeView()
        }else{
            removeRecordtimer()
            CWRecorder.shareInstance()?.deleteRecord()
            let path = CWRecorder.shareInstance()?.recordPath
            CWFlieManager.removeFile(path)
            ShowMessageTool.shared.showMessage("录制时间过短")
        }
        
        
    }
    
}
