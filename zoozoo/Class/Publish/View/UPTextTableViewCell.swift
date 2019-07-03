//
//  UPTextTableViewCell.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/6/27.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class UPTextTableViewCell: UITableViewCell ,UITextViewDelegate{
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        setupLayout()
        let keyBoardManager = IQKeyboardManager.shared
        keyBoardManager.enableAutoToolbar = false
        keyBoardManager.enable = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.textViewDidEndResignFirstResponder), name: ResignFirstResponderNotification, object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var PublishTextView : UITextView = {
        let view = UITextView.init()
        view.isEditable = true
        view.delegate = self
        view.showsVerticalScrollIndicator = false
        view.text = "说点什么吧,让守护者也可以了解你~"
        view.textColor = UIColor.colorWithHex(hex: 0xBBBBBB)
        view.font = UIFont.pingFangTextFont(size: 16)
        view.textContainerInset = UIEdgeInsets.init(top: 0, left: 8, bottom: 0, right: 8)
        view.tintColor = ColorTitle
        
        return view
    }()
    func setupLayout() {
        self.backgroundColor = UIColor.white
        contentView.addSubview(PublishTextView)
        PublishTextView.snp.makeConstraints { (make) in
            make.top.equalTo(15)
            make.right.equalTo(-15)
            make.left.equalTo(0)
            make.bottom.equalTo(-15)
        }
        
    }
    public  var sendContentBlock : ((_ content : String)->Void)?
    public  var sendContentHBlock : ((_ contentH : CGFloat)->Void)?
    @objc func textViewDidEndResignFirstResponder(){
        self.PublishTextView.resignFirstResponder()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.numberOfChars() > 120{
            textView.text = textView.text.rangeChars(num: 120)
            self.sendContentBlock?(textView.text)
            ShowMessageTool.shared.showMessage("不能输入超过120个字符")

            return
        }
        self.sendContentBlock?(textView.text)

    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "说点什么吧,让守护者也可以了解你~"
            textView.textColor =  UIColor.colorWithHex(hex: 0xBBBBBB)
        }
        if textView.text.numberOfChars() > 120 {
            ShowMessageTool.shared.showMessage("不能输入超过120个字符")

           textView.text = textView.text.rangeChars(num: 120)
            return
        }
        self.PublishTextView.resignFirstResponder()
        
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "说点什么吧,让守护者也可以了解你~" {
            textView.text = ""
            textView.textColor = ColorTitle
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == ""{
            return true
        }
        if textView.text.numberOfChars() > 120 {
            ShowMessageTool.shared.showMessage("不能输入超过120个字符")

            return false
        }
        return true
    }
    
}
