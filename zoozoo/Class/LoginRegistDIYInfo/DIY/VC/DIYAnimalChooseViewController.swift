//
//  DIYAnimalChooseViewController.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/5/24.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit


@objc protocol DIYAnimalViewDelegate: NSObjectProtocol {
    /**
     *  联动 DIYAnimalView 的方法
     *
     *  @param DIYType     //0:背景，1:头饰 2：皮肤/身体，3：衣服，4：表情
     *  @param animalType            选择动物更换
     *  @param DIY类型视图的数据Model       AnimalModel
     */
    @objc optional func ChangeReloadDIYAnimalView(animalType: Int, DIYType: Int ,  AnimalModel: AnimalModel)
    
}
class DIYAnimalChooseViewController: BaseViewController,UICollectionViewDataSource, UICollectionViewDelegate {
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width:Voicecollection, height: Voicecollection)
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        layout.scrollDirection = .vertical
        
        layout.sectionInset = UIEdgeInsets.init(top: 15, left: 15, bottom: 15, right: 15)
        
        let collection  = UICollectionView.init(frame: CGRect(x:0, y:0, width:ScreenW, height:ScreenH-DIYBackHeight-DIYSegmentH), collectionViewLayout: layout)
        collection.backgroundColor = ColorBackGround
        collection.delegate = self
        collection.dataSource = self
        collection.isScrollEnabled = true
        /// 滚动指示条
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        
        collection.register(DIYAnimalCell.self, forCellWithReuseIdentifier: Identifier)
        return collection
    }()
    
    weak var delegateDIYAnimalView: DIYAnimalViewDelegate?
    let Identifier       = "DIYAnimalCell"
    var dataArr = [AnimalModel]()
    var animalType = 1//对应动物的类型，狮子，熊等
    var DIYType = 1 //对应皮肤，表情，衣服，配饰，背景等
    init(animalType: Int , DIYType: Int) {
        super.init(nibName: nil, bundle: nil)
        self.animalType = animalType
        self.DIYType = DIYType
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ColorBackGround
        
        self.view.addSubview(collectionView)
        self.animalType = BaseConfig.shared.AnimalType
        
        if DIYType == 5{
            GetMainAnimalList()
        }else{
            GetDIYTypeAnimalList()
            NotificationCenter.default.addObserver(self, selector: #selector(ReloadData(notif:)), name: DIYAnimalNotification, object: nil)
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:DIYAnimalCell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier, for: indexPath) as! DIYAnimalCell
        cell.loadData(type: DIYType, model: self.dataArr[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.dataArr.forEach({ (voice) in
            voice.isSelected = false
        })
        let model = self.dataArr[indexPath.row]
        model.isSelected = true
        self.collectionView.reloadData()
        self.animalType = model.animalType ?? 1
        delegateDIYAnimalView?.ChangeReloadDIYAnimalView?(animalType: animalType, DIYType: DIYType, AnimalModel: self.dataArr[indexPath.row])
        
    }
    
    deinit {
        
        NotificationCenter.default.removeObserver(self)
    }
    
    
}

//MARK:数据请求
extension DIYAnimalChooseViewController {
    //获取动物数据列表
    func GetMainAnimalList(){
        
        DIYAPI.shared.APPGetMainAnimalTypeConfigURL(success: { (json) in
            if let response = BaseAnimalModel.deserialize(from: json as? [String:Any]){
                if response.code == 200 {
                    self.dataArr = response.data
                    self.dataArr.first?.isSelected = true
                    self.collectionView.reloadData()
                }else{
                    ShowMessageTool.shared.showMessage("请求失败")
                }
            }
            
        }) { (error) in
            
        }
        
    }
    //获取 DIYType//0:背景，1:头饰 2：皮肤/身体，3：衣服，4：表情 数据列表,5动物
    func GetDIYTypeAnimalList(){
        
        DIYAPI.shared.APPGetBodyConfigsURL(animalType: animalType, type: DIYType, success: { (json) in
            if let response = BaseAnimalModel.deserialize(from: json as? [String:Any]){
                if response.code == 200 {
                    self.dataArr = response.data
                    self.dataArr.first?.isSelected = true
                    self.collectionView.reloadData()
                }else{
                    ShowMessageTool.shared.showMessage("请求失败")
                }
            }
        }) { (error) in
            
        }
        
    }
    
    // MARK:更换动物后的刷新
    @objc private func ReloadData(notif: NSNotification){
        
        guard let type = notif.userInfo!["animalType"] as? Int else { return  }
      
        self.animalType = type
        BaseConfig.shared.AnimalType = type
        self.GetDIYTypeAnimalList()
    }
    
}





class DIYAnimalCell: UICollectionViewCell {
    
    lazy var chooseImageView:UIImageView = {
        let ImageView  = UIImageView.init()
        ImageView.image = UIImage.init(named: "Selectedanimals")
        ImageView.isHidden = true
        return ImageView
    }()
    lazy var topImageView:UIImageView = {
        let ImageView  = UIImageView.init()
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
        self.contentView.addSubview(topImageView)
        self.contentView.addSubview(chooseImageView)
        
        self.contentView.backgroundColor = ColorWhite
        self.contentView.layer.cornerRadius = 5
        self.contentView.layer.masksToBounds = true
        
        topImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        chooseImageView.snp.makeConstraints { (make) in
            make.top.equalTo(5)
            make.right.equalTo(-5)
            make.width.height.equalTo(15)
        }
        
    }
    
    func loadData(type : Int,model :AnimalModel){
        chooseImageView.isHidden = !(model.isSelected)
        if type == 5{
            topImageView.kf.setImage(urlString: model.imgUrl)
        }else{
            topImageView.kf.setImage(urlString: model.thumbImageUrl)
            
        }
    }
    
    public var model:AnimalModel? {
        didSet{
            guard let _ = model else {
                return
            }
            
            
            topImageView.kf.setImage(urlString: model?.thumbImageUrl)
            
            
            chooseImageView.isHidden = !(model?.isSelected ?? true)
            
        }
    }
    
    
}
