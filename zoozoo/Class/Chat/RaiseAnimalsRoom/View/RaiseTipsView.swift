//
//  RaiseTipsView.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/6/24.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class RaiseTipsView: BaseShowView {
    lazy var MoreImageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.image = UIImage.init(named: "ic_more")
        imageView.frame = CGRect.init(x: ScreenW - 45, y: statusBarH + 15, width: 30, height: 30)
        return imageView
    }()
    
    lazy var arrowView: UIImageView = {
        let arrowView = UIImageView.init()
        arrowView.image = UIImage.init(named: "arrowRight")
        arrowView.frame = CGRect.init(x: ScreenW - 140, y: statusBarH + 60, width: 40, height: 25)
        return arrowView
    }()
    lazy var TitleLab:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.pingFangTextFont(size: 14)
        label.textColor = ColorWhite
        label.numberOfLines = 0
        label.text = "恭喜你！\n  你已经找到了很多臭味相投的朋友 \n 点这里可以一键喂养它们咯"
        label.frame = CGRect.init(x: 50, y: self.arrowView.bottom + 20, width: ScreenW , height: 80)
        return label
    }()
    
    
    lazy var SureBtn:UIButton = {
        let Btn = UIButton.init(type: .custom)
        Btn.layer.cornerRadius  = 22
        Btn.layer.masksToBounds = true
        Btn.setTitle("我知道了", for: .normal)
        Btn.setTitleColor(ColorWhite, for: .normal)
        Btn.titleLabel?.font = UIFont.pingFangTextFont(size: 16)
        Btn.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        Btn.frame = CGRect.init(x: ScreenW - 80 - 110, y: self.TitleLab.bottom + 20, width: 110, height: 44)
        return Btn
    }()
    init() {
        super.init(frame: screenFrame)
        initSubView()
        ceteateUI()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubView()
        ceteateUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func  ceteateUI(){
        backView.addSubviews([arrowView,MoreImageView,TitleLab,SureBtn])
        backView.backgroundColor = .clear
         self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.6)
        self.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(dismiss)))
        backView.frame = self.frame

        SureBtn.addButtonGradientLayer()
    }
    

}

class RaiseAllAnimalsTipsView: BaseShowView {
    lazy var TitleLab:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.pingFangTextFont(size: 14)
        label.textColor = ColorWhite
        label.numberOfLines = 0
        label.text = "你精挑万选抱回来的小乖兽\n 都会显示在这里"
        label.frame = CGRect.init(x: 0, y: 0, width: ScreenW , height: 60)
        label.center = self.center
        return label
    }()
    lazy var arrowCenterView: UIImageView = {
        let arrowView = UIImageView.init()
        arrowView.image = UIImage.init(named: "arrowCenter")
        arrowView.frame = CGRect.init(x: 0, y: TitleLab.top - 80, width: 10, height: 40)
        arrowView.centerX = self.centerX
        return arrowView
    }()
    lazy var arrowLeftView: UIImageView = {
        let arrowView = UIImageView.init()
        arrowView.image = UIImage.init(named: "arrowLeft")
        arrowView.frame = CGRect.init(x: arrowCenterView.left - 80, y: arrowCenterView.top, width: 40, height: 25)
        return arrowView
    }()
    
    
    
    lazy var arrowRightView: UIImageView = {
        let arrowView = UIImageView.init()
        arrowView.image = UIImage.init(named: "arrowRight")
        arrowView.frame = CGRect.init(x: arrowCenterView.right + 40, y: arrowCenterView.top, width: 40, height: 25)
        return arrowView
    }()
    
    
    
    lazy var SureBtn:UIButton = {
        let Btn = UIButton.init(type: .custom)
        Btn.layer.cornerRadius  = 22
        Btn.layer.masksToBounds = true
        Btn.setTitle("我知道了", for: .normal)
        Btn.setTitleColor(ColorWhite, for: .normal)
        Btn.titleLabel?.font = UIFont.pingFangTextFont(size: 16)
        Btn.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        Btn.frame = CGRect.init(x: 0, y: self.TitleLab.bottom + 20, width: 110, height: 44)
         Btn.centerX = self.centerX
        return Btn
    }()
    init() {
        super.init(frame: screenFrame)
        initSubView()
        ceteateUI()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubView()
        ceteateUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func  ceteateUI(){
        backView.addSubviews([TitleLab,arrowCenterView,arrowLeftView,arrowRightView,SureBtn])
        backView.backgroundColor = .clear
        self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.6)
        self.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(dismiss)))
        backView.frame = self.frame
        
        SureBtn.addButtonGradientLayer()
    }
    
    
}
