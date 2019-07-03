//
//  AlertActionSheetTool.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/6/16.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class AlertActionSheetTool{
    static func showWindowAlert(titleStr: String?, msgStr: String?, style: UIAlertController.Style = .alert, cancelBtn: String = "取消", cancelHandler:((UIAlertAction) -> Void)?, otherBtns:Array<String>?, otherHandler:((Int) -> ())?) {
        //DispatchQueue.global().async{}//子线程
        DispatchQueue.main.async { // 主线程执行
            let alertController = UIAlertController(title: titleStr, message: msgStr,preferredStyle: style)
            //取消按钮
            let cancelAction = UIAlertAction(title:cancelBtn, style: .cancel, handler:{ (action) -> Void in
                cancelHandler?(action)
            })
            alertController.addAction(cancelAction)
            //其他按钮
            if otherBtns != nil {
                for (index, value) in (otherBtns?.enumerated())! {
                    let otherAction = UIAlertAction(title: value, style: .default, handler: { (action) in
                        otherHandler!(index)
                    })
                    alertController.addAction(otherAction)
                }
            }
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }
    
    static func showAlert(titleStr: String?, msgStr: String?, style: UIAlertController.Style = .alert, currentVC: UIViewController, cancelBtn: String = "取消", cancelHandler:((UIAlertAction) -> Void)?, otherBtns:Array<String>?, otherHandler:((Int) -> ())?) {
        //DispatchQueue.global().async{}//子线程
        DispatchQueue.main.async { // 主线程执行
            let alertController = UIAlertController(title: titleStr, message: msgStr,preferredStyle: style)
            //取消按钮
            let cancelAction = UIAlertAction(title:cancelBtn, style: .cancel, handler:{ (action) -> Void in
                cancelHandler?(action)
            })
            alertController.addAction(cancelAction)
            //其他按钮
            if otherBtns != nil {
                for (index, value) in (otherBtns?.enumerated())! {
                    let otherAction = UIAlertAction(title: value, style: .default, handler: { (action) in
                        otherHandler!(index)
                    })
                    alertController.addAction(otherAction)
                }
            }
            currentVC.present(alertController, animated: true, completion: nil)
        }
    }
    
    static func showRiskAlert(titleStr: String?, msgStr: String?, style: UIAlertController.Style = .alert, currentVC: UIViewController, cancelBtn: String = "取消", cancelHandler:((UIAlertAction) -> Void)?, otherBtns:Array<String>?, otherHandler:((Int) -> ())?) {
        //DispatchQueue.global().async{}//子线程
        DispatchQueue.main.async { // 主线程执行
            let alertController = UIAlertController(title: titleStr, message: msgStr,preferredStyle: style)
            //取消按钮
            let cancelAction = UIAlertAction(title:cancelBtn, style: .cancel, handler:{ (action) -> Void in
                cancelHandler?(action)
            })
            alertController.addAction(cancelAction)
            //其他按钮
            if otherBtns != nil {
                for (index, value) in (otherBtns?.enumerated())! {
                    let otherAction = UIAlertAction(title: value, style: .destructive, handler: { (action) in
                        otherHandler!(index)
                    })
                    alertController.addAction(otherAction)
                }
            }
            currentVC.present(alertController, animated: true, completion: nil)
        }
    }
}
