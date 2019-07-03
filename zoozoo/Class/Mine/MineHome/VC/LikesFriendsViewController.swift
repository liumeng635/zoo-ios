//
//  LikesFriendsViewController.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/6/13.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class LikesFriendsViewController: BaseViewController {

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
        tableView.backgroundColor = ColorWhite
        tableView.isHidden = true
        tableView.register(LikesFriendsTableViewCell.self, forCellReuseIdentifier: "LikesFriendsTableViewCell")
        
        
        return tableView
        
    }();
    lazy  var noDataView:LikesNoDataView = {
        let noDataView =  LikesNoDataView.init()
        noDataView.isHidden = true
        return noDataView
    }();
   
    
    var editingIndexPath = IndexPath.init()
    
    var lastLikeTime = ""
    var type = 0 //列表类型 0喜欢我的 1我喜欢的
    var userID = ""
    var isMine = true//是否为主人状态页面
    var dataArr = [UserLikesModel]()
    var noDataType = LikesNoDataType.mineLike
    
    
    
    init(userID :String ,type :Int ,isMine :Bool) {
        super.init(nibName: nil, bundle: nil)
        self.userID  = userID
        self.type  = type
        self.isMine  = isMine
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTitleUI()
        configNoDataView()
        loadData()
        refeshData()
        loadMoreData()
  
    }
    
    func configNoDataView(){
        noDataView = LikesNoDataView.init(type: self.noDataType, frame: self.table.frame)
        noDataView.isHidden = true
        noDataView.noDataClickBlock = {[unowned self] in
           
            self.clickLove()
        }
        
        self.view.addSubview(noDataView)
    }
    
    
    func configTitleUI(){
        if isMine {
            if type == 0{
                self.title = "这些人喜欢我"
                self.noDataType = .mineLike
            }else{
                self.title = "我喜欢的小乖兽"
                self.noDataType = .mineAnimal
            }
        }else{
            if type == 0{
                self.title = "这些人喜欢TA"
                self.noDataType = .personLike
            }else{
                self.title = "TA喜欢的小乖兽"
                self.noDataType = .personAnimal
            }
        }
        view.addSubview(table)
    }
    
    
    
    
}
extension LikesFriendsViewController {
    //  MARK:加载更多
    func loadMoreData(){
        self.table.ZFoot = RefreshDiscoverFooter{[weak self] in
            guard let self = self else {
                return
            }
            self.loadData()
        }
        
        
        
    }
    func refeshData(){
        self.table.ZHead = RefreshHeader{[weak self] in
            guard let self = self else {
                return
            }
            self.lastLikeTime = ""
            self.loadData()
        }
        
        
        
    }
    func loadData(){
        PersonalAPI.shared.APPUserLikesURL(type: type, lastLikeTime: lastLikeTime, userId: userID, success: { (json) in
            if let response = BaseUserLikesModel.deserialize(from: json as? [String:Any]){
                if  response.code == 200{
                    let array = response.data
                    if self.lastLikeTime.isEmpty {
                        self.dataArr.removeAll()
                    }
                    if self.isMine == false {
                        //陌生人访问的列表没有领养按钮
                        array.forEach({ (UserLikesModel) in
                            UserLikesModel.type = 0
                            self.dataArr.append(UserLikesModel)
                        })
                    }else{
                         self.dataArr += array
                    }
                    
                    if array.count == 0 {
                        
                        self.table.ZFoot?.endRefreshingWithNoMoreData()
                    }else{
                        self.lastLikeTime = self.dataArr.last?.likeTime ?? ""
                        self.table.ZFoot?.endRefreshing()
                        if array.count < 10 {
                            self.table.ZFoot?.endRefreshingWithNoMoreData()
                        }
                    }
                    self.table.ZHead?.endRefreshing()
                    
                    self.noDataView.isHidden = self.dataArr.count > 0
                    
                    self.table.isHidden = false
                    
                    self.table.reloadData()
                    
                }else{
                    self.table.ZHead?.endRefreshing()
                    self.table.ZFoot?.endRefreshing()
                }
            }
            
        }) { (error) in
            self.table.ZHead?.endRefreshing()
            self.table.ZFoot?.endRefreshing()
        }
        
    }
    
    func clickLove(){
        HomeAPI.shared.APPUserLikeURL(beLikedUserId: self.userID, success: { (json) in
            let dic = json as? NSDictionary
            let code = dic?.object(forKey: "code") as? Int
            if code == 200 {
                self.loadData()
            }else{
                ShowMessageTool.shared.showMessage("喜欢失败")
            }
        }) { (error) in
            
        }
    }
}

// MARK : - UITableViewDataSource
extension LikesFriendsViewController : UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LikesFriendsTableViewCell", for: indexPath) as! LikesFriendsTableViewCell
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
        return isMine
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction.init(style: .normal, title: nil) { (action, indexPath) in
            tableView.setEditing(false, animated: true)
        }
      
        return [deleteAction]
    }
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        self.editingIndexPath = indexPath
        self.viewDidLayoutSubviews()
    }
  
    
}
extension LikesFriendsViewController {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if #available(iOS 11.0, *) {
            for subview in self.table.subviews where subview.isKind(of: NSClassFromString("UISwipeActionPullView")!) {
                subview.backgroundColor = ColorLine
                if subview.subviews.count >= 1 {
                   
                    self.configDeleteButton(button: subview.subviews[0] as! UIButton)
                   
                }
            }
            
        } else {    // IOS 10以及以下
            for subview in self.table.subviews where subview.isKind(of: NSClassFromString("UITableViewCellDeleteConfirmationView")!) {
                subview.backgroundColor = ColorLine
                if subview.subviews.count >= 1 {
                    self.configDeleteButton(button: subview.subviews[0] as! UIButton)
                   
                }
            }
        }
    }
    
    func configDeleteButton(button :UIButton){
        button.backgroundColor = ColorLine
        button.setImage(UIImage.init(named: "tableDelete"), for: .normal)
        button.addTarget(self, action: #selector(self.Delete), for: .touchUpInside)
        
    }
    
    @objc private func Delete(){
        guard let userID =  self.dataArr[self.editingIndexPath.row].userId else {
            return
        }
        var beLikedUserId = ""
        var likeUserId = ""
        
        ////列表类型 0喜欢我的 1我喜欢的
        if type == 1 {
            beLikedUserId = userID
            likeUserId = GlobalDataStore.shared.currentUser.uid
        }else{
            likeUserId = userID
            beLikedUserId = GlobalDataStore.shared.currentUser.uid
        }
        HomeAPI.shared.APPUserLikeCancelURL(beLikedUserId: beLikedUserId, likeUserId: likeUserId, success: { (json) in
            let dic = json as? NSDictionary
            let code = dic?.object(forKey: "code") as? Int
            if code == 200 {
                if #available(iOS 11.0, *) {
                    self.table.performBatchUpdates({
                        self.dataArr.remove(at: self.editingIndexPath.row)
                        self.table.deleteRows(at: [self.editingIndexPath], with: .fade)
                    }) { (finished) in
                        if self.dataArr.count == 0{
                            self.loadData()
                        }
                        
                        self.table.reloadData()
                    }
                } else {
                    self.dataArr.remove(at: self.editingIndexPath.row)
                    self.table.deleteRows(at: [self.editingIndexPath], with: .fade)
                    if self.dataArr.count == 0{
                        self.loadData()
                    }
                    self.table.reloadData()
                }
                
            }else{
                ShowMessageTool.shared.showMessage("删除失败")
            }
        }) { (error) in
            ShowMessageTool.shared.showMessage("接口异常")
        }
        
        
        
    }
    
}

// MARK: - UITableViewDelegate
extension LikesFriendsViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
}


class LikesFriendsTableViewCell: UITableViewCell {
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        self.createUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    lazy var avatarV:UIImageView = {
        let avatar = UIImageView.init()
        avatar.layer.cornerRadius = 25.0
        avatar.layer.masksToBounds = true
        avatar.isUserInteractionEnabled = true
        avatar.contentMode = .scaleAspectFill

        avatar.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(gotoSelf)))
        return avatar
    }()
    
    lazy var nameLab:UILabel = {
        let nameLab = UILabel.init()
        nameLab.textAlignment = NSTextAlignment.left
        nameLab.font = UIFont.boldSystemFont(ofSize: 16)
        nameLab.textColor = ColorTitle
        return nameLab
    }()
    lazy var sex:UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "man")
        return imageV
    }()
    
    lazy var constellation:UIImageView = {
        let imageV = UIImageView.init()
        return imageV
    }()
    lazy var voiceButton : UIButton = {
        
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "smallPlay"), for: .normal)
        button.addTarget(self, action: #selector(playVoice), for: .touchUpInside)
        return button
    }()
   
    
   
    lazy var contentLab:UILabel = {
        let contentLab = UILabel.init()
        contentLab.textAlignment = NSTextAlignment.left
        contentLab.font = UIFont.pingFangTextFont(size: 14)
        contentLab.textColor = ColorGrayTitle
        nameLab.text = "我在这里的的函数名护甲你就看见简介"
        return contentLab
    }()
   
    
    lazy var line:UIView = {
        let line = UIView.init()
        line.backgroundColor = ColorLine
        return line
    }()
    lazy var loveButton : UIButton = {
        
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "LOVE"), for: .normal)
        button.addTarget(self, action: #selector(loveClick), for: .touchUpInside)
        return button
    }()
    lazy var arrowiamge:UIImageView = {
        let arrow = UIImageView.init()
        arrow.image = UIImage.init(named: "cellArrow")
        arrow.isHidden = true
        return arrow
    }()
    
    private func createUI(){
        self.contentView.addSubviews([avatarV,nameLab,sex,constellation,voiceButton,contentLab,loveButton,line,arrowiamge])
        
        avatarV.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(15)
            make.width.height.equalTo(50)
        }
       
        
        nameLab.snp.makeConstraints { (make) in
            make.left.equalTo(avatarV.snp.right).offset(15)
            make.top.equalTo(15)
            make.height.equalTo(20)
        }
        sex.snp.makeConstraints() { (make) in
            make.left.equalTo(nameLab.snp.right).offset(5)
            make.top.equalTo(15)
            make.width.equalTo(15)
            make.height.equalTo(15)
        }
        
        constellation.snp.makeConstraints() { (make) in
            make.left.equalTo(sex.snp.right).offset(5)
            make.top.equalTo(sex.snp.top)
            make.width.equalTo(45)
            make.height.equalTo(15)
        }
        voiceButton.snp.makeConstraints() { (make) in
            make.left.equalTo(constellation.snp.right).offset(5)
            make.top.equalTo(sex.snp.top)
            make.width.equalTo(15)
            make.height.equalTo(15)
        }
        
        contentLab.snp.makeConstraints { (make) in
            make.left.equalTo(avatarV.snp.right).offset(15)
            make.right.equalTo(-80)
            make.top.equalTo(nameLab.snp.bottom).offset(10)
            make.height.equalTo(20)
        }
        loveButton.snp.makeConstraints() { (make) in
            make.right.equalTo(-15)
            make.top.equalTo(20)
            make.width.height.equalTo(40)
        }
        
        line.snp.makeConstraints { (make) in
            make.left.equalTo(80)
            make.bottom.right.equalToSuperview()
            make.height.equalTo(0.5)
        }
        arrowiamge.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(-15)
            make.width.height.equalTo(15)
        }
        
    }
    
    public var Model: UserLikesModel?{
        didSet {
            guard let model = Model else {
                return
            }
            let petUrl = "\(model.petImage ?? "")\(BottomQiuniuUrl)"
            avatarV.kf.setImage(urlString: petUrl)
            let colors = model.backImage?.components(separatedBy: ",")
            avatarV.backgroundColor = UIColor.init(hexString: colors?.first ?? "#6760D4")
            
            nameLab.text = model.petNickname
            sex.image = model.sex == 1 ? UIImage.init(named: "man") : UIImage.init(named: "women")
            
            contentLab.text = "\(model.area ?? "")\(model.age ?? 18)岁"
            constellation.image = UIImage.init(named: model.constellation ?? "金牛座")
            if model.type == 0 {
                if model.isEach == 0{
                    //是否互相喜欢 0单向 1双向(喜欢我的)
                    loveButton.setImage(UIImage.init(named: "LOVE"), for: .normal)
                }else{
                    loveButton.setImage(UIImage.init(named: "friends"), for: .normal)
                }
            }else {
                //是否已经有主人了 0没有 1有(我喜欢的)
                if model.hasMaster == 1 {
                    loveButton.isHidden = true
                    arrowiamge.isHidden = false
                }else{
                    arrowiamge.isHidden = true
                    loveButton.isHidden = false
                    loveButton.setImage(UIImage.init(named: "HomePet"), for: .normal)
                }
            }
            
            
            
            
        }
    }
}
extension LikesFriendsTableViewCell {
    @objc private func playVoice(){

        guard let voiceIntro = Model?.voiceIntro else {
            return
        }
       
        VoiceAudioUrlPlayer.shared.playAudioUrl(audioUrl: voiceIntro)
        
    }
    @objc private func gotoSelf(){
        guard let userId = Model?.userId else {
            return
        }
        
        
        let vc = PageSpaceViewController.init(userID: userId)
        
        self.XZBCuruntView().navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @objc private func loveClick(){
        guard let userId = Model?.userId, let type = Model?.type ,let model = Model else {
            return
        }
        if type == 0 {
            if model.isEach == 0{
                //是否互相喜欢 0单向 1双向(喜欢我的)
                loveButton.setImage(UIImage.init(named: "LOVE"), for: .normal)
                HomeAPI.shared.APPUserLikeURL(beLikedUserId: userId, success: { (json) in
                    let dic = json as? NSDictionary
                    let code = dic?.object(forKey: "code") as? Int
                    if code == 200 {
                        model.isEach = 1
                        self.loveButton.setImage(UIImage.init(named: "friends"), for: .normal)
                    }else{
                        ShowMessageTool.shared.showMessage("喜欢失败")
                    }
                }) { (error) in
                    
                }
            }
            
        }else{
            HomeAPI.shared.APPAdoptAnimalURL(beAdoptedUserId: userId, success: { (json) in
                //code码: 506一种类型的宠物只能领养一个,507 该宠物已经被其他用户领取
                let data = json["data"] as? NSDictionary
                let code = data?.object(forKey: "code") as? Int
                
                if code == 1 {
                    model.hasMaster = 1
                    self.loveButton.isHidden = true
                    self.arrowiamge.isHidden = false
                    let chooseView = CardChooseAnimal3DView.init(imageUrl: model.petImage ?? "", userID: userId)
                    chooseView.show()
                }else if code == 506 {
                    
                    SystemTipsView.init(title: "留点机会给别人吧", deTitle: "你当前已拥有一个果冻熊好友\n 先去抱抱其他种类的朋友", H: 120).show()
                    
                }else if code == 507 {
                    SystemTipsView.init().show()
                }else if code == 508 {
                    SystemTipsView.init().show()
                }
                else{
                    ShowMessageTool.shared.showMessage("领养失败")
                    
                }
            }) { (error) in
                ShowMessageTool.shared.showMessage("领养失败")
            }
        }
       
    }
    
}
