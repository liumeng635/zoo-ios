//
//  PersonalViewController.swift
//  zoozoo
//
//  Created by 你猜 on 2019/5/28.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class PersonalViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
   
    public  var changedMineHeadInfoBlock  : (() -> Void)?

    let headView = UserEditHeadView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenW , height: ScreenW/1.7))
    
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
        tableView.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = ColorBackGround
        tableView.register(EditNomalTableViewCell.self, forCellReuseIdentifier: "EditNomalTableViewCell")
    
        
        
        return tableView
        
    }();
 
    var personalDetail =  userModel()
    var FirstGroupTitle = [["姓名","语音签名","出生日期"],["星座","年龄","性别"],["城市","学校","职业"]]
    var TipsGroupTitle = [["添加你的姓名","添加你的语音签名","添加你的出生日期"],["添加你的星座","添加你的年龄","添加你的性别"],["添加你的城市","添加你的学校","添加你的职业"]]
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.changedMineHeadInfoBlock?()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.tableHeaderView = headView
        self.title = "编辑资料"
        APPGetUserDetailURL()

        
        self.headView.changeUserIconBlock = {[unowned self] in
            self.choosePhotoUserAvator()
        }
        
         NotificationCenter.default.addObserver(self, selector: #selector(reloadVoiceUrl), name: DIYVioceNotification, object: nil)
    }
    deinit {
        
        NotificationCenter.default.removeObserver(self)
    }
    @objc func reloadVoiceUrl(){
        self.personalDetail.voiceIntro = GlobalDataStore.shared.currentUser.voiceIntro
        self.tableView.reloadData()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return FirstGroupTitle.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FirstGroupTitle[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EditNomalTableViewCell") as! EditNomalTableViewCell
        cell.model = self.personalDetail
        cell.loadDataPersonCell(model: self.personalDetail, section: indexPath.section, row: indexPath.row, personTitle: FirstGroupTitle[indexPath.section][indexPath.row], addTips: TipsGroupTitle[indexPath.section][indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
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
        if title == "姓名" {
            upDateName()
        }
        if title == "语音签名" {
            upDateVoice()
        }
        if title == "出生日期" {
            upDateBrithday()
        }

        if title == "性别" {
            upDateSex()
        }
        if title == "城市" {
            upDateCity()
        }
       
        if title == "学校" {
            upDateSchool()
        }
        if title == "职业" {
            upDateProfession()
        }
       
    }

}
extension  PersonalViewController{
    private  func upDateName(){
        let editNickNameVC = EditProfileNickNameViewController()
        editNickNameVC.nickName = self.personalDetail.nickname ?? ""
        
        editNickNameVC.changedNickNameBlock = { [unowned self] (nickName) in
            self.personalDetail.nickname = nickName
            
            self.tableView.reloadRows(at: [IndexPath.init(row: 0, section: 0)], with: UITableView.RowAnimation.automatic)
            
        }
        
        self.navigationController?.pushViewController(editNickNameVC, animated: true)
        
    }
    
    private  func upDateVoice(){
        self.navigationController?.pushViewController(VoiceIntroViewController(), animated: true)
    }
    
    private  func upDateBrithday(){
        if self.personalDetail.canUpdateBirth == 0 {
            ShowMessageTool.shared.showMessage("您已经修改过一次，生日信息只能修改一次")
            return
        }
        
        let alertController = UIAlertController(title: "生日信息只能修改一次",
                                                message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "修改", style: .default, handler: {
            action in
            let view = ShowBirthdayView.init(Birthdaytime: "2018-05-20")
            view.show()
            view.datePickerBirthdayBlock = {[unowned self] (time) in
                self.personalDetail.birthday = time
                
                self.APPPersonInfoUpdateURL()
            }
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    private  func upDateSex(){
        let sheet = UIAlertController(title: "选择性别", message: nil, preferredStyle: .actionSheet)
        let manAction = UIAlertAction(title: "男", style: .default) { (action) in
            self.personalDetail.sex = 1
            
             self.APPPersonInfoUpdateURL()
        }
        let womenAction = UIAlertAction(title: "女", style: .default) { (action) in
            self.personalDetail.sex = 0
           
             self.APPPersonInfoUpdateURL()
        }
        sheet.addAction(manAction)
        sheet.addAction(womenAction)
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        sheet.addAction(cancel)
        self.navigationController?.present(sheet, animated: true, completion: nil)
        
    }
    private  func upDateCity(){
        LocationManager.shareManager.creatLocationManager().startLocation { (location, adress, error) in
            self.personalDetail.area = adress
            self.APPPersonInfoUpdateURL()
            
        }
        
    }
    private  func upDateSchool(){
        let VC = AddSchoolViewController.init(personalDetail: self.personalDetail)
        VC.changeSchoolBlock = { [unowned self] in
            self.tableView.reloadData()
           
        }
        
        self.navigationController?.pushViewController(VC, animated: true)
        
    }
    
    private  func upDateProfession(){
       
        APPGetValuesURL(type: "profession") //获取职业
        
    }
}

//MARK:请求数据和更新上传编辑资料
extension  PersonalViewController{
    private  func APPGetUserDetailURL(){
       PersonalAPI.shared.APPGetUserDetailURL(success: { (json) in
            if let response = PersonalModel.deserialize(from: json as? [String:Any]){
                if  response.code == 200{
                    
                    if let model = response.data {
                        self.personalDetail = model
                       
                        self.headView.loadHeadData(model: model)
                         GlobalDataStore.shared.currentUser.loadLoginData(model: model)
                        GlobalDataStore.shared.currentUser.saveToLocal()
                        
                    }
                    
                   self.tableView.isHidden = false
                    self.tableView.reloadData()
                }
            }
        }) { (error) in
            ShowMessageTool.shared.showMessage("请求失败")
        }
    }
    
    // 更新个人详细信息
    private func APPPersonInfoUpdateURL(){
        
        let model = self.personalDetail
        DIYAPI.shared.APPDIYChooseInfoUpdateURL(birthday: model.birthday ?? "", nickName: model.nickname ?? "", sex: model.sex ?? 1, petImage: "", petNickname: "", petVoice: "", petType: 0, backImage: "", profession: model.profession ?? "", area: model.area ?? "", avatar: model.avatar ?? "", departmentId: "", schoolId: model.schoolId ?? "", voiceIntro: model.voiceIntro ?? "", success: { (json) in
            
            let dic = json as? NSDictionary
            let code = dic?.object(forKey: "code") as? Int
            if code != 200 {
                ShowMessageTool.shared.showMessage("更新失败")
            }else{
                 self.tableView.reloadData()
                
                self.APPGetUserDetailURL()
            }
            
            
        }, failure: { (error) in
            ShowMessageTool.shared.showMessage("更新失败")
        })
    }
    
    // 获取 职业 星座
    private func APPGetValuesURL(type :String){
        
        BaseAPI.shared.APPGetValuesURL(codeType: type, success: { (json) in
            if let response = ProfessionModel.deserialize(from: json as? [String:Any]){
                if  response.code == 200{
                   
                     let arr = response.data
                    var codeValue = [String]()
                    arr.forEach({ (model) in
                        codeValue.append(model.codeValue ?? "")
                    })
                    
                    RPicker.selectOption(title: "", dataArray: codeValue) { (selectedText, atIndex) in
                        if type == "constellation" {
                            self.personalDetail.constellation = selectedText
                        }else{
                            self.personalDetail.profession = selectedText
                        }
                        self.APPPersonInfoUpdateURL()
                       
                    }
                }
            }
        }) { (error) in
           ShowMessageTool.shared.showMessage("请求失败")
        }
    }
    
    
}

//MARK:上传头像
extension  PersonalViewController{

    func choosePhotoUserAvator(){
        AvatarManager.sharedManager.showWith(parentViewController: self) { (imageUrl) in
            self.headView.userImageView.kf.setImage(urlString: imageUrl)
            self.personalDetail.avatar = imageUrl
            self.APPPersonInfoUpdateURL()
        }
  
    }
   

}

