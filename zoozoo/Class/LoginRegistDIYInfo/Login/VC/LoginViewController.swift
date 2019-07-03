//
//  LoginViewController.swift
//  zoozoo
//
//  Created by 苹果上的豌豆 on 2019/5/15.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit
import FDFullscreenPopGesture
import YYText

class LoginViewController: UIViewController {
    lazy var backImage:UIImageView = {
        let backImage = UIImageView.init()
        backImage.image = UIImage.init(named: "LoginBackImage")
        backImage.isUserInteractionEnabled = true
        return backImage
    }()
    lazy var topLabel:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = ColorWhite
        label.text = "账号登录"
        return label
    }()
    
    lazy var explainLabel:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor.colorWithRGBA(r:255.0, g: 255.0, b: 255.0, alpha: 0.7)
        label.text = "若您没有账号，登录即可直接创建喔"
        return label
    }()
    
    lazy var explainimgaeView: UIImageView = {
        let clothesimgaeView = UIImageView.init()
        clothesimgaeView.image = UIImage(named: "LoginVector")
        clothesimgaeView.isHidden = true
        return clothesimgaeView
    }()
    
    lazy var phoneView:UIView = {
        let View = UIView.init()
        View.backgroundColor = .white
        View.layer.cornerRadius  = 30
        View.layer.masksToBounds = true
        return View
    }()
    
    lazy var phoneLabel:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.pingFangTextFont(size: 14)
        label.textColor = ColorTitle
        label.text = "+86"
        
        return label
    }()
    lazy var lineMagin:UIView = {
        let line = UIView.init()
        line.backgroundColor = ColorMargin
        return line
    }()
    lazy var phoneTextField : PhoneField = {
        let text = PhoneField()
        text.font = UIFont.pingFangTextFont(size: 14)
        text.textColor = ColorTitle
        text.backgroundColor = .clear
        text.returnKeyType = .done
        text.keyboardType = .phonePad
        text.clearButtonMode = .whileEditing
        text.delegate = self
        text.textAlignment = NSTextAlignment.justified
        let placeholserAttributes = [NSAttributedString.Key.foregroundColor : ColorMargin, NSAttributedString.Key.font : UIFont.pingFangTextFont(size: 14)]
        
        text.attributedPlaceholder = NSAttributedString(string: "请输入手机号",attributes: placeholserAttributes as [NSAttributedString.Key : Any])
        text.tintColor = ColorTheme
        text.addChangeTextTarget()
        text.maxTextNumber = 13
        
        text.addTarget(self, action: #selector(changedTextField), for: .editingChanged)
        
        return text
    }()
    
    lazy var timeMagin:UIView = {
        let line = UIView.init()
        line.backgroundColor = ColorMargin
        return line
    }()
    
    lazy var timeLabel:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.pingFangTextFont(size: 14)
        label.textColor = ColorDarkGrayTextColor
        label.text = "获取验证码"
        label.isUserInteractionEnabled = false
        label.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(SendSmsCode)))
        return label
    }()
    
    lazy var codeLabel:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor.colorWithRGBA(r:255.0, g: 255.0, b: 255.0, alpha: 0.7)
        return label
    }()
    
    lazy var WXLoginBtn:XZBUIButtonExt = {
        let Btn = XZBUIButtonExt.init(type: .custom)
        Btn.titleLabel?.font = UIFont.pingFangTextFont(size: 12)
        Btn.setTitle("微信登录", for: .normal)
        Btn.setTitleColor(UIColor.colorWithRGBA(r:255.0, g: 255.0, b: 255.0, alpha: 0.5), for: .normal)
        
        Btn.setImage(UIImage.init(named: "WeChaticon"), for: .normal)
      
        Btn.addTarget(self, action: #selector(self.gotoWXLogin), for: .touchUpInside)
       
        return Btn
    }()
    lazy var privacyLab:YYLabel = {
        let Lab = YYLabel.init()
        Lab.isUserInteractionEnabled = true
        let text = NSMutableAttributedString.init(string:  "登录即同意《用户协议》和《隐私政策》")
        text.yy_font = UIFont.pingFangTextFont(size: 12)
        text.yy_color = UIColor.colorWithRGBA(r:255.0, g: 255.0, b: 255.0, alpha: 0.7)
        text.yy_alignment = .center
        let range = NSRange.init(location:5  , length: 6)
        let endrRange = NSRange.init(location:12  , length: 6)
        text.yy_setTextHighlight(range
        , color: ColorOrange, backgroundColor: .clear) { (view, attributedString, HighlightRange, rect) in
            self.gotoAgree()
        }
        text.yy_setTextHighlight(endrRange
        , color: ColorOrange, backgroundColor: .clear) { (view, attributedString, HighlightRange, rect) in
            self.gotoPravite()
        }
        Lab.attributedText =  text
        Lab.numberOfLines = 0
        return Lab
    }()
    
    var timer : Timer?
    var leftTime = 60
    var VerificationCode : String = "8577"
    let ShowTips = ShowTipsView.init(frame: CGRect.init(x: 40, y: navigationBarHeight + 70, width: ScreenW - 80, height: 20))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fd_prefersNavigationBarHidden = true
        addSubLoginView()
    }
    
    private func addSubLoginView(){
        
        self.view.addSubview(backImage)
       backImage.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(hideKeyBoard)))
       
        backImage.addSubviews([topLabel,explainLabel,phoneView,WXLoginBtn,codeLabel,explainimgaeView,ShowTips])
        phoneView.addSubviews([phoneLabel,lineMagin,phoneTextField,timeMagin,timeLabel])
        self.view.addSubview(privacyLab)
        self.createLayoutUI()
    }
    
    private func createLayoutUI(){
       
        self.view.backgroundColor = UIColor.white
        backImage.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        topLabel.snp.makeConstraints { (make) in
            make.top.equalTo(navigationBarHeight)
            make.width.equalToSuperview()
            make.height.equalTo(40)
        }
        
        explainLabel.snp.makeConstraints { (make) in
            make.top.equalTo(topLabel.snp_bottom)
            make.width.equalTo(topLabel)
            make.height.equalTo(30)
        }
        
        explainimgaeView.snp.makeConstraints { (make) in
            make.top.equalTo(topLabel.snp_bottom).offset(9)
            make.width.equalTo(70)
            make.height.equalTo(22)
            make.centerX.equalToSuperview()
        }
        
        phoneView.snp.makeConstraints {(make) in
            make.top.equalTo(explainLabel.snp.bottom).offset(20)
            make.left.equalTo(40)
            make.right.equalTo(-40)
            make.height.equalTo(60)
            
        }
      
        phoneLabel.snp.makeConstraints {(make) in
            make.top.equalTo(20)
            make.left.equalTo(15)
            make.width.equalTo(30)
            make.height.equalTo(20)
            
        }
        lineMagin.snp.makeConstraints {(make) in
            make.top.equalTo(20)
            make.left.equalTo(phoneLabel.snp.right).offset(5)
            make.width.equalTo(0.5)
            make.height.equalTo(20)
            
        }
        phoneTextField.snp.makeConstraints {(make) in
            make.top.equalTo(20)
            make.left.equalTo(lineMagin.snp.right).offset(5)
            make.right.equalTo(-100)
            make.height.equalTo(20)
            
        }
        timeLabel.snp.makeConstraints {(make) in
            make.top.equalTo(20)
            make.right.equalTo(-15)
            make.width.equalTo(80)
            make.height.equalTo(20)
            
        }
        timeMagin.snp.makeConstraints {(make) in
            make.top.equalTo(20)
            make.right.equalTo(timeLabel.snp.left).offset(-5)
            make.width.equalTo(0.5)
            make.height.equalTo(20)
            
        }
        
        privacyLab.snp.makeConstraints { (make) in
            make.top.equalTo(phoneView.snp_bottom).offset(5)
            make.height.equalTo(30)
            make.left.equalTo(30)
            make.right.equalTo(-30)
        }
        
        codeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(privacyLab.snp_bottom).offset(70)
            make.width.height.equalTo(topLabel)
        }
        
        WXLoginBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo( -50 - SafeBottomMargin)
            make.centerX.equalToSuperview()
            make.height.equalTo(80)
            make.width.equalTo(60)
        }
    }
}

// MARK: - changedTextField
extension LoginViewController{
    @objc private func changedTextField(){
        let phone = phoneTextField.text ?? ""
        if phone.isEmpty{
            ShowTips.remove()
            return
        }
        if phone.clearBlankString().length >= 1 {
            let str = phone.clearBlankString().substring(location: 0, length: 1)
            if str != "1"{
                ShowTips.Show(tips: "请输入正确的手机号", Controller: self)
                return
            }else{
                ShowTips.remove()
            }
            
        }
        if phone.clearBlankString().length >= 11 {
            
            
            if phoneTextField.text!.clearBlankString().isPhoneNumber(){
                timeLabel.isUserInteractionEnabled = true
                self.phoneTextField.resignFirstResponder()
            }else{
                ShowTips.Show(tips: "请输入正确的手机号", Controller: self)
                timeLabel.isUserInteractionEnabled = false
            }
            return
        }
        if phone.clearBlankString().isPhoneNumber(){
            timeLabel.isUserInteractionEnabled = true
            self.phoneTextField.resignFirstResponder()
        }else{
            timeLabel.isUserInteractionEnabled = false
        }
    }

}
// MARK: - code
extension LoginViewController{
    
    @objc private func SendSmsCode(){
        topLabel.text = "输入验证码"
        explainLabel.isHidden = true
        explainimgaeView.isHidden = false
        
        GetMessageCodeLogin()
    }
    private func startTimer(){
        
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerRun), userInfo: nil, repeats: true)
        }
        timer?.fireDate = Date.distantPast
    }
    @objc private func timerRun(){
        leftTime = leftTime - 1
        let str = "\(leftTime)s后可重新获取"
        timeLabel.isUserInteractionEnabled = false
        timeLabel.textColor = ColorDarkGrayTextColor
        codeLabel.text = str
        phoneTextField.isUserInteractionEnabled = false
        if leftTime == 0 {
            phoneTextField.isUserInteractionEnabled = true
            
            let phone = phoneTextField.text ?? ""
            if phone.clearBlankString().length >= 11 {
                timeLabel.isUserInteractionEnabled = true
                timeLabel.textColor = ColorOrange
            }
            timer?.invalidate()
            timer    = nil
            leftTime = 60
            codeLabel.text = ""
        }
    }
    
    //发送验证码
    private func GetMessageCodeLogin(){
        guard let phone = self.phoneTextField.text else {
            return
        }
        LoginAPI.shared.APPGetMessageCodeLoginURL(cellphone: phone.clearBlankString(), success: { (json) in
           
            let code = json["code"] as? Int
            if code == 200 {
                self.VerificationCode = json["data"] as? String ?? ""
                self.startTimer()
                self.showCodeView()
            }else{
                ShowMessageTool.shared.showMessage("验证码发送失败")
            }
        }) { (error) in
            ShowMessageTool.shared.showMessage("验证码发送失败")
        }

    }
    func showCodeView(){
        let codeView = XZBVerificationCodeView.init(frame: CGRect.init(x: 40, y: 320, width: ScreenW - 80, height: 60 * ScaleW))
        codeView.delegate = self
        self.view.addSubview(codeView)
        codeView.snp.updateConstraints { (make) in
            make.width.equalTo(ScreenW - 80)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.privacyLab.snp_bottom).offset(10)
        }
    }
    @objc private func hideKeyBoard(){
        self.phoneTextField.resignFirstResponder()
        
    }
    @objc private func naviBack(){
        self.navigationController?.popViewController(animated: true)
    }
}

extension LoginViewController : XZBVerificationCodeViewDelegate {
    func verificationCodeDidFinishedInput(verificationCodeView: XZBVerificationCodeView, code: String) {
        if code == self.VerificationCode {
            self.gotoPhoneLogin()
        }else{
            ShowMessageTool.shared.showMessage("验证码错误")
            verificationCodeView.cleanVerificationCodeView()
        }
        
    }
}

extension LoginViewController {
   func gotoPhoneLogin(){
        guard let phone = self.phoneTextField.text else {
            return
        }
        LoginAPI.shared.APPPhoneLoginURL(cellphone: phone.clearBlankString(), smsCode: self.VerificationCode, success: { (json) in
            if let response = BaseLoginUserModel.deserialize(from: json as? [String:Any]){
                if response.code == 200 {
                    let model = response.data
                    if let accessToken = model?.access_token {
                        GlobalDataStore.shared.currentUser.key = "Bearer \(accessToken)"
                    }
                    if let usermodel = model?.user{
                        GlobalDataStore.shared.currentUser.loadLoginData(model: usermodel)
                    }
                    
                    GlobalDataStore.shared.currentUser.saveToLocal()
                    
                    if let isLoginInfo = model?.isCompleted{
                        if isLoginInfo == 1 {
                            GlobalDataStore.shared.currentUser.isLogin = 1
                             GlobalDataStore.shared.currentUser.saveToLocal()
                            BaseEngine.shared.goHomeVC()
                        }else{
                            
                            let vc = LoginInfoViewController()
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                    
                }else{
                    ShowMessageTool.shared.showMessage("登录失败")
                }
            }
        }) { (error) in
            ShowMessageTool.shared.showMessage("网络异常")
        }
    }
}

extension LoginViewController {
    @objc private func gotoWXLogin(){
        /// 1.通过UM获取第三方登录信息
        if  UMSocialManager.default()?.isInstall(.wechatSession) ?? true {}else{
            ShowMessageTool.shared.showMessage("未安装微信")
            return
        }
      
        UMSocialManager.default().getUserInfo(
            with: UMSocialPlatformType.wechatSession,
            currentViewController: self) { (result, error) in
                if result == nil {
                    ShowMessageTool.shared.showMessage("登录失败")
                    return
                }
                let info = result as? UMSocialUserInfoResponse
                let original = info?.originalResponse as! [String : Any]
                
                if info == nil {
                   ShowMessageTool.shared.showMessage("登录失败")
                    return
                }
                LoginAPI.shared.APPWechatLoginURL(openId: info?.openid ?? "", unionId: info?.unionId ?? "", wechatNickname: info?.name ?? "", wechatSex: info?.unionGender ?? "", wechatPic: info?.iconurl ?? "", city: original["city"]  as! String, success: { (json) in
                    if let response = BaseLoginUserModel.deserialize(from: json as? [String:Any]){
                        if response.code == 200 {
                            let model = response.data
                            if let accessToken = model?.access_token {
                                GlobalDataStore.shared.currentUser.key = "bearer \(accessToken)"
                            }
                            if let usermodel = model?.user{
                                GlobalDataStore.shared.currentUser.loadLoginData(model: usermodel)
                            }
                            
                            GlobalDataStore.shared.currentUser.saveToLocal()
                            
                            if let isLoginInfo = model?.isCompleted{
                                if isLoginInfo == 1 {
                                    GlobalDataStore.shared.currentUser.isLogin = 1
                                    GlobalDataStore.shared.currentUser.saveToLocal()
                                    BaseEngine.shared.goHomeVC()
                                }else{
                                    let vc = LoginInfoViewController()
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
                                
                            }
                        }else{
                            ShowMessageTool.shared.showMessage("登录失败")
                        }
                    }
                }, failure: { (error) in
                    ShowMessageTool.shared.showMessage("网络异常")
                })
                
                
        }
    }
    
    @objc private func gotoPravite(){
        
        PraviteAgreementView.init(type: 1).show()
     
        
    }
    @objc private func gotoAgree(){
       PraviteAgreementView.init(type: 0).show()

    }
    
    
}


// MARK: - UITextFieldDelegate
extension LoginViewController : UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let phone = textField.text ?? ""
        if phone.clearBlankString().isPhoneNumber(){
           timeLabel.textColor = ColorOrange
        }else{
           timeLabel.textColor = ColorDarkGrayTextColor
        }
       
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if string.isInputRuleAndBlank() || string == ""  {
            return true
        }else{
            return false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        phoneTextField.resignFirstResponder()
        
        return true
        
    }
    
    
}
