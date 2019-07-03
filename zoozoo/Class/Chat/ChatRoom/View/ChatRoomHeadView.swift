//
//  ChatRoomHeadView.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/6/30.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class ChatRoomHeadView: UIView {
    lazy var bgView: UIView = {
        let bgView = UIView.init()
        bgView.backgroundColor = ColorTheme
        return bgView
    }()
    
    lazy var circleView: UIImageView = {
        let imageView=UIImageView.init()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.image=UIImage(named: "circle")
        return imageView
    }()
    
    lazy var back : UIButton = {
        
        let Btn = UIButton.init(type: .custom)
        let backImage = UIImage.init(named: "back")!.render(color: .white)
        Btn.setImage(backImage, for: .normal)
        Btn.frame = CGRect.init(x: 15, y: statusBarH + 30, width: backImage.size.width, height: backImage.size.height)
       
        Btn.addTarget(self, action: #selector(backPop), for: .touchUpInside)
        return Btn
        
    }()
    lazy var moreButton : UIButton = {
        
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: ScreenW - 45, y: statusBarH + 25, width: 30, height: 30)
        button.setImage(UIImage.init(named: "BarMore")?.render(color: .white), for: .normal)
        button.addTarget(self, action: #selector(ClickMoreAction), for: .touchUpInside)
        return button
    }()
    lazy var petImage:UIImageView = {
        let imageV = UIImageView.init()
        imageV.layer.cornerRadius = 30.0
        imageV.layer.masksToBounds = true
        imageV.layer.borderColor = ColorWhite.cgColor
        imageV.layer.borderWidth = 2
        return imageV
    }()
    lazy var titleLab:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.pingFangTextFont(size: 14)
        label.textColor = ColorWhite
        return label
    }()
  
    lazy var sex:UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "man")
        return imageV
    }()
    
    lazy var age:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.pingFangTextFont(size: 10)
        label.textColor = ColorWhite
        label.backgroundColor = ColorTheme
        label.layer.cornerRadius = 3.0
        label.layer.masksToBounds = true
        return label
    }()
    lazy var constellation:UIImageView = {
        let imageV = UIImageView.init()
        return imageV
    }()
    lazy var accompanyTime:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.pingFangTextFont(size: 11)
        label.textColor = ColorWhite
        return label
    }()
    lazy var charm: UIImageView = {
        let imageView = UIImageView.init()
        imageView.image=UIImage(named: "qinmi")
        return imageView
    }()
    lazy var charmView: UIView = {
        let view = UIView.init()
        view.layer.cornerRadius  = 6
        view.layer.masksToBounds = true
        view.layer.borderColor = ColorCharmColor.cgColor
        view.layer.borderWidth = 0.5
        view.backgroundColor = .white
        
        return view
    }()
    lazy var charmLabel: lineLabel = {
        let label = lineLabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textColor = ColorCharmColor
        label.shadowOffset = CGSize.init(width: 0, height: 0)
        label.text = "20"
        label.frame  = CGRect.init(x:0, y: 0, width: 60, height: 12)
        self.charmView.addSubview(label)
        return label
    }()
    lazy var charmDianView: UIView = {
        let view = UIView.init()
        view.backgroundColor = ColorCharmColor
        view.frame  = CGRect.init(x:0, y: 0, width: 10, height: 12)
        self.charmView.addSubview(view)
        
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var model: RaiseAnimalsModel? {
        didSet {
            guard let model = model else { return }
             self.bgView.gradientStringDIYColor(colorsString :model.backImage ?? "")
            let colors = model.backImage?.components(separatedBy: ",")
            petImage.backgroundColor = UIColor.init(hexString: colors?.first ?? "#6760D4")
            
            
            let petUrl = "\(model.petImage ?? "")\(BottomQiuniuUrl)"
            petImage.kf.setImage(urlString: petUrl)
            titleLab.text = model.petNickName
            accompanyTime.text = "你们已经相互陪伴了\(model.accompanyTime ?? "1天")"
            if model.sex == 1{
                sex.image = UIImage.init(named: "man")
            }else{
                sex.image = UIImage.init(named: "woman")
            }
            age.text = "\(model.age)岁"
            constellation.image = UIImage.init(named: model.constellation ?? "金牛座")
            charmLabel.text = "\(model.closeDeg)"
            charmDianView.w = CGFloat((60 * model.closeDeg)) / 100
        }
    }
    func configUI() {
        self.addSubviews([bgView,circleView,back,moreButton,petImage,titleLab,sex,age,constellation,accompanyTime,charm,charmView])
        bgView.snp.makeConstraints() { (make) in
            make.edges.equalToSuperview()
        }
        circleView.snp.makeConstraints() { (make) in
            make.edges.equalToSuperview()
        }
        petImage.snp.makeConstraints() { (make) in
            make.left.equalTo(back.snp.right).offset(5)
            make.top.equalTo(statusBarH + 10)
            make.width.height.equalTo(60)
          
        }
        titleLab.snp.makeConstraints() { (make) in
            make.left.equalTo(petImage.snp.right).offset(5)
            make.top.equalTo(petImage.snp.top)
            make.height.equalTo(15)
        }
       
        sex.snp.makeConstraints() { (make) in
            make.left.equalTo(titleLab.snp.right).offset(5)
            make.top.equalTo(titleLab.snp.top)
            make.width.equalTo(15)
            make.height.equalTo(15)
        }
        age.snp.makeConstraints() { (make) in
            make.left.equalTo(sex.snp.right).offset(5)
            make.top.equalTo(sex.snp.top)
            make.width.equalTo(30)
            make.height.equalTo(15)
        }
        constellation.snp.makeConstraints() { (make) in
            make.left.equalTo(age.snp.right).offset(5)
            make.top.equalTo(sex.snp.top)
            make.width.equalTo(45)
            make.height.equalTo(15)
        }
        accompanyTime.snp.makeConstraints() { (make) in
            make.left.equalTo(titleLab.snp.left)
            make.top.equalTo(titleLab.snp.bottom).offset(5)
            make.right.equalTo(-60)
            make.height.equalTo(15)
        }
        charm.snp.makeConstraints() { (make) in
            make.left.equalTo(titleLab.snp.left)
            make.top.equalTo(accompanyTime.snp.bottom).offset(5)
            make.height.width.equalTo(15)
        }
        charmView.snp.makeConstraints() { (make) in
            make.left.equalTo(charm.snp.right).offset(10)
            make.top.equalTo(charm.snp.top)
            make.width.equalTo(60)
            make.height.equalTo(12)
        }
       
    }
    
    
}
extension ChatRoomHeadView {
    @objc func backPop(){
        self.XZBCuruntView().navigationController?.popViewController(animated: true)
        
    }
    @objc func ClickMoreAction(){
        self.XZBCuruntView().navigationController?.popViewController(animated: true)
        
    }
}
