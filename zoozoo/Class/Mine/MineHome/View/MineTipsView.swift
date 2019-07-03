//
//  MineTipsView.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/6/13.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class MineTipsView: BaseShowView {

   
    lazy var topLabel:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = ColorTitle
        label.text = "暂无权限"
        
        return label
    }()
    lazy var deLabel:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.pingFangMediumFont(size: 15)
        label.textColor = ColorGrayTitle
        label.text = "每个用户的真实资料仅对好友可见"
        return label
    }()
    lazy var petBtn : XZBShareButtonExt = {
        
        let Btn = XZBShareButtonExt.init(type: .custom)
        Btn.setImage(UIImage.init(named: "smallPet"), for: .normal)
        Btn.setTitle("抱它回家", for: .normal)
        Btn.setTitleColor(ColorGrayColor, for: .normal)
        Btn.titleLabel?.font = UIFont.pingFangTextFont(size: 12)
        return Btn
        
    }()
    lazy var arrow1:UIImageView = {
        let arrow = UIImageView.init()
        arrow.image = UIImage.init(named: "cellArrow")
        return arrow
    }()
    
    lazy var qimiBtn : XZBShareButtonExt = {
        
        let Btn = XZBShareButtonExt.init(type: .custom)
        Btn.setImage(UIImage.init(named: "qinmi"), for: .normal)
        Btn.setTitle("亲密值100", for: .normal)
        Btn.setTitleColor(ColorGrayColor, for: .normal)
        
        Btn.titleLabel?.font = UIFont.pingFangTextFont(size: 12)
        
        return Btn
        
    }()
    lazy var arrow2:UIImageView = {
        let arrow = UIImageView.init()
        arrow.image = UIImage.init(named: "cellArrow")
        return arrow
    }()
    
    lazy var frinedsBtn : XZBShareButtonExt = {
        
        let Btn = XZBShareButtonExt.init(type: .custom)
        Btn.setImage(UIImage.init(named: "friends"), for: .normal)
        Btn.setTitle("升为好友", for: .normal)
        Btn.setTitleColor(ColorGrayColor, for: .normal)
        
        Btn.titleLabel?.font = UIFont.pingFangTextFont(size: 12)
        
        return Btn
        
    }()
    
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubView()
        createUIView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func createUIView(){
        backView.frame = CGRect.init(x: 40, y: 0, width: Int(ScreenW - 80), height: 200)
        backView.center = self.center
        backView.addSubviews([topLabel,deLabel,petBtn,arrow1,qimiBtn,arrow2,frinedsBtn])
        
       
        topLabel.snp.makeConstraints { (make) in
            make.top.equalTo(25)
            make.left.right.equalToSuperview()
            make.height.equalTo(20)
        }
        deLabel.snp.makeConstraints { (make) in
            make.top.equalTo(topLabel.snp_bottom).offset(15)
            make.left.right.equalToSuperview()
            make.height.equalTo(20)
        }
        qimiBtn.snp.makeConstraints { (make) in
            make.top.equalTo(deLabel.snp_bottom).offset(15)
            make.centerX.equalToSuperview()
            make.height.equalTo(100)
            make.width.equalTo(60)
        }
        arrow1.snp.makeConstraints { (make) in
            make.top.equalTo(deLabel.snp.bottom).offset(35)
            make.right.equalTo(qimiBtn.snp.left).offset(-10)
            make.height.equalTo(13)
            make.width.equalTo(13)
        }
        arrow2.snp.makeConstraints { (make) in
            make.top.equalTo(deLabel.snp.bottom).offset(35)
            make.left.equalTo(qimiBtn.snp.right).offset(10)
            make.height.equalTo(13)
            make.width.equalTo(13)
        }
        petBtn.snp.makeConstraints { (make) in
            make.top.equalTo(deLabel.snp_bottom).offset(15)
            make.right.equalTo(arrow1.snp.left).offset(-10)
            make.height.equalTo(100)
            make.width.equalTo(60)
        }
        frinedsBtn.snp.makeConstraints { (make) in
            make.top.equalTo(deLabel.snp_bottom).offset(15)
            make.left.equalTo(arrow2.snp.right).offset(10)
            make.height.equalTo(100)
            make.width.equalTo(60)
        }

        self.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(dismiss)))
    }
    
    
   
    
}


class SystemTipsView: BaseShowView {
    
   
    lazy var topLabel:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = ColorTitle
        return label
    }()
    lazy var deLabel:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.pingFangTextFont(size: 15)
        label.textColor = ColorGrayTitle
        label.numberOfLines = 0
        return label
    }()
    var H = 150
    var title = "它已经被别人抱走了"
    var deTitle = "你可以有很多小乖兽\n 但每个人只能有一个守护者\n 过段时间再来看看吧"
    
    //初始化视图
    init(title :String ,deTitle :String ,H :Int) {
        super.init(frame: screenFrame)
        self.title = title
        self.deTitle = deTitle
        self.H = H
        initSubView()
        createUIView()
    }
    init() {
        super.init(frame: screenFrame)
        initSubView()
        createUIView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   func createUIView(){
        backView.frame = CGRect.init(x: 40, y: 0, width: Int(ScreenW - 80), height: H)
        backView.center = self.center
        backView.addSubviews([topLabel,deLabel])
        
       self.topLabel.text = title
        self.deLabel.text = deTitle
        
        topLabel.snp.makeConstraints { (make) in
            make.top.equalTo(25)
            make.left.right.equalToSuperview()
            make.height.equalTo(20)
        }
        deLabel.snp.makeConstraints { (make) in
            make.top.equalTo(topLabel.snp_bottom).offset(15)
            make.left.right.equalToSuperview()
            
        }
        
        
        self.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(dismiss)))
    }
    
    
  
}
