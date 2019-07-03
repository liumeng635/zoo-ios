//
//  ConfirmAnimalsViewController.swift
//  zoozoo
//
//  Created by 你猜 on 2019/5/21.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import TransitionButton
import Qiniu
import SwiftyJSON
class ConfirmAnimalsViewController: BaseViewController {
    
    
    //透明底色
    lazy var backgroundimgaeView: UIImageView = {
        let imgaeView=UIImageView.init()
        imgaeView.image=UIImage(named: "circle")
        return imgaeView
    }()
    
    lazy var nameLabel:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.pingFangTextFont(size: 16)
        label.textColor = ColorWhite
        label.text = "给它起个名字"
        return label
    }()
    
    lazy var bodyimgaeView: UIImageView = {
        let bodyimgaeView=UIImageView.init()
        return bodyimgaeView
    }()

    
    lazy var introduceStroyBTN: UIButton = {
        let btn = UIButton.init()
        btn.setImage(UIImage.init(named: "StoryIntroduction"), for: .normal)
        btn.addTarget(self, action: #selector(gotoStory), for: .touchUpInside)
        return btn
    }()
    
    lazy var nameView:UIView = {
        let View = UIView.init()
        View.backgroundColor = .white
        View.layer.cornerRadius  = 30
        View.layer.masksToBounds = true
        return View
    }()
    
    lazy var nameTextField : UITextField = {
        
        let text = UITextField()
    
        text.font = UIFont.pingFangTextFont(size: 14)
        text.textColor = ColorBlackTitle
        text.returnKeyType = .done
        text.keyboardType = .default
        text.clearButtonMode = .whileEditing
        text.delegate = self
        text.textAlignment = NSTextAlignment.justified
        let placeholserAttributes = [NSAttributedString.Key.foregroundColor : ColorLightTitleColor, NSAttributedString.Key.font : UIFont.pingFangTextFont(size: 14)]
        
        text.attributedPlaceholder = NSAttributedString(string: "给它起个名字",attributes: placeholserAttributes as [NSAttributedString.Key : Any])
        
        return text
    }()
    
    lazy var warningLabel:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.pingFangTextFont(size: 10)
        label.textColor = ColorWhite
        label.text = ""
        return label
    }()
    
    lazy var RandomBtn:XZBUIButtonExt = {
        let Btn = XZBUIButtonExt.init(type: .custom)
        Btn.titleLabel?.font = UIFont.pingFangTextFont(size: 10)
        Btn.setTitle("随机", for: .normal)
        Btn.setTitleColor(ColorWhite, for: .normal)
        Btn.setImage(UIImage.init(named: "RandomSwitching"), for: .normal)
        Btn.addTarget(self, action: #selector(self.RandomAction), for: .touchUpInside)
        return Btn
    }()
    
    lazy var sureBtn:TransitionButton = {
        let Btn = TransitionButton.init(type: .custom)
        Btn.spinnerColor = .white
        Btn.titleLabel?.font = UIFont.pingFangTextFont(size: 16)
        Btn.cornerRadius = 30
        Btn.setTitle("确定", for: .normal)
        Btn.setTitleColor(ColorWhite, for: .normal)
        Btn.setTitleColor(ColorWhite, for: .disabled)
        Btn.addTarget(self, action: #selector(self.gotoUP), for: .touchUpInside)
        return Btn
    }()
    let uploadManage = QNUploadManager()
    var option : QNUploadOption!

    var DIYImage = ""
    var DIYVoice = ""
   
    public var animalModel = UPDIYAnimalModel()
    
    var keyboardHeight:CGFloat = 0
    var PopDisabled = true
    
    init(PopDisabled :Bool ) {
        super.init(nibName: nil, bundle: nil)
        self.PopDisabled  = PopDisabled
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fd_prefersNavigationBarHidden = true
         createLayoutUI()
        if animalModel.backImage.isEmpty{
            view.addBackViewGradientLayer()
        }else{
              view.gradientStringDIYColor(colorsString :animalModel.backImage)
        }
     
        bodyimgaeView.image = animalModel.petImage

        sureBtn.addButtonGradientLayer()
        addKeyBoardListen()
        if PopDisabled{
            self.interactivePopDisabled()
        }else{
            self.view.addSubview(back)
        }
        if  GlobalDataStore.shared.currentUser.petNickname != ""{
            self.nameTextField.text = GlobalDataStore.shared.currentUser.petNickname
        }
        
        
    }
    private func createLayoutUI(){
    self.view.addSubviews([backgroundimgaeView,nameLabel,bodyimgaeView,introduceStroyBTN,nameView,sureBtn,RandomBtn,warningLabel])
       
        self.nameView.addSubviews([nameTextField])

    
        nameLabel.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.left.right.equalToSuperview()
            make.top.equalTo(navigationBarHeight)
        }
        
        bodyimgaeView.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp_bottom).offset(20)
            make.width.equalTo(ScreenW)
            make.height.equalTo(DIYImageHeight)
        }
        
        introduceStroyBTN.snp.makeConstraints { (make) in
            make.width.height.equalTo(35)
            make.left.equalTo(30)
            make.top.equalTo(bodyimgaeView.snp_top)
        }
        
        nameView.snp.makeConstraints {(make) in
            make.top.equalTo(bodyimgaeView.snp_bottom).offset(20)
            make.left.equalTo(60)
            make.right.equalTo(-60)
            make.height.equalTo(60)
        }
        
        nameTextField.snp.makeConstraints {(make) in
            make.top.equalTo(20)
            make.left.equalTo(nameView.snp.left).offset(20)
            make.right.equalTo(-20)
            make.height.equalTo(20)
        }
        
        warningLabel.snp.makeConstraints {(make) in
            make.top.equalTo(nameView.snp_bottom)
            make.height.equalTo(40)
            make.left.right.equalTo(nameTextField)
        }
        
        RandomBtn.snp.makeConstraints {(make) in
            make.top.equalTo(bodyimgaeView.snp_bottom).offset(30)
            make.height.equalTo(50)
            make.width.equalTo(50)
            make.right.equalTo(-5)
        }
        
        sureBtn.snp.makeConstraints {(make) in
            make.top.equalTo(nameView.snp_bottom).offset(40)
            make.left.right.height.equalTo(nameView)
        }
        
        backgroundimgaeView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
}

// MARK: - 点击事件
extension ConfirmAnimalsViewController{
    // 展示故事版
    @objc private func gotoStory(){
       
        if self.animalModel.storyImage.isEmpty{
            ShowMessageTool.shared.showMessage("该动物还没有背景故事")
            return
        }
        let view = PopImageView.init(imageUrl: self.animalModel.storyImage, animalDIYImage: self.animalModel.petImage)
        view.show()
    }
    
    // 随机姓名
    @objc private func RandomAction(){
        LoginAPI.shared.APPInfoRandomNicknameURL(success: { (json) in
            let dic = JSON(json)
            if dic["code"] == 200 {
                 self.nameTextField.text = dic["data"].string
            }else{
                self.StopShake()
                ShowMessageTool.shared.showMessage("请求失败")
            }   
        }) { (error) in
            
        }
    }
    
}

// MARK 上传资料，完成按钮事件
extension ConfirmAnimalsViewController {
    //MARK 昵称校验
    func nikeNameCheck(){
        
        
    }
    private func StopShake(){
        self.sureBtn.stopAnimation(animationStyle: .shake, revertAfterDelay: 0.5, completion: nil)
    }
    @objc private func gotoUP(){
        
        self.sureBtn.startAnimation()
        
        let name = self.nameTextField.text?.clearBlankString() ?? ""
        self.nameTextField.text = name
        if name.isEmpty {
            StopShake()
            self.warningLabel.text = "*昵称不能为空"
            return
        }
        
        if name.numberOfChars() > 15 {
            StopShake()
            nameTextField.text = name.rangeChars()
            self.warningLabel.text = "*昵称输入过长"
            nameTextField.becomeFirstResponder()
            return
            
        }
        BaseAPI.shared.APPSensitiveWordURL(word: name.clearBlankString(), success: { (json) in
            let dic = json as? NSDictionary
            let code = dic?.object(forKey: "code") as? Int
            if code == 200 {
                self.nameTextField.text = name.clearBlankString()
                self.warningLabel.text = ""
                 self.GetAPPQiNiuTokenUpImage(img: self.animalModel.petImage)
            }else{
                self.StopShake()
                self.warningLabel.text = "*该昵称含有敏感词汇"
                
            }
        }) { (error) in
            
        }
        
       
    }
    //MARK:开始上传
    func startDIYAnimalUP(){

        let user = GlobalDataStore.shared.currentUser
        DIYAPI.shared.APPDIYChooseInfoUpdateURL(birthday: user.birthday, nickName: user.username, sex: user.sex, petImage: self.DIYImage, petNickname: self.nameTextField.text ?? "", petVoice: self.DIYVoice, petType: self.animalModel.animalType, backImage: self.animalModel.backImage, profession: "", area: "", avatar: "", departmentId: "", schoolId: "", voiceIntro: "", success: { (json) in
            
            let dic = json as? NSDictionary
            let code = dic?.object(forKey: "code") as? Int
            if code == 200 {
                self.upSuccess()
               
            }else{
                self.upError()
            }
        }) { (error) in
            self.upError()
            
        }
    }
    
    func upSuccess(){
        GlobalDataStore.shared.currentUser.petType = self.animalModel.animalType
        GlobalDataStore.shared.currentUser.petNickname = self.nameTextField.text ?? ""
        GlobalDataStore.shared.currentUser.petImage = self.DIYImage
        GlobalDataStore.shared.currentUser.isLogin = 1
        if !self.DIYVoice.isEmpty{
            GlobalDataStore.shared.currentUser.petVoice = self.DIYVoice
        }
        
        GlobalDataStore.shared.currentUser.saveToLocal()
        
        self.sureBtn.stopAnimation()
        BaseEngine.shared.deleteVoiceFile()
        BaseEngine.shared.goTabHomeVC()
    }
    
    // MARK: - 上传DIY形象图片
    func GetAPPQiNiuTokenUpImage(img :UIImage){
       
        let urlStr = BaseUrlPath + RequestGetPublicTokenUrl
        
        HttpTool.getRequest(urlPath: urlStr, parameters: nil, success: { (json) in
            let dic = JSON(json)
            if dic["code"] == 200 {
                if let Token = dic["data"].string {
                    let Imagekey = GlobalDataStore.shared.currentUser.uid + UUID().uuidString + ".png"
                    self.uploadManage?.put(img.pngData(), key: Imagekey, token:Token, complete: { (info, key, resp) in
                        if info?.statusCode == 200 {
                            
                            let imageURL = "\(BaseImageURL)\(key ?? "")"
                            ZLog(imageURL)
                            self.DIYImage = imageURL
                            
                            if self.animalModel.VoiceUrl.isEmpty{
                                if self.animalModel.petVoicePath.isEmpty {
                                     self.DIYVoice = ""
                                    self.startDIYAnimalUP()
                                    
                                }else{
                                    self.GetAPPQiNiuTokenUpVoice(path: self.animalModel.petVoicePath)
                                }
                            }else{
                                self.DIYVoice = self.animalModel.VoiceUrl
                                 self.startDIYAnimalUP()
                            }
                            
                        }else{
                            self.upError()
                        }
                    }, option: self.option)
                }
                
            }else{
                self.upError()
            }
        }) { (error) in
            self.upError()
        }
        
        
    }
    // MARK: - 上传音频
    func GetAPPQiNiuTokenUpVoice(path :String){
      
        let urlStr = BaseUrlPath + RequestGetPublicTokenUrl
        
        HttpTool.getRequest(urlPath: urlStr, parameters: nil, success: { (json) in
            let dic = JSON(json)
            if dic["code"] == 200 {
                if let Token = dic["data"].string {
                    let voicekey =  UUID().uuidString + ".wav"
                    self.uploadManage?.putFile(path, key: voicekey, token: Token, complete: { (info, key, resp) in
                        if info?.statusCode == 200 {
                            
                            let voiceURL = "\(BaseImageURL)\(key ?? "")"
                            ZLog(voiceURL)
                            self.DIYVoice = voiceURL
                            
                            DispatchQueue.main.async {
                                 self.startDIYAnimalUP()
                            }
                           
                        }else{
                            
                            self.upError()
                        }
                    }, option: self.option)
                    
                }
                
            }else{
                self.upError()
            }
        }) { (error) in
            self.upError()
        }
        
        
    }
    
    func upError(){
        self.sureBtn.stopAnimation(animationStyle: .shake, revertAfterDelay: 0.5, completion: nil)
        ShowMessageTool.shared.showMessage("形象上传失败")
    }
    
}

extension ConfirmAnimalsViewController{
    // MARK: - 键盘监听
    
    func addKeyBoardListen(){
        let keyBoardManager = IQKeyboardManager.shared
        keyBoardManager.enableAutoToolbar = false
        keyBoardManager.enable = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardShow(noti : Notification) {
        
        
        let userInfo = noti.userInfo
        let frame    = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        keyboardHeight   = frame?.size.height ?? 0
        
        let h = (150*ScaleW)
        self.view.transform = CGAffineTransform.init(translationX: 0, y: -h )
        
    }
    @objc func keyboardHide(noti: Notification) {
        keyboardHeight = 0
       self.nameTextField.resignFirstResponder()
        self.view.transform = CGAffineTransform.identity
    }
    
    
    @objc private func hideKeyBoard(){
        self.nameTextField.resignFirstResponder()
    }
}
// MARK: - UITextFieldDelegate
extension ConfirmAnimalsViewController : UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        nameTextField.resignFirstResponder()
       
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        nameTextField.resignFirstResponder()
        return true
        
    }
    
}

