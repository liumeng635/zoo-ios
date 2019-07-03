//
//  MessageListViewCell.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/6/16.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class MessageListViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        self.createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var UserImage:UIImageView = {
        let imageV = UIImageView.init()
        imageV.layer.cornerRadius = 25
        imageV.layer.masksToBounds = true
        return imageV
    }()
    
    lazy var titleLab:UILabel = {
        let Lab = UILabel.init()
        Lab.textAlignment = NSTextAlignment.left
        Lab.textColor = ColorTitle
        Lab.font = UIFont.boldSystemFont(ofSize: 14)
      
        return Lab
    }()
    
    
    lazy var sex:UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "man")
        return imageV
    }()
    lazy var loveBack : UIButton = {
        
        let Btn = UIButton.init(type: .custom)
        
        Btn.layer.masksToBounds = true
        Btn.layer.cornerRadius  = 3
        Btn.titleLabel?.font = UIFont.pingFangMediumFont(size: 10)
        Btn.backgroundColor = UIColor.colorWithHex(hex: 0xEA593A)
        Btn.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 5)
        Btn.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 0)
        Btn.setTitleColor(ColorWhite, for: .normal)
        Btn.setImage(UIImage.init(named: "charm"), for: .normal)
        return Btn
        
    }()
    
    lazy var MailListimage:UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "FriendMail")
        return imageV
    }()
    
    lazy var messgaeNumLab:UILabel = {
        let Lab = UILabel.init()
        Lab.textAlignment = NSTextAlignment.center
        Lab.backgroundColor = ColorCancleColor
        Lab.textColor = ColorWhite
        Lab.font = UIFont.pingFangMediumFont(size: 12)
        Lab.layer.masksToBounds = true
        Lab.layer.cornerRadius = 8
        Lab.font = UIFont.systemFont(ofSize: 10)
        Lab.isHidden = true
        return Lab
    }()
    
    lazy var contentLab:UILabel = {
        let Lab = UILabel.init()
        Lab.textAlignment = NSTextAlignment.left
       
        Lab.textColor = ColorGrayColor
        Lab.font = UIFont.pingFangTextFont(size: 12)
        return Lab
    }()
    
    lazy var timeLab:UILabel = {
        let Lab = UILabel.init()
        Lab.textAlignment = NSTextAlignment.right
       
        Lab.textColor = ColorGrayColor
        Lab.font = UIFont.pingFangTextFont(size: 10)
        return Lab
    }()
    
    
    lazy var line:UIView = {
        let line = UIView.init()
        line.backgroundColor = ColorLine
        return line
    }()
    
    private func createUI(){
        self.contentView.addSubviews([UserImage,titleLab,MailListimage,sex,loveBack,messgaeNumLab,contentLab,timeLab,line])
       
        
        UserImage.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(50)
            make.left.equalTo(15)
        }
        titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.height.equalTo(20)
            make.left.equalTo(UserImage.snp.right).offset(10)
        }
        sex.snp.makeConstraints() { (make) in
            make.left.equalTo(titleLab.snp.right).offset(5)
            make.top.equalTo(titleLab.snp.top)
            make.width.equalTo(15)
            make.height.equalTo(15)
        }
        
        
        loveBack.snp.makeConstraints() { (make) in
            make.left.equalTo(sex.snp.right).offset(5)
            make.top.equalTo(sex.snp_top)
            make.width.equalTo(40)
            make.height.equalTo(15)
        }
        MailListimage.snp.makeConstraints() { (make) in
            make.left.equalTo(loveBack.snp.right).offset(5)
            make.top.equalTo(sex.snp_top)
           
            make.height.width.equalTo(15)
        }
       
        messgaeNumLab.snp.makeConstraints { (make) in
            make.top.equalTo(5)
            make.width.height.equalTo(16)
            make.left.equalTo(52)
            
        }
        
        contentLab.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom).offset(10)
            make.height.equalTo(20)
            make.right.equalTo(-15)
            make.left.equalTo(UserImage.snp.right).offset(10)
        }
        
        timeLab.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.top.equalTo(10)
            make.height.equalTo(20)
        }
        line.snp.makeConstraints { (make) in
            make.left.equalTo(65)
            make.bottom.right.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
    
    public var Model : FriendsOwnerModel? {
        didSet{
            guard let model = Model else {
                return
            }
            UserImage.kf.setImage(urlString: model.avatar)
            titleLab.text = model.nickname
           
            sex.image = model.sex == 1 ? UIImage.init(named: "man") : UIImage.init(named: "women")
            
            loveBack.setTitle("\(model.closeDeg ?? 0)", for: .normal)
            
            MailListimage.isHidden = model.relationType == 0
            
            contentLab.text = model.latestMsg
            
            timeLab.text = model.beFriendTime
            if model.msgCnt == 0 {
                messgaeNumLab.isHidden = true
            }else{
                messgaeNumLab.isHidden = false
                messgaeNumLab.text = "\(model.msgCnt ?? 1)"
            }
        }
    }

    
}


class FriendGuardHeadView: UIView {
    
    lazy var UserImage:UIImageView = {
        let imageV = UIImageView.init()
        imageV.layer.cornerRadius = 25
        imageV.layer.masksToBounds = true
        return imageV
    }()
    
    lazy var titleLab:UILabel = {
        let Lab = UILabel.init()
        Lab.textAlignment = NSTextAlignment.left
        Lab.textColor = ColorTitle
        Lab.font = UIFont.boldSystemFont(ofSize: 14)
        
        return Lab
    }()
    
    
    lazy var sex:UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "man")
        return imageV
    }()
    lazy var loveBack : UIButton = {
        
        let Btn = UIButton.init(type: .custom)
        
        Btn.layer.masksToBounds = true
        Btn.layer.cornerRadius  = 3
        Btn.titleLabel?.font = UIFont.pingFangMediumFont(size: 10)
        Btn.backgroundColor = UIColor.colorWithHex(hex: 0xEA593A)
        Btn.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 5)
        Btn.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 0)
        Btn.setTitleColor(ColorWhite, for: .normal)
        Btn.setImage(UIImage.init(named: "charm"), for: .normal)
        return Btn
        
    }()
    
    lazy var MailListimage:UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "FriendMail")
        return imageV
    }()
    
    lazy var messgaeNumLab:UILabel = {
        let Lab = UILabel.init()
        Lab.textAlignment = NSTextAlignment.center
        Lab.backgroundColor = ColorCancleColor
        Lab.textColor = ColorWhite
        Lab.font = UIFont.pingFangTextFont(size: 8)
        Lab.layer.masksToBounds = true
        Lab.layer.cornerRadius = 8
        Lab.font = UIFont.systemFont(ofSize: 10)
        Lab.isHidden = true
        return Lab
    }()
    
    lazy var contentLab:UILabel = {
        let Lab = UILabel.init()
        Lab.textAlignment = NSTextAlignment.left
        
        Lab.textColor = ColorGrayColor
        Lab.font = UIFont.pingFangTextFont(size: 12)
        return Lab
    }()
    
    lazy var timeLab:UILabel = {
        let Lab = UILabel.init()
        Lab.textAlignment = NSTextAlignment.right
        
        Lab.textColor = ColorGrayColor
        Lab.font = UIFont.pingFangTextFont(size: 10)
        return Lab
    }()
    lazy var Topline:UIView = {
        let line = UIView.init()
        line.backgroundColor = ColorLine
        return line
    }()
    
    lazy var line:UIView = {
        let line = UIView.init()
        line.backgroundColor = ColorLine
        return line
    }()
    
    private func createUI(){
       self.backgroundColor = .white
        self.addSubviews([Topline,UserImage,titleLab,MailListimage,sex,loveBack,messgaeNumLab,contentLab,timeLab,line])
        
        Topline.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(10)
        }
        UserImage.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(50)
            make.left.equalTo(15)
        }
        titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.height.equalTo(20)
            make.left.equalTo(UserImage.snp.right).offset(10)
        }
        sex.snp.makeConstraints() { (make) in
            make.left.equalTo(titleLab.snp.right).offset(5)
            make.top.equalTo(titleLab.snp.top)
            make.width.equalTo(15)
            make.height.equalTo(15)
        }
        
        
        loveBack.snp.makeConstraints() { (make) in
            make.left.equalTo(sex.snp.right).offset(5)
            make.top.equalTo(sex.snp_top)
            make.width.equalTo(40)
            make.height.equalTo(15)
        }
        MailListimage.snp.makeConstraints() { (make) in
            make.left.equalTo(loveBack.snp.right).offset(5)
            make.top.equalTo(sex.snp_top)
            
            make.height.width.equalTo(15)
        }
        
        messgaeNumLab.snp.makeConstraints { (make) in
            make.top.equalTo(15)
            make.width.height.equalTo(16)
            make.left.equalTo(52)
            
        }
        
        contentLab.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom).offset(10)
            make.height.equalTo(20)
            make.right.equalTo(-15)
            make.left.equalTo(UserImage.snp.right).offset(10)
        }
        
        timeLab.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.top.equalTo(20)
            make.height.equalTo(20)
        }
        line.snp.makeConstraints { (make) in
            
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(10)
        }
        
    }
    
    public var Model : FriendsOwnerModel? {
        didSet{
            guard let model = Model else {
                return
            }
            sex.isHidden = false
            loveBack.isHidden = false
            MailListimage.isHidden = false
            timeLab.isHidden = false
            
            
            UserImage.kf.setImage(urlString: model.avatar)
            titleLab.text = model.nickname
            
            sex.image = model.sex == 1 ? UIImage.init(named: "man") : UIImage.init(named: "women")
            
            loveBack.setTitle("\(model.closeDeg ?? 0)", for: .normal)
            
            MailListimage.isHidden = model.relationType == 0
            
            contentLab.text = model.latestMsg
            
            timeLab.text = model.beFriendTime
            
            if model.msgCnt == 0 {
                messgaeNumLab.isHidden = true
            }else{
                messgaeNumLab.isHidden = false
                messgaeNumLab.text = "\(model.msgCnt ?? 1)"
            }
            
            
        }
    }
    
    func noGuardHeadData(){
        UserImage.image = UIImage.init(named: "avatarPlacehold")
        titleLab.text = "暂无人守护你"
        contentLab.text = "完善个人主页有助于更快找到守护者"
        sex.isHidden = true
        loveBack.isHidden = true
        MailListimage.isHidden = true
        timeLab.isHidden = true
        
        
    }
    
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
        noGuardHeadData()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
}






