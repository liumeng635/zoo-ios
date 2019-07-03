//
//  ShowTipsView.swift
//  zoozoo
//
//  Created by 苹果上的豌豆 on 2019/5/16.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit
import SnapKit
class ShowTipsView: UIView {
    lazy var view:UIView = {
        
        
        let View = UIView.init()
        View.backgroundColor = ColorDianColor
        View.layer.cornerRadius  = 2.5
        return View
        
        
    }()
    lazy var tips:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.pingFangTextFont(size: 12)
        label.textColor =  UIColor.colorWithHex(hex: 0xFC7676)
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    public func Show(tips :String , Controller :UIViewController) {
        
        Controller.view.addSubview(self)
        
        self.tips.text = tips
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
            self.view.isHidden = false
            
        }, completion: nil)
        
        
    }
    public func remove() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
                
                self.view.isHidden = true
                
            }, completion: { _ in
                self.removeFromSuperview()
            })
            
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupUI() {
        self.view.isHidden = true
        self.addSubview(view)
        self.addSubview(tips)
        view.snp.makeConstraints { (make) in
            make.left.top.equalTo(7.5)
            make.width.height.equalTo(5)
            
        }
        tips.snp.makeConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
            make.left.equalTo(18)
            
            
        }
        
    }
    
    
    
    

}
