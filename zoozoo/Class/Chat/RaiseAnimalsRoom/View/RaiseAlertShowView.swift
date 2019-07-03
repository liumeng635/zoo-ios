//
//  RaiseAlertShowView.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/6/26.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit
enum RaiseType {
    case feeding
    case play
    case education
}
class RaiseAlertShowView: UIView {
    public  var RaiseAlertShowSuccessBlcok  : (() -> Void)?
    
    
    lazy var whiteCicleView:UIView = {
        let view = UIView.init()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        view.layer.masksToBounds = true
        view.layer.borderWidth = 0.3
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.shadowColor = UIColor.white.cgColor
        view.layer.shadowOpacity = 0.5//不透明度
        view.layer.shadowRadius = 2.0//设置阴影所照射的范围
        view.layer.shadowOffset = CGSize.init(width: 0, height: 0)// 设置阴影的偏移量
        return view
    }()
    
    
    lazy var backView:UIView = {
        let view = UIView.init()
        view.backgroundColor = .clear
        self.whiteCicleView.addSubview(view)
        return view
    }()
    lazy var imageV:UIImageView = {
        let imageV = UIImageView.init()
        
        return imageV
    }()
    
    lazy var topButton:RaiseButtonExt = {
        let Btn = RaiseButtonExt.init(type: .custom)
        Btn.titleLabel?.font = UIFont.pingFangTextFont(size: 12)
        Btn.setTitleColor(ColorGrayColor, for: .normal)
        Btn.addTarget(self, action: #selector(topAction), for: .touchUpInside)
         Btn.frame = CGRect.init(x: 0, y: 15, width: 60, height: 50)
        self.backView.addSubview(Btn)
        
        return Btn
    }()
    lazy var bottomButton:RaiseButtonExt = {
        let Btn = RaiseButtonExt.init(type: .custom)
        Btn.titleLabel?.font = UIFont.pingFangTextFont(size: 12)
        Btn.setTitleColor(ColorGrayColor, for: .normal)
        Btn.addTarget(self, action: #selector(bottomAction), for: .touchUpInside)
        Btn.frame = CGRect.init(x: 0, y: topButton.bottom + 5, width: 60, height: 50)
        self.backView.addSubview(Btn)
        
        
        return Btn
    }()
    lazy var bottomLab:UILabel = {
        let label = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.pingFangTextFont(size: 12)
        label.textColor = ColorGrayColor
        label.frame = CGRect.init(x: 0, y: bottomButton.bottom , width: 60, height: 15)
        self.backView.addSubview(label)
        return label
    }()
    
    var model = RaiseAnimalsModel()
    var type = RaiseType.feeding
    var ImageX = [20,95,170]
    var WhiteCicleX = [15,90,165]
    var RaiseImages = ["Raisefeeding","Play","education"]
    var topIcon = ["weiyang","liuwan","jiaoyu"]
    var topText = ["亲自喂养","带它遛弯","我来教育"]
    var BottomIcon = ["toushi","chuanmen","chuti"]
    var BottomText = ["一键投食","丢去串门","一键出题"]
    init(model: RaiseAnimalsModel,type :RaiseType) {
        super.init(frame: screenFrame)
        self.model = model
        self.type = type
        self.configUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    func configUI() {
        self.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(dismiss)))
        self.backgroundColor = UIColor.init(white: 0, alpha: 0.6)
        
        self.addSubviews([whiteCicleView,imageV])
        
        switch self.type {
        case .feeding:
             self.loadConfigUI(num: 0, model: model.oneKeyCnt.feed)
            
        case .play:
            self.loadConfigUI(num: 1, model: model.oneKeyCnt.accompany)
            
        case .education:
            self.loadConfigUI(num: 2, model: model.oneKeyCnt.edu)
            
        }
        
    }
    
    func show() {
        let animationH = CGFloat.init(3)
        let window = UIApplication.shared.delegate?.window as? UIWindow
        window?.addSubview(self)
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .beginFromCurrentState, animations: {
            self.whiteCicleView.y = ScreenH - 196 - 25 - SafeBottomMargin
            self.whiteCicleView.h = 190
            self.backView.frame = CGRect.init(x: 0, y: 0, width: 60, height: 190)
        }) { (finish) in
            UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseOut, animations: {
                self.backView.y = self.backView.y - animationH
            }) { finshed in
                UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseOut, animations: {
                    self.backView.y = self.backView.y + animationH*2
                }) { finshed in
                    UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseOut, animations: {
                        self.backView.y = self.backView.y - animationH*2
                    }) { finshed in
                        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseOut, animations: {
                            self.backView.y = self.backView.y + animationH
                        }) { finshed in
                        }
                    }
                }
            }

        }
        
        
    }
    
    
    func loadConfigUI(num:Int,model:AlertShowModel){
        imageV.image = UIImage.init(named: RaiseImages[num])
        topButton.setImage(UIImage.init(named: topIcon[num]), for: .normal)
        topButton.setTitle(topText[num], for: .normal)
        bottomButton.setImage(UIImage.init(named: BottomIcon[num]), for: .normal)
        bottomButton.setTitle(BottomText[num], for: .normal)
        if model.canDo == 0 {
            bottomButton.isEnabled = false
            bottomButton.setImage(UIImage.init(named: BottomIcon[num])?.render(color: ColorGrayColor), for: .normal)
            bottomLab.text = "\(model.dailyCnt)/\(model.dailyCnt)"
        }else{
            bottomButton.isEnabled = true
            bottomButton.setImage(UIImage.init(named: BottomIcon[num]), for: .normal)
            bottomLab.text = "\(model.todayCnt)/\(model.dailyCnt)"
        }
        
        imageV.frame  = CGRect.init(x:CGFloat.init(ImageX[num]), y: ScreenH - 56 - 25 - SafeBottomMargin, width: 50, height: 56)
        whiteCicleView.frame = CGRect.init(x: CGFloat.init(WhiteCicleX[num]), y: ScreenH - 6 - 25 - SafeBottomMargin, width: 60, height: 0)
        backView.frame = CGRect.init(x: 0, y: 0, width: 60, height: 0)
    }
   
    @objc func dismiss() {
        UIView.animate(withDuration: 0.15, delay: 0.0, options: .curveEaseIn, animations: {
            self.whiteCicleView.y = ScreenH - 6 - 25 - SafeBottomMargin
            self.whiteCicleView.h = 0
            self.backView.alpha = 0
            self.whiteCicleView.alpha = 0
            self.alpha = 0
        }) { finshed in
            self.isHidden = true
            self.removeFromSuperview()
        }
    }
}
extension RaiseAlertShowView{
    //1一键喂食 2一键遛弯 3一键教育
    func typeRequestAPI(type :Int){
        guard let uid = model.userId else {
            return
        }
        let arr = ["一键喂食","一键遛弯","一键教育"]
        ChatRoomAPI.shared.APPMoringNightURL(beUserId: uid, msgType: type, success: { (json)in
            let dic = json as? NSDictionary
            let code = dic?.object(forKey: "code") as? Int
            if code == 200 {
                ShowMessageTool.shared.showMessage("\(arr[type - 1])成功")
                self.RaiseAlertShowSuccessBlcok?()
            }else{
                ShowMessageTool.shared.showMessage("\(arr[type - 1])失败")
            }
        }) { (error) in
            ShowMessageTool.shared.showMessage("\(arr[type - 1])失败")
        }
    }

    
    @objc private func topAction(){
        dismiss()

        let vc = PublishViewController.init(type: self.type, model: model)
        let nav = NavigationController.init(rootViewController: vc)
        self.XZBCuruntView().present(nav, animated: true, completion: nil)

    }
    @objc private func bottomAction(){
        dismiss()
        switch self.type {
        case .feeding:
            self.typeRequestAPI(type: 1)
        case .play:
            self.typeRequestAPI(type: 2)
        case .education:
            self.typeRequestAPI(type: 3)
        }
    }
    
}



//MARK:养成页设置

class RaiseSettingShowView: UIView {
    lazy var whiteCicleView:UIView = {
        let view = UIView.init()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        view.layer.masksToBounds = true
        view.layer.borderWidth = 0.3
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.shadowColor = UIColor.white.cgColor
        view.layer.shadowOpacity = 0.5//不透明度
        view.layer.shadowRadius = 2.0//设置阴影所照射的范围
        view.layer.shadowOffset = CGSize.init(width: 0, height: 0)// 设置阴影的偏移量
        return view
    }()
    
    lazy var imageV:UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "Raiseset")
        return imageV
    }()
    
    lazy var topButton:RaiseSettingButtonExt = {
        let Btn = RaiseSettingButtonExt.init(type: .custom)
        Btn.titleLabel?.font = UIFont.pingFangTextFont(size: 12)
        Btn.setTitleColor(ColorGrayColor, for: .normal)
        Btn.addTarget(self, action: #selector(topAction), for: .touchUpInside)
        Btn.frame = CGRect.init(x: 15, y: 0, width: 50, height: 50)
        self.whiteCicleView.addSubview(Btn)
        Btn.setImage(UIImage.init(named: "jubao"), for: .normal)
        Btn.setTitle("举报", for: .normal)
        return Btn
    }()
    lazy var bottomButton:RaiseSettingButtonExt = {
        let Btn = RaiseSettingButtonExt.init(type: .custom)
        Btn.titleLabel?.font = UIFont.pingFangTextFont(size: 12)
        Btn.setTitleColor(ColorGrayColor, for: .normal)
        Btn.addTarget(self, action: #selector(bottomAction), for: .touchUpInside)
        Btn.frame = CGRect.init(x: topButton.right, y: 0, width: 50, height: 50)
        self.whiteCicleView.addSubview(Btn)
        Btn.setImage(UIImage.init(named: "quguan"), for: .normal)
        Btn.setTitle("解除关系", for: .normal)
        
        return Btn
    }()
   
    
    var model = RaiseAnimalsModel()
    
    init(model: RaiseAnimalsModel) {
        super.init(frame: screenFrame)
        self.model = model
        self.configUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    func configUI() {
        self.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(dismiss)))
        self.backgroundColor = UIColor.init(white: 0, alpha: 0.6)
        
        self.addSubviews([whiteCicleView,imageV])
        imageV.frame  = CGRect.init(x: ScreenW - 40 - 20, y: navigationBarHeight + 168, width: 42, height: 49)
        
        whiteCicleView.frame = CGRect.init(x: imageV.right, y: imageV.top - 5, width: 0, height: 60)
       
    }
    
    func show() {
        let window = UIApplication.shared.delegate?.window as? UIWindow
        window?.addSubview(self)
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .beginFromCurrentState, animations: {
            self.whiteCicleView.x = ScreenW - 160 - 20
            self.whiteCicleView.w = 160
            
        }) { (finish) in
            let originalFrame = self.topButton.frame
            
            self.topButton.frame = CGRect.init(origin: CGPoint.init(x: originalFrame.minX, y: 10), size: originalFrame.size)
            let originalFrames = self.bottomButton.frame
            self.bottomButton.frame = CGRect.init(origin: CGPoint.init(x: originalFrames.minX, y: 10), size: originalFrame.size)
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: {
                self.topButton.frame = originalFrame
                self.bottomButton.frame = originalFrames
            }) { finished in
                
            }
            
            
        }
        
        
    }

    @objc func dismiss() {
        UIView.animate(withDuration: 0.15, delay: 0.0, options: .curveEaseIn, animations: {
            self.whiteCicleView.x = ScreenW - 20
            self.whiteCicleView.w = 0
            self.whiteCicleView.alpha = 0
            self.alpha = 0
        }) { finshed in
            self.isHidden = true
            self.removeFromSuperview()
        }
    }
}
extension RaiseSettingShowView{
    @objc private func topAction(){
        dismiss()
        guard let UID = self.model.userId,let nameTitle = self.model.nickname else { return }
        let vc = ReportViewController.init(UID: UID, name: nameTitle)
        self.XZBCuruntView().navigationController?.pushViewController(vc, animated: true)
    }
    @objc private func bottomAction(){
        dismiss()
        guard let UID = self.model.userId,let nameTitle = self.model.nickname else { return }
        let vc = RaiseOverRelationViewController.init(UID: UID, name: nameTitle)
        self.XZBCuruntView().navigationController?.pushViewController(vc, animated: true)
        
    }
    
}





//MARK:攻略弹窗
class RaiseStrategyView: BaseShowView {
    lazy var imageV:UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage.init(named: "RaiseGuideBook")
        return imageV
    }()
    lazy var closeBtn : UIButton = {
        
        let Btn = UIButton.init(type: .custom)
        Btn.setImage(UIImage.init(named: "close"), for: .normal)
        Btn.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        
        return Btn
        
    }()
    
    
    init() {
        super.init(frame: screenFrame)
        initSubView()
        ceteateUI()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubView()
        ceteateUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func  ceteateUI(){
        backView.addSubviews([imageV,closeBtn])
        
        self.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(dismiss)))
        backView.frame = CGRect.init(x: 25, y: 0, width: ScreenW - 50, height: (ScreenW - 50)*1.42)
        
        backView.center = self.center
        
        backView.backgroundColor = .clear
        
        imageV.frame = CGRect.init(x: 0, y: 0, width: ScreenW - 50, height: (ScreenW - 50)*1.42)
        
        backView.addSubview(imageV)
        
        closeBtn.frame = CGRect.init(x: 0, y: backView.bottom + 20, width: 30, height: 30)
        closeBtn.centerX = self.centerX
        self.addSubview(closeBtn)
        
    }
    
   
}
