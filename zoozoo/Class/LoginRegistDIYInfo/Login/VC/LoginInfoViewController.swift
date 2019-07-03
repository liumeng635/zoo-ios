//
//  LoginInfoViewController.swift
//  zoozoo
//
//  Created by 苹果上的豌豆 on 2019/5/17.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit
import TransitionButton
import AMPopTip

let margin = 50*ScaleW
let textMargin = 70*ScaleW

class LoginInfoViewController: BaseViewController {
    lazy var backImage:UIImageView = {
        let backImage = UIImageView.init()
        backImage.image = UIImage.init(named: "LoginBackImage")
        backImage.isUserInteractionEnabled = true
        return backImage
    }()
    lazy var topLabel:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = ColorWhite
        label.text = "完善信息"
        return label
    }()
    
    lazy var nameView:UIView = {
        let View = UIView.init()
        View.backgroundColor = .white
        View.layer.cornerRadius  = 30
        View.layer.masksToBounds = true
        return View
    }()
    
    lazy var FirstNameTextField : UITextField = {
        let text = UITextField()
        text.font = UIFont.pingFangTextFont(size: 14)
        text.textColor = ColorBlackTitle
        text.backgroundColor = .clear
        text.returnKeyType = .done
        text.keyboardType = .default
        text.clearButtonMode = .whileEditing
        text.delegate = self
        text.textAlignment = NSTextAlignment.justified
        let placeholserAttributes = [NSAttributedString.Key.foregroundColor : ColorLightTitleColor, NSAttributedString.Key.font : UIFont.pingFangTextFont(size: 12)]
        
        text.attributedPlaceholder = NSAttributedString(string: "输入昵称",attributes: placeholserAttributes as [NSAttributedString.Key : Any])
        text.tintColor = ColorWhite
        
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
    
    lazy var dateView:UIView = {
        let View = UIView.init()
        View.backgroundColor = .white
        View.layer.cornerRadius  = 30
        View.layer.masksToBounds = true
        return View
    }()
    
    lazy var birthdayLabel : UITextField = {
        let text = UITextField()
        text.font = UIFont.pingFangTextFont(size: 14)
        text.textColor = ColorBlackTitle
        text.text = "2001-05-27"
        text.backgroundColor = .clear
        text.textAlignment = NSTextAlignment.justified
        let placeholserAttributes = [NSAttributedString.Key.foregroundColor : ColorLightTitleColor, NSAttributedString.Key.font : UIFont.pingFangTextFont(size: 12)]
        
        text.attributedPlaceholder = NSAttributedString(string: "选择出生日期",attributes: placeholserAttributes as [NSAttributedString.Key : Any])
        text.tintColor = ColorWhite
        text.isUserInteractionEnabled = true
        text.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(chooseBirthday)))
        return text
    }()
    
    lazy var manChoiceBtn:XZBUIButtonImgLTextR = {
        let Btn = XZBUIButtonImgLTextR.init(type: .custom)
        Btn.setTitle("男", for: .normal)
        Btn.tag = 0
        Btn.addTarget(self, action: #selector(self.chooseSex(button:)), for: .touchUpInside)
        return Btn
    }()
    
    lazy var womanChoiceBtn:XZBUIButtonImgLTextR = {
        let Btn = XZBUIButtonImgLTextR.init(type: .custom)
        Btn.setTitle("女", for: .normal)
        Btn.tag = 1
        Btn.addTarget(self, action: #selector(self.chooseSex(button:)), for: .touchUpInside)
        return Btn
    }()
    
    lazy var sexTipsLabel:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.pingFangTextFont(size: 10)
        label.textColor = ColorWhite
        label.text = "*确认性别后不可更改"
        return label
    }()
    
  
    lazy var sureBtn:TransitionButton = {
        let Btn = TransitionButton.init(type: .custom)
        Btn.spinnerColor = .white
        Btn.titleLabel?.font = UIFont.pingFangTextFont(size: 16)
        Btn.cornerRadius = 30
        Btn.setTitle("下一步", for: .normal)
        Btn.setTitleColor(ColorWhite, for: .normal)
        Btn.setTitleColor(ColorWhite, for: .disabled)
        Btn.addTarget(self, action: #selector(self.gotoUP), for: .touchUpInside)
        return Btn
    }()
    
    fileprivate var selectedBtn = UIButton.init()
    fileprivate var selectedTag : Int = 2
    private var SensitiveBool = Bool()
    let popTip = PopTip()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fd_prefersNavigationBarHidden = true
        self.interactivePopDisabled()
        
        createLayoutUI()
        
        sureBtn.addButtonGradientLayer()
    }
    private func createLayoutUI(){
       
        SensitiveBool = false
        self.view.addSubview(backImage)
        backImage.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(hideKeyBoard)))
        
        backImage.addSubviews([topLabel,nameView,dateView,manChoiceBtn,womanChoiceBtn,sexTipsLabel,warningLabel,sureBtn])
        self.nameView.addSubview(FirstNameTextField)
        self.dateView.addSubview(birthdayLabel)
      
        backImage.snp.makeConstraints {(make) in
            make.edges.equalToSuperview()
        }
        topLabel.snp.makeConstraints {(make) in
            make.top.equalTo(navigationBarHeight)
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(30)
        }
        nameView.snp.makeConstraints {(make) in
            make.top.equalTo(topLabel.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.height.equalTo(60)
        }
        FirstNameTextField.snp.makeConstraints {(make) in
            make.top.height.equalTo(nameView)
            make.left.equalTo(nameView.snp_left).offset(30)
            make.right.equalTo(nameView.snp_right).offset(-30)
        }
        
        warningLabel.snp.makeConstraints {(make) in
            make.top.equalTo(nameView.snp_bottom)
            make.height.equalTo(40)
            make.left.right.equalTo(FirstNameTextField)
        }
        
        dateView.snp.makeConstraints {(make) in
            make.top.equalTo(nameView.snp.bottom).offset(40)
            make.left.height.right.equalTo(nameView)
        }
        birthdayLabel.snp.makeConstraints {(make) in
            make.height.top.equalTo(dateView)
            make.left.right.equalTo(FirstNameTextField)
        }
        manChoiceBtn.snp.makeConstraints {(make) in
            make.top.equalTo(dateView.snp.bottom).offset(40)
            make.height.left.equalTo(dateView)
            make.width.equalTo((ScreenW-80)/2-20)
        }
        womanChoiceBtn.snp.makeConstraints {(make) in
            make.top.width.height.equalTo(manChoiceBtn)
            make.right.equalTo(dateView.snp_right)
        }
        sexTipsLabel.snp.makeConstraints {(make) in
            make.top.equalTo(womanChoiceBtn.snp.bottom).offset(15)
            make.left.equalTo(dateView.snp_left).offset(15)
            make.right.equalTo(-80)
            make.height.equalTo(20)
        }
        sureBtn.snp.makeConstraints { (make) in
            make.top.equalTo(sexTipsLabel.snp.bottom).offset(40)
            make.height.left.right.equalTo(dateView)
        }
        
        
    }
    private func createAMPopUI(frame:CGRect){
        let imageView = UIImageView(image: UIImage(named: "SureSex"))
        let customView = UIView(frame:frame)
        customView.backgroundColor = UIColor.clear
        imageView.frame = CGRect(x: 0, y: -20, width: imageView.frame.width, height: imageView.frame.height)
        customView.addSubview(imageView)
    
        popTip.bubbleColor = UIColor.clear
        popTip.show(customView: customView, direction: .down, in: view, from: frame)
    }
}

// MARK: - 点击事件
extension LoginInfoViewController{
    //选择生日
    @objc private func chooseBirthday(){
        self.hideKeyBoard()
        let view = ShowBirthdayView.init(Birthdaytime: self.birthdayLabel.text ?? "")
        view.show()
        
        view.datePickerBirthdayBlock = {(time) in
            self.birthdayLabel.text = time
        }
        
    }
    // 性别选择
    @objc private func chooseSex (button:UIButton ){
        if button != self.selectedBtn {
            self.selectedBtn.isSelected = false
            button.isSelected = true
            self.selectedBtn = button
        }else{
            self.selectedBtn.isSelected = true
        }

        if button.tag == 0{
            self.selectedTag = 1
            createAMPopUI(frame:manChoiceBtn.frame)
        }else{
            self.selectedTag = 0
             createAMPopUI(frame:womanChoiceBtn.frame)
        }
        sexTipsLabel.text = ""
    }
    
    //MARK 昵称校验
    func nikeNameCheck(){
        self.SensitiveBool = false
        let name = self.FirstNameTextField.text?.clearBlankString() ?? ""
        self.FirstNameTextField.text = name
        if name.isEmpty {
            self.warningLabel.text = "*昵称不能为空"
            FirstNameTextField.becomeFirstResponder()
            return
        }
        
        if name.numberOfChars() > 15 {
            FirstNameTextField.text = name.rangeChars()
            self.warningLabel.text = "*昵称输入过长"
            FirstNameTextField.becomeFirstResponder()
            return
            
        }
        BaseAPI.shared.APPSensitiveWordURL(word: name.clearBlankString(), success: { (json) in
            let dic = json as? NSDictionary
            let code = dic?.object(forKey: "code") as? Int
            if code == 200 {
                self.SensitiveBool = true
                 self.warningLabel.text = ""
                
            }else{
                self.SensitiveBool = false
                self.FirstNameTextField.becomeFirstResponder()
                self.warningLabel.text = "*该昵称含有敏感词汇"
            }
        }) { (error) in
            
        }
    }
    private func StopShake(){
        self.sureBtn.stopAnimation(animationStyle: .shake, revertAfterDelay: 0.5, completion: nil)
    }
    //上传资料
    @objc private func gotoUP(){
        self.sureBtn.startAnimation()
        self.FirstNameTextField.resignFirstResponder()
        if  self.FirstNameTextField.text?.isEmpty == true {
            StopShake()
            ShowMessageTool.shared.showMessage("昵称不能为空")
            return
        }
        
        if  self.SensitiveBool == false{
            StopShake()
            ShowMessageTool.shared.showMessage("*该昵称含有敏感词汇")
            return
        }
        
        if  self.birthdayLabel.text?.isEmpty == true  {
            StopShake()
            ShowMessageTool.shared.showMessage("生日不能为空")
            return
        }
        
        if self.selectedTag == 2{
            StopShake()
            ShowMessageTool.shared.showMessage("请选择性别")
            return
        }
         self.sureBtn.startAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.sureBtn.stopAnimation()
            
            GlobalDataStore.shared.currentUser.birthday = self.birthdayLabel.text ?? ""
            GlobalDataStore.shared.currentUser.username = self.FirstNameTextField.text ?? ""
            GlobalDataStore.shared.currentUser.sex = self.selectedTag
            GlobalDataStore.shared.currentUser.saveToLocal()
            let vc = ChooseDIYViewController.init(PopDisabled: true)
            self.navigationController?.pushViewController(vc, animated: true)
        }
       
        
    }
   
    
    @objc private func hideKeyBoard(){
        self.FirstNameTextField.resignFirstResponder()
    }
}

// MARK: - UITextFieldDelegate
extension LoginInfoViewController : UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.FirstNameTextField.resignFirstResponder()
        
        nikeNameCheck()
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.FirstNameTextField.resignFirstResponder()
        return true
    }
}
