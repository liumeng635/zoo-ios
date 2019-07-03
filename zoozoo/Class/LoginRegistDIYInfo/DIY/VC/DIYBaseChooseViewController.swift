//
//  DIYBaseChooseViewController.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/5/24.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit
import SwiftyJSON
import Qiniu

let DIYUPImageH = CGFloat.init(680/3)
let DIYUPImageW = CGFloat.init(750/3)
class DIYBaseChooseViewController: BaseViewController ,UIScrollViewDelegate{
    
    private var pageTitleView: SGPageTitleView? = nil
    private var pageContentCollectionView: SGPageContentCollectionView? = nil
    //背景
    lazy var topView:UIView = {
        let topView=UIView.init()
        return topView
    }()
    lazy var DIYImage:UIImageView = {
        let imageV = UIImageView.init()
        
        return imageV
    }()
    //动物皮肤/身体
    lazy var bodyimgaeView: UIImageView = {
        let bodyimgaeView=UIImageView.init()
       
        return bodyimgaeView
    }()
    //动物头饰
    lazy var hatimgaeView: UIImageView = {
        let hatimgaeView=UIImageView.init()
       
        return hatimgaeView
    }()
    //动物衣服
    lazy var clothesimgaeView: UIImageView = {
        let clothesimgaeView=UIImageView.init()
       
        return clothesimgaeView
    }()
    //动物表情
    lazy var expressionimgaeView: UIImageView = {
        let expressionimgaeView=UIImageView.init()
       
        return expressionimgaeView
    }()
    
    //透明底色
    lazy var backgroundimgaeView: UIImageView = {
        let imgaeView=UIImageView.init()
        imgaeView.image=UIImage(named: "circle")
        return imgaeView
    }()
    
    lazy var completebtn: UIButton = {
        let completebtn = UIButton.init()
        completebtn.setTitle("完成", for: .normal)
        completebtn.titleLabel?.font = UIFont.pingFangTextFont(size: 14)
        completebtn.setTitleColor(UIColor.white, for: .normal)
        completebtn.layer.cornerRadius = 15
        completebtn.layer.masksToBounds = true
        completebtn.setBackgroundColor(ColorDIYTopBtn, forState: .normal)
        completebtn.addTarget(self, action: #selector(gotoComplete), for: .touchUpInside)
        return completebtn
    }()
    

    lazy var introduceStroyBTN: UIButton = {
        let btn = UIButton.init()
        btn.setImage(UIImage.init(named: "StoryIntroduction"), for: .normal)
        btn.addTarget(self, action: #selector(gotoStory), for: .touchUpInside)
        return btn
    }()
    
    var UPDIYModel = UPDIYAnimalModel()
    var animalModel = AnimalModel()
    var PopDisabled = true
    var backColor = "#8330E1,#7DA8F7"
    init(PopDisabled :Bool ) {
        super.init(nibName: nil, bundle: nil)
        self.PopDisabled  = PopDisabled
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fd_prefersNavigationBarHidden = true
        
        configUI()
        setupSGPagingView()
    
        // 添加默认背景图层
        self.topView.addBackViewGradientLayer()
        
        if PopDisabled{
            self.interactivePopDisabled()
        }else{
            self.view.addSubview(back)
        }
        
        GetMainAnimalList()
    }
}

extension DIYBaseChooseViewController {
    //获取动物数据列表
    func GetMainAnimalList(){
        
        DIYAPI.shared.APPGetMainAnimalTypeConfigURL(success: { (json) in
            if let response = BaseAnimalModel.deserialize(from: json as? [String:Any]){
                if response.code == 200 {
                    self.animalModel = response.data.first ?? AnimalModel()
                    self.updateAnimalDIY(AnimalModel: self.animalModel)
                    BaseConfig.shared.AnimalType = 1
                    self.UPDIYModel.VoiceUrl = GlobalDataStore.shared.currentUser.petVoice
                }else{
                    ShowMessageTool.shared.showMessage("请求失败")
                }
            }
            
        }) { (error) in
            
        }
        
    }
}

extension DIYBaseChooseViewController {
    func configUI(){
        self.view.backgroundColor = UIColor.white
        self.view.addSubviews([topView,backgroundimgaeView,DIYImage,completebtn,introduceStroyBTN])

        DIYImage.addSubviews([bodyimgaeView,expressionimgaeView,clothesimgaeView,hatimgaeView])
       
        topView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(DIYBackHeight)
        }
        
        DIYImage.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(statusBarH + 40)
            make.height.equalTo(DIYImageHeight)
        }
        
        bodyimgaeView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        hatimgaeView.snp.makeConstraints { (make) in
           make.edges.equalToSuperview()
        }
        
        clothesimgaeView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        expressionimgaeView.snp.makeConstraints { (make) in
           make.edges.equalToSuperview()
        }
        
        completebtn.snp.makeConstraints { (make) in
            make.width.equalTo(60)
            make.height.equalTo(30)
            make.right.equalTo(-10)
            make.top.equalTo(statusBarH + 20)
        }
        
        introduceStroyBTN.snp.makeConstraints { (make) in
            make.width.height.equalTo(35)
            make.left.equalTo(20)
            make.top.equalTo(navigationBarHeight + 20)
        }
        
        backgroundimgaeView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(topView)
            make.height.equalTo(ScreenW*1.78)
        }
        
    }
    
    //动物选择DIY刷新视图
    func updateAnimalDIY(AnimalModel: AnimalModel){
       self.animalModel = AnimalModel
        BaseConfig.shared.AnimalType = AnimalModel.animalType ?? 1
        self.backColor = AnimalModel.background?.imgUrl ?? "#8330E1,#7DA8F7"
        self.topView.gradientStringDIYColor(colorsString :AnimalModel.background?.imgUrl ?? "")
        self.hatimgaeView.kf.setImage(urlString: AnimalModel.head?.imgUrl)
        self.hatimgaeView.shakeView(direction: .vertical, times: 2, interval: 0.06, offset: 2) {
        }
        self.bodyimgaeView.kf.setImage(urlString: AnimalModel.body?.imgUrl)
        self.clothesimgaeView.kf.setImage(urlString: AnimalModel.cloth?.imgUrl)
        self.expressionimgaeView.kf.setImage(urlString: AnimalModel.expression?.imgUrl)
        self.expressionimgaeView.shakeView(direction: .vertical, times: 2, interval: 0.06, offset: 2) {
        }
        
    }
}

extension DIYBaseChooseViewController{
    private func setupSGPagingView() {
        
        let titles = [ "配音","动物", "皮肤", "表情", "衣服", "配饰", "背景"]
        let DIYType  = [5,2,4,3,1,0]
        let configure = SGPageTitleViewConfigure()
        configure.indicatorStyle = .Dynamic
        configure.titleAdditionalWidth = 50
        configure.showBottomSeparator = false
        configure.titleColor = ColorSegmentTitle
        configure.titleSelectedColor = ColorOrange
        configure.indicatorColor = ColorOrange
        configure.titleFont = UIFont.pingFangTextFont(size: 14)
        configure.indicatorDynamicWidth = 50
        
        self.pageTitleView = SGPageTitleView(frame: CGRect(x: 0, y: DIYBackHeight, width: ScreenW, height: DIYSegmentH), delegate: self, titleNames: titles, configure: configure)
        self.pageTitleView?.backgroundColor = ColorBackGround
        view.addSubview(pageTitleView!)
        
        var childVCs: [UIViewController] = []
        
        let vc = DIYVoiceViewController.init()
        vc.delegateDIYVioceView = self
        childVCs.append(vc)

        for i in 0 ..< DIYType.count {
            let VC = DIYAnimalChooseViewController.init(animalType: BaseConfig.shared.AnimalType, DIYType: DIYType[i])
            VC.delegateDIYAnimalView = self
        
            childVCs.append(VC)
        }
        
        
        let contentViewHeight = ScreenH - DIYBackHeight - DIYSegmentH
        let contentRect = CGRect(x: 0, y: DIYBackHeight + DIYSegmentH, width: ScreenW, height: contentViewHeight)
        self.pageContentCollectionView = SGPageContentCollectionView(frame: contentRect, parentVC: self, childVCs: childVCs)
        
        pageContentCollectionView?.delegateCollectionView = self
        view.addSubview(pageContentCollectionView!)
    }
    
    
   
}

// MARK 上传资料，完成按钮事件
extension DIYBaseChooseViewController {
   
    @objc private func gotoStory(){
        
        guard let storyImage = self.animalModel.body?.storyImage else {
            ShowMessageTool.shared.showMessage("该动物还没有背景故事")
            return
        }
        let newImage = self.DIYImage.convertToImage().reSizeImage(reSize: CGSize.init(width: DIYUPImageW, height: DIYUPImageH))
        let view = PopImageView.init(imageUrl: storyImage, animalDIYImage: newImage)
        view.show()
    }
    @objc private func gotoComplete(){
        if GlobalDataStore.shared.currentUser.petVoice.isEmpty {
            if UPDIYModel.VoiceUrl.isEmpty && UPDIYModel.petVoicePath.isEmpty {
                ShowMessageTool.shared.showMessage("快去选择配音吧~")
                return
            }
        }

       
        let newImage = self.DIYImage.convertToImage().reSizeImage(reSize: CGSize.init(width: DIYUPImageW, height: DIYUPImageH))
        UPDIYModel.petImage = newImage
         UPDIYModel.animalType = BaseConfig.shared.AnimalType
        UPDIYModel.backImage = backColor
        UPDIYModel.storyImage = self.animalModel.body?.storyImage ?? ""
        let vc = ConfirmAnimalsViewController.init(PopDisabled: self.PopDisabled)
        vc.animalModel = UPDIYModel
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
   
  
}
//MARK: 更新DIY音频控件
extension DIYBaseChooseViewController : DIYVoiceViewDelegate{
    func getDIYPathVoice(isSourceURLPathVoice: Bool, Path: String) {
        if isSourceURLPathVoice{
            self.UPDIYModel.VoiceUrl = Path
        }else{
            self.UPDIYModel.petVoicePath = Path
        }
        
    }
    
}

//MARK: 更新动物视图控件
extension DIYBaseChooseViewController : DIYAnimalViewDelegate{
    func ChangeReloadDIYAnimalView(animalType: Int, DIYType: Int, AnimalModel: AnimalModel) {
        //0:背景，1:头饰 2：皮肤/身体，3：衣服，4：表情5.动物
        self.animalModel  = AnimalModel
        switch DIYType {
        case 0:
            
            if AnimalModel.imgUrl.isEmpty == true{
                self.topView.addBackViewGradientLayer()
               self.backColor = "#8330E1,#7DA8F7"
            }else{
                self.backColor = AnimalModel.imgUrl
                self.topView.gradientStringDIYColor(colorsString :AnimalModel.imgUrl)
            }
            break
        case 1:
            self.hatimgaeView.kf.setImage(urlString: AnimalModel.imgUrl)
            self.hatimgaeView.shakeView(direction: .vertical, times: 2, interval: 0.06, offset: 2) {
            }
            
            break
        case 2:
            self.bodyimgaeView.kf.setImage(urlString: AnimalModel.imgUrl)
            break
        case 3:
            self.clothesimgaeView.kf.setImage(urlString: AnimalModel.imgUrl)
            
            break
        case 4:
            
            self.expressionimgaeView.kf.setImage(urlString: AnimalModel.imgUrl)
            self.expressionimgaeView.shakeView(direction: .vertical, times: 2, interval: 0.06, offset: 2) {
            }
            break
        case 5:
            NotificationCenter.default.post(name: DIYAnimalNotification, object: nil,userInfo:["animalType":animalType])
            self.updateAnimalDIY(AnimalModel: AnimalModel)
            break
        default: break
            
        }
        
    }
}

// SGPageTitleViewDelegate  Delegate
extension DIYBaseChooseViewController: SGPageTitleViewDelegate, SGPageContentCollectionViewDelegate {
    func pageContentCollectionView(pageContentCollectionView: SGPageContentCollectionView, index: Int) {
        
    }
    func pageTitleView(pageTitleView: SGPageTitleView, index: Int) {
        pageContentCollectionView?.setPageContentCollectionView(index: index)
    }
    
    func pageContentCollectionView(pageContentCollectionView: SGPageContentCollectionView, progress: CGFloat, originalIndex: Int, targetIndex: Int) {
        pageTitleView?.setPageTitleView(progress: progress, originalIndex: originalIndex, targetIndex: targetIndex)
    }
}

