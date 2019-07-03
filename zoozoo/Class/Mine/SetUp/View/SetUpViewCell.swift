//
//  SetUpViewCell.swift
//  zoozoo
//
//  Created by 你猜 on 2019/6/5.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit


class SetUpViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        self.createUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var imageicon:UIImageView = {
        let image = UIImageView.init()
        return image
    }()
    
    
    lazy var titleLab:UILabel = {
        let Lab = UILabel.init()
        Lab.textAlignment = NSTextAlignment.left
        Lab.font = UIFont.pingFangMediumFont(size: 14)
        Lab.textColor = ColorGrayTitle
        return Lab
    }()
    
    lazy var contentLab:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.right
        label.font = UIFont.pingFangTextFont(size: 13)
        label.textColor = ColorGrayColor
        label.isHidden = true
        label.isUserInteractionEnabled = false
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ClearCache)))
        return label
    }()
    
    lazy var arrowiamge:UIImageView = {
        let arrow = UIImageView.init()
        arrow.image = UIImage.init(named: "cellArrow")
        return arrow
    }()
    lazy var switchOnOff:UISwitch = {
        let switchOnOff = UISwitch.init()
        switchOnOff.addTarget(self,action: #selector(switchStateDidChange(_:)), for: .valueChanged)
        switchOnOff.onTintColor = UIColor.colorWithRGB(r: 114, g: 88, b: 217)
        switchOnOff.tintColor = UIColor.colorWithRGB(r: 232, g: 233, b: 237)
        switchOnOff.setOn(false, animated: true)
        switchOnOff.isHidden = true
        return switchOnOff
    }()
    
    lazy var line:UIView = {
        let label = UIView.init()
        label.backgroundColor = ColorLine
        return label
    }()

    private func createUI(){
        self.contentView.addSubviews([imageicon,titleLab,contentLab,arrowiamge,switchOnOff,line])
        
        imageicon.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(imageicon.snp.right).offset(10)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(ScreenW/3)
        }
        
        contentLab.snp.makeConstraints { (make) in
            make.centerY.height.equalToSuperview()
            make.right.equalTo(arrowiamge.snp_left).offset(-10)
            make.left.equalTo(titleLab.snp.right).offset(5)
        }

        arrowiamge.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(-15)
            make.width.height.equalTo(15)
        }
        
        switchOnOff.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
        }
        
        line.snp.makeConstraints { (make) in
            make.right.bottom.equalToSuperview()
            make.left.equalTo(titleLab.snp.left)
            make.height.equalTo(0.5)
        }
        
    }
    func loadData(icon :String ,title :String){
        titleLab.text = title
        imageicon.image = UIImage.init(named: icon)
        if title == "新消息通知"{
            switchOnOff.isHidden = false
            arrowiamge.isHidden = true
        }else{
            
            switchOnOff.isHidden = true
            arrowiamge.isHidden = false
        }
        
        if title == "账号安全"{
            contentLab.isHidden = false
            let phone = GlobalDataStore.shared.currentUser.phone
            if phone.isEmpty{
                contentLab.isHidden = true
            }else{
                contentLab.text = phone.kReplaceString(replaceString: "****", start: 4, len: 4)
            }
            
        }
        
        
    }
    
    
    @objc func switchStateDidChange(_ sender : UISwitch){
        if(sender.isOn == true){
            print("ON")
            
        }else{
            print("OFF")
        }
    }
    
    // 清理缓存
    @objc func ClearCache() {
        self.contentLab.text = "清理缓存中，请稍微等待..."
        DispatchQueue.main.asyncAfter(deadline: .now()+1, execute:
            {
                ShowMessageTool.shared.showMessage("清理成功")
                self.contentLab.text = ""
        })
    }
}
