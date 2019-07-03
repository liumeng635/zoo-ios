//
//  RaiseAnimalsViewController.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/6/24.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class RaiseAnimalsViewController: BaseViewController {
    lazy var backImageView : UIImageView = {
        let backImageView = UIImageView.init()
        return backImageView
    }()
    lazy var moreButton : UIButton = {
        
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: ScreenW - 45, y: statusBarH + 15, width: 30, height: 30)
        button.setImage(UIImage.init(named: "BarMore")?.render(color: .white), for: .normal)
        button.addTarget(self, action: #selector(ClickMoreAction), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    lazy var scrollView : UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = true
        scroll.bounces = true
        if #available(iOS 11.0, *) {
            
            scroll.contentInsetAdjustmentBehavior = .never
        }
        scroll.delegate = self
        return scroll
    }()
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame:  .zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor.clear
        collection.delegate = self
        collection.dataSource = self
        collection.isScrollEnabled = false
        collection.showsHorizontalScrollIndicator = false
        /// 注册
        collection.register(RaiseAnimalsListCell.self, forCellWithReuseIdentifier: "RaiseAnimalsListCell")
        return collection
    }()
    var imageH : CGFloat = ScreenH
    var dataArr = [RaiseAnimalsModel]()
    override func viewDidLoad() {
        super.viewDidLoad()

        configTitleUI()
        
        loadData()
    }
    
    func configTitleUI(){
        self.fd_prefersNavigationBarHidden = true
        configScrollUI()
        view.addSubview(back)
        view.addSubview(self.moreButton)
    }
    func configScrollUI(){
        view.backgroundColor = ColorTheme
        view.addSubview(scrollView)
        
        scrollView.addSubview(backImageView)
       
        let imageV = UIImage.init(named: "RaiseRoomBg")!
        backImageView.image = imageV
        imageH = (imageV.size.height/imageV.size.width)*ScreenW
        
        scrollView.frame = CGRect.init(x: 0, y: 0, width: ScreenW, height: ScreenH)
        scrollView.contentSize = CGSize.init(width: 0, height: imageH)
        backImageView.frame = CGRect.init(x: 0, y: 0, width: ScreenW, height: imageH)
        
         scrollView.addSubview(collection)
        
        collection.frame = CGRect.init(x: 35, y: navigationBarHeight + 30, width: ScreenW - 70, height: imageH - navigationBarHeight - 200)
    }

}
extension RaiseAnimalsViewController{
    func loadData(){
        RaiseRoomAPI.shared.APPRaiseRoomPetsListURL(success: { (json) in
            if let response = BaseRaiseAnimalsModel.deserialize(from: json as? [String:Any]){
                if  response.code == 200{
                    self.dataArr = response.data
                    self.collection.reloadData()
                    self.MoreButtonIsHidden()
                    
                }
            }
            
        }) { (error) in
            
        }
    }
    
    func MoreButtonIsHidden(){
        var arr = [1]
        self.dataArr.forEach { (model) in
            if model.isExists == 1 {
                arr.append(model.isExists)
            }
            
        }
        
        
        moreButton.isHidden = arr.count < 4 ? true : false
        
        if arr.count == 1 {
            AlertAnimalChooseView.init(H: 150, Title: "您还没有获得该小乖兽").show()
        }
        
        
        
    }
}
extension RaiseAnimalsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return self.dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (ScreenW - 100) / 3
        let height = width / 1.1 + 40 + 50
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RaiseAnimalsListCell", for: indexPath) as! RaiseAnimalsListCell
        cell.model = self.dataArr[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = self.dataArr[indexPath.row]
        if model.isExists == 1{
            let vc = RaiseAnimalInfoViewController.init(dataArr: self.dataArr, indexPath: indexPath.row)
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            AlertAnimalChooseView.init(H: 150, Title: "您还没有获得该小乖兽").show()
            
        }
    }
    
    
    
}
extension RaiseAnimalsViewController : UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offsetY = scrollView.contentOffset.y
//        var frame = CGRect.init(x: 0, y: 0, width: ScreenW, height: imageH)
//        frame.size.height -= offsetY
//        frame.origin.y = offsetY
//
//        if offsetY <= 0 {
//            
//            frame.size.width = frame.size.height * self.backImageView.size.width / self.backImageView.size.height
//            frame.origin.x = (self.view.frame.size.width - frame.size.width) / 2
//        }
//
//        self.backImageView.frame = frame
    }
    
}

extension RaiseAnimalsViewController {
    @objc private func ClickMoreAction(){
        var arr = [RaiseAnimalsModel]()
        self.dataArr.forEach { (model) in
            if model.isExists == 1 {
                arr.append(model)
            }  
        }
        
        RaiseMoreHeadShowView.init(animalsData: arr).show()
    }
}

