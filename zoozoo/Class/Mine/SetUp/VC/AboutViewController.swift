//
//  AboutViewController.swift
//  zoozoo
//
//  Created by 你猜 on 2019/6/5.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit
import YYText

class AboutViewController: BaseViewController {
    
    lazy var imageicon:UIImageView = {
        let image = UIImageView.init()
        image.image = UIImage(named: "LOGO")
        return image
    }()
    
    lazy var titleLab:UILabel = {
        let Lab = UILabel.init()
        Lab.textAlignment = NSTextAlignment.center
        Lab.font = UIFont.pingFangMediumFont(size: 16)
        Lab.textColor = ColorTitle
        
        return Lab
    }()
    
    
    lazy var AgreementButton : BottonLineBtn = {
        let button = BottonLineBtn.init(type: .custom)
        button.setTitle("用户协议", for: .normal)
        button.setTitleColor(ColorMinePolicyTitle, for: .normal)
        button.addTarget(self, action: #selector(Agreement), for: .touchUpInside)
        button.titleLabel?.font = UIFont.pingFangTextFont(size: 15)
        button.setBackgroundColor(.clear, forState: .normal)
        return button
    }()
    
    lazy var policyButton : BottonLineBtn = {
        let button = BottonLineBtn.init(type: .custom)
        button.setTitle("隐私政策", for: .normal)
        button.setTitleColor(ColorMinePolicyTitle, for: .normal)
        button.addTarget(self, action: #selector(policy), for: .touchUpInside)
        button.titleLabel?.font = UIFont.pingFangTextFont(size: 15)
        button.setBackgroundColor(.clear, forState: .normal)
        return button
    }()
    
    lazy var lineView:UIView = {
        let view = UIView.init()
        view.backgroundColor = ColorLine
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubviews([imageicon,titleLab,AgreementButton,lineView,policyButton])
        
        self.title = "设置"
        
        let infoDictionary = Bundle.main.infoDictionary!
        let minorVersion :AnyObject? = infoDictionary ["CFBundleVersion"] as AnyObject?
        
        print(minorVersion as Any)
        
        titleLab.text = "嗅嗅版本号\(CurrentVersion)"
        
        imageicon.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(80)
            make.top.equalTo(100 + navigationBarHeight)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageicon.snp_bottom).offset(40)
            make.width.equalTo(ScreenW)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.height.equalTo(15)
            make.bottom.equalTo(-SafeBottomMargin-27)
            make.width.equalTo(0.5)
        }
        
        
        AgreementButton.snp.makeConstraints { (make) in
            make.right.equalTo(lineView.snp.left).offset(-15)
            make.height.equalTo(30)
            make.bottom.equalTo(-SafeBottomMargin-20)
            make.width.equalTo(100)
        }
        
        
        policyButton.snp.makeConstraints { (make) in
            make.left.equalTo(lineView.snp.right).offset(15)
            make.height.width.bottom.equalTo(AgreementButton)
        }
    }
    

    @objc private func policy(){
        
        PraviteAgreementView.init(type: 1).show()
        
        
    }
    @objc private func Agreement(){
        PraviteAgreementView.init(type: 0).show()
        
    }
}

