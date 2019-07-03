//
//  LikesNoDataView.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/6/14.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

enum  LikesNoDataType{
    
    case mineLike
    
    case personLike
    
    case mineAnimal
    
    case personAnimal
    
    case mineAnimalStore
    
    case personAnimalStore
    
}
class LikesNoDataView: UIView {
   
    lazy var topLabel:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.pingFangTextFont(size: 15)
        label.textColor = ColorGrayColor
        label.numberOfLines = 0
        return label
    }()
    lazy var clickBtn : UIButton = {
        
        let Btn = UIButton.init(type: .custom)
        Btn.layer.cornerRadius  = 25
        Btn.layer.borderColor = ColorThemeLan.cgColor
        Btn.layer.borderWidth = 1
        Btn.setTitleColor(ColorThemeLan, for: .normal)
        Btn.setTitleColor(ColorThemeLan, for: .selected)
        Btn.titleLabel?.font = UIFont.pingFangTextFont(size: 14)
        Btn.addTarget(self, action: #selector(click), for: .touchUpInside)
        return Btn
        
    }()
    lazy var loveBtn : UIButton = {
        
        let Btn = UIButton.init(type: .custom)
        Btn.setImage(UIImage.init(named: "LOVE"), for: .normal)
        Btn.addTarget(self, action: #selector(click), for: .touchUpInside)
        return Btn
        
    }()
    
    lazy var addBtn : UIButton = {
        
        let Btn = UIButton.init(type: .custom)
        Btn.setImage(UIImage.init(named: "add"), for: .normal)
        Btn.addTarget(self, action: #selector(click), for: .touchUpInside)
        return Btn
        
    }()
    
    
    lazy var animalButton : BottonLineBtn = {
        let button = BottonLineBtn.init(type: .custom)
        button.setTitle("去首页寻找", for: .normal)
        button.setTitleColor(ColorTheme, for: .normal)
        button.addTarget(self, action: #selector(click), for: .touchUpInside)
        button.titleLabel?.font = UIFont.pingFangTextFont(size: 14)
        return button
    }()
    
    
    var type = LikesNoDataType.mineLike
    
   
    
    //初始化视图
    init(type :LikesNoDataType ,frame: CGRect) {
        super.init(frame: frame)
        self.type = type
        
        initSubView()
    }
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func initSubView(){

        self.backgroundColor = .white
        
        switch self.type {
            
        case .mineLike:
            self.mineLikeUI()
            break
        case .personLike:
            self.personLikeUI()
            break
        case .mineAnimal:
            self.mineAnimalUI()
            break
        case .personAnimal:
            self.personAnimalUI()
            break
        case .mineAnimalStore:
            self.mineAnimalStoreUI()
            break
        case .personAnimalStore:
            self.personAnimalStoreUI()
            break
        }
       
    }
    
    func mineLikeUI(){
        topLabel.text = "暂未收到喜欢\n 完善个人资料可提升曝光率"
        clickBtn.setTitle("去完善", for: .normal)
        
        topLabel.frame = CGRect.init(x: 0, y: 0, width: ScreenW, height: 60)
       topLabel.centerY = self.centerY - topLabel.h
        clickBtn.frame = CGRect.init(x: 0, y: topLabel.bottom, width: 120, height: 50)
        clickBtn.centerX = self.centerX
        
        self.addSubviews([topLabel,clickBtn])
        
    }
    
    func personLikeUI(){
        topLabel.text = "TA暂未收到喜欢\n 点个喜欢鼓励它呗"
       
        
        topLabel.frame = CGRect.init(x: 0, y: 0, width: ScreenW, height: 60)
        topLabel.centerY = self.centerY - topLabel.h
        loveBtn.frame = CGRect.init(x: 0, y: topLabel.bottom, width: 60, height: 60)
        loveBtn.centerX = self.centerX
        
        self.addSubviews([topLabel,loveBtn])
        
    }
    
    func mineAnimalUI(){
        topLabel.text = "“喜欢”等同于“收藏”\n 多多mark小乖兽们有助于魅力值提升\n 去首页寻找与你臭味相投的它吧"
        clickBtn.setTitle("去首页", for: .normal)
        
        topLabel.frame = CGRect.init(x: 0, y: 0, width: ScreenW, height: 100)
        topLabel.centerY = self.centerY - topLabel.h
        clickBtn.frame = CGRect.init(x: 0, y: topLabel.bottom, width: 120, height: 50)
        clickBtn.centerX = self.centerX
        
        self.addSubviews([topLabel,clickBtn])
        
    }
    
    func personAnimalUI(){
        topLabel.text = "TA有一些高冷\n 目前还没找到喜欢的人"
       
        topLabel.frame = CGRect.init(x: 0, y: 0, width: ScreenW, height: 60)
       topLabel.centerY = self.centerY - topLabel.h
    
        
        self.addSubview(topLabel)
        
    }
    func mineAnimalStoreUI(){
        topLabel.text = "每拥有一个亲密值达到100的嗅友\n 你就拥有了一张《小乖兽图鉴》\n TA的嗅嗅形象+TA的星座=你的小乖兽图鉴\n 当你集齐某种动物的"
        
        
        topLabel.frame = CGRect.init(x: 0, y: 0, width: ScreenW, height: 100)
        topLabel.centerY = self.centerY - topLabel.h
        addBtn.frame = CGRect.init(x: 0, y: topLabel.bottom + 20, width: 50, height: 50)
        animalButton.frame = CGRect.init(x: 0, y: addBtn.bottom + 10, width: 80, height: 20)
        addBtn.centerX = self.centerX
        animalButton.centerX = self.centerX
        
        self.addSubviews([topLabel,addBtn,animalButton])
        
    }
    func personAnimalStoreUI(){
        topLabel.text = "TA当前暂未获得图鉴"
        
        topLabel.frame = CGRect.init(x: 0, y: 0, width: ScreenW, height: 30)
        topLabel.centerY = self.centerY - topLabel.h
        
        
        self.addSubview(topLabel)
        
    }
    public var noDataClickBlock : (()->Void)?
    
    @objc func click(){
        
        switch self.type {
            
        case .mineLike:
            self.XZBCuruntView().navigationController?.pushViewController(PersonalViewController(), animated: true)
            break
        case .personLike:
            self.noDataClickBlock?()
            
            break
        case .mineAnimal:
            
            BaseEngine.shared.goTabHomeVC()
            
            break
        case .personAnimal:
            
            break
        case .mineAnimalStore:
            BaseEngine.shared.goTabHomeVC()
            break
        case .personAnimalStore:
            
            break
        }
    }
    

}
