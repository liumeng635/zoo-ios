//
//  AddFriendsViewController.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/6/15.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class AddFriendsViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource{
    
    var FirstGroupTitle = ["通过通讯录","搜索手机号","添加微信好友"]
    var FirstGroupIcon = ["FriendMail","AddFriendsPh","AddFriendsWX"]
    
    lazy  var table:UITableView = {
        
        let tableView = UITableView.init(frame:  CGRect.init(x: 0, y: navigationBarHeight, width: ScreenW, height: ScreenH - navigationBarHeight), style: UITableView.Style.grouped)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.rowHeight          = UITableView.automaticDimension
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionFooterHeight   = 0
        tableView.estimatedSectionHeaderHeight   = 0
        if #available(iOS 11.0, *) {
            
            tableView.contentInsetAdjustmentBehavior = .never
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = ColorBackGround
        tableView.register(AddFriendsTypeCell.self, forCellReuseIdentifier: "AddFriendsTypeCell")
        tableView.register(AddFriendsCell.self, forCellReuseIdentifier: "AddFriendsCell")
        
        
        return tableView
        
    }();
    
    
    lazy var RecommendBtn:UIButton = {
        let Btn = UIButton.init(type: .custom)
        Btn.frame = CGRect.init(x: 0, y: ScreenH - SafeBottomMargin - 100, width: ScreenW/2, height: 50)
        Btn.centerX = self.view.centerX
        Btn.layer.cornerRadius  = 25
        Btn.layer.masksToBounds = true
        Btn.layer.borderColor = ColorTheme.cgColor
        Btn.layer.borderWidth = 1
        Btn.setTitle("把嗅嗅推荐给朋友", for: .normal)
        Btn.setTitleColor(ColorTheme, for: .normal)
        Btn.titleLabel?.font = UIFont.pingFangMediumFont(size: 14)
        Btn.addTarget(self, action: #selector(Recommend), for: .touchUpInside)
        return Btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "添加好友"
        
        self.view.addSubviews([table,RecommendBtn])
       
        
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 3 {
            return 0
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddFriendsCell") as! AddFriendsCell
   
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddFriendsTypeCell") as! AddFriendsTypeCell
            cell.titleLab.text = FirstGroupTitle[indexPath.section]
            cell.imageIcon.image = UIImage.init(named: FirstGroupIcon[indexPath.section])
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 3 {
            return 70
        }else{
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01;
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 3 {
            return 40
        }else{
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view  = UIView.init()
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 3 {
            let view  = UIView.init()
            let title = UILabel.init(frame:CGRect(x: 0, y: 10, width:ScreenW, height: 30) )
            title.text = "    你可能认识的人"
            title.textAlignment = .left
            title.backgroundColor = ColorWhite
            title.textColor = ColorMineTableContent
            title.font = UIFont.pingFangMediumFont(size: 12)
            view.addSubview(title)
            return view
        }else{
            let view  = UIView.init()
            return view
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section != 3  {
            let title = FirstGroupTitle[indexPath.section]
            if title == "通过通讯录" {
                let vc = AddressBookFriendsViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            if title == "搜索手机号" {
                let vc = MobileSearchViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            if title == "添加微信好友" {
                
            }
        }
    }
    
    @objc func Recommend(){
        ShareView.init(shareImage: GlobalDataStore.shared.currentUser.petImage, type: .mineShare).show()
    }
    
}


class AddFriendsTypeCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        self.createUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var imageIcon:UIImageView = {
        let image = UIImageView.init()
        return image
    }()
    
    lazy var titleLab:UILabel = {
        let Lab = UILabel.init()
        Lab.textAlignment = NSTextAlignment.left
        Lab.font = UIFont.boldSystemFont(ofSize: 15)
        Lab.textColor = ColorTitle
        return Lab
    }()
    
    lazy var arrowImage:UIImageView = {
        let arrow = UIImageView.init()
        arrow.image = UIImage.init(named: "cellArrow")
        return arrow
    }()
    
    private func createUI(){
        self.contentView.addSubviews([imageIcon,titleLab,arrowImage])
        
        imageIcon.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(15)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(imageIcon.snp.right).offset(10)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(ScreenW/3)
        }
        
        arrowImage.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(15)
        }
    }
    
}



class AddFriendsCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        self.createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var UserImage:UIImageView = {
        let imageV = UIImageView.init()
        imageV.layer.cornerRadius  = 20
        imageV.layer.masksToBounds = true
        return imageV
    }()
    
    lazy var titleLab:UILabel = {
        let Lab = UILabel.init()
        Lab.textAlignment = NSTextAlignment.left
        
        Lab.font = UIFont.boldSystemFont(ofSize: 14)
        Lab.textColor = ColorMinePolicyTitle
        return Lab
    }()
    
    lazy var contentLab:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.left
        
        label.font = UIFont.pingFangTextFont(size: 12)
        label.textColor = ColorGrayColor
        return label
    }()
    
    lazy var TakehomeBtn:UIButton = {
        let Btn = UIButton.init(type: .custom)
        Btn.layer.cornerRadius  = 15
        Btn.layer.masksToBounds = true
        Btn.setTitle("抱他回家", for: .normal)
        Btn.setTitleColor(ColorWhite, for: .normal)
        Btn.setBackgroundColor(.clear, forState: .normal)
        Btn.titleLabel?.font = UIFont.pingFangMediumFont(size: 14)
        Btn.addTarget(self, action: #selector(Takehome), for: .touchUpInside)
        return Btn
    }()
    
    lazy var deleImage:UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "AddFriendsDel")
        imageV.isUserInteractionEnabled = true
        imageV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DeleteAction)))
        return imageV
    }()
    
    lazy var line:UILabel = {
        let label = UILabel.init()
        label.backgroundColor = ColorLine
        return label
    }()
    
    
    private func createUI(){
        self.contentView.addSubviews([UserImage,titleLab,contentLab,TakehomeBtn,deleImage,line])
        UserImage.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.width.height.equalTo(40)
            make.centerY.equalToSuperview()
        }
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(UserImage.snp_right).offset(10)
            make.height.equalTo(15)
           make.right.equalTo(deleImage.snp_left).offset(-5)
            make.top.equalTo(15)
        }
        
        contentLab.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom).offset(10)
            make.height.equalTo(15)
           make.right.equalTo(deleImage.snp_left).offset(-5)
            make.left.equalTo(UserImage.snp_right).offset(10)
            
        }
        deleImage.snp.makeConstraints { (make) in
            make.width.height.equalTo(12)
            make.centerY.equalToSuperview()
            make.right.equalTo(-15)
        }
        
        TakehomeBtn.snp.makeConstraints { (make) in
            make.right.equalTo(deleImage.snp_left).offset(-10)
            make.centerY.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
        
        
        
        line.snp.makeConstraints { (make) in
            make.left.equalTo(65)
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        TakehomeBtn.addButtonGradientLayer()
    }
    
   
    
    // 抱他回家
    @objc func Takehome(){
        
    }
    
    // 删除
    @objc func DeleteAction(){
       
    }
}

