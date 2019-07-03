//
//  MineTableViewCell.swift
//  zoozoo
//
//  Created by 苹果上的豌豆 on 2019/5/20.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit



class changeAppIconCell: UITableViewCell,UICollectionViewDataSource, UICollectionViewDelegate {
    
    lazy var downView:UIView = {
        let View = UIView.init()
        View.backgroundColor = ColorWhite
        View.layer.masksToBounds = true
        View.layer.cornerRadius = 10
        return View
    }()
    
    lazy var titleLab:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.pingFangMediumFont(size: 14)
        label.textColor = ColorMineTableTitle
        label.text = "更换图标"
        return label
    }()
    
    var collectionView : UICollectionView?
    let Identifier       = "APPIconCollectionCell"
    
    let nologo = "Unlocklogo"
    var APPLogoData = ["zoo","bear","rabbit","cat","lion","monster","kaola","owl","yin","dragon","dog","monkey","tiger"]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        self.backgroundColor = ColorBackGround
        self.createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createUI(){
        // 初始化
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: (ScreenW-105)/4, height: (ScreenW-105)/4)
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets.init(top: 15, left: 15, bottom: 15, right: 15)
        
        // 注册cell
        collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView?.backgroundColor = ColorWhite
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.layer.cornerRadius = 5
        collectionView?.layer.masksToBounds = true
        collectionView?.register(APPIconCollectionCell.self, forCellWithReuseIdentifier: Identifier)
    
        self.contentView.addSubviews([downView])
        downView.addSubviews([titleLab,collectionView!])
        
        downView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.bottom.equalToSuperview()
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(ScreenW/2)
        }
        
        collectionView?.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp_bottom)
            make.left.bottom.right.equalToSuperview()
        }
    }
    public var Model:APPIconTackModel?{
        didSet{
            let model = self.Model ?? APPIconTackModel()
             self.reloadData(model: model)
            self.collectionView?.reloadData()
            
            
        }
    }
   var APPIconSelectArr = [APPIconSelectModel()]
    func reloadData(model:APPIconTackModel){
        let frined = model.friendCnt
        let animals = ["熊","兔","猫","狮子","独角兽","考拉","猫头鹰","嘤嘤怪","龙","狗","猴","虎"]
        let APPLogoData = ["bear","rabbit","cat","lion","monster","kaola","owl","yin","dragon","dog","monkey","tiger"]
        let arr = [frined?.bear,frined?.rabbit,frined?.cat,frined?.lion,frined?.monster,frined?.kaola,frined?.owl,frined?.yin,frined?.dragon,frined?.dog,frined?.monkey,frined?.tiger]
        
        self.APPIconSelectArr.removeAll()
        let animalModel = APPIconSelectModel.init()
        animalModel.APPIconImage = "zoo"
        animalModel.APPIconName = "嗅嗅"
        animalModel.continueDays = 7
        animalModel.isCompleted = 1
        animalModel.friendCnt = 3
        animalModel.APPIconSelect = true
        self.APPIconSelectArr.append(animalModel)
        for i in 0 ..< animals.count {
            let animalModel = APPIconSelectModel.init()
            animalModel.APPIconImage = APPLogoData[i]
            animalModel.APPIconName = animals[i]
            animalModel.continueDays = model.continueDays ?? 0
            animalModel.isCompleted = model.isCompleted ?? 0
            animalModel.friendCnt = arr[i] ?? 0
            animalModel.APPIconSelect = false
            if model.continueDays == 7 && arr[i] == 3 && model.isCompleted == 1{
                
                animalModel.APPIconSelect = true
            }
            if let num = model.firstPetType{
                if i == num - 1 {
                    animalModel.systemGift = true
                    animalModel.APPIconSelect = true
                }
            }
            self.APPIconSelectArr.append(animalModel)
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 13
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:APPIconCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier, for: indexPath) as! APPIconCollectionCell
        if self.APPIconSelectArr.count > 0 {
            cell.reloadData(model: self.APPIconSelectArr[indexPath.row])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 判断是否 有解锁 icon
        let model = self.APPIconSelectArr[indexPath.row]
        if model.APPIconSelect{
            let view = ChangeIconView.init(model: model)
            view.show()
            view.changeIconBlock = {[unowned self] in
                self.changeIcon(appIcon: model.APPIconImage)
            }
        }else{
            let view = UnlockedChangeIconView.init(model: model)
            view.show()
        }
    }
    
    func changeIcon(appIcon :String){
        
        if #available(iOS 10.3, *) {
            //判断是否支持替换图标, false: 不支持
            guard UIApplication.shared.supportsAlternateIcons else { return }
            //如果支持, 替换icon
            UIApplication.shared.setAlternateIconName(appIcon) { (error) in
                if error == nil {
                   ShowMessageTool.shared.showMessage("更换成功")
                } else {
                    
                   ShowMessageTool.shared.showMessage("更换失败")
                }
            }
        }else{
            ShowMessageTool.shared.showMessage("您的系统过低，暂不支持")
        }
    }
}

class APPIconCollectionCell: UICollectionViewCell {
    
    lazy var backImageView:UIImageView = {
        let ImageView  = UIImageView.init()
        ImageView.backgroundColor = UIColor.colorWithHex(hex: 0x6760D4, alpha: 0.4)
        ImageView.layer.cornerRadius = 5
        ImageView.layer.masksToBounds = true
        return ImageView
    }()
    
    lazy var APPIconImageView:UIImageView = {
        let ImageView  = UIImageView.init()
        ImageView.layer.cornerRadius = 5
        ImageView.layer.masksToBounds = true
        ImageView.image = UIImage.init(named: "Unlocklogo")
        return ImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        self.contentView.addSubview(backImageView)
        self.contentView.addSubview(APPIconImageView)
        
        self.contentView.backgroundColor = UIColor.white
        
        backImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        APPIconImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        backImageView.transform = CGAffineTransform(rotationAngle: -(CGFloat.pi / 16))
        
    }
   
   
    func reloadData(model:APPIconSelectModel){
       
        if model.APPIconSelect {
           
            backImageView.isHidden = false
            APPIconImageView.image = UIImage.init(named: model.APPIconImage)
        }else{
            APPIconImageView.image = UIImage.init(named: "Unlocklogo")
            backImageView.isHidden = true
        }
        
    }
   
}


class normalPersonalCell: UITableViewCell {
    lazy var downView:UIView = {
        let View = UIView.init()
        View.backgroundColor = ColorWhite
        View.layer.masksToBounds = true
        View.layer.cornerRadius = 10
        return View
    }()
    
    lazy var titleLab:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.pingFangMediumFont(size: 14)
        label.textColor = ColorMineTableTitle
        return label
    }()
    
    lazy var arrowiamge:UIImageView = {
        let arrow = UIImageView.init()
        arrow.image = UIImage.init(named: "cellArrow")
        return arrow
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        self.contentView.backgroundColor = ColorBackGround
        self.createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createUI(){
        self.contentView.addSubview(downView)
        downView.addSubviews([titleLab,arrowiamge])
        
        downView.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.bottom.equalToSuperview()
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(ScreenW/2)
        }
    
        arrowiamge.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(15)
        }
    }
  
}

