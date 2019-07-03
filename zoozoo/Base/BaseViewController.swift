//
//  BaseViewController.swift
//  zoozoo
//
//  Created by 苹果上的豌豆 on 2019/5/15.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    lazy var NavigationTitleLabel:UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: 0, y: statusBarH + 15, width: 120, height: 20))
        label.centerX = self.view.centerX
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = ColorWhite
        return label
    }()
    
    lazy var back : UIButton = {
        
        let Btn = UIButton.init(type: .custom)
        let backImage = UIImage.init(named: "back")!.render(color: .white)
        Btn.setImage(backImage, for: .normal)
        Btn.frame = CGRect.init(x: 15, y: statusBarH + 15, width: backImage.size.width, height: backImage.size.height)
        Btn.contentHorizontalAlignment = .left
        Btn.addTarget(self, action: #selector(backPop), for: .touchUpInside)
        return Btn
        
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
       
    }
    
    //禁止侧滑
    public func interactivePopDisabled(){
        self.fd_interactivePopDisabled = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIButton.init(type: .custom))
        self.navigationItem.leftBarButtonItem?.isEnabled = false
    }
    @objc func backPop(){
        self.navigationController?.popViewController(animated: true)
        
    }
    
}
