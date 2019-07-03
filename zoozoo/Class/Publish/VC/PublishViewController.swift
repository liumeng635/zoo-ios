//
//  PublishViewController.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/6/27.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit
import Photos
import Qiniu
import SwiftyJSON
class PublishViewController: BaseViewController {
    lazy var closeButton : UIButton = {
        let Btn = UIButton.init(type: .custom)
        Btn.setImage(UIImage.init(named: "ic_guanbi"), for: .normal)
        if #available(iOS 10.0, *) {
            Btn.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        }
        Btn.addTarget(self, action: #selector(closeItemBtnClick), for: .touchUpInside)
       
        return Btn
    }()
    
    lazy var UPButton : UIButton = {
        let Btn = UIButton.init(type: .custom)
        Btn.layer.cornerRadius  = 15
        Btn.layer.masksToBounds = true
        Btn.setTitle("上传", for: .normal)
        Btn.setTitleColor(ColorWhite, for: .normal)
        Btn.titleLabel?.font = UIFont.pingFangTextFont(size: 15)
        if #available(iOS 10.0, *) {
            Btn.frame = CGRect.init(x: 0, y: 0, width:60, height: 30)
        }
        Btn.addTarget(self, action: #selector(self.UPBtnClick), for: .touchUpInside)
       
        return Btn
    }()
    
    lazy  var table:UITableView = {
        
        let tableView = UITableView.init(frame: CGRect.zero, style: UITableView.Style.grouped)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.rowHeight          = UITableView.automaticDimension
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionFooterHeight   = 0
        tableView.estimatedSectionHeaderHeight   = 0
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.register(UPTextTableViewCell.self, forCellReuseIdentifier: "UPTextTableViewCell")
         tableView.register(XZBUPChoosePhotoCell.self, forCellReuseIdentifier: "XZBUPChoosePhotoCell")
         tableView.register(PublishAnimalsTableViewCell.self, forCellReuseIdentifier: "PublishAnimalsTableViewCell")
        return tableView
    }();
   
    fileprivate var content            : String = ""
    fileprivate var VideoURL            : String = ""
    fileprivate var isPhoto           : Bool = true
    fileprivate var imageArr = [UIImage]()      //存储图片数组
    fileprivate var imageKeyStr = ""    //存储图片KEY
    fileprivate var assetArr = [PHAsset]()      //存储图片资源信息数组
    fileprivate var CollectionNum            : CGFloat = 1
    fileprivate var videoScaleHW            : CGFloat = 1
    let uploadManage = QNUploadManager()
    var option : QNUploadOption!
    
    var dataArr = [RaiseAnimalsModel]()
    var type = RaiseType.feeding
    var isAll = false//是否是群体上传
    var animalsID           : String = ""
    var model = RaiseAnimalsModel()
    //单次喂养，出题，遛弯
    init(type :RaiseType ,model:RaiseAnimalsModel) {
        super.init(nibName: nil, bundle: nil)
        self.type  = type
        self.model  = model
        self.animalsID = model.userId ?? ""
    }
    //群体喂养，出题，遛弯
    init(type :RaiseType ,dataArr :[RaiseAnimalsModel]) {
        super.init(nibName: nil, bundle: nil)
        self.type  = type
        self.dataArr  = dataArr
        self.isAll  = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutViews()
    }
    //MARK:初始化视图
    fileprivate func layoutViews(){
        self.view.backgroundColor = .white
        self.view.addSubview(table)
        self.automaticallyAdjustsScrollViewInsets = false
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: UPButton)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: closeButton)
        
        table.snp.makeConstraints { (make) in
            make.top.equalTo(navigationBarHeight)
            make.left.right.equalToSuperview()
            make.bottom.equalTo( -SafeBottomMargin )
        }
        updateBottonUI()
    }
    
    func updateBottonUI(){
        UPButton.addButtonGradientLayer()
        if !self.isAll {
            switch self.type {
            case .feeding:
                self.title = "喂养小乖兽"
                UPButton.setTitle("喂养", for: .normal)
            case .play:
                self.title = "带小乖兽遛弯"
                UPButton.setTitle("遛弯", for: .normal)
            case .education:
                self.title = "带小乖兽学习"
                UPButton.setTitle("出题", for: .normal)
            }
        }else{
            UPButton.setTitle("上传", for: .normal)
            switch self.type {
            case .feeding:
                self.title = "群体喂养"
                
            case .play:
                self.title = "群体遛弯"
                
            case .education:
                self.title = "群体出题"
                
            }
        }
    }


}
//MARK:UITableViewDataSource
extension PublishViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if  indexPath.row == 0 {
            return 120
        }else if indexPath.row == 1 {
            if self.imageArr.count == 9 ||  self.imageArr.count == 5 || self.imageArr.count == 2 || self.imageArr.count == 8{
                return ((itemWH + 6)*CollectionNum - 6 + 40 + 30)
            }
            return ((itemWH + 6)*(CollectionNum + 1) - 6 + 40 + 30)
        }else{
            return 300
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UPTextTableViewCell", for: indexPath) as! UPTextTableViewCell
            self.handleUptextCell(cell: cell)//动态内容输入框业务逻辑处理
            
            return cell
        }else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "XZBUPChoosePhotoCell", for: indexPath) as! XZBUPChoosePhotoCell
            cell.selectionStyle = .none
            self.handlePhotoCell(cell: cell)//图片选择业务逻辑处理
            cell.selectedPhotos = NSMutableArray.init(array: self.imageArr)
            cell.selectedAssets = NSMutableArray.init(array: self.assetArr)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "PublishAnimalsTableViewCell", for: indexPath) as! PublishAnimalsTableViewCell
            cell.reloadUI(dataArr: self.dataArr, type: self.type,isAll :self.isAll)
            cell.selectTopicBlock = {[unowned self] (animalsID) in
                self.animalsID = animalsID
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        NotificationCenter.default.post(name: ResignFirstResponderNotification, object: nil,userInfo:nil)
    }
    
    
}
//MARK:UITableViewDelegate
extension PublishViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != 1 {
            self.regesture()
        }
        
    }
}
extension PublishViewController {
    //MARK 处理图片、视频选择逻辑
    private func handlePhotoCell(cell:XZBUPChoosePhotoCell){
       
        switch self.type {
        case .feeding:
            cell.upType = "publishAdd1"
        case .play:
            cell.upType = "publishAdd2"
        case .education:
            cell.upType = "publishAdd3"
        }

        cell.photosSelectedBlock = {[unowned self] (photosArr,assetsArr) in
            self.isPhoto = true
            self.imageArr.removeAll()
            self.assetArr.removeAll()
            //图片信息资源
            assetsArr?.forEach({ (asset) in
                self.assetArr.append(asset as! PHAsset)
            })
            photosArr?.forEach({ (image) in
                self.imageArr.append(image as! UIImage)
            })
            
            self.CollectionNum = CGFloat.init((self.imageArr.count + 1) / 3)
            self.table.reloadData()
        }
       
    }
    
    //MARK 处理动态内容逻辑
    private func handleUptextCell(cell:UPTextTableViewCell){
        cell.sendContentBlock = {[weak self] (contentStr) in
            self?.content = contentStr
        }
        
    }
    
    func getType() -> Int{
        //：0普通 1一键喂食 2一键遛弯 3一键教育; 4撒娇 5上传 6提问 7回答问题 8灰体消息 9喂食 10遛弯 11教育 12评论 13点赞 14回复 15早安 16晚安
        var num = 1
        switch self.type {
        case .feeding:
            num = 9
        case .play:
            num = 10
        case .education:
            num = 11
        }
        return num
    }
    
}

extension PublishViewController {
    //MARK:上传按钮点击事件
    @objc private func UPBtnClick(){
        if self.imageArr.count == 0 {
            ShowMessageTool.shared.showMessage("请至少上传一张图片吧~")
            return
        }
        if self.content.clearBlankString().isEmpty {
            self.publishToserver()
            self.UPButton.isEnabled = false  //禁用发布按钮
            self.perform(#selector(self.changeButtonStatus), with: nil, afterDelay: 5.0)
        }else{
             self.sensitiveWordsFiltering(content: self.content)
        }
      
       
    }
    //MARK: 敏感词汇过滤
    fileprivate func sensitiveWordsFiltering(content:String){
        BaseAPI.shared.APPSensitiveWordURL(word: content, success: { (json) in
            let dic = json as? NSDictionary
            let code = dic?.object(forKey: "code") as? Int
            if code == 200 {
                self.publishToserver()
                self.UPButton.isEnabled = false  //禁用发布按钮
                self.perform(#selector(self.changeButtonStatus), with: nil, afterDelay: 5.0)
            }else{
                ShowMessageTool.shared.showMessage("您输入的内容含有敏感词")
                
            }
        }) { (error) in
            
        }
    }
    
    // MARK:发布动态到服务端
    private func publishToserver(){
        let group = DispatchGroup()
        let queue = DispatchQueue(label: "uploadQueue", attributes: .concurrent)
        queue.async(group: group){
            //上传图片到七牛云上
            self.imageKeyStr = ""
            for img in self.imageArr {
                let imgkey = UUID().uuidString + ".png"
                let imgkeyUrl = BaseImageURL + imgkey
                self.imageKeyStr.append(imgkeyUrl)
                self.imageKeyStr.append(",")
                self.GetAPPQiNiuTokenUpImage(img, imgkey)
            }
            self.imageKeyStr.removeLast()
        }
        group.notify(queue: queue){
             let paramDic = NSMutableDictionary.init()
            paramDic.setValue(self.animalsID, forKey: "beUserIds")
            paramDic.setValue(self.getType(), forKey: "msgType")
            paramDic.setValue(self.content, forKey: "content")
            paramDic.setValue(self.imageKeyStr, forKey: "imgUrl")
            ChatRoomAPI.shared.APPChatRoomMessagePublishURL(parameter: paramDic, success: { (json) in
                let dic = json as? NSDictionary
                let code = dic?.object(forKey: "code") as? Int
                if code == 200 {
                    self.dismiss(animated: true, completion: nil)
                    PublishTipsView.init(type: self.type, isNomal: true).show()
                }else{
                    self.publishError()
                }
            }, failure: { (error) in
                self.publishError()
            })
        }
    }
    
    func publishError(){
        switch self.type {
        case .feeding:
            ShowMessageTool.shared.showMessage("哎呀，喂食失败")
        case .play:
            ShowMessageTool.shared.showMessage("哎呀，遛弯失败")
        case .education:
            ShowMessageTool.shared.showMessage("哎呀，出题失败")
        }
    }
    
    // MARK: - 上传DIY形象图片
    func GetAPPQiNiuTokenUpImage(_ img :UIImage,_ imgkey :String){
        
        let urlStr = BaseUrlPath + RequestGetPublicTokenUrl
        
        HttpTool.getRequest(urlPath: urlStr, parameters: nil, success: { (json) in
            let dic = JSON(json)
            if dic["code"] == 200 {
                if let Token = dic["data"].string {
                    let imageData = img.pngData()
                    //上传处理
                    self.uploadManage?.put(imageData!, key: imgkey, token:Token, complete: { (info, key, resp) in
                        if info?.statusCode != 200 {
                            ShowMessageTool.shared.showMessage("图片上传失败")
                            
                        }
                       
                    }, option: self.option)
                }
                
            }else{
                ShowMessageTool.shared.showMessage("图片上传失败")
            }
        }) { (error) in
            ShowMessageTool.shared.showMessage("图片上传失败")
        }
        
        
    }
    //MARK:取消事件
    @objc private func closeItemBtnClick(){
        self.view.endEditing(true)
        if isAll {
            let view = AlertShowSureOrCancleView.init(showType: .nomal)
            view.sureAlertClickBlock = {
                self.dismiss(animated: true, completion: nil)
            }
            view.show()
        }else{
            let view = PublishCloseTipsView.init(type: type, model: model)
            view.PublishCloseOutBlcok = {
                self.dismiss(animated: true, completion: nil)
            }
            view.show()
        }
        
        
        
    }
    
    //MARK:发布成功后跳转到首页
    @objc private func publishSunccess(){
//        if self.VideoURL.length != 0 {//删除导入到沙盒里的视频
//            YNBaseEngine.shared.deleteFile(filePath: self.VideoURL)
//        }
//        Router.shared.push(route: .index)
    }
    @objc private func changeButtonStatus(){
        self.UPButton.isEnabled = true
    }
    //MARK:键盘收回通知事件
    @objc private func regesture(){
        NotificationCenter.default.post(name: ResignFirstResponderNotification, object: nil,userInfo:nil)
    }
}
