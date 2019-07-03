//
//  PopImageView.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/5/26.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

let storyImageW = ScreenW - 60
let storyImageH = storyImageW*1.4
class PopImageView: UIView {
    var cancelBtn :UIButton = UIButton()
    var storyImage:UIImageView = UIImageView()
    var outerImage:UIImageView = UIImageView()
    var whiteView :UIView = UIView()
    //背景区域的颜色和透明度
   
    var StartFrame = CGRect.init(x: 30, y: ScreenH, width: storyImageW, height: storyImageH)
    var imageUrl = "https://public.zhuiyinanian.com/story-42423423423.png"
    var animalDIYImage = UIImage.init()
    //初始化视图
    init(imageUrl : String, animalDIYImage: UIImage) {
        super.init(frame: screenFrame)
        if !imageUrl.isEmpty {
            self.imageUrl = imageUrl
        }
        self.animalDIYImage = animalDIYImage
        initSubView()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func initSubView(){
        self.frame = CGRect.init(x: 0, y: 0, width: ScreenW, height: ScreenH)
        self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.8)
        self.isHidden = true
        
        storyImage.layer.masksToBounds = true
        storyImage.contentMode = .scaleAspectFill
        storyImage.layer.cornerRadius = 5
        storyImage.kf.setImage(urlString: self.imageUrl)
       
        storyImage.frame = StartFrame

        self.addSubview(storyImage)
        
        outerImage.contentMode = .scaleAspectFill
        outerImage.image = self.animalDIYImage
        outerImage.frame = StartFrame
        storyImage.addSubview(outerImage)

        self.cancelBtn.setImage(UIImage.init(named: "close"), for: .normal)
        self.cancelBtn.addTarget(self, action: #selector(self.dismiss), for: .touchUpInside)
        self.addSubview(cancelBtn)
        
        outerImage.snp.makeConstraints { (make) in
            make.width.equalTo(storyImageW/2.4)
            make.height.equalTo(storyImageH/2.4)
            make.centerX.equalToSuperview()
            make.top.equalTo(storyImage.snp_top).offset(storyImageH/17)
        }
        
        self.cancelBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.storyImage.snp_bottom)
        }
    }
    func show(){
        let window = UIApplication.shared.delegate?.window as? UIWindow
        window?.addSubview(self)
        self.isHidden = false
        let h  = (ScreenH - storyImageH)/2

        self.storyImage.frame.origin.y = h
        self.storyImage.alpha = 0
        self.alpha = 0
        storyImage.transform = storyImage.transform.scaledBy(x: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .beginFromCurrentState, animations: {
            self.storyImage.transform = .identity
            self.storyImage.alpha = 1
            self.alpha = 1
        }) { (finish) in
            
        }
        

    }
    @objc func dismiss(){
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .beginFromCurrentState, animations: {
            self.storyImage.transform = self.storyImage.transform.scaledBy(x: 0.5, y: 0.5)
            self.storyImage.alpha = 0
            self.alpha = 0
        }) { (finish) in
            self.isHidden = true
            self.removeFromSuperview()
        }
        
    }
    
   
}
