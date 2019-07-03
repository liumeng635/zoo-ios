//
//  PetAnimalsImageViewController.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/6/14.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit
import Kingfisher
class PetAnimalsImageViewController: BaseViewController {
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame:  CGRect.init(x: 0, y: navigationBarHeight, width: ScreenW, height: ScreenH - navigationBarHeight), collectionViewLayout: layout)
        collection.backgroundColor = .white
        collection.delegate = self
        collection.dataSource = self
        collection.isScrollEnabled = true
        collection.showsHorizontalScrollIndicator = false
        /// 注册
        collection.register(PetAnimalsImageListCell.self, forCellWithReuseIdentifier: "PetAnimalsImageListCell")
        return collection
    }()
    lazy  var noDataView:LikesNoDataView = {
        let noDataView =  LikesNoDataView.init()
        noDataView.isHidden = true
        return noDataView
    }();
    lazy var rightButton : UIButton = {
        
        let Btn = UIButton.init(type: .custom)
        let backImage = UIImage.init(named: "question")!
        Btn.setImage(backImage, for: .normal)
        Btn.frame = CGRect.init(x: 15, y: statusBarH + 15, width: backImage.size.width, height: backImage.size.height)
        Btn.contentHorizontalAlignment = .right
        Btn.addTarget(self, action: #selector(rightClcik), for: .touchUpInside)
        return Btn
        
    }()
    lazy var sureBtn:UIButton = {
        let Btn = UIButton.init(type: .custom)
        Btn.titleLabel?.font = UIFont.pingFangTextFont(size: 16)
        Btn.layer.cornerRadius = 30
        Btn.layer.masksToBounds = true
        Btn.setTitle("兑换", for: .normal)
        Btn.setTitleColor(ColorGrayColor, for: .normal)
        Btn.frame = CGRect.init(x: 50, y: ScreenH - SafeBottomMargin - 100, width: ScreenW - 100, height: 60)
        Btn.addTarget(self, action: #selector(self.gotoChange), for: .touchUpInside)
        Btn.backgroundColor = ColorLine
        
        return Btn
    }()
    
    var page = 1
    var isMine = true//是否为主人状态页面
    var dataArr = [HandbookModel]()
    var userID = ""
    var noDataType = LikesNoDataType.mineAnimalStore
    init(userID :String,isMine :Bool) {
        super.init(nibName: nil, bundle: nil)
        self.userID  = userID
        self.isMine  = isMine
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configTitleUI()
        configNoDataView()
        loadData()
        refeshData()
        loadMoreData()
        
    }
    func configNoDataView(){
        noDataView = LikesNoDataView.init(type: self.noDataType, frame: self.collection.frame)
        noDataView.isHidden = true
        self.view.addSubview(noDataView)
    }
    
    
    func configTitleUI(){
        if isMine {
            self.title = "乖兽图鉴"
            self.noDataType = .mineAnimalStore
        }else{
            self.title = "TA的乖兽图鉴"
            self.noDataType = .personAnimalStore
        }
        view.addSubview(collection)
         self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
        view.addSubview(sureBtn)
        sureBtn.isHidden = true
//        sureBtn.addButtonGradientLayer()
    }
    
    
}
extension PetAnimalsImageViewController {
    //  MARK:加载更多
    func loadMoreData(){
        self.collection.ZFoot = RefreshDiscoverFooter{[weak self] in
            guard let self = self else {
                return
            }
            self.loadData()
        }
    }
    func refeshData(){
        self.collection.ZHead = RefreshHeader{[weak self] in
            guard let self = self else {
                return
            }
            self.page = 1
            self.loadData()
        }
    }
    func loadData(){
       
        PersonalAPI.shared.APPUserAdoptHandbookURL(beUserId: userID, type: 999, pageIndex: page, success: { (json) in
            if let response = AdoptHandbookModel.deserialize(from: json as? [String:Any]){
                if  response.code == 200{
                    let array = response.data
                    if self.page == 1 {
                        self.dataArr.removeAll()
                    }
                    self.dataArr += array
                    if array.count == 0 {
                        
                        self.collection.ZFoot?.endRefreshingWithNoMoreData()
                    }else{
                        self.page += 1
                        self.collection.ZFoot?.endRefreshing()
                        if array.count < 10 {
                            self.collection.ZFoot?.endRefreshingWithNoMoreData()
                        }
                    }
                    self.collection.ZHead?.endRefreshing()
                    
                    self.noDataView.isHidden = self.dataArr.count > 0
                    
                    self.collection.isHidden = false
                    self.sureBtn.isHidden = false
                    self.collection.reloadData()
                    
                }else{
                    self.noDataView.isHidden = false
                    self.collection.ZHead?.endRefreshing()
                    self.collection.ZFoot?.endRefreshing()
                }
            }
            
        }) { (error) in
            self.collection.ZHead?.endRefreshing()
            self.collection.ZFoot?.endRefreshing()
        }
        
    }
}
extension PetAnimalsImageViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return self.dataArr.count > 0 ? self.dataArr.count + 1 :  self.dataArr.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (ScreenW - 15*4) / 3
        let height = width * 1.6
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PetAnimalsImageListCell", for: indexPath) as! PetAnimalsImageListCell
        if indexPath.row == 0  {
            cell.AddImageView.isHidden = false
             cell.cardView.isHidden = true
            
        }else{
            cell.model = self.dataArr[indexPath.row - 1]
        }
       
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == 0  {
           AlertAnimalChooseView.init().show()
            
        }else{
            
            if self.dataArr.count == 0 {
                return
            }
            let model = self.dataArr[indexPath.row - 1]
            var type = PetAnimalCardType.mineHaveAnimal
      
            if isMine{
                //是否养成 0即将养成 1已养成
                if model.isDevelop == 0 {
                    type = .mineWillAnimal
                }else{
                    type = .mineHaveAnimal
                }
            }else{
                type = .personAnimal
            }
            
            let view = PetAnimalCardChooseView.init(Model: model, type: type)
            view.show()
            
        }
    }



}
extension PetAnimalsImageViewController {
    @objc private func rightClcik(){
        let VC = WordViewController.init(nameTitle: "玩法说明")
        self.navigationController?.pushViewController(VC, animated: true)
        
    }
    @objc private func gotoChange(){
       
         SystemTipsView.init(title: "未达到兑换要求", deTitle: "当你集齐某种动物下的12星座\n  就可兑换一份嗅嗅大礼", H: 120).show()
    }

}

class PetAnimalsImageListCell: UICollectionViewCell {
    lazy var AddImageView: UIImageView = {
        let imageView=UIImageView.init()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 5.0
        imageView.layer.masksToBounds = true
        imageView.image = UIImage.init(named: "animalsAdd")
        return imageView
    }()
    let cardView = petAnimalCardView.init()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configUI() {
        contentView.layer.cornerRadius = 5.0
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .white
        contentView.addSubview(AddImageView)
        contentView.addSubview(cardView)
       
        AddImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        cardView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
       
    }

    var model: HandbookModel? {
        didSet {
            guard let model = model else { return }
            AddImageView.isHidden = true
            cardView.isHidden = false
            cardView.model = model
        }
    }

    @objc private func closeClickAction(sender:UIButton){
       
    }
    
}

class petAnimalCardView: UIView {
    lazy var BackImageView: UIImageView = {
        let imageView=UIImageView.init()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 5.0
        imageView.layer.masksToBounds = true
        imageView.image = UIImage.init(named: "animalsImageBack")
        return imageView
    }()
    lazy var constellation:UIImageView = {
        let imageV = UIImageView.init()
        return imageV
    }()
    lazy var bodyimgaeView: UIImageView = {
        let bodyimageView=UIImageView.init()
        bodyimageView.contentMode = .scaleAspectFit
        return bodyimageView
    }()
    lazy var baseBottom: UIImageView = {
        let baseBottom=UIImageView.init()
        
        baseBottom.image = UIImage.init(named: "yinying")
        return baseBottom
    }()
    lazy var developBodyimgaeView: UIImageView = {
        let bodyimageView=UIImageView.init()
        bodyimageView.contentMode = .scaleAspectFit
        return bodyimageView
    }()
    
    
    lazy var nameLab:UILabel = {
        let Lab = UILabel.init()
        Lab.textAlignment = NSTextAlignment.center
        Lab.font = UIFont.pingFangTextFont(size: 12)
        Lab.textColor = ColorWhite
        
        return Lab
    }()
    lazy var timeLab:UILabel = {
        let Lab = UILabel.init()
        Lab.textAlignment = NSTextAlignment.center
        Lab.font = UIFont.pingFangTextFont(size: 10)
        Lab.textColor = ColorWhite
        return Lab
    }()
    lazy var nameButton:UIButton = {
        let Btn = UIButton.init(type: UIButton.ButtonType.custom)
        Btn.setTitleColor(ColorWhite, for: .normal)
        Btn.titleLabel?.font = UIFont.pingFangTextFont(size: 10)
        Btn.layer.cornerRadius = 7.5
        Btn.layer.masksToBounds = true
        return Btn
    }()
    lazy var blueView:UIView = {
        let blueView = UIView.init()
        blueView.layer.cornerRadius = 10
        blueView.layer.masksToBounds = true
        blueView.isHidden = true
        return blueView
    }()
    
    lazy var currentLab:UILabel = {
        let Lab = UILabel.init()
        Lab.textAlignment = NSTextAlignment.right
        Lab.font = UIFont.pingFangTextFont(size: 10)
        Lab.textColor = ColorWhite
        Lab.text = "当前"
        return Lab
    }()
    lazy var charm:UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "charm")
        return imageV
    }()
    lazy var numLab:UILabel = {
        let Lab = UILabel.init()
        Lab.textAlignment = NSTextAlignment.left
        Lab.font = UIFont.pingFangTextFont(size: 10)
        Lab.textColor = ColorWhite
        return Lab
    }()
    var type  = 0
    init(type :Int ,frame: CGRect) {
        super.init(frame: frame)
        configCardUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configCardUI() {
        self.addSubview(BackImageView)
        BackImageView.addSubviews([bodyimgaeView,developBodyimgaeView,baseBottom,constellation,nameButton,nameLab,timeLab,blueView])
        bodyimgaeView.addSubview(developBodyimgaeView)
        
        blueView.addSubviews([currentLab,charm,numLab])
        
        layoutCardUI()
        BackImageView.layer.cornerRadius = 10.0
        BackImageView.layer.masksToBounds = true
        nameButton.layer.cornerRadius = 13.0
        nameButton.layer.masksToBounds = true
        nameButton.titleLabel?.font = UIFont.pingFangTextFont(size: 14)
        currentLab.font = UIFont.pingFangTextFont(size: 17)
        blueView.layer.cornerRadius = 15
        
        nameLab.font = UIFont.pingFangTextFont(size: 17)
        timeLab.font = UIFont.pingFangTextFont(size: 17)
        numLab.font = UIFont.pingFangTextFont(size: 17)
    }
    func configUI() {

       
        self.addSubview(BackImageView)
        BackImageView.addSubviews([bodyimgaeView,developBodyimgaeView,baseBottom,constellation,nameButton,nameLab,timeLab,blueView])
        bodyimgaeView.addSubview(developBodyimgaeView)
        
        blueView.addSubviews([currentLab,charm,numLab])
        layoutUI()
    }
     func layoutCardUI() {
        BackImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        constellation.snp.makeConstraints { (make) in
            make.top.left.equalTo(15)
            make.width.height.equalTo(25)
        }
        nameButton.snp.makeConstraints { (make) in
            make.top.equalTo(15)
            make.right.equalTo(10)
            make.width.equalTo(75)
            make.height.equalTo(26)
        }
        
        let bodyImageW = ScreenW - 200*ScaleW
        bodyimgaeView.snp.makeConstraints { (make) in
            
            make.top.equalTo(15)
            make.centerX.equalToSuperview()
            make.width.equalTo(bodyImageW)
            make.height.equalTo(bodyImageW/1.1)
        }
        developBodyimgaeView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        baseBottom.snp.makeConstraints { (make) in
            
            make.centerX.equalToSuperview()
            make.height.equalTo(12)
            make.width.equalTo(80)
            make.bottom.equalTo(-100)
        }
        timeLab.snp.makeConstraints { (make) in
            make.bottom.equalTo(-15)
            make.left.equalTo(5)
            make.right.equalTo(-5)
            make.height.equalTo(25)
        }
        
        nameLab.snp.makeConstraints { (make) in
            make.bottom.equalTo(-50)
            make.left.equalTo(5)
            make.right.equalTo(-5)
            make.height.equalTo(25)
        }
        
        blueView.snp.makeConstraints { (make) in
            make.bottom.equalTo(-15)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(30)
        }
        charm.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.width.equalTo(15)
        }
        currentLab.snp.makeConstraints { (make) in
            make.right.equalTo(charm.snp.left).offset(-5)
            make.centerY.equalToSuperview()
            make.height.equalTo(25)
        }
        numLab.snp.makeConstraints { (make) in
            make.left.equalTo(charm.snp.right).offset(5)
            make.centerY.equalToSuperview()
            make.height.equalTo(25)
        }
        
    }
    
    func layoutUI() {
        
        BackImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        constellation.snp.makeConstraints { (make) in
            make.top.left.equalTo(5)
            make.width.height.equalTo(15)
        }
        nameButton.snp.makeConstraints { (make) in
            make.top.equalTo(5)
            make.right.equalTo(5)
            make.width.equalTo(50)
            make.height.equalTo(15)
        }
        
        let bodyImageW = (ScreenW - 15*4) / 3
        bodyimgaeView.snp.makeConstraints { (make) in
            
            make.top.equalTo(5)
            make.centerX.equalToSuperview()
            make.width.equalTo(bodyImageW)
            make.height.equalTo(bodyImageW/1.1)
        }
        developBodyimgaeView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        baseBottom.snp.makeConstraints { (make) in
            
            make.centerX.equalToSuperview()
            make.height.equalTo(8)
            make.width.equalTo(60)
            make.bottom.equalTo(-60)
        }
        timeLab.snp.makeConstraints { (make) in
            make.bottom.equalTo(-5)
            make.left.equalTo(5)
            make.right.equalTo(-5)
            make.height.equalTo(20)
        }
        
        nameLab.snp.makeConstraints { (make) in
            make.bottom.equalTo(-35)
            make.left.equalTo(5)
            make.right.equalTo(-5)
            make.height.equalTo(15)
        }
        
        blueView.snp.makeConstraints { (make) in
            make.bottom.equalTo(-10)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(20)
        }
        charm.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.width.equalTo(10)
        }
        currentLab.snp.makeConstraints { (make) in
            make.right.equalTo(charm.snp.left).offset(-5)
            make.centerY.equalToSuperview()
            make.height.equalTo(15)
        }
        numLab.snp.makeConstraints { (make) in
            make.left.equalTo(charm.snp.right).offset(5)
            make.centerY.equalToSuperview()
            make.height.equalTo(15)
        }
    }
    
    
    
    var model: HandbookModel? {
        didSet {
            guard let model = model else { return }
            
            BackImageView.isHidden = false
            
            if model.isDevelop == 1 {
                blueView.isHidden = true
                timeLab.isHidden = false
                developBodyimgaeView.isHidden = true
               
                timeLab.text = "\(model.developTime ?? "")获得"
                bodyimgaeView.kf.setImage(urlString: model.petImage)
            }else{
                blueView.isHidden = false
                timeLab.isHidden = true
                numLab.text = "\(model.closeDeg ?? 0)"
                blueView.addGradientLayer(colors: [UIColor.colorWithHex(hex: 0x44CCC0).cgColor, UIColor.colorWithHex(hex: 0x6FE8CC).cgColor])
                
                self.developBodyimgaeView.isHidden = false
                
                self.developBodyimgaeView.kf.setImage(with: URL(string: model.petImage?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""), placeholder: nil, options: [KingfisherOptionsInfoItem.forceRefresh], progressBlock: nil, completionHandler: { (image, error, CacheType, url) in
                    let newImage = self.developBodyimgaeView.convertToImage().render(color: ColorNoAnimalColor)
                    self.bodyimgaeView.isHidden = false
                    self.developBodyimgaeView.isHidden = true
                    self.bodyimgaeView.image = newImage
                })
                
            }
            constellation.image = UIImage.init(named: "Z\(model.constellation ?? "金牛座")")
            nameButton.setTitle(model.animalName, for: .normal)
            nameButton.addGradientLayer(colors: [UIColor.colorWithHex(hex: 0xAB49FF).cgColor, UIColor.colorWithHex(hex: 0x1FE2FF).cgColor])
            nameLab.text = model.petNickname
            
            
        }
    }

}
