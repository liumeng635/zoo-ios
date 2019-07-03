//
//  SearchSchoolViewController.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/6/12.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
class SearchSchoolViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    
    private var searchBar : UISearchBar = UISearchBar.init()
    var tapGesture : UITapGestureRecognizer!
    lazy  var table:UITableView = {
        
        let tableView = UITableView.init(frame: CGRect.zero, style: UITableView.Style.grouped)
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
//        tableView.isHidden = true
        tableView.register(SearchCell.self, forCellReuseIdentifier: "SearchCell")
        
        return tableView
        
    }();
    private var dataArr = [SchoolsDataModel]()
    private var RecDataArr = [SchoolsDataModel]()
    private var ResultArr = [SchoolsDataModel]()
    private var historyArr = [String]()
    private var searchKey : String      = ""
    
    public  var GetSearchForSchoolBlock : ((_ school : String , _ schoolID : String)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        automaticallyAdjustsScrollViewInsets = false//对应iOS10系统刷新有
        
        view.addSubview(table)
        table.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(navigationBarHeight)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset( -SafeBottomMargin)
        }
        let keyBoardManager = IQKeyboardManager.shared
        keyBoardManager.enableAutoToolbar = false
        keyBoardManager.enable = false
        
        self.searchBar.becomeFirstResponder()
        configSearchBar()
        requestRecSchoolForData()
        loadMoreData()
    }
    
    //  MARK: -搜索的导航栏界面
    private func configSearchBar(){
        
        searchBar.returnKeyType     = .search
        searchBar.placeholder       = "请输入学校名称"
        
        searchBar.frame = CGRect.init(x: 0, y: UIApplication.shared.statusBarFrame.height, width: ScreenW - 40 , height: 40)
        searchBar.layer.cornerRadius  = 20
        searchBar.layer.masksToBounds = true
        searchBar.showsCancelButton = false
        searchBar.tintColor         = ColorDarkGrayTextColor
        searchBar.backgroundImage = UIImage.blankImage()
        searchBar.setImage(UIImage.init(named: "search"), for: .search, state: .normal)
        self.navigationItem.titleView = searchBar
        
        let searchTf  : UITextField? = searchBar.value(forKey: "_searchField") as? UITextField
        searchTf?.backgroundColor   = UIColor.colorWithRGB(r: 243, g: 243, b: 243)
        
        searchTf?.font              = UIFont.pingFangTextFont(size: 14)
        searchBar.delegate          = self
        
        let CancelButton : UIButton = UIButton.init(type : .custom)
        CancelButton.frame = CGRect.init(x: ScreenW - 40, y: UIApplication.shared.statusBarFrame.height, width: 40 , height: 40)
        CancelButton.setTitle("取消", for: .normal)
        CancelButton.setTitleColor(ColorCancleColor, for: .normal)
        CancelButton.titleLabel?.font = UIFont.pingFangTextFont(size: 15)
        CancelButton.addTarget(self, action: #selector(cancelClick), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: CancelButton)
    }
    var lastSchoolId = ""
    //  MARK: - 默认推荐学校数据处理
    private func requestRecSchoolForData(){
        
        PersonalAPI.shared.APPBaseUniversityURL(lastSchoolId: lastSchoolId, success: { (json) in
            if let response = SchoolsModel.deserialize(from: json as? [String:Any]){
                if  response.code == 200{
                    let array = response.data
                    
                    if self.lastSchoolId.isEmpty {
                        self.dataArr.removeAll()
                        self.ResultArr.removeAll()
                    }
                    self.dataArr += array
                    if array.count == 0 {
                        self.table.ZFoot?.endRefreshingWithNoMoreData()
                    }else{
                        self.lastSchoolId = self.dataArr.last?.id ?? ""
                        self.table.ZFoot?.endRefreshing()
                        if array.count < 10 {
                            self.table.ZFoot?.endRefreshingWithNoMoreData()
                        }
                    }
                    self.ResultArr = self.dataArr
                    self.table.reloadData()
                    
                }else{
                   
                    self.table.ZFoot?.endRefreshing()
                }
            }
        }) { (error) in
           
            self.table.ZFoot?.endRefreshing()
        }
       
        
    }
    //  MARK: - requestSearchForSchoolData
    private func requestSearchForData(){
        self.ResultArr.removeAll()
        self.table.ZFoot?.removeFromSuperview()
        PersonalAPI.shared.APPSearchUniversityURL(word: self.searchKey, success: { (json) in
            if let response = SchoolsModel.deserialize(from: json as? [String:Any]){
                if  response.code == 200{
                    self.ResultArr = response.data
                    self.table.reloadData()
                }
            }
        }) { (error) in
            
        }
        
        if self.ResultArr.count == 0 && self.searchKey.clearBlankString().isEmpty == true {
            self.ResultArr = self.dataArr
            self.loadMoreData()
        }
    }
    
    //  MARK:加载更多
    func loadMoreData(){
        self.table.ZFoot = RefreshDiscoverFooter{[weak self] in
            guard let self = self else {
                return
            }
            self.requestRecSchoolForData()
        }
        
        
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ResultArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
        if self.ResultArr.count > 0 {
            cell.nameLabel.text = self.ResultArr[indexPath.row].schoolName
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01;
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    //MARK:UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.dismiss(animated: true, completion: nil)
        if self.ResultArr.count > 0 {
            self.GetSearchForSchoolBlock?(self.ResultArr[indexPath.row].schoolName!, self.ResultArr[indexPath.row].id!)
           
        }
        self.searchBar.resignFirstResponder()
        
    }
   
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.searchBar.resignFirstResponder()
    }
    @objc private func cancelClick(){
        self.searchBar.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
        
    }
    @objc private func hideKeyBoard(){
        self.searchBar.resignFirstResponder()
        self.searchBar.endEditing(true)
        
        
    }
    // MARK: - UISearchBarDelegate
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchKey = searchText
        self.requestSearchForData()
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
        self.searchKey = searchBar.text ?? ""
        
        self.requestSearchForData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


class SearchCell: UITableViewCell {
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        self.createUI()
    }
    lazy var nameLabel:UILabel = {
        let nameLab = UILabel.init()
        nameLab.textAlignment = NSTextAlignment.left
        nameLab.font = UIFont.pingFangTextFont(size: 14)
        nameLab.textColor = ColorTitle
        
        return nameLab
    }()
    lazy var line:UIView = {
        let line = UIView.init()
        line.backgroundColor = ColorLine
        return line
    }()
    private func createUI(){
        self.backgroundColor = UIColor.white
        
        
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(line)
        nameLabel.snp.makeConstraints { (make) in
            make.bottom.top.equalToSuperview()
            
            make.right.equalTo(-30)
            make.left.equalTo(15)
        }
        line.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            
            
            make.height.equalTo(0.5)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


