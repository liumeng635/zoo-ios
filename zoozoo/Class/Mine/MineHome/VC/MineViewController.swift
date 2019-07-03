//
//  MineViewController.swift
//  zoozoo
//
//  Created by 苹果上的豌豆 on 2019/5/15.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit
import StoreKit
import SwiftyJSON


class MineViewController: BaseViewController {
    
    let headView = MineHeadView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenW , height: HeadMineH))
    
    lazy  var tableView:UITableView = {
        
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenW, height: ScreenH - SafeBottomMargin), style: UITableView.Style.grouped)
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
//        tableView.isHidden = true
        tableView.register(changeAppIconCell.self, forCellReuseIdentifier: "changeAppIconCell")
        tableView.register(normalPersonalCell.self, forCellReuseIdentifier: "normalPersonalCell")
        
        
        return tableView
        
    }();
  
    var MineModel = MineHomeDetailModel()
   
    var APPIconTaskModel = APPIconTackModel()
    
    
    var prsonalData = ["更换图标","设置","推荐给好友","评分"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fd_prefersNavigationBarHidden = true
        createUI()
        APPGetUserHomeURL()
        APPIconTaskInfoURL()
      
    }
    
    func createUI(){
        
        view.addSubview(tableView)
        self.tableView.tableHeaderView = self.headView
        self.headView.addSubviews([back,NavigationTitleLabel])
        NavigationTitleLabel.text = "我的"
  
    }
   
}
extension MineViewController : SKStoreProductViewControllerDelegate{
    func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
        self.dismiss(animated: true, completion: nil)
    }
}

//  MARK  tableViewDelegate
extension  MineViewController  : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return prsonalData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "changeAppIconCell") as! changeAppIconCell
            cell.Model = self.APPIconTaskModel
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "normalPersonalCell") as! normalPersonalCell
            cell.titleLab.text = prsonalData[indexPath.section]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         if indexPath.section == 0{
            return  (ScreenW-105)/4+70
        }else{
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10;
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

// MARK: - UITableViewDelegate
extension MineViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let vc = MessageListViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        if indexPath.section == 1 {
            let vc = SetUpViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        if indexPath.section == 2 {
            ShareView.init().show()
        }
        
        if indexPath.section == 3 {
            if #available(iOS 10.3, *) {
                SKStoreReviewController.requestReview()
            } else {
                UIApplication.shared.openURL(URL.init(string: BaseConfig.shared.appURL)!)
                
            }
        }
    }
}
extension MineViewController : UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        self.headView.scrollViewDidScroll(offsetY: offsetY)
    }
    
}
extension MineViewController{
    private  func APPGetUserHomeURL(){
        PersonalAPI.shared.APPGetUserHomeURL(success: { (json) in
            if let response = MineHomeModel.deserialize(from: json as? [String:Any]){
                if  response.code == 200{
                    
                    if let model = response.data {
                        self.MineModel = model
                        
                        if model.friends.count == 0 {
                            self.headView.h = HeadMineH - HeadWhiteH + 50
                        }else{
                            self.headView.h = HeadMineH
                        }
                        
                        self.headView.Model = model
                    }
                    self.tableView.isHidden = false
                    self.tableView.reloadData()
                   
                }else{
                    ShowMessageTool.shared.showMessage("请求失败")
                }
            }
        }) { (error) in
            ShowMessageTool.shared.showMessage("请求失败")
        }
    }
    
    
     private  func APPIconTaskInfoURL(){
        PersonalAPI.shared.APPUserHomeTaskInfoURL(success: { (json) in
            if let response = APPIconModel.deserialize(from: json){
                if  response.code == 200{
                    
                    if let model = response.data {
                        self.APPIconTaskModel = model
                        self.tableView.reloadData()
                    }
                }
            }
        }) { (error) in
            
        }
        
    }
    
    
}
