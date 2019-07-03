//
//  ModifyPhoneControllerView.swift
//  zoozoo
//
//  Created by 你猜 on 2019/6/5.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit
import TransitionButton

class ModifyPhoneControllerView: BaseViewController {
    
    lazy var OriginalLab:UILabel = {
        let Lab = UILabel.init()
        Lab.textAlignment = NSTextAlignment.left
        Lab.font = UIFont.pingFangMediumFont(size: 13)
        Lab.textColor = ColorMineAlertPhone
        Lab.text = "原电话号码"
        return Lab
    }()
    
    lazy var OrphoneLab:UILabel = {
        let Lab = UILabel.init()
        Lab.textAlignment = NSTextAlignment.left
        Lab.font = UIFont.pingFangMediumFont(size: 14)
        Lab.textColor = ColorMineTableTitle
        Lab.text = "+86"
        return Lab
    }()
    
    lazy var OriginalphonetField : PhoneField = {
        let text = PhoneField()
        text.font = UIFont.pingFangMediumFont(size: 14)
        text.textColor = ColorTitle
        text.backgroundColor = .clear
        text.returnKeyType = .done
        text.keyboardType = .phonePad
        text.clearButtonMode = .whileEditing
        text.textAlignment = NSTextAlignment.justified
        let placeholserAttributes = [NSAttributedString.Key.foregroundColor : ColorMargin, NSAttributedString.Key.font : UIFont.pingFangTextFont(size: 14)]
         text.delegate  = self
        text.attributedPlaceholder = NSAttributedString(string: "请输入原电话号码",attributes: placeholserAttributes as [NSAttributedString.Key : Any])
        text.tintColor = ColorMineAlertPhone
        text.addChangeTextTarget()
        text.maxTextNumber = 13
       
        
        return text
    }()
    
    lazy var orline:UILabel = {
        let label = UILabel.init()
        label.backgroundColor = ColorLine
        return label
    }()
    
    lazy var NewLab:UILabel = {
        let Lab = UILabel.init()
        Lab.textAlignment = NSTextAlignment.left
        Lab.font = UIFont.pingFangMediumFont(size: 13)
        Lab.textColor = ColorMineAlertPhone
        Lab.text = "新电话号码"
        return Lab
    }()
    
    lazy var NephoneLab:UILabel = {
        let Lab = UILabel.init()
        Lab.textAlignment = NSTextAlignment.left
        Lab.font = UIFont.pingFangMediumFont(size: 14)
        Lab.textColor = ColorMineTableTitle
        Lab.text = "+86"
        return Lab
    }()
    
    lazy var NewphoneTextField : PhoneField = {
        let text = PhoneField()
        text.font = UIFont.pingFangMediumFont(size: 14)
        text.textColor = ColorTitle
        text.backgroundColor = .clear
        text.returnKeyType = .done
        text.keyboardType = .phonePad
        text.clearButtonMode = .whileEditing
        text.textAlignment = NSTextAlignment.justified
        let placeholserAttributes = [NSAttributedString.Key.foregroundColor : ColorMargin, NSAttributedString.Key.font : UIFont.pingFangTextFont(size: 14)]
        
        text.attributedPlaceholder = NSAttributedString(string: "请输入新电话号码",attributes: placeholserAttributes as [NSAttributedString.Key : Any])
        text.tintColor = ColorMineAlertPhone
        text.addChangeTextTarget()
        text.maxTextNumber = 13
        text.delegate  = self
        
        return text
    }()
    
    lazy var timeLabel:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.pingFangTextFont(size: 14)
        label.textColor = ColorGrayColor
        label.text = "获取验证码"
        label.isUserInteractionEnabled = false
        label.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(SendSmsCode)))
        return label
    }()
    
    
    lazy var newline:UILabel = {
        let label = UILabel.init()
        label.backgroundColor = ColorSegmentback
        return label
    }()
    
    lazy var codeLab:UILabel = {
        let Lab = UILabel.init()
        Lab.textAlignment = NSTextAlignment.left
        Lab.font = UIFont.pingFangMediumFont(size: 13)
        Lab.textColor = ColorMineAlertPhone
        Lab.text = "验证码"
        return Lab
    }()
    
    lazy var codeTextField : UITextField = {
        let text = UITextField()
        text.font = UIFont.pingFangMediumFont(size: 14)
        text.textColor = ColorTitle
        text.backgroundColor = .clear
        text.returnKeyType = .done
        text.keyboardType = .phonePad
        text.clearButtonMode = .whileEditing
        text.delegate  = self
        text.textAlignment = NSTextAlignment.justified
        let placeholserAttributes = [NSAttributedString.Key.foregroundColor : ColorMargin, NSAttributedString.Key.font : UIFont.pingFangTextFont(size: 14)]
        
        text.attributedPlaceholder = NSAttributedString(string: "请输入验证码",attributes: placeholserAttributes as [NSAttributedString.Key : Any])
        text.tintColor = ColorMineAlertPhone
     
        return text
    }()
    
    
    lazy var codeline:UILabel = {
        let label = UILabel.init()
        label.backgroundColor = ColorLine
        return label
    }()
    
    lazy var sureBtn:TransitionButton = {
        let Btn = TransitionButton.init(type: .custom)
        Btn.spinnerColor = .white
        Btn.titleLabel?.font = UIFont.pingFangTextFont(size: 16)
        Btn.cornerRadius = 30
        Btn.setTitle("下一步", for: .normal)
        Btn.setTitleColor(ColorWhite, for: .normal)
        Btn.addTarget(self, action: #selector(self.Next), for: .touchUpInside)
        return Btn
    }()
    
   
   
    
    var timer : Timer?
    var leftTime = 60
    var VerificationCode : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ColorWhite
        createUI()
        self.title = "修改绑定手机号"
        
        sureBtn.addButtonGradientLayer()
    }
    
    func createUI(){
    self.view.addSubviews([OriginalLab,OrphoneLab,OriginalphonetField,orline,NewLab,NephoneLab,NewphoneTextField,timeLabel,newline,codeLab,codeTextField,codeline,sureBtn])
        OriginalLab.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(navigationBarHeight + 20)
            make.height.equalTo(30)
        }
        
        OrphoneLab.snp.makeConstraints { (make) in
            make.width.equalTo(40)
            make.height.equalTo(50)
            make.top.equalTo(OriginalLab.snp_bottom)
            make.left.equalTo(OriginalLab.snp_left)
        }
        
        OriginalphonetField.snp.makeConstraints { (make) in
            make.right.equalTo(-120)
            make.height.equalTo(50)
            make.top.equalTo(OriginalLab.snp_bottom)
            make.left.equalTo(OrphoneLab.snp_right)
        }
        
        orline.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(0.5)
            make.top.equalTo(OriginalphonetField.snp_bottom)
        }
        
        NewLab.snp.makeConstraints { (make) in
            make.width.height.left.equalTo(OriginalLab)
            make.top.equalTo(orline.snp_bottom)
        }
        
        NephoneLab.snp.makeConstraints { (make) in
            make.width.height.left.equalTo(OrphoneLab)
            make.top.equalTo(NewLab.snp_bottom)
        }
        
        NewphoneTextField.snp.makeConstraints { (make) in
            make.width.height.left.equalTo(OriginalphonetField)
            make.top.equalTo(NewLab.snp_bottom)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.height.equalTo(OriginalphonetField)
            make.top.equalTo(NewLab.snp_bottom)
            make.width.equalTo(100)
            make.right.equalTo(-15)
        }
        

        newline.snp.makeConstraints { (make) in
            make.height.right.left.equalTo(orline)
            make.top.equalTo(NewphoneTextField.snp_bottom)
        }
        
        codeLab.snp.makeConstraints { (make) in
            make.width.height.left.equalTo(OriginalLab)
            make.top.equalTo(newline.snp_bottom)
        }
        
        codeTextField.snp.makeConstraints { (make) in
            make.width.height.left.equalTo(NewphoneTextField)
            make.top.equalTo(codeLab.snp_bottom)
        }
        
        codeline.snp.makeConstraints { (make) in
            make.height.right.left.equalTo(orline)
            make.top.equalTo(codeTextField.snp_bottom)
        }
        
        sureBtn.snp.makeConstraints { (make) in
            make.left.equalTo(44)
            make.right.equalTo(-44)
            make.height.equalTo(60)
            make.top.equalTo(codeline.snp.bottom).offset(40)
        }
    }
    
    
    
   
}

extension  ModifyPhoneControllerView{
    // MARK  获取验证码
    @objc private func SendSmsCode(){
        guard let phone = self.NewphoneTextField.text else {
            return
        }
        LoginAPI.shared.APPGetMessageCodeLoginURL(cellphone: phone.clearBlankString(), success: { (json) in
            let code = json["code"] as? Int
            if code == 200 {
                self.VerificationCode = json["data"] as? String ?? ""
                self.startTimer()
            }else{
                ShowMessageTool.shared.showMessage("验证码发送失败")
            }
        }) { (error) in
            ShowMessageTool.shared.showMessage("验证码发送失败")
        }
    }
    private func startTimer(){
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerRun), userInfo: nil, repeats: true)
        }
        timer?.fireDate = Date.distantPast
    }
    
    @objc private func timerRun(){
        leftTime = leftTime - 1
        let str = "\(leftTime)s"
        timeLabel.isUserInteractionEnabled = false
        timeLabel.textColor = ColorGrayColor
        timeLabel.text = str
        OriginalphonetField.isUserInteractionEnabled = false
        NewphoneTextField.isUserInteractionEnabled = false
        if leftTime == 0 {
            OriginalphonetField.isUserInteractionEnabled = true
            NewphoneTextField.isUserInteractionEnabled = true
            timeLabel.isUserInteractionEnabled = true
            timeLabel.textColor = ColorCancleColor
            timeLabel.text = "获取验证码"
            timer?.invalidate()
            timer    = nil
            leftTime = 60
        }
    }
}




extension ModifyPhoneControllerView{
    // MARK  下一步
    @objc private func Next(){
         self.sureBtn.startAnimation()
        guard let oldPhone = OriginalphonetField.text?.clearBlankString() , let newPhone = NewphoneTextField.text?.clearBlankString() ,let code = codeTextField.text else {
             self.sureBtn.stopAnimation(animationStyle: .shake, revertAfterDelay: 0.5, completion: nil)
            return
        }
        if oldPhone.isEmpty {
            self.sureBtn.stopAnimation(animationStyle: .shake, revertAfterDelay: 0.5, completion: nil)
            ShowMessageTool.shared.showMessage("请输入旧手机号")
            return
        }
        if !oldPhone.isPhoneNumber(){
            self.sureBtn.stopAnimation(animationStyle: .shake, revertAfterDelay: 0.5, completion: nil)
            ShowMessageTool.shared.showMessage("请输入正确的手机号")
            return
        }
        
        if newPhone.isEmpty {
            self.sureBtn.stopAnimation(animationStyle: .shake, revertAfterDelay: 0.5, completion: nil)
            ShowMessageTool.shared.showMessage("请输入新手机号")
            return
        }
        
       
        if !newPhone.isPhoneNumber(){
             self.sureBtn.stopAnimation(animationStyle: .shake, revertAfterDelay: 0.5, completion: nil)
            ShowMessageTool.shared.showMessage("请输入正确的手机号")
            return
        }
        if oldPhone == newPhone {
            self.sureBtn.stopAnimation(animationStyle: .shake, revertAfterDelay: 0.5, completion: nil)
            ShowMessageTool.shared.showMessage("新手机号不能和旧手机号相同")
            return
        }else{
            timeLabel.isUserInteractionEnabled = true
            timeLabel.textColor = ColorCancleColor
            timeLabel.text = "获取验证码"
            
        }
        
        if code.count != 4 || code != self.VerificationCode{
             self.sureBtn.stopAnimation(animationStyle: .shake, revertAfterDelay: 0.5, completion: nil)
            ShowMessageTool.shared.showMessage("请输入正确的验证码")
            return
        }
        
        

        PersonalAPI.shared.APPChangePhoneURL(newPhone: newPhone, smsCode: code, success: { (json) in
            let dic = json as? NSDictionary
            let code = dic?.object(forKey: "code") as? Int
            if code == 200 {
                self.sureBtn.stopAnimation()
                
                GlobalDataStore.shared.currentUser.phone = newPhone
                GlobalDataStore.shared.currentUser.saveToLocal()
                self.navigationController?.popViewController(animated: true)
                ShowMessageTool.shared.showMessage("手机号换绑成功")
            }else{
                 self.sureBtn.stopAnimation(animationStyle: .shake, revertAfterDelay: 0.5, completion: nil)
                ShowMessageTool.shared.showMessage("手机号换绑失败,请稍后重试")
            }
        }) { (error) in
             self.sureBtn.stopAnimation(animationStyle: .shake, revertAfterDelay: 0.5, completion: nil)
            ShowMessageTool.shared.showMessage("网络异常")
        }
    }

}



// MARK: - UITextFieldDelegate
extension ModifyPhoneControllerView : UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        OriginalphonetField.resignFirstResponder()
        NewphoneTextField.resignFirstResponder()
        codeTextField.resignFirstResponder()
        
        guard let oldPhone = OriginalphonetField.text?.clearBlankString() , let newPhone = NewphoneTextField.text?.clearBlankString() else {
            
            return
        }
        if  oldPhone.isEmpty || newPhone.isEmpty {
            timeLabel.isUserInteractionEnabled = false
            timeLabel.textColor = ColorGrayColor
            timeLabel.text = "获取验证码"
           
            
        }
       
        if !oldPhone.isPhoneNumber(){
            ShowMessageTool.shared.showMessage("请输入正确的手机号")
            return
        }
        if !newPhone.isPhoneNumber() || !oldPhone.isPhoneNumber(){
            ShowMessageTool.shared.showMessage("请输入正确的手机号")
            return
        }
        
        if oldPhone == newPhone {
           ShowMessageTool.shared.showMessage("新手机号不能和旧手机号相同")
        }else{
            timeLabel.isUserInteractionEnabled = true
            timeLabel.textColor = ColorCancleColor
            
            
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
        OriginalphonetField.resignFirstResponder()
         NewphoneTextField.resignFirstResponder()
         codeTextField.resignFirstResponder()
        
        return true
        
    }
    
    
}
