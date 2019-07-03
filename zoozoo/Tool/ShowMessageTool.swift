//
//  ShowMessageTool.swift
//  zoozoo
//
//  Created by 苹果上的豌豆 on 2019/5/19.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit
import MBProgressHUD

class ShowMessageTool: NSObject {
    static let shared: ShowMessageTool = ShowMessageTool()
    //获取主window
    func getWindowView() -> UIView {
        var window = UIApplication.shared.keyWindow
        if window?.windowLevel != UIWindow.Level.normal {
            let windowArray = UIApplication.shared.windows
            
            for tempWin in windowArray {
                if tempWin.windowLevel == UIWindow.Level.normal {
                    window = tempWin;
                    break
                }
            }
            
        }
        return window!
    }
}
extension ShowMessageTool {
    
    public func showMessage(_ message : String){
        
       let hud = MBProgressHUD.showAdded(to: self.getWindowView(), animated: true)
        
        hud.show(animated: true)
        hud.mode = .customView
        
        hud.bezelView.style = .solidColor
        hud.bezelView.color = UIColor.colorWithHex(hex: 0x171B1E, alpha: 0.8)
        let w = message.textWidth(font: UIFont.pingFangTextFont(size: 14), height: 20) + 30
        hud.minSize = CGSize.init(width: w, height: 35)
          hud.bezelView.layer.masksToBounds = false
        
        let titleLabel = UILabel.init(frame: CGRect.init(x: 0, y: 5, width: w, height: 30))
        titleLabel.textColor = .white
        titleLabel.font = UIFont.pingFangTextFont(size: 14)
        titleLabel.textAlignment = .center
        titleLabel.layer.cornerRadius = 5
        titleLabel.text = message
        titleLabel.layer.masksToBounds = true
        hud.bezelView.addSubview(titleLabel)
        
        hud.removeFromSuperViewOnHide = true
        
        hud.animationType = MBProgressHUDAnimation.fade

       hud.hide(animated: true, afterDelay: 1.5)
    }
    public func showSuccess(_ message : String){
        self.showTextWithCustomView(text: message, icon: "", delay: 1)
  
    }
    
    public func showError(_ message : String){
        self.showTextWithCustomView(text: message, icon: "", delay: 1)
        
    }
    func showTextWithCustomView(text: String, icon: String,delay:Double){
        let hud = MBProgressHUD.showAdded(to: self.getWindowView(), animated: true)
        hud.label.text = text
        hud.label.font = UIFont.pingFangTextFont(size: 14)
        
        let img = UIImage(named: icon)
        hud.customView = UIImageView(image: img)
        
        
        //hud显示的大小
        hud.minSize=CGSize.init(width: 200, height: 200)
        //hud动画的模式
        hud.animationType=MBProgressHUDAnimation.zoomIn
        
        hud.mode = MBProgressHUDMode.customView;
        hud.removeFromSuperViewOnHide = true
        
        //延迟隐藏
        hud.hide(animated: true, afterDelay: delay)
    }
}

