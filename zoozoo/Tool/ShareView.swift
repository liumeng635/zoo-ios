//
//  ShareView.swift
//  zoozoo
//
//  Created by 苹果上的豌豆 on 2019/5/15.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit
import Kingfisher
/*
 我的-推荐给好友
 图标：嗅嗅LOGO
 主标题：嗅嗅APP，换个方式谈恋爱
 副标题：来玩嗅嗅，我养你啊！
 
 APP里其他分享或邀请好友：
 图标：我的宠物形象
 主标题：嗅嗅APP，换个方式谈恋爱
 副标题：喂，我养你啊！点进来，让我宠溺你
 
 */

enum shareType {
    case logoShare
    case mineShare
}
class ShareView: UIView {
    public  var removeFinishBlcok  : (() -> Void)?
    
    let shareH = 200 + SafeBottomMargin
    var topTexts = ["微信","QQ好友","朋友圈","QQ空间"]
    let topIconsName = ["ic_wechat","ic_qq","ic_pyq","ic_qqkongjian"]
    var container = UIView.init()
    var cancel = UILabel.init()
    var title = "嗅嗅APP，换个方式谈恋爱"
    var body = "来玩嗅嗅，我养你啊！"
    var shareImage = ""
     var type = shareType.logoShare
    var shareUIImage = UIImage.init()
    
    //动态详情
    init(shareImage :String ,type:shareType) {
        super.init(frame: screenFrame)
        self.shareImage = shareImage
        self.type = type
        initSubView()
    }
    init() {
        super.init(frame: screenFrame)
        initSubView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initSubView() {
        self.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(handleGuesture(sender:))))
        self.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        container.frame = CGRect.init(x: 0, y: ScreenH, width: ScreenW, height: shareH)
        container.backgroundColor = ColorBackGround
        self.addSubview(container)
        
        let rounded = UIBezierPath.init(roundedRect: CGRect.init(origin: .zero, size: CGSize.init(width: ScreenW, height: shareH)), byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize.init(width: 10.0, height: 10.0))
        let shape = CAShapeLayer.init()
        shape.path = rounded.cgPath
        container.layer.mask = shape
        
        let blurEffect = UIBlurEffect.init(style: .light)
        let visualEffectView = UIVisualEffectView.init(effect: blurEffect)
        visualEffectView.frame = self.bounds
        visualEffectView.alpha = 1.0
        container.addSubview(visualEffectView)
        
        let label = UILabel.init(frame: CGRect.init(origin: .zero, size: CGSize.init(width: ScreenW, height: 35)))
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "选择邀请方式"
        label.textColor = ColorGrayTitle
        label.font = UIFont.pingFangTextFont(size: 14)
        container.addSubview(label)
        
        
        let itemWidth = Int.init((ScreenW - 50 - 48*4)/3 + 48)
        let topScrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 40, width: ScreenW, height: 90))
        topScrollView.contentSize = CGSize.init(width: itemWidth * topIconsName.count, height: 80)
        topScrollView.showsHorizontalScrollIndicator = false
        topScrollView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 30)
        container.addSubview(topScrollView)
        

        for index in 0..<topIconsName.count {
            let item = ShareItem.init(frame: CGRect.init(x: 25 + itemWidth * index, y: 0, width: 48, height: 90))
            item.icon.image = UIImage.init(named: topIconsName[index])
            item.label.text = topTexts[index]
            item.tag = index
            item.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(onShareItemTap(sender:))))
            item.startAnimation(delayTime: TimeInterval(Double(index) * 0.03))
            topScrollView.addSubview(item)
        }
        
        cancel.frame = CGRect.init(x: 0, y: 145, width: ScreenW, height: 55)
        cancel.textAlignment = .center
        cancel.text = "取消"
        cancel.textColor = ColorGrayTitle
        cancel.font =  UIFont.boldSystemFont(ofSize: 18)
        cancel.backgroundColor = ColorWhite
        container.addSubview(cancel)
 
        cancel.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(handleGuesture(sender:))))
        
        if self.type == shareType.mineShare{
            label.text = "把你的小乖兽丢到朋友家去"
            self.body = "喂，我养你啊！点进来，让我宠溺你"
            ImageDownloader.default.downloadImage(with: URL(string: self.shareImage)!, retrieveImageTask: nil, options: nil, progressBlock: nil) { (image, error, url, _) in
                self.shareUIImage = image ?? UIImage.init(named: "LOGO")!
            }
    
        }
        
        
    }
    
    
    
   
}

extension ShareView {
    //MARK :分享的点击事件
    @objc func onShareItemTap(sender:UITapGestureRecognizer) {
        let index = sender.view?.tag ?? 0
        
      
        
        let arrPlatformType = [UMSocialPlatformType.wechatSession,UMSocialPlatformType.QQ,UMSocialPlatformType.wechatTimeLine,UMSocialPlatformType.qzone]
        
        //创建分享消息对象
        let messageObject = UMSocialMessageObject()
        var shareObject = UMShareWebpageObject.init()
        if type == shareType.logoShare{
            //分享消息对象设置分享内容对象
            shareObject = UMShareWebpageObject.shareObject(withTitle: title, descr: body, thumImage: UIImage.init(named: "LOGO"))!
        }else{
            //分享消息对象设置分享内容对象
            shareObject = UMShareWebpageObject.shareObject(withTitle: title, descr: body, thumImage: self.shareUIImage)!
        }
        
        //设置网页地址
        shareObject.webpageUrl = BaseConfig.shared.appURL
        messageObject.shareObject = shareObject
        //调用分享接口
        UMSocialManager.default().share(to: arrPlatformType[index], messageObject: messageObject, currentViewController: self.curViewController(), completion: { (shareResponse, error) in
            if error == nil {
               self.showSuccess()
            }else{
                self.showError()
            }
        })
        dismiss()
    }
    
    func showSuccess(){
         SystemTipsView.init(title: "分享成功", deTitle: "待您的朋友加入嗅嗅后\n 可以通过搜索手机号抱TA回家\n \n建议多询问朋友是否已加入，\n 以免TA被他人抢走", H: 200).show()
    }
    
    func showError(){
        SystemTipsView.init(title: "分享失败", deTitle: "和朋友一起玩嗅嗅\n 换一种方式聊天特别有趣\n 期待您的下次分享 ", H: 150).show()
    }
    
    @objc func handleGuesture(sender:UITapGestureRecognizer) {
        var point = sender.location(in: container)
        if !(container.layer.contains(point)) {
            dismiss()
            return
        }
        point = sender.location(in: cancel)
        if cancel.layer.contains(point) {
            dismiss()
        }
    }
    
    func show() {
        let window = UIApplication.shared.delegate?.window as? UIWindow
        window?.addSubview(self)
        UIView.animate(withDuration: 0.15, delay: 0.0, options: .curveEaseOut, animations: {
            var frame = self.container.frame
            frame.origin.y = frame.origin.y - frame.size.height
            self.container.frame = frame
        }) { finshed in
        }
    }
    
    func dismiss() {
        UIView.animate(withDuration: 0.15, delay: 0.0, options: .curveEaseIn, animations: {
            var frame = self.container.frame
            frame.origin.y = frame.origin.y + frame.size.height
            self.container.frame = frame
        }) { finshed in
            self.removeFromSuperview()
        }
    }
}

class ShareItem:UIView {
    
    var icon = UIImageView.init()
    var label = UILabel.init()
    init() {
        super.init(frame: .zero)
        initSubView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initSubView() {
        icon.contentMode = .scaleToFill
        icon.isUserInteractionEnabled = true
        self.addSubview(icon)
    
        label.textColor = UIColor.colorWithHex(hex: 0xB5B5B5)
        label.font = UIFont.pingFangTextFont(size: 12)
        label.textAlignment = .center
        self.addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        icon.snp.makeConstraints { make in
            make.width.height.equalTo(48)
            make.centerX.equalTo(self)
            make.top.equalTo(self).offset(10)
        }
        label.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(self.icon.snp.bottom).offset(10)
        }
    }
    
    func startAnimation(delayTime:TimeInterval) {
        let originalFrame = self.frame
        self.frame = CGRect.init(origin: CGPoint.init(x: originalFrame.minX, y: 35), size: originalFrame.size)
        UIView.animate(withDuration: 0.9, delay: delayTime, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: {
            self.frame = originalFrame
        }) { finished in
        }
    }
    
    
    
}
