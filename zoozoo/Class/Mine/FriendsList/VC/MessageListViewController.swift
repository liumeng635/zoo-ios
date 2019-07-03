//
//  MessageListViewController.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/6/14.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class MessageListViewController: BaseViewController {
    
    let guardHeadView = FriendGuardHeadView.init(frame: CGRect.init(x: 0, y: navigationBarHeight, width: ScreenW, height: 90))
    
    lazy  var table:UITableView = {
        
        let tableView = UITableView.init(frame:  CGRect.init(x: 0, y: navigationBarHeight + 90, width: ScreenW, height: ScreenH - navigationBarHeight - 90), style: UITableView.Style.grouped)
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
        tableView.isHidden = true
        tableView.register(MessageListViewCell.self, forCellReuseIdentifier: "MessageListViewCell")
        
        
        return tableView
        
    }();
    lazy var rightButton : UIButton = {
        
        let Btn = UIButton.init(type: .custom)
        let backImage = UIImage.init(named: "AddFriends")!
        Btn.setImage(backImage, for: .normal)
        Btn.frame = CGRect.init(x: 15, y: statusBarH + 15, width: backImage.size.width, height: backImage.size.height)
        Btn.contentHorizontalAlignment = .right
        Btn.addTarget(self, action: #selector(moreAction), for: .touchUpInside)
        return Btn
        
    }()
    var dataArr = [FriendsOwnerModel]()
    var lastUserId = ""
    var friendUserId = ""
    
    var editingIndexPath = IndexPath.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        configtableUI()
    
        APPUserFriendListURL()
        refeshData()
        loadMoreData()
    }
    
    func configtableUI(){
        self.title = "我的好友"
        view.addSubview(table)
        view.addSubview(guardHeadView)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
       
    }
    
    
    
    @objc func moreAction(){
        let vc = AddFriendsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
// MARK : - UITableViewDataSource
extension MessageListViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageListViewCell", for: indexPath) as! MessageListViewCell
        cell.Model = self.dataArr[indexPath.row]
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let disLoveAction = UITableViewRowAction.init(style: .normal, title: nil) { (action, indexPath) in
            tableView.setEditing(false, animated: true)
        }
        return [disLoveAction]
    }
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        self.editingIndexPath = indexPath
        self.viewDidLayoutSubviews()
    }
    
    
}
extension MessageListViewController {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if #available(iOS 11.0, *) {
            for subview in self.table.subviews where subview.isKind(of: NSClassFromString("UISwipeActionPullView")!) {
                subview.backgroundColor = ColorLine
                if subview.subviews.count >= 1 {
                    
                    
                    self.configDisLoveButton(button:subview.subviews[0] as! UIButton)
                }
            }
            
        } else {    // IOS 10以及以下
            for subview in self.table.subviews where subview.isKind(of: NSClassFromString("UITableViewCellDeleteConfirmationView")!) {
                subview.backgroundColor = ColorLine
                if subview.subviews.count >= 1 {
                     self.configDisLoveButton(button:subview.subviews[0] as! UIButton)
                   
                    
                }
            }
        }
    }
    
  
    func configDisLoveButton(button :UIButton){
        button.backgroundColor = ColorLine
        button.setImage(UIImage.init(named: "likedown"), for: .normal)
        button.addTarget(self, action: #selector(self.DisLove), for: .touchUpInside)
        
    }
    @objc private func DisLove(){
        guard let name =  self.dataArr[self.editingIndexPath.row].nickname else {
            return
        }
        
        let view = AlertOverRelationshipView.init(nameTitle: name)
        view.show()
        view.overRelationshipAlertClickBlock = {[weak self] in
           
            self?.AlertOverRelationshipLove()
            
        }
    }
    func AlertOverRelationshipLove(){
        guard let userID =  self.dataArr[self.editingIndexPath.row].userId else {
            return
        }
        
        FriendsAPI.shared.APPUserFriendDeleteURL(friendUserId: userID, success: { (json) in
            let dic = json as? NSDictionary
            let code = dic?.object(forKey: "code") as? Int
            if code == 200 {
                ShowMessageTool.shared.showMessage("解除成功")
                if #available(iOS 11.0, *) {
                    self.table.performBatchUpdates({
                        self.dataArr.remove(at: self.editingIndexPath.row)
                        self.table.deleteRows(at: [self.editingIndexPath], with: .fade)
                    }) { (finished) in
                        if self.dataArr.count == 0{
                            self.APPUserFriendListURL()
                        }
                        
                        self.table.reloadData()
                    }
                } else {
                    self.dataArr.remove(at: self.editingIndexPath.row)
                    self.table.deleteRows(at: [self.editingIndexPath], with: .fade)
                    if self.dataArr.count == 0{
                        self.APPUserFriendListURL()
                    }
                    self.table.reloadData()
                }
                
            }else{
                ShowMessageTool.shared.showMessage("解除失败")
            }
        }) { (error) in
            ShowMessageTool.shared.showMessage("接口异常")
        }
        
        
        
    }
    
  
}

// MARK: - UITableViewDelegate
extension MessageListViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
}


// 处理 好友 状态
extension MessageListViewController{
    
    //  MARK:加载更多
    func loadMoreData(){
        self.table.ZFoot = RefreshDiscoverFooter{[weak self] in
            guard let self = self else {
                return
            }
            self.APPUserFriendListURL()
        }
        
        
        
    }
    func refeshData(){
        self.table.ZHead = RefreshHeader{[weak self] in
            guard let self = self else {
                return
            }
            self.lastUserId = ""
            self.APPUserFriendListURL()
        }
        
        
        
    }
    func APPUserFriendListURL(){
        if self.dataArr.count > 0 {
            self.dataArr.removeLast()//删除管理员
        }
        
        FriendsAPI.shared.APPUserFriendListURL(lastUserId: lastUserId, success: { (json) in
            if let response = BaseFriendsModel.deserialize(from: json as? [String:Any]){
                if response.code == 200 {
                    let array = response.data?.friends ?? [FriendsOwnerModel]()
                    let adminFriend = response.data?.adminFriend
                    if self.lastUserId.isEmpty {
                        self.dataArr.removeAll()
                        let model = response.data?.currentOwner
                        if model?.avatar?.isEmpty == false{
                            self.guardHeadView.Model = model
                        }
                    }
                   
                    self.dataArr += array
                    if array.count == 0 {
                        self.table.ZFoot?.endRefreshingWithNoMoreData()
                    }else{
                        self.lastUserId = self.dataArr.last?.userId ?? ""
                        self.table.ZFoot?.endRefreshing()
                        if array.count < 10 {
                            self.table.ZFoot?.endRefreshingWithNoMoreData()
                        }
                    }
                    self.table.ZHead?.endRefreshing()
                   
                    self.table.isHidden = false
                    
                    self.dataArr.append(adminFriend ?? FriendsOwnerModel())//添加管理员
                    self.table.reloadData()
                    
                }else{
                    ShowMessageTool.shared.showMessage("获取好友列表失败")
                    self.table.ZHead?.endRefreshing()
                    self.table.ZFoot?.endRefreshing()
                }
            }
            
        }) { (error) in
            ShowMessageTool.shared.showMessage("获取好友列表失败")
            self.table.ZHead?.endRefreshing()
            self.table.ZFoot?.endRefreshing()
        }
        
    }
    
    
    //解除好友关系
    private func APPUserFriendDeleteURL(){
       
        FriendsAPI.shared.APPUserFriendDeleteURL(friendUserId: friendUserId, success: { (json) in
            let dic = json as? NSDictionary
            let code = dic?.object(forKey: "code") as? Int
            if code == 200 {
                
            }else{
                ShowMessageTool.shared.showMessage("解除失败")
            }
        }) { (error) in
            ShowMessageTool.shared.showMessage("解除失败")
        }
        
    }
}




