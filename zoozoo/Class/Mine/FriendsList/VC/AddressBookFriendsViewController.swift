//
//  AddressBookFriendsViewController.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/6/15.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit
import MessageUI
class AddressBookFriendsViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource{
    
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
        tableView.register(AddressBookCell.self, forCellReuseIdentifier: "AddressBookCell")
       
        
        
        return tableView
        
    }();
    var AddressBookdataArr = [AddressBookModel]()
    var dataArr = [BookFriendsDataModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "添加通讯录好友"
        self.view.addSubview(table)
        getAddressBookData()
      
    }
    func getAddressBookData(){
        
        AuthorityTool.authorizeToContaces { (isCan) in
            if isCan {
                let queue = DispatchQueue(label: "addressBook.array")
                queue.async {
                    AddressBookHandle().getAddressBookDataSource(addressBookModel: { (model) in
                        self.AddressBookdataArr.append(model)
                        
                        
                    }, authorizationFailure: {
                        self.getAuthorizeToContaces()
                        
                    })
                    
                    // 将联系人数组回调到主线程
                    DispatchQueue.main.async {
                        self.table.reloadData()
                        self.APPQueryByAddrBookURL()
                    }
                    
                }
                
               
            }else{
                 self.getAuthorizeToContaces()
            }
        }
    }
    
    func getAuthorizeToContaces(){
        AlertActionSheetTool.showAlert(titleStr: "提示", msgStr: "请在iPhone的“设置-隐私-通讯录”选项中，允许ZOO访问您的通讯录", currentVC: self, cancelHandler: nil, otherBtns:["确定"]){(index) in
            if let appSettings = URL(string: UIApplication.openSettingsURLString)
            {
                UIApplication.shared.openURL(appSettings)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressBookCell") as! AddressBookCell
        cell.Model = self.dataArr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01;
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view  = UIView.init()
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view  = UIView.init()
        let title = UILabel.init(frame:CGRect(x: 15, y: 0, width:ScreenW, height: 40) )
        title.text = "你的联系人"
        title.textAlignment = .left
        view.backgroundColor = ColorWhite
        title.textColor = ColorGrayColor
        title.font = UIFont.boldSystemFont(ofSize: 14)
        view.addSubview(title)
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
  
    
}


// MARK: - HTTP
extension AddressBookFriendsViewController{
    //寻找小怪兽
    private func APPQueryByAddrBookURL(){
        
        FriendsAPI.shared.APPQueryByAddrBookURL(phones: self.AddressBookdataArr, success: { (json) in
            if let response = BookFriendsModel.deserialize(from: json as? [String:Any]){
                if  response.code == 200{
                    self.dataArr = response.data
                    self.table.reloadData()
                    
                    
                }
            }
        }) { (error) in
            ShowMessageTool.shared.showMessage("网络异常")
        }
    }
}




class AddressBookCell: UITableViewCell {
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
    lazy var headerImageBtn:UIButton = {
        let Btn = UIButton.init(type: .custom)
        Btn.layer.cornerRadius  = 20
        Btn.layer.masksToBounds = true
        Btn.isHidden = true
        Btn.setTitleColor(ColorWhite, for: .normal)
        
        Btn.titleLabel?.font = UIFont.pingFangMediumFont(size: 14)
        Btn.addTarget(self, action: #selector(Takehome), for: .touchUpInside)
        return Btn
    }()
    
    lazy var titleLab:UILabel = {
        let Lab = UILabel.init()
        Lab.textAlignment = NSTextAlignment.left
        
        Lab.font = UIFont.boldSystemFont(ofSize: 14)
        Lab.textColor = ColorMinePolicyTitle
        return Lab
    }()
    
    lazy var TakehomeBtn:UIButton = {
        let Btn = UIButton.init(type: .custom)
        Btn.layer.cornerRadius  = 15
        Btn.layer.masksToBounds = true
        Btn.setTitle("抱他回家", for: .normal)
        Btn.setTitleColor(ColorWhite, for: .normal)
       
        Btn.titleLabel?.font = UIFont.pingFangMediumFont(size: 14)
        Btn.addTarget(self, action: #selector(Takehome), for: .touchUpInside)
        return Btn
    }()
    lazy var InviteBtn:UIButton = {
        let Btn = UIButton.init(type: .custom)
        Btn.layer.cornerRadius  = 15
        Btn.layer.masksToBounds = true
        Btn.setTitle("邀请", for: .normal)
        Btn.setTitleColor(ColorTitle, for: .normal)
        Btn.setBackgroundColor(ColorLine, forState: .normal)
        Btn.titleLabel?.font = UIFont.pingFangMediumFont(size: 14)
        Btn.addTarget(self, action: #selector(Invite), for: .touchUpInside)
        return Btn
    }()
    
    
    lazy var line:UILabel = {
        let label = UILabel.init()
        label.backgroundColor = ColorLine
        return label
    }()
    
    
    private func createUI(){
        self.contentView.addSubviews([UserImage,headerImageBtn,titleLab,TakehomeBtn,InviteBtn,line])
        UserImage.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.width.height.equalTo(40)
            make.centerY.equalToSuperview()
        }
        headerImageBtn.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.width.height.equalTo(40)
            make.centerY.equalToSuperview()
        }
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(UserImage.snp_right).offset(10)
            make.height.equalTo(15)
            make.right.equalTo(-100)
            make.centerY.equalToSuperview()
        }
        TakehomeBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
        InviteBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
            make.width.equalTo(60)
            make.height.equalTo(30)
        }
       
        line.snp.makeConstraints { (make) in
            make.left.equalTo(65)
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        TakehomeBtn.addButtonGradientLayer()
        
         headerImageBtn.addGradientLayer(colors: [UIColor.colorWithHex(hex: 0x9F9BD4).cgColor, UIColor.colorWithHex(hex: 0xF4F3FF).cgColor])
    }
    
    public var Model : BookFriendsDataModel? {
        didSet{
            guard let model = Model else {
                return
            }
       
            titleLab.text = model.nickname
            
            //0新用户显示邀请按钮 1老用户可以领养 2老用户不可领养
            if model.status == 0 {
                TakehomeBtn.isHidden = true
                InviteBtn.isHidden = false
            }else if model.status == 1 {
                TakehomeBtn.isHidden = false
                InviteBtn.isHidden = true
            }else{
                TakehomeBtn.isHidden = true
                InviteBtn.isHidden = true
            }
            
            
            if model.avatar == nil {

                if model.nickname?.count == 0 {
                    UserImage.isHidden = false
                    headerImageBtn.isHidden = true
                    UserImage.image = UIImage.init(named: "PersionalIocn")
                }else{
                    UserImage.isHidden = true
                    headerImageBtn.isHidden = false

                    self.headerImageBtn.setTitle(model.nickname?.first(), for: .normal)
                }

            }else{
                UserImage.isHidden = false
                headerImageBtn.isHidden = true

                UserImage.kf.setImage(urlString: model.avatar)
            }
            
        }
    }
  
    @objc func Takehome(){
        guard let userId = Model?.userId else {
            return
        }
        
        HomeAPI.shared.APPAdoptAnimalURL(beAdoptedUserId: userId, success: { (json) in
            //code码: 506一种类型的宠物只能领养一个,507 该宠物已经被其他用户领取
            let data = json["data"] as? NSDictionary
            let code = data?.object(forKey: "code") as? Int
            if code == 1 {
                ShowMessageTool.shared.showMessage("领养成功")
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
   @objc func Invite(){
        guard let phones = Model?.phone else {
            ShowMessageTool.shared.showMessage("手机号不正确")
            return
        }
        guard MFMessageComposeViewController.canSendText() else {
            
            ShowMessageTool.shared.showMessage("不能发送短信")
            
            return
            
        }
        
        let messageVC = MFMessageComposeViewController()
        messageVC.navigationBar.isTranslucent = false
        messageVC.messageComposeDelegate = self // 代理
        
        messageVC.recipients = [phones]// 收件人
        
        messageVC.body = "下载该应用\(BaseConfig.shared.appURL)"// 内容
        self.XZBCuruntView().present(messageVC, animated:true, completion:nil)
    }
}
// MARK: - MFMessageComposeViewControllerDelegate
extension AddressBookCell : MFMessageComposeViewControllerDelegate{
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated:true, completion:nil)
        switch result {
        case .cancelled:
            ShowMessageTool.shared.showMessage("短信发送取消")
            break
        case .sent:
            ShowMessageTool.shared.showMessage("短信发送成功")
            break
        case .failed:
            ShowMessageTool.shared.showMessage("短信发送失败")
            break
        default:
            break
        }
    }
    

}

