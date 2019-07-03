//
//  ShowBirthdayView.swift
//  zoozoo
//
//  Created by 苹果上的豌豆 on 2019/5/17.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class ShowBirthdayView: UIView {
    var container = UIView.init()
    var cancel = UILabel.init()
    var sure = UILabel.init()
    var Birthdaytime : String = ""
    let datePicker = UIDatePicker(frame: CGRect(x:0, y:50, width:ScreenW, height:200))
    public  var datePickerBirthdayBlock : ((_ Birthday: String)->Void)?
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubView()
    }
    init(Birthdaytime : String) {
        super.init(frame: screenFrame)
        self.Birthdaytime = Birthdaytime
        initSubView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func initSubView() {
        self.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        
        container.frame = CGRect.init(x: 0, y: ScreenH, width: ScreenW, height: 250)
        container.backgroundColor = .white
        self.addSubview(container)
        
        let rounded = UIBezierPath.init(roundedRect: CGRect.init(origin: .zero, size: CGSize.init(width: ScreenW, height: 250)), byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize.init(width: 10.0, height: 10.0))
        let shape = CAShapeLayer.init()
        shape.path = rounded.cgPath
        container.layer.mask = shape
        
        let blurEffect = UIBlurEffect.init(style: .light)
        let visualEffectView = UIVisualEffectView.init(effect: blurEffect)
        visualEffectView.frame = self.bounds
        visualEffectView.alpha = 1.0
        container.addSubview(visualEffectView)
        
        cancel.frame = CGRect.init(x: 0, y: 10, width: 80, height: 30)
        cancel.textAlignment = .center
        cancel.text = "取消"
        cancel.textColor = ColorDarkGrayTextColor
        cancel.font =  UIFont.pingFangTextFont(size: 14)
        cancel.isUserInteractionEnabled = true
        cancel.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(dismiss)))
        container.addSubview(cancel)
        
        sure.frame = CGRect.init(x: ScreenW - 80, y: 10, width: 80, height: 30)
        sure.textAlignment = .center
        sure.text = "确定"
        sure.textColor = ColorTitle
        sure.font =  UIFont.pingFangTextFont(size: 14)
        
        sure.isUserInteractionEnabled = true
        sure.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(sureClick)))
        container.addSubview(sure)
        
       
        dateload()
        //设置可以选择的最小日期
        datePicker.maximumDate = Date.init(timeIntervalSinceNow: -(60*60*24*365*18))
        //设置可以选择的最小日期
        datePicker.minimumDate = Date.init(timeIntervalSinceNow: -(60*60*24*365*80))
        
        datePicker.datePickerMode = .date

        datePicker.locale = Locale(identifier: "zh_CN")
       
        datePicker.addTarget(self, action: #selector(dateChanged),
                             for: .valueChanged)
        container.addSubview(datePicker)
        
    }
    func dateload(){
        if Birthdaytime.isEmpty{
            //设置默认的日期
            datePicker.date = Date.init(timeIntervalSinceNow: -(60*60*24*365*18))
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            Birthdaytime = formatter.string(from: datePicker.date)
        }else{
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let dates = formatter.date(from: Birthdaytime)
            datePicker.date = dates!
        }
        
    }
    //日期选择器响应方法
    @objc func dateChanged(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        Birthdaytime = formatter.string(from: datePicker.date)    
    }
    @objc func sureClick(){
        
        self.datePickerBirthdayBlock?(Birthdaytime)
        dismiss()
    }
    func show() {
        let window = UIApplication.shared.delegate?.window as? UIWindow
        window?.addSubview(self)
        UIView.animate(withDuration: 0.15, delay: 0.0, options: .curveEaseOut, animations: {
            var frame = self.container.frame
            frame.origin.y = frame.origin.y - frame.size.height
            self.container.frame = frame
        }) { finshed in
        }
    }
    
   @objc func dismiss() {
        UIView.animate(withDuration: 0.15, delay: 0.0, options: .curveEaseIn, animations: {
            var frame = self.container.frame
            frame.origin.y = frame.origin.y + frame.size.height
            self.container.frame = frame
        }) { finshed in
            self.removeFromSuperview()
        }
    }
}
