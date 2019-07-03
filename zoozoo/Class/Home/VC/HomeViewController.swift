//
//  HomeViewController.swift
//  zoozoo
//
//  Created by 苹果上的豌豆 on 2019/5/15.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

let CircleViewY = ScreenH/1.8
class HomeViewController: BaseViewController {
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    lazy var buttonleft:UIButton = {
        let Btn = UIButton.init(type: .custom)
        Btn.setImage(UIImage.init(named: "mine"), for: .normal)
        Btn.frame = CGRect.init(x: 0, y: statusBarH + 15, width: 50, height: 40)
       Btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        Btn.addTarget(self, action: #selector(leftBtnAction), for: .touchUpInside)
        Btn.setBackgroundColor(UIColor.colorWithHex(hex: 0x171B1E, alpha: 0.3), forState: .normal)
        return Btn
    }()
    lazy var buttonright:UIButton = {
        let Btn = UIButton.init(type: .custom)
        Btn.setImage(UIImage.init(named: "message"), for: .normal)
        Btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        Btn.frame = CGRect.init(x: ScreenW - 50, y: statusBarH + 15, width: 50, height: 40)
        Btn.addTarget(self, action: #selector(rightBtnAction), for: .touchUpInside)
       Btn.setBackgroundColor(UIColor.colorWithHex(hex: 0x171B1E, alpha: 0.3), forState: .normal)
        return Btn
    }()
    
    lazy var CircleView:HomeCircleView = {
        let view  = HomeCircleView.init(frame: CGRect(x: 0, y: CircleViewY, width: VIEWH, height: VIEWH))
        view.center.x = self.view.center.x
        view.delegate = self
        return view
    }()
    lazy var container:CardContainerView = {
        let container  = CardContainerView.init(frame: CGRect(x: 0, y: 0, width: ScreenW, height: CircleViewY + 60))
        container.delegate = self
        container.dataSource = self
        
        return container
    }()
   
   var sourceArr = [RandomPetsModel]()
    var dataArr = [HomeAnimalModel]()
    var nextArr = [HomeAnimalModel]()
    override func viewWillDisappear(_ animated: Bool) {
        self.CircleView.voicePopTip.hide()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addBackViewGradientLayer()
        
       
        self.fd_prefersNavigationBarHidden = true
        
        loadLocalData()
        
        configUI()
        
        
        userDailyLogin()
       
    }
   
    func configUI(){
        self.view.addSubview(container)
        self.view.addSubview(CircleView)
        loadBarButtonItem ()
    }

    
    
    func userDailyLogin(){
        BaseAPI.shared.APPUserDailyLoginURL(success: { (json) in
        }) { (error) in}
    }

}
//MARK:加载数据
extension HomeViewController {
    /// 第一次加载本地数据
    func loadLocalData(){
        
        guard let homeData = BaseEngine.shared.fetchInfo(key: "homeData") else {
             self.loadData()
            return
        }
        if let response = BaseHomeAnimalModel.deserialize(from: homeData as? [String:Any]){
            if response.code == 200 {
                let arr = response.data
                arr.forEach({ (model) in
                    self.sourceArr.append(model)
                })
                self.CircleView.reloadView(arr: self.sourceArr.first?.randomPets ?? [HomeAnimalModel]())
                
                self.container.reloadData()
            }
        }else{
            self.loadData()
        }
    }
    
    func loadData() {
        if self.sourceArr.count > 0 {
            self.sourceArr.remove(at: 0)
        }
        if self.sourceArr.count > 3 {
            self.CircleView.reloadView(arr: self.sourceArr.first?.randomPets ?? [HomeAnimalModel]())
            
            self.container.reloadData()
            return
        }
        
        HomeAPI.shared.APPGetHomeRandomPetURL(success: { (json) in

            if let response = BaseHomeAnimalModel.deserialize(from: json as? [String:Any]){
                if response.code == 200 {
                    let arr = response.data
                    arr.forEach({ (model) in
                        self.sourceArr.append(model)
                    })
                   BaseEngine.shared.saveInfo(dic: json as! NSDictionary, key: "homeData")
                    
                     self.CircleView.reloadView(arr: self.sourceArr.first?.randomPets ?? [HomeAnimalModel]())
                    
                    self.container.reloadData()
                    
                    
                }else{
                    ShowMessageTool.shared.showMessage("请求失败")
                }
            }
        }) { (error) in
            ShowMessageTool.shared.showMessage("请求失败")
        }
        
    }
    
   
    
}
//Mark: 轮盘选中动物后的放大
extension HomeViewController :HomeCircleViewDelegate{
    func getSelectAnimal(selectAnimal: Int) {
        self.container.showSelectAniaml(index: selectAnimal)
    }
}
//Mark: 卡片动物个数和视图
extension HomeViewController : CardContainerViewDataSource{
    func numberOfRowsInCardContainer(container: CardContainerView) -> Int {
        return self.sourceArr.count
    }
    func container(_ container: CardContainerView, viewForRowAt index: Int) -> CardAnimalHeadView {
        let cardView = CardAnimalHeadView.init(frame: container.bounds)
        cardView.model = self.sourceArr[index]
        cardView.delegate = self
        return cardView
    }
}
//Mark: 卡片选中动物后的放大
extension HomeViewController : CardAnimalHeadViewDelegate{
    func CardSelectAnimalCircleDiselect(selectAnimal: Int) {
        self.CircleView.showSelectCircleAnimal(index: selectAnimal)
    }
}
extension HomeViewController :CardContainerViewDelegate{
    func container(_ container: CardContainerView, didSelectRowAt index: Int) {
        
    }
    //卡片消失，开始请求下一个数据
    func container(_ container: CardContainerView, dataSourceIsDisappear isEmpty: Bool ,index :Int) {
  
        self.loadData()
        
      
    }
    
    func container(_ container: CardContainerView, canDragForCardView: CardAnimalHeadView) -> Bool {
        return true
    }
}
//MARK:BarButtonItems
extension HomeViewController {
    func loadBarButtonItem () {
        
        buttonleft.corner(byRoundingCorners: [.topRight,.bottomRight], radii: 20)
        self.view.addSubview(buttonleft)
        buttonright.corner(byRoundingCorners: [.topLeft,.bottomLeft], radii: 20)
        self.view.addSubview(buttonright)
        
    }
    @objc func leftBtnAction () {
        self.navigationController?.pushViewController(MineViewController(), animated: true)
    }
    
    @objc func rightBtnAction() {
       
        self.navigationController?.pushViewController(RaiseAnimalsViewController(), animated: true)
    }

}
