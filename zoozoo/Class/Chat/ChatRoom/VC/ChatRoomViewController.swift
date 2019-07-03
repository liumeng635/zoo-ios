//
//  ChatRoomViewController.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/6/24.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

let ChatRoomHeadH = statusBarH + 80
class ChatRoomViewController: BaseViewController {
    
    let headView = ChatRoomHeadView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenW , height: ChatRoomHeadH))
    
    lazy var tableView:UITableView = {
        
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: ChatRoomHeadH, width: ScreenW, height: ScreenH - SafeBottomMargin - ChatRoomHeadH), style: UITableView.Style.grouped)
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
        tableView.register(ChatRoomBaseTableViewCell.self, forCellReuseIdentifier: "ChatRoomBaseTableViewCell")
        tableView.register(ChatRoomSystemTableViewCell.self, forCellReuseIdentifier: "ChatRoomSystemTableViewCell")
        tableView.register(ChatRoomTextTableViewCell.self, forCellReuseIdentifier: "ChatRoomTextTableViewCell")
        tableView.register(ChatRoomEmojiTableViewCell.self, forCellReuseIdentifier: "ChatRoomEmojiTableViewCell")
         tableView.register(ChatRoomFriendTableViewCell.self, forCellReuseIdentifier: "ChatRoomFriendTableViewCell")
        tableView.register(ChatRoomEducationTableViewCell.self, forCellReuseIdentifier: "ChatRoomEducationTableViewCell")
        return tableView
        
    }();
    var headModel = RaiseAnimalsModel()
    var isRefreshIng = false
    var dataArr = [ChatBaseModel]()
    var userID = ""
    var lastMessageId = ""
    init(userID :String ) {
        super.init(nibName: nil, bundle: nil)
        self.userID  = userID
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fd_prefersNavigationBarHidden = true
        view.addSubview(headView)
        createUI()
        startLoadRequest()
        refeshData()
    }
    
    func startLoadRequest(){
        let group = DispatchGroup()
        let queue = DispatchQueue(label: "ChatRoomQueue", attributes: .concurrent)
        queue.async(group: group){
            self.loadHeadDataURL()
        }
        group.notify(queue: queue){
            self.loadData()
        }
    }
    
    func createUI(){
        
        view.addSubview(tableView)
        
       
        
    }
    
    

}
extension  ChatRoomViewController{
    //  MARK:上拉加载更多
    func refeshData(){
        self.tableView.ZHead = RefreshHeader{[weak self] in
            guard let self = self else {
                return
            }
            
            self.lastMessageId = self.dataArr.first?.chatModel.id ?? "0"
            if self.lastMessageId == "0" {
                
                return
            }
            self.loadData()
        }
    }
    
    
    private  func loadData(){
        ChatRoomAPI.shared.APPChatRoomMessageListURL(beUserId: userID, lastMessageId: lastMessageId, success: { (json) in
            if let response = BaseChatRoomModel.deserialize(from: json as? [String:Any]){
                if  response.code == 200{
                    if self.lastMessageId.isEmpty {
                        self.dataArr.removeAll()
                    }
                    let array = response.data
                    let preCount = self.dataArr.count
                    UIView.setAnimationsEnabled(false)
                    self.processData(array: array)
                    let curCount = self.dataArr.count
                    if self.lastMessageId.isEmpty || preCount == 0 || (curCount - preCount) <= 0 {
                        self.scrollToBottom()
                    } else {
                        self.tableView.scrollToRow(at: IndexPath.init(row: curCount - preCount, section: 0), at: .top, animated: false)
                    }
  
                   self.tableView.ZHead?.endRefreshing()
                    if array.count == 0 || array.count < 10{
                        self.tableView.ZHead?.removeFromSuperview()
                    }
                    UIView.setAnimationsEnabled(true)
                    self.tableView.reloadData()
                    
                }else{
                    self.tableView.ZHead?.endRefreshing()
                    ShowMessageTool.shared.showMessage("请求失败")
                }
            }
        }) { (error) in
            self.tableView.ZHead?.endRefreshing()
             ShowMessageTool.shared.showMessage("请求失败")
        }
        
    }
    func processData(array:[ChatRoomModel]) {
        if array.count == 0 {
            return
        }
        self.dataArr.reverse()
        array.forEach({ (Model) in
            Model.headModel = self.headModel
            let model = ChatBaseModel.init(model: Model)
            self.dataArr.append(model)
        })
        self.dataArr.reverse()
        self.tableView.reloadData()
        
    }
    
    private  func loadHeadDataURL(){
        ChatRoomAPI.shared.APPChatRoomUserHeadURL(beUserId: userID, success: { (json) in
            if let response = ChatRoomHeadModel.deserialize(from: json as? [String:Any]){
                if  response.code == 200{
                    self.headModel = response.data ?? RaiseAnimalsModel()
                    self.headView.model = response.data
                }else{
                    ShowMessageTool.shared.showMessage("请求失败")
                }
            }
        }) { (error) in
            ShowMessageTool.shared.showMessage("请求失败")
        }
        
    }
    
    func scrollToBottom() {
        if self.dataArr.count > 0 {
            self.tableView.scrollToRow(at: IndexPath.init(row: self.dataArr.count-1, section: 0), at: .bottom, animated: false)
        }
    }
    
}

//  MARK  tableViewDelegate
extension  ChatRoomViewController  : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let feedType = self.dataArr[indexPath.row].FeedType
        switch feedType {
        case .nomal:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatRoomBaseTableViewCell") as! ChatRoomBaseTableViewCell
            cell.model = self.dataArr[indexPath.row]
            return cell
        case .system:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatRoomSystemTableViewCell") as! ChatRoomSystemTableViewCell
            cell.model = self.dataArr[indexPath.row].chatModel
            return cell
        case .text:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatRoomTextTableViewCell") as! ChatRoomTextTableViewCell
            cell.model = self.dataArr[indexPath.row]
            return cell
        case .emoji:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatRoomEmojiTableViewCell") as! ChatRoomEmojiTableViewCell
            cell.model = self.dataArr[indexPath.row].chatModel
            return cell
        case .education:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatRoomBaseTableViewCell") as! ChatRoomBaseTableViewCell
            
            return cell
        case .friend:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatRoomFriendTableViewCell") as! ChatRoomFriendTableViewCell
            cell.model = self.dataArr[indexPath.row].chatModel
            return cell
            
        }
        
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.dataArr[indexPath.row].cellHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
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
extension ChatRoomViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
