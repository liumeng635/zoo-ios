//
//  PublishAnimalsTableViewCell.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/6/27.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class PublishAnimalsTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        self.createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var selectAnimalsID = ""
    var selectArr = [String]()
    public  var selectTopicBlock : ((_ content : String)->Void)?
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        layout.scrollDirection = .vertical
        
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor.white
        collection.dataSource = self
        collection.delegate = self
        collection.isScrollEnabled = false
        collection.register(PublishAnimalsCell.self, forCellWithReuseIdentifier: "PublishAnimalsCell")
        return collection
    }()
    
    lazy var qinmiLabel : UILabel = {
        [unowned self] in
        let Label = UILabel.init()
        Label.layer.cornerRadius  = 10
        Label.layer.masksToBounds = true
        Label.layer.borderColor = UIColor.colorWithHex(hex: 0xE7E8EC).cgColor
        Label.layer.borderWidth = 0.5
        Label.backgroundColor = ColorBackGround
        Label.font = UIFont.pingFangTextFont(size: 12)
        Label.textColor = ColorGrayColor
        Label.textAlignment = .center
        Label.text = "本次上传所有小乖兽均可获得10亲密值"
        return Label
        }()
    lazy var konwLabel : UILabel = {
        [unowned self] in
        let Label = UILabel.init()
        Label.font = UIFont.pingFangMediumFont(size: 14)
        Label.textColor = ColorGrayColor
        Label.textAlignment = .left
        Label.text = "你正在使用群体喂养"
        return Label
        }()
    //MARK:- Method
    fileprivate func createUI(){
        contentView.backgroundColor = UIColor.white
        contentView.addSubview(collectionView)
        contentView.addSubview(qinmiLabel)
        contentView.addSubview(konwLabel)
        
        qinmiLabel.snp.makeConstraints { (make) in
            make.top.equalTo(10)
//            make.width.equalTo(100)
            make.left.equalTo(15)
            make.height.equalTo(20)
        }
        
        konwLabel.snp.makeConstraints { (make) in
            
            make.top.equalTo(qinmiLabel.snp.bottom).offset(10)
            make.width.equalTo(200)
            make.left.equalTo(15)
            make.height.equalTo(20)
            
        }
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(konwLabel.snp.bottom).offset(10)
            make.left.right.bottom.equalToSuperview()
        }
    }
    var dataArr: [RaiseAnimalsModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    func reloadUI(dataArr :[RaiseAnimalsModel] ,type :RaiseType,isAll :Bool){
        self.dataArr = dataArr
        if !isAll{
            konwLabel.isHidden = true
            switch type {
            case .feeding:
                qinmiLabel.text = " 本次喂养可获得10亲密值 "
            case .play:
                qinmiLabel.text = " 本次遛弯可获得10亲密值 "
            case .education:
                qinmiLabel.text = " 本次出题可获得10亲密值 "
            }
        }else{
            konwLabel.isHidden = false
            qinmiLabel.text = " 本次上传所有小乖兽均可获得10亲密值 "
            switch type {
            case .feeding:
                konwLabel.text = "你正在使用群体喂养"
            case .play:
                konwLabel.text = "你正在使用群体遛弯"
            case .education:
                konwLabel.text = "你正在使用群体出题"
            }
        }
    }
    
}

extension PublishAnimalsTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (ScreenW - 15*4) / 3
        let height = CGFloat.init(50)
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PublishAnimalsCell", for: indexPath) as! PublishAnimalsCell
        cell.loadData(Model: dataArr[indexPath.row])
        
       
        var selectAnimalIDs = ""
        cell.PublishAnimalsCellCloseBlcok = {[weak self] in
            if self?.dataArr.count == 1 {
                ShowMessageTool.shared.showMessage("至少选择一个动物")
                
            }else{
                self?.dataArr.remove(at: indexPath.row)
            }
            self?.collectionView.reloadData()
            self?.dataArr.forEach({ (model) in
                selectAnimalIDs.append(model.userId ?? "")
                selectAnimalIDs.append(",")
            })
            selectAnimalIDs.removeLast()
            self?.selectTopicBlock?(selectAnimalIDs)
        }
        

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
    
    
}

class PublishAnimalsCell: UICollectionViewCell {
    public  var PublishAnimalsCellCloseBlcok  : (() -> Void)?
    
    
    lazy var backView:UIView = {
        let view = UIView.init()
        view.backgroundColor = ColorBackGround
        view.layer.cornerRadius = 25
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var imageV:UIImageView = {
        let imageV = UIImageView.init()
        imageV.layer.cornerRadius = 20
        imageV.layer.masksToBounds = true
        imageV.contentMode = .scaleAspectFit
        imageV.backgroundColor = ColorTheme
        return imageV
    }()
    lazy var close:UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage.init(named: "close"), for: .normal)
         btn.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        return btn
    }()
    lazy var titleLabel:UILabel = {
        let Lab = UILabel.init()
        Lab.textAlignment = NSTextAlignment.center
        Lab.font = UIFont.pingFangTextFont(size: 12)
        Lab.textColor = ColorGrayTitle
        return Lab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadData(Model: RaiseAnimalsModel){
        let petUrl = "\(Model.petImage ?? "")\(BottomQiuniuUrl)"
        
        self.imageV.kf.setImage(urlString: petUrl)
        
        self.titleLabel.text = Model.petNickName
        
    }
    
    func configUI() {
        
        contentView.addSubviews([backView,imageV,titleLabel,close])
        
        backView.frame = CGRect.init(x: 0, y: 0, width: (ScreenW - 15*4) / 3, height: 50)
        imageV.frame = CGRect.init(x: 5, y: 5, width: 40, height: 40)

        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(imageV.snp.right).offset(5)
            make.centerY.equalToSuperview()
            make.right.equalTo(-10)
            make.width.equalTo(20)
        }
        close.snp.makeConstraints { (make) in
            make.right.equalTo(16)
            make.top.equalTo(-8)
            make.width.height.equalTo(15)
        }
    }
  
    @objc private func closeAction(){
       self.PublishAnimalsCellCloseBlcok?()
    }
    
    
}
