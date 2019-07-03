//
//  PhotoView.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/7/1.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit
import JXPhotoBrowser
let alignBorder  : CGFloat = 5.0
class PhotoView: UIView ,UICollectionViewDelegate , UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    lazy var collection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        /// 上下左右边距
        layout.minimumLineSpacing = alignBorder
        layout.minimumInteritemSpacing = alignBorder
        /// 组内边距
//        layout.sectionInset = UIEdgeInsets(top: 0, left:0, bottom: 0, right: 0)
        
        let collection = UICollectionView(
            frame: CGRect.zero,collectionViewLayout: layout)
        /// 滚动指示条
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        /// 默认竖直滚动
        collection.alwaysBounceVertical = true
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        
        /// 弹簧效果
        collection.bounces = false
        collection.isScrollEnabled = false
        
        /// 注册
        collection.register(photoCollectionCell.self, forCellWithReuseIdentifier: "photoCollectionCell")
        
        return collection
    }()
    var dataArr = [PhotoModel]()
    var model: ChatRoomModel? {
        didSet {
            guard let model = model else {
                return
            }
            if model.imgUrls.count  > 0 {
                self.dataArr = model.imgUrls
            }
            
            self.collection.reloadData()
        }
    }
   
    
    //MARK:- init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Method
    fileprivate func createUI(){
        self.backgroundColor = .clear
        self.addSubview(collection)
        collection.snp.makeConstraints { (make) in
            
            make.edges.equalToSuperview()
            
        }
        
        
    }
    
    
    //MARK:- UICollectionDataSource
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCollectionCell", for: indexPath) as! photoCollectionCell
        
        cell.imageView.kf.setImage(urlString: self.dataArr[indexPath.row].thumbUrl)
   
        return cell
    }
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return self.dataArr.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return self.collectionViewCellSize(self.dataArr.count)
        
    }
    //MARK:- UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let loader = JXKingfisherLoader()
        // 数据源
        var ImageViewArr : [String]    = []
        self.dataArr.forEach { item in
            ImageViewArr.append(item.originUrl)
        }
        
        let dataSource = JXNetworkingDataSource(photoLoader: loader, numberOfItems: { () -> Int in
            return ImageViewArr.count
        }, placeholder: { index -> UIImage? in
            let cell = collectionView.cellForItem(at: indexPath) as? photoCollectionCell
            return cell?.imageView.image
        }) { index -> String? in
            return ImageViewArr[index]
        }
        // 视图代理，实现了光点型页码指示器
        let delegate = JXDefaultPageControlDelegate()
        // 转场动画
        let trans = JXPhotoBrowserZoomTransitioning { (browser, index, view) -> UIView? in
            let indexPath = IndexPath(item: index, section: 0)
            let cell = collectionView.cellForItem(at: indexPath) as? photoCollectionCell
            return cell?.imageView
        }
       
        // 长按事件
        delegate.longPressedCallback = { browser, index, image, gesture in
            self.longPressed(browser: browser, image: image, gesture: gesture)
        }
        // 打开浏览器
        JXPhotoBrowser(dataSource: dataSource, delegate: delegate, transDelegate: trans)
            .show(pageIndex: indexPath.item)

    }
    private func longPressed(browser: JXPhotoBrowser, image: UIImage?, gesture: UILongPressGestureRecognizer) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let saveImageAction = UIAlertAction(title: "保存图片", style: .default) { (_) in
            UIImageWriteToSavedPhotosAlbum(image ?? UIImage(), self, #selector(self.saveImage(image:didFinishSavingWithError:contextInfo:)), nil)
       
        }
        actionSheet.addAction(saveImageAction)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        actionSheet.addAction(cancelAction)
        browser.present(actionSheet, animated: true, completion: nil)
    }
    
    @objc private func saveImage(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: AnyObject) {
        if error != nil{
            ShowMessageTool.shared.showMessage("保存失败")
            
        }else{
            ShowMessageTool.shared.showMessage("保存成功")
            ZLog("保存成功保存成功保存成功")
        }
       
        
        
    }
    /// 计算 collectionViewCell 的大小
    func collectionViewCellSize(_ count: Int) -> CGSize {
        switch count {
        case 1: return CGSize(width: ChatBackWidth, height: image1Width)
        case 2: return CGSize(width: image2Width, height: image2Width)
        case 4: return CGSize(width: image2Width, height: image2Width)
        case 3,5...9: return CGSize(width: image3Width, height: image3Width)
        default: return .zero
        }
    }
    
}
class photoCollectionCell: UICollectionViewCell {
    lazy var imageView: UIImageView = {
        let imageV = UIImageView()
        imageV.contentMode = .scaleAspectFill
        imageV.clipsToBounds = true
        return imageV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        contentView.addSubview(imageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
