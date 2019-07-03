//
//  RaiseOverRelationViewController.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/6/26.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class RaiseOverRelationViewController: BaseViewController {

    lazy var reportLab:UILabel = {
        let Lab = UILabel.init()
        Lab.textAlignment = NSTextAlignment.left
        Lab.font = UIFont.boldSystemFont(ofSize: 14)
        Lab.textColor = ColorTitle
        Lab.text = "是我的小乖兽，我要与他解除当前关系"
        return Lab
    }()
    lazy var nameLab:UILabel = {
        let Lab = UILabel.init()
        Lab.textAlignment = NSTextAlignment.left
        Lab.font = UIFont.pingFangTextFont(size: 14)
        Lab.textColor = ColorGrayTitle
        
        return Lab
    }()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 65, bottom: 20, right: 65)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        layout.itemSize = CGSize.init(width: ScreenW - 130, height: 40)
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor.white
        collection.dataSource = self
        collection.delegate = self
        collection.isScrollEnabled = false
        collection.register(TopicCell.self, forCellWithReuseIdentifier: "TopicCell")
        return collection
    }()
    
    lazy var reportBtn:UIButton = {
        let Btn = UIButton.init(type: .custom)
        Btn.titleLabel?.font = UIFont.pingFangTextFont(size: 16)
        Btn.layer.cornerRadius = 30
        Btn.layer.masksToBounds = true
        Btn.setTitle("确认解除", for: .normal)
        Btn.setTitleColor(ColorWhite, for: .normal)
        Btn.frame = CGRect.init(x: 50, y: ScreenH - SafeBottomMargin - 100, width: ScreenW - 100, height: 60)
        Btn.addTarget(self, action: #selector(self.gotoReport), for: .touchUpInside)
        
        return Btn
    }()
    
    var data = ["TA是违规用户，我已投诉","TA长期不在线","臭味不投，沟通不畅","没理由，就要解除"]
    var selectArr = [String]()
    var UID = ""
    var name = ""
    init(UID :String ,name:String) {
        super.init(nibName: nil, bundle: nil)
        self.UID  = UID
        self.name  = name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "举报"
        
        createUI()
        
        self.nameLab.text = "@\(self.name)"
    }
    func createUI(){
        
        self.view.addSubviews([reportLab,nameLab,collectionView,reportBtn])
        
        nameLab.snp.makeConstraints { (make) in
            
            make.top.equalTo(20 + navigationBarHeight)
            make.left.equalTo(15)
            make.height.equalTo(20)
            
        }
        reportLab.snp.makeConstraints { (make) in
            
            make.top.equalTo(nameLab.snp.top)
            make.left.equalTo(nameLab.snp.right).offset(5)
            make.height.equalTo(20)
            
        }
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(reportLab.snp.bottom).offset(5)
            make.left.right.equalToSuperview()
            make.height.equalTo(350)
        }
        
        
        reportBtnNomal()
    }
    
    func reportBtnSelected(){
        reportBtn.setBackgroundColor(.clear, forState: .normal)
        reportBtn.addButtonGradientLayer()
        
        reportBtn.setTitleColor(ColorWhite, for: .normal)
        reportBtn.isUserInteractionEnabled = true
    }
    func reportBtnNomal(){
        reportBtn.setBackgroundColor(ColorBackGround, forState: .normal)
        reportBtn.setTitleColor(ColorGrayColor, for: .normal)
        reportBtn.isUserInteractionEnabled = false
    }
    
}
extension RaiseOverRelationViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopicCell", for: indexPath) as! TopicCell
        cell.layer.cornerRadius = 5
        cell.clipsToBounds = true
        cell.titleLabel.text = data[indexPath.row]
        if self.selectArr.contains(data[indexPath.row]){
            cell.contentView.backgroundColor = ColorCancleColor
            cell.titleLabel.textColor = ColorWhite
            
        }else{
            cell.contentView.backgroundColor = ColorBackGround
            cell.titleLabel.textColor = ColorGrayTitle
            
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectStr = self.data[indexPath.row]
        
        if selectArr.contains(selectStr) {
            self.selectArr.removeAll()
            self.reportBtnNomal()
        }else{
            
            self.selectArr.removeAll()
            selectArr.append(selectStr)
            self.reportBtnSelected()
        }
        
        self.collectionView.reloadData()
    }
    
    
}

extension  RaiseOverRelationViewController{
    
    @objc private func gotoReport(){
        if self.selectArr.count == 0 {
            ShowMessageTool.shared.showMessage("请选择你要解除的理由")
            return
        }
        
        let view = AlertOverRelationshipView.init()
        view.overRelationshipAlertClickBlock = {
            self.overRelationAPI()
        }
        view.show()
       
    }

    func overRelationAPI(){
        RaiseRoomAPI.shared.APPReleaseAdoptURL(beAdoptedUserId: UID, releaseReason: self.selectArr[0],success: { (json) in
            let dic = json as? NSDictionary
            let code = dic?.object(forKey: "code") as? Int
            if code == 200 {
                SystemTipsView.init(title: "解除成功", deTitle: "愿你在嗅嗅能尽快找到臭味相投的TA", H: 100).show()
            }else{
                ShowMessageTool.shared.showMessage("解除失败")
            }
        }) { (error) in
            ShowMessageTool.shared.showMessage("解除失败")
        }
    }

}
