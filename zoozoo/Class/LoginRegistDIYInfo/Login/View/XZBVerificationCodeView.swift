//
//  XZBVerificationCodeView.swift
//  xiaohongshu
//
//  Created by 🍎上的豌豆 on 2019/2/20.
//  Copyright © 2019 xiao. All rights reserved.
//

import UIKit

protocol XZBVerificationCodeViewDelegate {
    func verificationCodeDidFinishedInput(verificationCodeView:XZBVerificationCodeView,code:String)
}
class XZBVerificationCodeView: UIView {
    /// 代理回调
    var delegate:XZBVerificationCodeViewDelegate?
    
    /// 一堆框框的数组
    var textfieldarray = [XZBUITextField]()
    /// 框框的大小
    let CodeWidth:CGFloat = 60 * ScaleW
    /// 框框个数
    var numOfRect = 4
    
    /// 框框个数
    var seletedTag = 0
    
    /// 构造函数
    ///
    /// - Parameters:
    ///   - frame: frame，宽度最好设置为屏幕宽度
    ///   - num: 框框个数，默认 4 个
    
    init(frame: CGRect,num:Int = 4) {
        super.init(frame: frame)
        setupUI()
    }
    public func cleanVerificationCodeView(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            
            for tv in self.textfieldarray {
                tv.text = ""
                tv.layer.borderWidth = 0;
            }
           
            self.textfieldarray.first?.becomeFirstResponder()
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - UI 相关方法
extension XZBVerificationCodeView{
    
    fileprivate func setupUI(){

        // 计算左间距
        let margin = (self.w - CodeWidth * CGFloat(numOfRect)) / CGFloat(numOfRect - 1)
        // 创建 n个 UITextFied
        for i in 0..<numOfRect{
            
            let rect = CGRect(x: CGFloat(i)*CodeWidth + CGFloat(i)*margin, y: 0, width: CodeWidth, height: CodeWidth)
            let tv = createTextField(frame: rect)
//            tv.layer.borderWidth = 0.8;
//            tv.layer.borderColor = ColorOrange.cgColor
            tv.tag = i
            textfieldarray.append(tv as! XZBUITextField)
            
        }
        textfieldarray.first?.becomeFirstResponder()
    }
    private func createTextField(frame:CGRect)->UITextField{
        
        let tv = XZBUITextField(frame: frame)
        tv.borderStyle = .none
        tv.keyboardType = .phonePad
        tv.textAlignment = .center
        tv.layer.cornerRadius  = 10 * ScaleW
        tv.tintColor = ColorTitle
        tv.backgroundColor = ColorWhite

        tv.font = UIFont.boldSystemFont(ofSize: 25)
        tv.textColor = ColorTitle
        tv.delegate = self
        tv.deleteDelegate = self
        
        addSubview(tv)
        
        
        if #available(iOS 12.0, *) {
            tv.textContentType = UITextContentType.oneTimeCode

        }
        return tv
        
    }
    
   
}
extension XZBVerificationCodeView:UITextFieldDelegate,XZBUITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty {
            return false
        }
        if string.length >= 2 {
            return false
        }

        if !textField.hasText {
            
            // tag 对应数组下标
            let index = textField.tag
            
            textField.resignFirstResponder()
            if index == numOfRect - 1 {
                textfieldarray[index].text = string
                // 拼接结果
                var code = ""
                for tv in textfieldarray{
                    code += tv.text ?? ""
                    tv.resignFirstResponder()
                }
                delegate?.verificationCodeDidFinishedInput(verificationCodeView: self, code: code)
                
                textfieldarray[index].layer.borderWidth = 0.8;
                textfieldarray[index].layer.borderColor = ColorOrange.cgColor
                
                return false
            }
            
            self.seletedTag = index
           
            textfieldarray[index].layer.borderWidth = 0.8;
            textfieldarray[index].layer.borderColor = ColorOrange.cgColor
    
            textfieldarray[index].text = string
            textfieldarray[index + 1].becomeFirstResponder()
        }
        return false
        
    }
  
    /// 监听键盘删除键
    func didClickBackWard() {

        textfieldarray[self.seletedTag].layer.borderWidth = 0;
        if  self.seletedTag > 0{
            self.seletedTag = self.seletedTag-1
        }
        
        for i in 1..<numOfRect{
            
            if !textfieldarray[i].isFirstResponder {
                continue
            }
            textfieldarray[i].resignFirstResponder()
            textfieldarray[i-1].becomeFirstResponder()
            textfieldarray[i-1].text = ""
            
        }
    }
    
    
}

