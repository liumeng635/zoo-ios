//
//  MineHeadView.swift
//  zoozoo
//
//  Created by 苹果上的豌豆 on 2019/5/20.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

let HeadWhiteH : CGFloat = 65 + 85 + 15
let HeadBodyImgaeH : CGFloat = ScreenW/2 * 1.1
let HeadMineH = HeadBodyImgaeH + navigationBarHeight + HeadWhiteH + 10
class MineHeadView: UIView {
    
    var bgImgFrame: CGRect = CGRect(x: 0, y: 0, width: ScreenW, height: HeadBodyImgaeH + navigationBarHeight + 50)

    lazy var bgView: UIView = {
        let bgView = UIView.init(frame: bgImgFrame)
        bgView.backgroundColor = ColorTheme
        return bgView
    }()
    lazy var bgImage: UIImageView = {
        let bgImage = UIImageView.init(frame: bgImgFrame)
        return bgImage
    }()
    
    lazy var backgroundimgaeView: UIImageView = {
        let imgaeView=UIImageView.init()
        imgaeView.contentMode = .scaleAspectFill
        imgaeView.image=UIImage(named: "circle")
        return imgaeView
    }()

    lazy var bodyimgaeView: UIImageView = {
        let bodyimgaeView=UIImageView.init()
        bodyimgaeView.contentMode = .scaleAspectFill
        bodyimgaeView.isUserInteractionEnabled = true
        bodyimgaeView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(gotoSelf)))
        return bodyimgaeView
    }()
   
    lazy var nickNameLabel : CircleTextView = {
        
        let nickNameLabel = CircleTextView.init()
        nickNameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nickNameLabel.textColor = ColorWhite
        return nickNameLabel
        
    }()
    lazy var editBtn : UIButton = {
        
        let Btn = UIButton.init(type: .custom)
        
        Btn.layer.masksToBounds = true
        Btn.layer.cornerRadius  = 20
        Btn.titleLabel?.font = UIFont.pingFangMediumFont(size: 14)
        Btn.backgroundColor = UIColor.colorWithRGBA(r:23.0, g: 27.0, b: 30.0, alpha: 0.3)
        Btn.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 10)
        Btn.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 0)
        Btn.setTitle("编辑形象", for: .normal)
        Btn.setTitleColor(ColorWhite, for: .normal)
        Btn.setImage(UIImage.init(named: "mineEdite"), for: .normal)
        Btn.addTarget(self, action: #selector(gotoEdit), for: .touchUpInside)
        
        return Btn
        
    }()
    lazy var whiteView: UIView = {
        let View = UIView.init()
        View.backgroundColor = .white
        View.layer.cornerRadius  = 10
        View.layer.masksToBounds = true
        return View
    }()
    lazy var clickFriendButton : UIButton = {
        
        let button = UIButton.init(type: .custom)
        button.addTarget(self, action: #selector(ClickFriendAction), for: .touchUpInside)
        return button
    }()
    
    lazy var titleLab:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.pingFangMediumFont(size: 14)
        label.textColor = ColorTitle
        label.text = "我的好友"
        return label
    }()
    lazy var arrowiamge:UIImageView = {
        let arrow = UIImageView.init()
        arrow.image = UIImage.init(named: "cellArrow")
        return arrow
    }()
    
    lazy var line:UILabel = {
        let label = UILabel.init()
        label.backgroundColor = ColorLine
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    public var Model: MineHomeDetailModel?{
        didSet {
            guard let model = Model else {
                return
            }
            
            self.configBgView(model: model)
            
            self.bodyimgaeView.kf.setImage(urlString: model.petImage)
            
            self.nickNameLabel.text = model.nickname ?? ""
            
            self.configFriendUI(model: model)
        }
    }
    
    //加载背景颜色和圆角
    func configBgView(model :MineHomeDetailModel){

        if model.backImage?.isEmpty == true{
            self.bgView.addBackViewGradientLayer()
        }else{
            self.bgView.gradientStringDIYColor(colorsString :model.backImage ?? "")
        }
       
        let newImage = self.bgView.convertToImage()
        
        self.bgImage.image = newImage
    }
    
    //加载好友UI
    func configFriendUI(model :MineHomeDetailModel){
        let friendArr = model.friends
        if friendArr.count == 0 {
            self.whiteView.isHidden = true
        }else{
            self.whiteView.isHidden = false
            
            let Margin = (ScreenW - 60 - 240)/3
            
            for i in 0 ..< friendArr.count {
                let friendView = FriendsBaseView.init(frame: CGRect.init(x: 15 + ((60 + Margin) * CGFloat.init(i)), y: 65, width: 60, height: 85))
                friendView.loadData(model: friendArr[i])
                self.whiteView.addSubview(friendView)
                
            }
        }
    }
    
    fileprivate func setupUI(){
        self.backgroundColor = ColorBackGround
      
  self.addSubviews([bgView,bgImage,bodyimgaeView,nickNameLabel,editBtn,whiteView])
        
        bgView.addSubview(backgroundimgaeView)
        
        whiteView.addSubviews([titleLab,arrowiamge,line,clickFriendButton])
        
        setupLayout()

        let maskPath = UIBezierPath(roundedRect: bgView.bounds, byRoundingCorners: [.bottomLeft,.bottomRight], cornerRadii: CGSize(width:15, height:30))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bgView.bounds
        maskLayer.path = maskPath.cgPath
        bgView.layer.mask = maskLayer
        
    }
    public func scrollViewDidScroll(offsetY: CGFloat) {
        var frame = self.bgImgFrame
        
        // 上下放大
        frame.size.height -= offsetY
        frame.origin.y = offsetY
        
        // 左右放大
        if offsetY <= 0 {
            frame.size.width = frame.size.height * self.bgImgFrame.size.width / self.bgImgFrame.size.height
            frame.origin.x = (self.frame.size.width - frame.size.width) / 2
        }
        
        
        self.bgImage.frame = frame
    }
    fileprivate func setupLayout() {
        
        backgroundimgaeView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        bodyimgaeView.snp.makeConstraints { (make) in
            make.top.equalTo(navigationBarHeight)
            make.left.equalToSuperview()
            make.width.equalTo(HeadBodyImgaeH/1.1)
            make.height.equalTo(HeadBodyImgaeH)
        }
        nickNameLabel.snp.makeConstraints { (make) in
            
            make.top.equalTo(bodyimgaeView.snp.top).offset(50)
             make.right.equalTo(-(ScreenW/2 - 110)/2)
            make.height.equalTo(40)
            make.width.equalTo(110)
        }
        
        editBtn.snp.makeConstraints { (make) in
            
            make.top.equalTo(nickNameLabel.snp.bottom).offset(15)
            make.right.equalTo(-(ScreenW/2 - 110)/2)
            make.width.equalTo(110)
            make.height.equalTo(40)
        }
        whiteView.snp.makeConstraints { (make) in
            make.top.equalTo(bodyimgaeView.snp_bottom)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(HeadWhiteH)
            
        }
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(ScreenW/4)
        }
        
        arrowiamge.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(-15)
            make.width.height.equalTo(15)
        }
        
        line.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(titleLab.snp_bottom)
            make.height.equalTo(1)
        }
        clickFriendButton.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension MineHeadView{
    @objc private func ClickFriendAction(){
        self.XZBCuruntView().navigationController?.pushViewController(MessageListViewController(), animated: true)
    }
    @objc private func gotoEdit(){
    
        
        let vc = DIYBaseChooseViewController.init(PopDisabled: false)
        self.XZBCuruntView().navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @objc private func gotoSelf(){
       
       let vc = PageSpaceViewController.init(userID: GlobalDataStore.shared.currentUser.uid)
        
        self.XZBCuruntView().navigationController?.pushViewController(vc, animated: true)
    }
}



//MARK:收藏视图
class FriendsBaseView: UIView {
    
    lazy var FriendsImgView: UIImageView = {
        let ImgView = UIImageView.init()
        ImgView.layer.cornerRadius  = 30
        ImgView.layer.masksToBounds = true
        ImgView.contentMode = .scaleAspectFit
        return ImgView
    }()
    
    lazy var FriendsLabel : UILabel = {
        let Label = UILabel.init()
        Label.textAlignment = NSTextAlignment.center
        Label.font = UIFont.pingFangTextFont(size: 12)
        Label.textColor = ColorGrayColor
        return Label
        
    }()
    lazy var numLabel : UILabel = {
        let Label = UILabel.init()
        Label.textAlignment = NSTextAlignment.center
        Label.font = UIFont.pingFangTextFont(size: 12)
        Label.textColor = ColorWhite
        Label.backgroundColor = ColorNums
        Label.layer.cornerRadius  = 7.5
        Label.layer.masksToBounds = true
        Label.isHidden = true
        return Label
        
    }()
   
    lazy var clickButton : UIButton = {
        
        let button = UIButton.init(type: .custom)
        button.addTarget(self, action: #selector(CollectClickAction), for: .touchUpInside)
        return button
    }()
    
    func loadData(model: MineHomeFriendsModel){
        
        self.FriendsImgView.kf.setImage(urlString: model.avatar)
        self.FriendsLabel.text = model.nickname
        
        if model.msgCnt == 0 {
            self.numLabel.isHidden = true
        }else{
            self.numLabel.isHidden = false
            self.numLabel.text = "\(model.msgCnt ?? 1)"
        }
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        layoutUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI() {
        
        
        self.addSubviews([FriendsImgView,FriendsLabel,numLabel])
        
    }
    private func layoutUI(){
        
        FriendsImgView.snp.makeConstraints() { (make) in
            make.left.top.equalToSuperview()
            make.height.width.equalTo(60)
        }
        FriendsLabel.snp.makeConstraints() { (make) in
            make.top.equalTo(FriendsImgView.snp_bottom).offset(5)
            make.height.equalTo(20)
            make.width.equalTo(60)
        }
      
        numLabel.snp.makeConstraints() { (make) in
            make.right.top.equalToSuperview()
            make.height.width.equalTo(15)
        }
        
    }
   
    @objc private func CollectClickAction(){
        
    }
    
}
