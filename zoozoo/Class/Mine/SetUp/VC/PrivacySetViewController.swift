//
//  PrivacySetViewController.swift
//  zoozoo
//
//  Created by 你猜 on 2019/6/5.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class PrivacySetViewController: SetUpViewController{
    
    var GroupTitle = ["不给我推荐通讯录好友","不让通讯录好友看到我","不被附近的人发现我"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "隐私设置"
        
        self.tableView.register(PrivacySetCell.self, forCellReuseIdentifier: "PrivacySetCell")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrivacySetCell") as! PrivacySetCell
        cell.titleLab.text = GroupTitle[indexPath.row]
        return cell
    }
    
    @objc override func moreAction(){
       
    }
    
}


class PrivacySetCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        self.createUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleLab:UILabel = {
        let Lab = UILabel.init()
        Lab.textAlignment = NSTextAlignment.left
        Lab.font = UIFont.pingFangMediumFont(size: 14)
        Lab.textColor = ColorMineTableTitle
        return Lab
    }()
    
    
    lazy var switchOnOff:UISwitch = {
        let switchOnOff = UISwitch.init()
        switchOnOff.addTarget(self,action: #selector(switchStateDidChange(_:)), for: .valueChanged)
        switchOnOff.onTintColor = UIColor.colorWithRGB(r: 114, g: 88, b: 217)
        switchOnOff.tintColor = UIColor.colorWithRGB(r: 232, g: 233, b: 237)
        return switchOnOff
    }()
    
    lazy var line:UILabel = {
        let label = UILabel.init()
        label.backgroundColor = ColorLine
        return label
    }()
    
    private func createUI(){
        self.contentView.addSubviews([titleLab,switchOnOff,line])
        
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.centerY.equalToSuperview()
            make.right.equalTo(-100)
        }
        
        switchOnOff.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.centerY.equalToSuperview()
        }
        
        line.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
    }

    @objc func switchStateDidChange(_ sender : UISwitch){
        if(sender.isOn == true){
            print("ON")
            
        }else{
            print("OFF")
        }
    }
}





