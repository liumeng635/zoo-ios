//
//  ChatRoomBaseTableViewCell.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/6/24.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit
import YYText
import Kingfisher
let CHAT_RADIUS:CGFloat = 10
class ChatRoomBaseTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        self.initSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     var backgroundLayer = CAShapeLayer.init()
    
    //背景
    lazy var backView:UIView = {
        let view = UIView.init()
        view.backgroundColor = ColorChatBack
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    //头像
    lazy var avatar:UIImageView = {
        let avatar = UIImageView.init()
        avatar.layer.cornerRadius = 17.5
        avatar.layer.masksToBounds = true
        avatar.contentMode = .center
        avatar.contentMode = .scaleToFill
        avatar.isUserInteractionEnabled = true
        avatar.image = UIImage.init(named: "avaterplaceholder")
//        avatar.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(gotoSelf)))
        
        return avatar
    }()
    //正文
    lazy var contentLab:YYLabel = {
        let Lab = YYLabel.init()
        Lab.textVerticalAlignment = YYTextVerticalAlignment.top
        Lab.numberOfLines = 0
        let mod = YYTextLinePositionSimpleModifier.init()
        mod.fixedLineHeight = 25
        Lab.linePositionModifier = mod
        return Lab
    }()
    //图片
    lazy var photo:PhotoView = {
        let photo = PhotoView.init()
        return photo
    }()
    public var model : ChatBaseModel? {
        
        didSet{
            guard let model = model else {
                return
            }
            
            
            loadContent()
            photo.model = model.chatModel
           
            createUI()
        }
    }
    //MARK:- Method
    private func initSubViews(){
        self.backgroundColor = ColorBackGround
//        backgroundLayer = CAShapeLayer.init()
//        backgroundLayer.zPosition = -1
//        backView.layer.addSublayer(backgroundLayer)

        self.addSubviews([avatar,backView])
        backView.addSubviews([contentLab,photo])
        
    }
    func createUI(){
        guard let model = model else {
            return
        }
        let backH = model.cellNomalHeight - 20
        let ChatBackW = ChatBackWidth + 30
        if model.chatModel.isMaster == 1 {
            avatar.frame = CGRect.init(x: ScreenW - 15 - 35, y: 10, width: 35, height: 35)
            backView.frame = CGRect.init(x: 25, y: 10, width: ChatBackW, height: backH)
            avatar.kf.setImage(urlString: GlobalDataStore.shared.currentUser.petAvatar)
            
            let colors = GlobalDataStore.shared.currentUser.backImage.components(separatedBy: ",")
            avatar.backgroundColor = UIColor.init(hexString: colors.first ?? "#6760D4")
            
        } else {
            avatar.frame = CGRect.init(x: 15, y: 10, width: 35, height: 35)
            backView.frame = CGRect.init(x: 60, y: 10, width: ChatBackW, height: backH)
            let petUrl = "\(model.chatModel.petImage ?? "")\(BottomQiuniuUrl)"
            avatar.kf.setImage(urlString: petUrl)
            
            let colors = model.chatModel.headModel.backImage?.components(separatedBy: ",")
            avatar.backgroundColor = UIColor.init(hexString: colors?.first ?? "#6760D4")
        }
        
        if self.model?.chatModel.content.isEmpty ?? true {
            contentLab.isHidden = true
            contentLab.frame = CGRect.init(x: 15, y: 0, width:ChatBackWidth, height: self.model?.cellTextHeight ?? 0)
            photo.frame = CGRect.init(x: 15, y: 15, width:ChatBackWidth, height: self.model?.cellPhotoHeight ?? 0)
        }else{
            contentLab.isHidden = false
            contentLab.frame = CGRect.init(x: 15, y: 15, width:ChatBackWidth, height: self.model?.cellTextHeight ?? 0)
            photo.frame = CGRect.init(x: 15, y: contentLab.bottom + 10, width:ChatBackWidth, height: self.model?.cellPhotoHeight ?? 0)
        }
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        CATransaction.begin()
//        CATransaction.setDisableActions(true)
//
//        let backH = self.model?.cellNomalHeight ?? 0 - 20
//        let ChatBackW = ChatBackWidth + 30
//        backgroundLayer.path = UIBezierPath.init().createBezierPath(cornerRadius: CHAT_RADIUS, width: ChatBackW , height: backH).cgPath
//        backgroundLayer.frame = CGRect.init(origin: .zero, size: CGSize.init(width: ChatBackW - CHAT_RADIUS*2, height: backH - CHAT_RADIUS*2))
//        backgroundLayer.transform = CATransform3DIdentity
//
//        if self.model?.chatModel.isMaster == 1 {
//            avatar.frame = CGRect.init(x: ScreenW - 15 - 35, y: 10, width: 35, height: 35)
//            backView.frame = CGRect.init(x: 25, y: 10, width: ChatBackW, height: backH )
//            backgroundLayer.transform = CATransform3DMakeRotation(.pi, 0.0, 1.0, 0.0)
//            backgroundLayer.fillColor = ColorChatBack.cgColor
//        } else {
//            avatar.frame = CGRect.init(x: 15, y: 10, width: 35, height: 35)
//            backView.frame = CGRect.init(x: 60, y: 10, width: ChatBackW, height: backH )
//            backgroundLayer.fillColor = ColorChatBack.cgColor
//        }
//        CATransaction.commit()
//
//        if self.model?.chatModel.content.isEmpty ?? true {
//            contentLab.isHidden = true
//            contentLab.frame = CGRect.init(x: 15, y: 0, width:ChatBackWidth, height: self.model?.cellTextHeight ?? 0)
//            photo.frame = CGRect.init(x: 15, y: 15, width:ChatBackWidth, height: self.model?.cellPhotoHeight ?? 0)
//        }else{
//            contentLab.isHidden = false
//            contentLab.frame = CGRect.init(x: 15, y: 15, width:ChatBackWidth, height: self.model?.cellTextHeight ?? 0)
//             photo.frame = CGRect.init(x: 15, y: contentLab.bottom + 10, width:ChatBackWidth, height: self.model?.cellPhotoHeight ?? 0)
//        }
//
//    }
    
    func loadContent(){
        let str = NSAttributedString.init(string: model?.chatModel.content ?? "")
        let attributedString = NSMutableAttributedString.init(attributedString: str)
        
        attributedString.yy_font = UIFont.pingFangTextFont(size: 14)
        attributedString.yy_color = ColorGrayTitle
         contentLab.attributedText =  attributedString
    }
    
}
