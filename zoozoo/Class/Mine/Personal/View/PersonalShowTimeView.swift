//
//  PersonalShowTimeView.swift
//  zoozoo
//
//  Created by 你猜 on 2019/5/29.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class PersonalShowTimeView: UIView ,UITableViewDelegate,UITableViewDataSource{

    lazy var backgroundView:UIView = {
        let View = UIView.init()
        View.backgroundColor = UIColor.colorWithHex(hex: 0x000000, alpha: 0.8)
        View.addTapGesture(target: self, action: #selector(dismissController))
        View.alpha = 0
        return View
    }()
    
    lazy var downView:UIView = {
        let View = UIView.init()
        View.backgroundColor = UIColor.colorWithHex(hex: 0xffffff)
        return View
    }()
    
    //userImage
    lazy var userImageView: UIImageView = {
        let imgaeView=UIImageView.init()
        imgaeView.image=UIImage(named: "AnimalBear5")
        return imgaeView
    }()
    
    lazy  var tableView:UITableView = {
        let table  = UITableView.init(frame: CGRect.zero, style: UITableView.Style.grouped)
        table.backgroundColor = .white
        table.register(PersonalShowCell.self, forCellReuseIdentifier: "PersonalShowCell")
        table.rowHeight = UITableView.automaticDimension
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        return table
    }()

    var downViewH = ScreenH - navigationBarHeight - 60
    fileprivate var Jurisdiction : Int = 0
    
    //初始化视图
    init(qualifications : Int) {  // 0 无 1有 权限
        super.init(frame: screenFrame)
        Jurisdiction = qualifications
        if  qualifications == 1{
            setupUI()
        }else{
            setupUnqualifiedUI()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func Show() {
        UIApplication.shared.keyWindow?.addSubview(self)
        UIView.animate(withDuration: 0.25) {
            self.backgroundView.alpha = 1
            if self.Jurisdiction == 0 { //无权限
                self.downView.snp.makeConstraints { (make) in
                    make.top.equalTo(self.snp_top).offset(ScreenH*3/4)
                    make.left.right.width.equalToSuperview()
                    make.height.equalTo(ScreenH/4)
                }
            }else{
                self.downView.snp.makeConstraints { (make) in
                    make.top.equalTo(self.snp_top).offset(navigationBarHeight+60)
                    make.left.right.width.equalToSuperview()
                    make.height.equalTo(self.downViewH)
                }
            }
        }
    }
    
    @objc public func remove() {
        UIView.animate(withDuration: 0.5, animations: {
            self.backgroundView.alpha = 0
            self.downView.snp.updateConstraints { (make) in
                make.top.equalTo(self.snp_top).offset(ScreenH)
            }
        }) { (finish) in
            self.removeFromSuperview()
        }
        
    }
    
    @objc func dismissController() {
        self.remove()
    }
    
    func setupUI() {
        self.backgroundColor = UIColor.clear
        self.addSubviews([backgroundView,downView])
        downView.addSubviews([userImageView,tableView])
        
        backgroundView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        userImageView.snp.makeConstraints { (make) in
            make.top.left.right.width.equalTo(downView)
            make.height.equalTo(self.downViewH/2)
        }
    
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.downViewH/2)
            make.left.right.width.equalTo(downView)
            make.height.equalTo(self.downViewH/2 - SafeBottomMargin)
        }
        
    }
    
    func setupUnqualifiedUI(){
        self.backgroundColor = UIColor.clear
        self.addSubviews([backgroundView,downView])
        
        backgroundView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        downView.backgroundColor = UIColor.white
    }
    
    fileprivate var PershowTimeList = ["姓名","男","21岁","水瓶座","语音签名","学校专业","职业信息"]
    
    struct PersonalShowItem {
        var title:String?
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PershowTimeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonalShowCell") as! PersonalShowCell
        cell.modelCell(mode: PershowTimeList[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01;
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view  = UIView.init()
        return view
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view  = UIView.init()
        return view
    }
    
}


class PersonalShowCell: UITableViewCell {
    
    lazy var titleLab:UILabel = {
        let Lab = UILabel.init()
        Lab.textAlignment = NSTextAlignment.left
        //        nameLab.font = CYTPingFangFont.pingFangRegularFont(size: 14)
        Lab.textColor = ColorNavigationBar
        return Lab
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createUI(){
        self.contentView.addSubviews([titleLab])
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp_left).offset(15)
            make.right.equalTo(self.contentView.snp_right).offset(-15)
            make.top.bottom.equalToSuperview()
        }
    }
    
    func modelCell(mode:String){
        titleLab.text = mode
    }
}
