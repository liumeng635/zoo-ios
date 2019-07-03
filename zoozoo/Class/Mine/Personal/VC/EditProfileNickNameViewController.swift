//
//  EditProfileNickNameViewController.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/6/11.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class EditProfileNickNameViewController: BaseViewController {

    var nickName : String = ""
    var changedNickNameBlock : ((_ nickName : String)->Void)?
    
    lazy var nameTextField : UITextField = {
        let text = UITextField()
        text.font = UIFont.boldSystemFont(ofSize: 15)
        text.borderStyle = .none
        text.textColor = ColorTitle
        text.backgroundColor = .clear
        text.returnKeyType = .done
        text.clearButtonMode = .whileEditing
        text.textAlignment = NSTextAlignment.left
        text.delegate = self
        let placeholserAttributes = [NSAttributedString.Key.foregroundColor : UIColor.init(hex: "#BCBCBC"), NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)]
        
        text.attributedPlaceholder = NSAttributedString(string: "请输入姓名",attributes: placeholserAttributes as [NSAttributedString.Key : Any])
        
        text.tintColor = UIColor.init(hex: "#436BF2")
        
        text.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        
        
        return text
    }()
    
    lazy var navSureBtn : UIButton = {
        
        let navSureBtn = UIButton.init(type: .custom)
        navSureBtn.setTitle("完成", for: UIControl.State.normal)
        navSureBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        navSureBtn.setTitleColor(ColorLightTitleColor, for: UIControl.State.normal)
        navSureBtn.setTitleColor(ColorCancleColor, for: UIControl.State.selected)
        navSureBtn.addTarget(self, action: #selector(sureBtnClick), for: UIControl.Event.touchUpInside)
        navSureBtn.isEnabled = false
        
        return navSureBtn
        
    }()
    
    lazy var lineView : UIView = {
        
        let lineView = UIView.init()
        lineView.backgroundColor = ColorLine
        
        return lineView
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "编辑姓名"
        setupUI()
        self.nameTextField.becomeFirstResponder()
        view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(hideKeyBoard)))
    }
    
    @objc fileprivate func hideKeyBoard(){
        
        nameTextField.resignFirstResponder()
    }
    
}

extension EditProfileNickNameViewController{
    
    func setupUI(){
        
        setupNav()
        
        view.addSubview(nameTextField)
        view.addSubview(lineView)
        
        setupLayout()
    }
    
    func setupNav(){
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: navSureBtn)
        
        
    }
    
    func setupLayout(){
        
        nameTextField.snp.makeConstraints { (make) in
            
            make.top.equalTo(navigationBarHeight)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(40)
            
        }
        
        lineView.snp.makeConstraints { (make) in
            
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalTo(nameTextField.snp.bottom)
            make.height.equalTo(0.5)
        }
        
    }
    
}

extension EditProfileNickNameViewController{
    
    @objc func sureBtnClick(){
        nikeNameCheck()
        
    }
    
}

extension EditProfileNickNameViewController {
    
    @objc func textFieldDidChange(textField : UITextField){
        
        if textField.text?.isEmpty == true{
            
            navSureBtn.isEnabled = false
            navSureBtn.isSelected = false
            
        }else{
            
            navSureBtn.isEnabled = true
            navSureBtn.isSelected = true
            
        }
        
    }
    
    //MARK 昵称校验
    func nikeNameCheck(){
        let name = self.nameTextField.text?.clearBlankString() ?? ""
        self.nameTextField.text = name
        if name == "" {
           
            ShowMessageTool.shared.showMessage("昵称不能为空")
            
            return
        }
        if name == self.nickName {
            
            ShowMessageTool.shared.showMessage("您输入的昵称和原始昵称相同，请重新输入")
            
            return
        }
        
        if name.numberOfChars() > 15 {
            
            nameTextField.text = name.rangeChars()
            ShowMessageTool.shared.showMessage("昵称输入过长")
            
            return
        }
        BaseAPI.shared.APPSensitiveWordURL(word: name.clearBlankString(), success: { (json) in
            let dic = json as? NSDictionary
            let code = dic?.object(forKey: "code") as? Int
            if code == 200 {
                self.updateNickNameAction()
            }else{
                 ShowMessageTool.shared.showMessage("姓名不合法")
            }
        }) { (error) in
            
        }
        
    }
    
    
    func updateNickNameAction(){
        guard let name =  self.nameTextField.text?.clearBlankString() else {
            ShowMessageTool.shared.showMessage("昵称不能为空")
            return
        }
        PersonalAPI.shared.APPInfoUpdateNickNameURL(nickName: name, success: { (json) in
            let dic = json as? NSDictionary
            let code = dic?.object(forKey: "code") as? Int
            if code == 200 {
                GlobalDataStore.shared.currentUser.username = name
                GlobalDataStore.shared.currentUser.saveToLocal()
                
                self.changedNickNameBlock?(name)
                self.nameTextField.resignFirstResponder()
                self.navigationController?.popViewController(animated: true)
            }else{
                ShowMessageTool.shared.showMessage("姓名更新失败")
            }
        }) { (error) in
            ShowMessageTool.shared.showMessage("姓名更新失败")
        }
        
    }
    
}
extension EditProfileNickNameViewController :UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.nameTextField.resignFirstResponder()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.nameTextField.resignFirstResponder()
        return true
    }
    
}
