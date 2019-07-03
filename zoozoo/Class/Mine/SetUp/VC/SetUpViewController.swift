//
//  SetUpViewController.swift
//  zoozoo
//
//  Created by 你猜 on 2019/6/5.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit
import Kingfisher

class SetUpViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource{
    lazy  var tableView:UITableView = {
        
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: navigationBarHeight, width: ScreenW, height: ScreenH - navigationBarHeight), style: UITableView.Style.grouped)
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
        tableView.register(SetUpViewCell.self, forCellReuseIdentifier: "SetUpViewCell")
        return tableView
        
    }();
    lazy var rightButton : UIButton = {
        
        let Btn = UIButton.init(type: .custom)
        let backImage = UIImage.init(named: "BarMore")!
        Btn.setImage(backImage, for: .normal)
        Btn.frame = CGRect.init(x: 15, y: statusBarH + 15, width: backImage.size.width, height: backImage.size.height)
        Btn.contentHorizontalAlignment = .right
        Btn.addTarget(self, action: #selector(moreAction), for: .touchUpInside)
        return Btn
        
    }()
    var FirstGroupTitle = [["新消息通知"],["账号安全","隐私设置","清理缓存"],["意见反馈","关于我们"]]
    var FirstGroupIcon = [["SetUpMsg"],["SetUpSave","SetUpset","SetUpdetele"],["SetUpNew","SetUpWe"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设置"
        view.addSubview(tableView)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightButton)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return FirstGroupTitle.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FirstGroupTitle[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SetUpViewCell") as! SetUpViewCell
      cell.loadData(icon: FirstGroupIcon[indexPath.section][indexPath.row], title: FirstGroupTitle[indexPath.section][indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let title = FirstGroupTitle[indexPath.section][indexPath.row]
        if title == "隐私设置"{
            let vc = PrivacySetViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        if title == "清理缓存"{
            clearCache()
            
        }
        
        if title == "账号安全"{
            let vc = ModifyPhoneControllerView()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        if title == "关于我们"{
            let vc = AboutViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}

extension SetUpViewController{
    func clearCache() {
        
        ShowMessageTool.shared.showMessage("清理缓存中，请稍微等待...")
        
        
        let fileManager = FileManager.default
        
        guard let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first,
            let files = fileManager.subpaths(atPath: cachePath) else { return }
        
        for file in files {
            
            let path = cachePath + "(/\(file))"
            if fileManager.fileExists(atPath: path) {
                
                do {
                    try fileManager.removeItem(atPath: path)
                } catch  {
                    print(error.localizedDescription)
                }
            }
        }
        
        kingfisherClear()
        
        DispatchQueue.main.asyncAfter(deadline: .now()+15, execute:
            {
                ShowMessageTool.shared.showMessage("清理成功")
                
        })
    }
    
    //清理kingfisher缓存
    func kingfisherClear(){
        //获取缓存
        let cache = KingfisherManager.shared.cache
        //设置最大磁盘缓存为500Mb，默认为无限制
        cache.maxDiskCacheSize = 500 * 1024 * 1024
        //设置最大缓存时间为4天，默认为1周
        cache.maxCachePeriodInSecond = 60 * 60 * 24 * 4
        //计算缓存占用的磁盘大小
        cache.calculateDiskCacheSize { (size) in
            
        }
        
        //清空存储器缓存
        cache.clearMemoryCache()
        //清空磁盘缓存
        cache.clearDiskCache()
        //清空失效和过大的缓存
        cache.cleanExpiredDiskCache()
        
    }
    @objc func moreAction(){
        AlertActionSheetTool.showRiskAlert(titleStr: nil, msgStr: nil, style:.actionSheet, currentVC: self, cancelHandler: nil, otherBtns: ["退出登录"]) { (_) in
            
            self.quitLoginAction()
            
        }
    }
    func quitLoginAction(){
        
        AlertActionSheetTool.showRiskAlert(titleStr: "提示", msgStr: "确认退出登录吗？", currentVC: self, cancelHandler: { (_) in
            
            
        }, otherBtns: ["确认"]) { (index) in
            
          
            GlobalDataStore.shared.currentUser.uid = "0"
            GlobalDataStore.shared.currentUser.isLogin = 0
            GlobalDataStore.shared.currentUser.saveToLocal()
            
            self.navigationController?.popViewController(animated: false)
            BaseEngine.shared.goHomeVC()
            
        }
        
    }
    
}
