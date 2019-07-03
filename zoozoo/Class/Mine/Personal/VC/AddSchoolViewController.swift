//
//  AddSchoolViewController.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/6/12.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class AddSchoolViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource {
    
    public var changeSchoolBlock : (()->Void)?
    
    lazy  var tableView:UITableView = {
        
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: navigationBarHeight, width: ScreenW, height: ScreenH - SafeBottomMargin - navigationBarHeight), style: UITableView.Style.grouped)
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
        tableView.backgroundColor = .white
        tableView.register(EditNomalTableViewCell.self, forCellReuseIdentifier: "EditNomalTableViewCell")
        return tableView
        
    }();
   
    
    var GroupTitle = ["学校","院系"]
     var personalDetail =  userModel()
    var CollegeData = [ProfessionDetailModel]()
    
    init(personalDetail :userModel) {
        super.init(nibName: nil, bundle: nil)
        self.personalDetail  = personalDetail
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        self.title = "添加学校"
       
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GroupTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EditNomalTableViewCell") as! EditNomalTableViewCell
        
        cell.SchoolData(model: self.personalDetail, row: indexPath.row, personTitle: GroupTitle[indexPath.row])
        
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
        
        if indexPath.row == 0 {
            let vc = SearchSchoolViewController()
            vc.GetSearchForSchoolBlock = { [unowned self] (School , SchoolId) in
               self.personalDetail.schoolName = School
                self.personalDetail.schoolId = SchoolId
                self.APPDefautCollegeURL()   
            }
            let nav = NavigationController.init(rootViewController: vc)
            self.present(nav, animated: true, completion: nil)
        }else{
            
            if self.personalDetail.schoolName?.isEmpty == true{
                ShowMessageTool.shared.showMessage("请先选择学校")
            }else{
                APPGetCollegeURL()
            }
            
            
        }
        
        
    }
}

extension AddSchoolViewController{
    // 默认学院
    private func APPDefautCollegeURL(){
        
        guard let schoolID =  self.personalDetail.schoolId else {
            
            return
        }
        PersonalAPI.shared.APPDepartmentURL(schoolId: schoolID, success: { (json) in
            if let response = CollegeModel.deserialize(from: json as? [String:Any]){
                if  response.code == 200{
                    self.personalDetail.departmentName = response.data.first?.departmentName
                    
                   self.personalDetail.departmentId = response.data.first?.id
                    
                }else{
                    self.personalDetail.departmentName = ""
                    
                    self.personalDetail.departmentId = ""
                }
                self.APPPersonInfoUpdateURL()
            }else{
                self.tableView.reloadData()
            }
        }) { (error) in
           self.tableView.reloadData()
        }
    }
    

    
    // 获取学院
    private func APPGetCollegeURL(){
        
        guard let schoolID =  self.personalDetail.schoolId else {
            
            return
        }
        PersonalAPI.shared.APPDepartmentURL(schoolId: schoolID, success: { (json) in
            if let response = CollegeModel.deserialize(from: json as? [String:Any]){
                if  response.code == 200{
                    let arr = response.data
                    if arr.count == 0 {
                         ShowMessageTool.shared.showMessage("学院录入中")
                        return
                    }
                    var departmentNames = [String]()
                    arr.forEach({ (model) in
                        departmentNames.append(model.departmentName ?? "")
                    })
                    
                    RPicker.selectOption(title: "", dataArray: departmentNames) { (selectedText, atIndex) in
                        self.personalDetail.departmentName = selectedText
                        
                        arr.forEach({ (model) in
                            if selectedText == model.departmentName {
                                self.personalDetail.departmentId = model.id
                            }
                        })
                        self.APPPersonInfoUpdateURL()
                    }
                }
            }
        }) { (error) in
            ShowMessageTool.shared.showMessage("请求失败")
        }
    }
    
    // 更新个人详细信息
    private func APPPersonInfoUpdateURL(){
        
        let model = self.personalDetail
        DIYAPI.shared.APPDIYChooseInfoUpdateURL(birthday: model.birthday ?? "", nickName: model.nickname ?? "", sex: model.sex ?? 1, petImage: "", petNickname: "", petVoice: "", petType: 0, backImage: "", profession: model.profession ?? "", area: model.area ?? "", avatar: model.avatar ?? "", departmentId: model.departmentId ?? "", schoolId: model.schoolId ?? "", voiceIntro: model.voiceIntro ?? "", success: { (json) in
            
            let dic = json as? NSDictionary
            let code = dic?.object(forKey: "code") as? Int
            if code != 200 {
                ShowMessageTool.shared.showMessage("更新失败")
            }else{
                self.changeSchoolBlock?()
                self.tableView.reloadData()
            }
        }, failure: { (error) in
            ShowMessageTool.shared.showMessage("更新失败")
        })
    }
    
}

