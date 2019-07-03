//
//  ReportViewController.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/6/17.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class ReportViewController: BaseViewController {
    lazy var reportLab:UILabel = {
        let Lab = UILabel.init()
        Lab.textAlignment = NSTextAlignment.left
        Lab.font = UIFont.boldSystemFont(ofSize: 14)
        Lab.textColor = ColorTitle
        Lab.text = "举报用户"
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
        let Layout = XZBCollectionViewAlignedLayout()
        Layout.minimumInteritemSpacing = 25
        Layout.minimumLineSpacing = 25
        Layout.sectionInset = UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 25)
        Layout.horizontalAlignment = .left
        Layout.estimatedItemSize = CGSize(width: 200, height: 40)
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: Layout)
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
        Btn.setTitle("确认举报", for: .normal)
        Btn.setTitleColor(ColorWhite, for: .normal)
        Btn.frame = CGRect.init(x: 50, y: ScreenH - SafeBottomMargin - 100, width: ScreenW - 100, height: 60)
        Btn.addTarget(self, action: #selector(self.gotoReport), for: .touchUpInside)
        
        return Btn
    }()
    lazy var clickLab:UILabel = {
        let Lab = UILabel.init()
        Lab.textAlignment = NSTextAlignment.left
        Lab.font = UIFont.boldSystemFont(ofSize: 14)
        Lab.textColor = ColorTitle
        Lab.text = "点击了解"
        return Lab
    }()
    lazy var xiuxiuLab:UILabel = {
        let Lab = UILabel.init()
        Lab.textAlignment = NSTextAlignment.left
        Lab.font =  UIFont.pingFangTextFont(size: 14)
        Lab.textColor = ColorTheme
        Lab.text = "嗅嗅交友规范"
        Lab.isUserInteractionEnabled = true
        Lab.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(gotoxiuxiu)))
        return Lab
    }()
    lazy var deLab:UILabel = {
        let Lab = UILabel.init()
        Lab.textAlignment = NSTextAlignment.left
        Lab.font = UIFont.pingFangTextFont(size: 12)
        Lab.textColor = ColorGrayColor
        Lab.text = "网络一线牵，珍惜这段缘！为保护交友环境，我们坚持打击不正 当交友目的。同时，我们也坚持拒绝恶意举报行为。"
        Lab.numberOfLines = 0
        return Lab
    }()
    var data = ["政治敏感","低俗色情","攻击歧视","头像违规/涉黄","声音违规/涉黄","血腥暴力","骚扰广告","其他"]
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
       
        self.view.addSubviews([reportLab,nameLab,collectionView,clickLab,xiuxiuLab,deLab,reportBtn])
        
        reportLab.snp.makeConstraints { (make) in
            
            make.top.equalTo(20 + navigationBarHeight)
            make.left.equalTo(15)
            make.height.equalTo(20)
            
        }
        nameLab.snp.makeConstraints { (make) in
            
            make.top.equalTo(reportLab.snp.top)
            make.left.equalTo(reportLab.snp.right).offset(5)
            make.height.equalTo(20)
            
        }
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(reportLab.snp.bottom).offset(5)
            make.left.right.equalToSuperview()
            make.height.equalTo(200 / ScaleW)
        }
        clickLab.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView.snp.bottom).offset(40)
            make.left.equalTo(15)
            make.height.equalTo(20)
        }
        xiuxiuLab.snp.makeConstraints { (make) in
            make.top.equalTo(clickLab.snp.top)
            make.left.equalTo(clickLab.snp.right).offset(10)
            make.height.equalTo(20)
        }
        deLab.snp.makeConstraints { (make) in
            make.top.equalTo(xiuxiuLab.snp.bottom).offset(20)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(60)
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
extension ReportViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UICollectionViewDelegate {
    
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

extension  ReportViewController{
    @objc private func gotoxiuxiu(){
        let VC = WordViewController.init(nameTitle: "交友规范")
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @objc private func gotoReport(){
        if self.selectArr.count == 0 {
            ShowMessageTool.shared.showMessage("请选择你要举报的内容")
            return
        }
        
        
        BaseAPI.shared.APPReportURL(content: self.selectArr[0], beReportUserId: UID, success: { (json) in
            let dic = json as? NSDictionary
            let code = dic?.object(forKey: "code") as? Int
            if code == 200 {
                AlertReportView.init().show()
               
            }else{
                 ShowMessageTool.shared.showMessage("举报失败")
            }
        }) { (error) in
             ShowMessageTool.shared.showMessage("举报失败")
        }
    }
}
class TopicCell: UICollectionViewCell {
    
    lazy var titleLabel:UILabel = {
        let Lab = UILabel.init()
        Lab.textAlignment = NSTextAlignment.center
        Lab.font = UIFont.pingFangTextFont(size: 14)
        Lab.textColor = ColorGrayTitle
        return Lab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        
        self.contentView.addSubview(titleLabel)
        self.contentView.layer.cornerRadius = 20
        self.contentView.layer.masksToBounds = true
        self.contentView.backgroundColor  = ColorBackGround
        
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 18, bottom: 10, right: 18))
        }
        
        
    }
    
    
    
    
}



//MARK:弹窗
class AlertReportView: BaseShowView {
    
    
    lazy var TitleLab:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = ColorTitle
        label.text = "感谢您的反馈"
        return label
    }()
    lazy var deLab:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.pingFangTextFont(size: 15)
        label.textColor = ColorGrayTitle
        label.numberOfLines = 0
        label.text = "我们会尽快处理您的举报\n  若不想再收到TA的消息，可点击页面\n  右上角，与TA解除关系"
        return label
    }()
    lazy var SureBtn:UIButton = {
        let Btn = UIButton.init(type: .custom)
        Btn.layer.cornerRadius  = 22
        Btn.layer.masksToBounds = true
        Btn.layer.borderColor = ColorTheme.cgColor
        Btn.layer.borderWidth = 1
        Btn.setTitle("好的", for: .normal)
        Btn.setTitleColor(ColorTheme, for: .normal)
        Btn.titleLabel?.font = UIFont.pingFangTextFont(size: 16)
        Btn.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        return Btn
    }()
    
    
   
    init() {
        super.init(frame: screenFrame)
        initSubView()
        ceteateUI()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubView()
        ceteateUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func  ceteateUI(){
        backView.addSubviews([TitleLab,deLab,SureBtn])
        
        self.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(dismiss)))
        backView.frame = CGRect.init(x: 35, y: 0, width: ScreenW - 70, height: 220)
        backView.center = self.center
        TitleLab.frame = CGRect.init(x: 15, y: 20, width: ScreenW - 100 , height: 30)
        deLab.frame = CGRect.init(x: 15, y: 60, width: ScreenW - 100 , height: 80)
        
        SureBtn.frame = CGRect.init(x: ScreenW/2 - 60, y: deLab.bottom + 20, width: 120 , height: 44)
    
    }
    
   
}


