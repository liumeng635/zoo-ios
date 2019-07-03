
//
//  WordViewController.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/6/18.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class WordViewController: BaseViewController {
    var nameTitle : String = ""
    var imageH : CGFloat = ScreenH
    lazy var scrollView : UIScrollView = {
        let scroll = UIScrollView()
        
        scroll.showsVerticalScrollIndicator = true
        scroll.bounces = true
        
        return scroll
    }()
    init(nameTitle :String ) {
        super.init(nibName: nil, bundle: nil)
        self.nameTitle  = nameTitle
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = nameTitle
        view.backgroundColor = .white
        view.addSubview(scrollView)
        
        let img = UIImageView.init()
        scrollView.addSubview(img)
        
        guard let imageV = UIImage.init(named: nameTitle) else {
            return
        }
        img.image = imageV
        imageH = (imageV.size.height/imageV.size.width)*ScreenW
        
        scrollView.frame = CGRect.init(x: 0, y: navigationBarHeight, width: ScreenW, height: ScreenH - navigationBarHeight)
        
        scrollView.contentSize = CGSize.init(width: 0, height: imageH)
        img.frame = CGRect.init(x: 0, y: 0, width: ScreenW, height: imageH)
        
        
    }
    

}
