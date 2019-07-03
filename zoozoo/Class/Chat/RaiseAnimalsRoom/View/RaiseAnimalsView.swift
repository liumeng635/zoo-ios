//
//  RaiseAnimalsView.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/6/24.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class RaiseAnimalsView: UIView {

   

}
class RaiseTagInfoView: UIView {
    lazy var titleLab:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.pingFangTextFont(size: 14)
        label.textColor = ColorWhite
        return label
    }()
    lazy var cityLab:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.pingFangTextFont(size: 12)
        label.textColor = ColorWhite
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var model: RaiseAnimalsModel? {
        didSet {
            guard let model = model else { return }
            
            titleLab.text = model.nickname
            cityLab.text = model.area
            if model.sex == 1{
                sex.image = UIImage.init(named: "man")
            }else{
                sex.image = UIImage.init(named: "woman")
            }
            age.text = "\(model.age)岁"
            constellation.image = UIImage.init(named: model.constellation ?? "金牛座")
            
        }
    }
    func configUI() {
        self.addSubviews([titleLab,cityLab,sex,age,constellation])
        titleLab.snp.makeConstraints() { (make) in
            make.left.equalTo(15)
            make.top.equalTo(5)
            make.width.equalTo(60)
            make.height.equalTo(15)
        }
        cityLab.snp.makeConstraints() { (make) in
            make.left.equalTo(titleLab.snp.right).offset(5)
            make.top.equalTo(5)
            make.width.equalTo(30)
            make.height.equalTo(15)
        }
        sex.snp.makeConstraints() { (make) in
            make.left.equalTo(15)
            make.top.equalTo(titleLab.snp.bottom).offset(10)
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
    }
    
    
}

class RaiseAnimalsListCell: UICollectionViewCell {
    lazy var MSGImageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.image = UIImage.init(named: "airbubbles")
        imageView.isHidden = true
        imageView.isUserInteractionEnabled = true
       
        imageView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(gotoPlayVoice)))
        return imageView
    }()
    lazy var voiceImageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.image = UIImage.init(named: "RaiseVoice")
        return imageView
    }()
    lazy var msgLab:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.pingFangTextFont(size: 14)
        label.textColor =  ColorTitle
        return label
    }()
    lazy var voiceLab:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.pingFangTextFont(size: 14)
        label.textColor =  ColorTitle
        label.text = "语音"
        return label
    }()
    lazy var AnimalImageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage.init(named: "Raisebears")
        return imageView
    }()
    lazy var nameLab:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.right
        label.font = UIFont.pingFangTextFont(size: 14)
        label.textColor =  ColorWhite
        return label
    }()
    lazy var sex: UIImageView = {
        let imageView = UIImageView.init()
        imageView.image = UIImage.init(named: "man")
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        contentView.addSubview(AnimalImageView)
        contentView.addSubview(sex)
        contentView.addSubview(nameLab)
        contentView.addSubview(MSGImageView)
        MSGImageView.addSubviews([voiceImageView,voiceLab,msgLab])
        
        AnimalImageView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(-40)
            make.top.equalTo(50)
        }
        sex.snp.makeConstraints { (make) in
            make.right.equalTo(-30)
            make.bottom.equalTo(-15)
            make.width.height.equalTo(10)
        }
        
        nameLab.snp.makeConstraints { (make) in
            make.right.equalTo(sex.snp.left).offset(-5)
            make.bottom.equalTo(-10)
            make.height.equalTo(20)
            make.width.equalTo(60)
        }
        
        MSGImageView.snp.makeConstraints { (make) in
            make.centerX.top.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(80)
        }
        msgLab.snp.makeConstraints { (make) in
            make.centerX.top.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(60)
        }
        voiceImageView.snp.makeConstraints { (make) in
            make.top.left.equalTo(15)
            make.height.width.equalTo(15)
            
        }
        voiceLab.snp.makeConstraints { (make) in
            make.left.equalTo(voiceImageView.snp.right).offset(5)
            make.top.equalTo(15)
            make.height.equalTo(15)
            make.width.equalTo(60)
        }
    }
    
    var model: RaiseAnimalsModel? {
        didSet {
            guard let model = model else { return }
           
            if model.isExists == 1{
                AnimalImageView.kf.setImage(urlString: model.petImage)
                nameLab.text = model.petNickName
                if model.sex == 1{
                    sex.image = UIImage.init(named: "man")
                }else{
                    sex.image = UIImage.init(named: "woman")
                }
                
                if model.newMsgCnt == 1 {
                    MSGImageView.isHidden = true
                }else{
                    MSGImageView.isHidden = false
                    if model.latestMsg != nil {
                         MSGImageView.isUserInteractionEnabled = false
                        voiceLab.isHidden = true
                        voiceImageView.isHidden = true
                        msgLab.isHidden = false
                        msgLab.text = model.latestMsg
                    }
                    if model.latestVoiceMsg != nil {
                        MSGImageView.isUserInteractionEnabled = true
                        voiceLab.isHidden = false
                        voiceImageView.isHidden = false
                        msgLab.isHidden = true
                        
                    }
                }
                sex.isHidden = false
                sex.snp.remakeConstraints() { (make) in
                    make.right.equalTo(-30)
                    make.bottom.equalTo(-15)
                    make.width.height.equalTo(10)
                }
                nameLab.textAlignment = NSTextAlignment.right
                nameLab.snp.remakeConstraints() { (make) in
                    make.right.equalTo(sex.snp.left).offset(-5)
                    make.bottom.equalTo(-10)
                    make.height.equalTo(20)
                    make.width.equalTo(60)
                }
                
            }else{
                MSGImageView.isHidden = true
                sex.isHidden = true
                nameLab.text = model.animalName
                nameLab.textAlignment = NSTextAlignment.center
                nameLab.snp.remakeConstraints() { (make) in
                  
                    make.bottom.equalTo(-10)
                    make.height.equalTo(20)
                    make.left.right.equalToSuperview()
                }
            }
            
        }
        
    }
}
extension RaiseAnimalsListCell{
    
    @objc private func gotoPlayVoice(){
        guard let voiceUrl = self.model?.latestVoiceMsg else { return }
        VoiceAudioUrlPlayer.shared.playAudioUrl(audioUrl: voiceUrl)
    }
}
