//
//  ChatRoomSystemTableViewCell.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/7/2.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class ChatRoomSystemTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        self.initSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    lazy var TitleLab:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.pingFangTextFont(size: 11)
        label.textColor = ColorSystemGray
        label.numberOfLines = 0
        label.frame = CGRect.init(x: 15, y: 0, width: ScreenW - 30 , height: 60)
        return label
    }()
    
    public var model : ChatRoomModel? {
        
        didSet{
            guard let model = model else {
                return
            }
            if !model.content.isEmpty {
                let systymeStr = model.content.components(separatedBy: "|")
                if systymeStr.count == 2 {
                    TitleLab.text = "\(systymeStr.first ?? "")\n\(systymeStr.last ?? "")"
                }
            }
        }
    }
    
    //MARK:- Method
    private func initSubViews(){
        self.backgroundColor = ColorBackGround
       
        self.addSubview(TitleLab)
        
        
    }
}

class ChatRoomFriendTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        self.initSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    lazy var TitleLab:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.pingFangTextFont(size: 12)
        label.textColor = ColorGrayTitle
        label.numberOfLines = 0
        label.backgroundColor = .white
        label.frame = CGRect.init(x: ScreenW/2 - 80, y: 7.5, width: 160 , height: 30)
        return label
    }()
    lazy var avatar:UIImageView = {
        let avatar = UIImageView.init()
        avatar.layer.cornerRadius = 17.5
        avatar.contentMode = .center
        avatar.contentMode = .scaleToFill
        avatar.layer.masksToBounds = true
        avatar.isUserInteractionEnabled = true
        avatar.image = UIImage.init(named: "avaterplaceholder")
        avatar.layer.borderColor = ColorWhite.cgColor
        avatar.layer.borderWidth = 2.5
        avatar.frame = CGRect.init(x: TitleLab.left - 17.5, y: 5, width: 35 , height: 35)
        //        avatar.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(gotoSelf)))
        
        return avatar
    }()
    lazy var mineAvatar:UIImageView = {
        let avatar = UIImageView.init()
        avatar.layer.cornerRadius = 19
        avatar.layer.masksToBounds = true
        avatar.contentMode = .center
        avatar.contentMode = .scaleToFill
        avatar.isUserInteractionEnabled = true
        avatar.image = UIImage.init(named: "avaterplaceholder")
        //        avatar.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(gotoSelf)))
        avatar.layer.borderColor = ColorWhite.cgColor
        avatar.layer.borderWidth = 3
        avatar.frame = CGRect.init(x: TitleLab.right - 17.5, y: 5, width: 38 , height: 38)
        return avatar
    }()
    
    
    public var model : ChatRoomModel? {
        
        didSet{
            guard let model = model else {
                return
            }
          
            TitleLab.text = model.content
            let minePetUrl = "\(model.headModel.myPetImage ?? "")\(BottomQiuniuUrl)"
            mineAvatar.kf.setImage(urlString: minePetUrl)
            let colors = model.headModel.myBackImage?.components(separatedBy: ",")
            mineAvatar.backgroundColor = UIColor.init(hexString: colors?.first ?? "#6760D4")
            
            let petUrl = "\(model.headModel.petImage ?? "")\(BottomQiuniuUrl)"
            avatar.kf.setImage(urlString: petUrl)
            let avatarcolors = model.headModel.backImage?.components(separatedBy: ",")
            avatar.backgroundColor = UIColor.init(hexString: avatarcolors?.first ?? "#6760D4")
            
        }
    }
    
    //MARK:- Method
    private func initSubViews(){
        self.backgroundColor = ColorBackGround
        
        self.addSubview(TitleLab)
        self.addSubview(avatar)
        self.addSubview(mineAvatar)
    }
}

class ChatRoomEmojiTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        self.initSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var avatar:UIImageView = {
        let avatar = UIImageView.init()
        avatar.layer.cornerRadius = 17.5
        avatar.layer.masksToBounds = true
        avatar.contentMode = .center
        avatar.contentMode = .scaleToFill
        avatar.isUserInteractionEnabled = true
        avatar.image = UIImage.init(named: "avaterplaceholder")
        avatar.frame = CGRect.init(x: 15, y: 45/2, width: 35 , height: 35)
        //        avatar.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(gotoSelf)))
        
        return avatar
    }()
    lazy var ImageV:UIImageView = {
        let imageV = UIImageView.init()
        imageV.contentMode = .scaleAspectFill
        imageV.clipsToBounds = true
        imageV.frame = CGRect.init(x: avatar.right + 15, y: 0, width: 80 , height: 80)
        return imageV
    }()
    
    
    public var model : ChatRoomModel? {
        
        didSet{
            guard let model = model else {
                return
            }
           
            let petUrl = "\(model.petImage ?? "")\(BottomQiuniuUrl)"
            avatar.kf.setImage(urlString: petUrl)
            ImageV.kf.setImage(urlString: model.imgUrls.first?.thumbUrl)
        }
    }
    
    //MARK:- Method
    private func initSubViews(){
        self.backgroundColor = ColorBackGround
        
        self.addSubview(avatar)
        self.addSubview(ImageV)
    }
}
