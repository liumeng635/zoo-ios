//
//  EditNomalTableViewCell.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/6/11.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class EditNomalTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        self.createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleLab:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.pingFangMediumFont(size: 14)
        label.textColor = ColorGrayTitle
        return label
    }()
    
    lazy var contentLab:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.right
        label.font = UIFont.pingFangTextFont(size: 14)
        label.textColor = ColorGrayColor
        return label
    }()
    lazy var playImamge : UIButton = {
        
        let Btn = UIButton.init(type: .custom)
        Btn.isHidden = true
        Btn.setImage(UIImage.init(named: "ic_bofan"), for: .normal)
        Btn.setImage(UIImage.init(named: "playIng"), for: .selected)
        Btn.addTarget(self, action: #selector(playVoice), for: .touchUpInside)
        return Btn
        
    }()
    
    lazy var arrowImamge:UIImageView = {
        let arrow = UIImageView.init()
        arrow.image = UIImage.init(named: "cellArrow")
        return arrow
    }()
    
    lazy var line:UILabel = {
        let label = UILabel.init()
        label.backgroundColor = ColorLine
        return label
    }()
    
    private func createUI(){
        self.contentView.addSubviews([titleLab,contentLab,playImamge,arrowImamge,line])
        titleLab.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(ScreenW/5)
        }
        arrowImamge.snp.makeConstraints { (make) in
            
            make.right.equalTo(-15)
            make.centerY.equalToSuperview()
            make.width.equalTo(6)
            make.height.equalTo(8)
        }
        contentLab.snp.makeConstraints { (make) in
            make.left.equalTo(titleLab.snp_right)
            make.top.bottom.equalToSuperview()
            make.right.equalTo(arrowImamge.snp.left).offset(-5)
        }
        playImamge.snp.makeConstraints { (make) in
            make.width.height.equalTo(50)
            make.centerY.equalToSuperview()
            make.right.equalTo(arrowImamge.snp.left).offset(-5)
        }
        
        
        line.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-1)
            make.width.equalTo(ScreenW)
            make.height.equalTo(1)
        }
    }
    
    
    
    public var model:userModel?
    var playerItem:AVPlayerItem!
    var audioPlayer:AVPlayer!
    
    @objc private func playVoice(){
        guard let url = self.model?.voiceIntro else {
            return
        }
        
        self.playImamge.isSelected = !self.playImamge.isSelected
        self.playAudioUrl(audioUrl: url)
        if !self.playImamge.isSelected {
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
        self.playImamge.isSelected = false
    }
    
    
    
}
extension EditNomalTableViewCell{
    func SchoolData(model :userModel ,row:Int,personTitle: String){
        self.titleLab.text = personTitle
        line.isHidden = false
        if row == 0 {
            if model.schoolName?.isEmpty == true{
                contentLab.text = ""
            }else{
                contentLab.text = model.schoolName
            }
        }else{
            if model.departmentName?.isEmpty == true {
                contentLab.text = ""
            }else{
                contentLab.text = model.departmentName
            }
        }
    }
    
    
    
    //编辑资料的数据
    func loadDataPersonCell(model:userModel,section:Int,row:Int,personTitle: String ,addTips:String){
        self.titleLab.text = personTitle
        switch section {
        case 0:
            
            if row == 0 {
                line.isHidden = false
                if model.nickname?.isEmpty ?? true {
                    contentLab.text = addTips
                }else{
                    contentLab.text = model.nickname
                }
                
            }else if row == 1 {
                line.isHidden = false
                if model.voiceIntro == nil{
                    contentLab.text = addTips
                    playImamge.isHidden = true
                    
                }else{
                    contentLab.text = ""
                    playImamge.isHidden = false
                }
                
            }else if row == 2 {
                
                if model.birthday == nil{
                    contentLab.text = addTips
                    
                }else{
                    contentLab.text = model.birthday
                }
                line.isHidden = true
            }
            
            
            break
        case 1:
            if row == 0 {
                line.isHidden = false
                if model.constellation?.isEmpty == true {
                    contentLab.text = addTips
                }else{
                    contentLab.text = Constellation.calculateWithDate(dateStr: model.birthday ?? "")
                }
                
            }else if row == 1 {
                line.isHidden = false
                contentLab.text = Date.getAgeDateFormatterWithString(model.birthday ?? "")
                
            }else if row == 2 {
                
                contentLab.text = model.sex == 1 ? "男" : "女"
                line.isHidden = true
            }
            
            break
        case 2:
            if row == 0 {
                line.isHidden = false
                if model.area?.isEmpty == true{
                    contentLab.text = addTips
                }else{
                    contentLab.text = model.area
                }
                
            }else if row == 1 {
                line.isHidden = false
                if model.schoolName?.isEmpty == true{
                    contentLab.text = addTips
                }else{
                    contentLab.text = model.schoolName
                }
            }else if row == 2 {
                
                if model.profession?.isEmpty == true{
                    contentLab.text = addTips
                    
                }else{
                    contentLab.text = model.profession
                }
                line.isHidden = true
            }
            
            
            break
        default:
            break
        }
    }
}



class UserEditHeadView: UIView {
    lazy var backgroundimgaeView: UIImageView = {
        let imgaeView=UIImageView.init()
        imgaeView.contentMode = .scaleAspectFill
        imgaeView.image=UIImage(named: "circle")
        return imgaeView
    }()
    lazy var bgView: UIView = {
        let bgView = UIView.init()
        bgView.backgroundColor = ColorTheme
        return bgView
    }()
  
    lazy var userImageView: UIImageView = {
        let imgaeView=UIImageView.init()
        imgaeView.image=UIImage(named: "PersionalIocn")
        imgaeView.layer.cornerRadius  = 50
        imgaeView.layer.masksToBounds = true
        imgaeView.contentMode = .scaleAspectFit
        imgaeView.isUserInteractionEnabled = true
        imgaeView.layer.borderColor = ColorWhite.cgColor
        imgaeView.layer.borderWidth = 2
        imgaeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeUserIcon)))
        return imgaeView
    }()
    
    
    lazy var CameraImageView: UIImageView = {
        let imgaeView = UIImageView.init()
        imgaeView.image = UIImage(named: "PersonalPhoto")
        imgaeView.isUserInteractionEnabled = true
        imgaeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeUserIcon)))
        return imgaeView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func loadHeadData(model: userModel){
        if model.avatar?.isEmpty == false {
           userImageView.kf.setImage(urlString: model.avatar)
        }
        
        userImageView.kf.setImage(urlString: model.avatar)
        if model.backImage?.isEmpty ?? true {
            self.bgView.addBackViewGradientLayer()
        }else{
            self.bgView.gradientStringDIYColor(colorsString :model.backImage ?? "")
        }
        
    }
    fileprivate func setupUI(){
        
        self.addSubviews([bgView,backgroundimgaeView,userImageView,CameraImageView])
       
        bgView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        backgroundimgaeView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        userImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(100)
            make.center.equalToSuperview()
        }
        
        CameraImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(50)
            make.bottom.equalTo(userImageView.snp_bottom).offset(10)
            make.right.equalTo(userImageView.snp_right).offset(10)
        }
        
    }
    
    public var changeUserIconBlock : (()->Void)?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension UserEditHeadView{
    @objc private func changeUserIcon(){
        self.changeUserIconBlock?()
    }
    
}

