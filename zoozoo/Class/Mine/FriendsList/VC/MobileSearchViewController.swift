//
//  MobileSearchViewController.swift
//  zoozoo
//
//  Created by 你猜 on 2019/6/10.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit
import MessageUI
class MobileSearchViewController: BaseViewController {
    
    lazy var OriginalLab:UILabel = {
        let Lab = UILabel.init()
        Lab.textAlignment = NSTextAlignment.left
        Lab.font = UIFont.pingFangMediumFont(size: 13)
        Lab.textColor = ColorMineAlertPhone
        Lab.text = "电话号码"
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
        
        text.attributedPlaceholder = NSAttributedString(string: "请输入电话号码",attributes: placeholserAttributes as [NSAttributedString.Key : Any])
        text.tintColor = ColorMineAlertPhone
        text.addChangeTextTarget()
        text.maxTextNumber = 13
        text.addTarget(self, action: #selector(changedTextField(textAction:)), for: .editingChanged)
        text.delegate = self
        
        
        return text
    }()
    
    lazy var orline:UILabel = {
        let label = UILabel.init()
        label.backgroundColor = ColorLine
        return label
    }()
    
    lazy var sureBtn:UIButton = {
        let Btn = UIButton.init(type: .custom)
        Btn.titleLabel?.font = UIFont.pingFangTextFont(size: 16)
        Btn.layer.cornerRadius = 30
        Btn.layer.masksToBounds = true
        Btn.setTitle("确认", for: .normal)
        Btn.setTitleColor(ColorWhite, for: .normal)
        Btn.frame = CGRect.init(x: 50, y: ScreenH - SafeBottomMargin - 100, width: ScreenW - 100, height: 60)
        Btn.addTarget(self, action: #selector(self.SureAction), for: .touchUpInside)
        
        return Btn
    }()
    
    
    var phoneType : Int = 0
    var UID = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "通过手机号寻找小乖兽"
        createUI()
    }
    
    func createUI(){
        self.view.addSubviews([OriginalLab,OrphoneLab,OriginalphonetField,orline,sureBtn])
        
        OriginalLab.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(40 + navigationBarHeight)
            make.height.equalTo(30)
        }
        
        OrphoneLab.snp.makeConstraints { (make) in
            make.width.equalTo(40)
            make.height.equalTo(50)
            make.top.equalTo(OriginalLab.snp_bottom)
            make.left.equalTo(OriginalLab.snp_left)
        }
        
        OriginalphonetField.snp.makeConstraints { (make) in
            make.width.equalTo(ScreenW/2)
            make.height.equalTo(50)
            make.top.equalTo(OriginalLab.snp_bottom)
            make.left.equalTo(OrphoneLab.snp_right)
        }
        
        orline.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(1)
            make.top.equalTo(OriginalphonetField.snp_bottom)
        }
        self.sureBtn.addButtonGradientLayer()
        
    }
    
    // 确定
    @objc func SureAction(){
        switch phoneType {
        case 0:
            let phone = OriginalphonetField.text ?? ""
            if phone.isEmpty {
                ShowMessageTool.shared.showMessage("请输入手机号")
                return
            }
            if phone.clearBlankString().isPhoneNumber(){
                APPFriendAddPetByPhoneURL()
                
            }else{
                ShowMessageTool.shared.showMessage("请输入正确手机号")
                return
            }
        case 1:
           composeMail()
        case 2:
            gotoAdoptAnimal()
        case 3:
            gotoPersonSpace()
            break
           
        case 4:
            gotoPersonSpace()
        case 5:
            gotoBack()
        default: break
        }
    }
    
    //领养
    func gotoAdoptAnimal() {
        if self.UID.isEmpty {
            return
        }
        HomeAPI.shared.APPAdoptAnimalURL(beAdoptedUserId: self.UID, success: { (json) in
            //code码: 506一种类型的宠物只能领养一个,507 该宠物已经被其他用户领取

            let data = json["data"] as? NSDictionary
            let code = data?.object(forKey: "code") as? Int
           
            if code == 1 {
                ShowMessageTool.shared.showMessage("领养成功")
            }else if code == 506 {
                
                SystemTipsView.init(title: "留点机会给别人吧", deTitle: "你当前已拥有一个果冻熊好友\n 先去抱抱其他种类的朋友", H: 120).show()
                
            }else if code == 507 {
                SystemTipsView.init().show()
            }else if code == 508 {
                SystemTipsView.init().show()
            }
            else{
                ShowMessageTool.shared.showMessage("领养失败")
                
            }
        }) { (error) in
            ShowMessageTool.shared.showMessage("领养失败")
        }
        
        
        
        
        
    }
    func gotoPersonSpace() {
        if self.UID.isEmpty {
            
             ShowMessageTool.shared.showMessage("ID为空，不能访问")
            return
        }
        
        let vc = PageSpaceViewController.init(userID: self.UID)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func gotoBack() {
       
        
        self.navigationController?.popViewController(animated: false)
    }
    
    private func composeMail(){
        guard let phones = OriginalphonetField.text else {
            ShowMessageTool.shared.showMessage("请输入正确手机号")
            return
        }
        guard MFMessageComposeViewController.canSendText() else {
        
            ShowMessageTool.shared.showMessage("不能发送短信")
        
        return
    
        }
    
        let messageVC = MFMessageComposeViewController()
        messageVC.navigationBar.isTranslucent = false
        messageVC.messageComposeDelegate = self // 代理
    
        messageVC.recipients = [phones]// 收件人
    
        messageVC.body = "下载该应用\(BaseConfig.shared.appURL)"// 内容
        self.present(messageVC, animated:true, completion:nil)
    }
}
 // MARK: - MFMessageComposeViewControllerDelegate
extension MobileSearchViewController : MFMessageComposeViewControllerDelegate{
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
         controller.dismiss(animated:true, completion:nil)
        switch result {
        case .cancelled:
            ShowMessageTool.shared.showMessage("短信发送取消")
            break
        case .sent:
            ShowMessageTool.shared.showMessage("短信发送成功")
            break
        case .failed:
            ShowMessageTool.shared.showMessage("短信发送失败")
            break
        default:
            break
        }
    }
    
}
// MARK: - HTTP  changedTextField
extension MobileSearchViewController{
    
    // MARK: - changedTextField
    @objc private func changedTextField(textAction:UITextField){
        
    }
    
    //寻找小怪兽
    private func APPFriendAddPetByPhoneURL(){
        guard let phones = OriginalphonetField.text else {
            return
        }
        FriendsAPI.shared.APPFriendAddPetByPhoneURL(phone: phones.clearBlankString(), success: { (json) in
            let dic = json as? NSDictionary
            let code = dic?.object(forKey: "code") as? Int
            let data = dic?.object(forKey: "data") as? NSDictionary
            if code == 200 {
                let uid = data?.object(forKey: "userId") as? String
                let status = data?.object(forKey: "status") as? Int
                self.UID = uid ?? ""
                self.phoneType = status ??  0
                self.UserStatus(Type: status ?? 1)
                
            }else{
                ShowMessageTool.shared.showMessage("获取失败")
            }
            
        }) { (error) in
            ShowMessageTool.shared.showMessage("网络异常")
        }
        
    }
}


extension  MobileSearchViewController{
     //1该手机号未注册用户 2手机号为注册用户，且无主人,当前可领养 3手机号为注册用户，且无主人,当前不可领养（已经领养了同类型的宠物） 4手机号为注册用户，已经有主人 5已经拉黑 不可领养
    
    func UserStatus(Type: Int ) {
        if Type == 1{ // 该手机号未注册
            ShowMessageTool.shared.showMessage("该用户还未加入嗅嗅")
            self.sureBtn.setTitle("邀请", for: .normal)
        }
        if Type == 2{ // 为注册用户，且无主人,当前可领养
            ShowMessageTool.shared.showMessage("该用户正在等待守护者")
             self.sureBtn.setTitle("抱它回家", for: .normal)
        }
        if Type == 3{ // 注册用户，且无主人,当前不可领养（已经领养了同类型的宠物）
            ShowMessageTool.shared.showMessage("已经领养了同类型的宠物")
             self.sureBtn.setTitle("访问它的主页", for: .normal)
        }
        if Type == 4{ // 注册用户，已经有主人
            ShowMessageTool.shared.showMessage("该用户已被其他人抱走了")
            self.sureBtn.setTitle("访问它的主页", for: .normal)
        }
        if Type == 5{ // 已经拉黑 不可领养
            ShowMessageTool.shared.showMessage("该用户已被拉黑,不可领养")
            self.sureBtn.setTitle("确认", for: .normal)
        }
        
    }
}





// MARK: - UITextFieldDelegate
extension MobileSearchViewController : UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
       self.phoneType = 0
        self.sureBtn.setTitle("确定", for: .normal)
        
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
        
        return true
        
    }
    
    
}
