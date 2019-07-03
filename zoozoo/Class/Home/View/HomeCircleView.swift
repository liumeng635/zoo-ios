//
//  HomeCircleView.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/5/27.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit
import SVGAPlayer
import AMPopTip

let VIEWH = ScreenW*2
let scaleChoose : CGFloat = 1.3
// 子view比例
let MENURADIUS = 0.5 * VIEWH
// 中心view比例
let PROPORTION: Float = 0.8

func DIST(pointA: CGPoint, pointB: CGPoint) -> CGFloat {
    let pointX = (pointA.x - pointB.x) * (pointA.x - pointB.x)
    let pointY = (pointA.y - pointB.y) * (pointA.y - pointB.y)
    return CGFloat(sqrtf(Float(pointX + pointY)))
}
@objc protocol HomeCircleViewDelegate: NSObjectProtocol {
    /** 轮盘转到动物选中后卡片动物也 放大**/
    @objc optional func getSelectAnimal(selectAnimal: Int)
   
    
}
class HomeCircleView: UIView {
    weak var delegate: HomeCircleViewDelegate?
    private var beginPoint: CGPoint?
    
    private var orgin: CGPoint?
    private var oldRadius : CGFloat = 0
    private var beginRadius: CGFloat = 0
    private var rotateRadius : CGFloat = 0
    
    private var circleAngle : CGFloat = 0
    private var centerBigAnimalPoint: CGPoint = CGPoint.init(x: 0, y: 0)
    private var secBigAnimalPoint: CGPoint = CGPoint.init(x: 0, y: 0)
    private var subArray : [String] = []
    // 子view Array
    private var viewArray: [HomeAnimalView] = []
    // 背景view
    lazy var contentView:UIView = {
        let contentView  = UIView.init()
        contentView.backgroundColor = .white
        return contentView
    }()
    lazy var centerView:HomeCircleCenterView = {
        let centerView  = HomeCircleCenterView.init()
        return centerView
    }()
    
    var dataArr = [HomeAnimalModel]()
    let voicePopTip = PopTip.init()
    var voiceUrl = ""
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK:刷新布局
    func reloadView(arr :[HomeAnimalModel]){
        RetStatus()
        
        for _ in 0 ..< 4{
            arr.forEach({ (model) in
               self.dataArr.append(model)
            })
        }
        
        self.circleAngle = CGFloat(Double.pi/180*360) / CGFloat.init(self.dataArr.count)
        
        
        self.rotationCircleCenter(contentOrgin: CGPoint(x: MENURADIUS, y: MENURADIUS), contentRadius: MENURADIUS)
       
        self.addSubview(contentView)
        contentView.addSubview(centerView)
    }
    //MARK:重置
    func RetStatus(){
       

        self.subArray.removeAll()
        self.dataArr.removeAll()
        self.viewArray.removeAll()
        self.contentView.removeSubviews()
        self.contentView.removeFromSuperview()
        self.contentView.transform = .identity
        self.centerView.transform = .identity
    }
    //MARK:挑选卡片动物后轮盘动物弹出
    func showSelectCircleAnimal(index :Int){
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.backStartUI()
            if index > 0 && index < 4 {
                self.rotateCicleAnimal(angle: CGFloat.init(-index)*self.circleAngle)
            }
            if index == 4 {
                self.rotateCicleAnimal(angle: 3*self.circleAngle)
            }
            if index == 5 {
                self.rotateCicleAnimal(angle: 2*self.circleAngle)
            }
            if index == 6 {
                self.rotateCicleAnimal(angle: self.circleAngle)
            }
           
        }) { (finish) in
            self.getFinishBigAnimalView(isShowDelegate: false)
           
        }
    }
    //MARK:回到最初的角度
    func backStartUI(){
        contentView.transform = .identity
        centerView.transform = .identity
        for i in 0..<viewArray.count {
            let view = viewArray[i]
        
            view.transform = .identity
            view.tag = 0
           
        }
    }
    //MARK:初始化圆盘
    func initSubView(){
        
        contentView.frame = CGRect(x: 0, y: 0, width: VIEWH, height: VIEWH)
        contentView.center.x = self.center.x
        let maskPath = UIBezierPath(roundedRect: contentView.bounds, byRoundingCorners: .allCorners, cornerRadii: contentView.bounds.size)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = contentView.bounds
        maskLayer.path = maskPath.cgPath
        contentView.layer.mask = maskLayer
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(_:)))
        contentView.addGestureRecognizer(panGesture)
        self.addSubview(contentView)
        
        loadCenterView()
       
    }
    //MARK:初始化中间动物信息视图
    func loadCenterView(){
        let centerPoint = CGPoint(x: VIEWH / 2, y: VIEWH / 2)
        let centerViewH = VIEWH * CGFloat(PROPORTION)
        centerView.frame.size = CGSize(width: centerViewH, height: centerViewH)
        centerView.center = centerPoint
        let maskPath = UIBezierPath(roundedRect: centerView.bounds, byRoundingCorners: .allCorners, cornerRadii: centerView.bounds.size)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = centerView.bounds
        maskLayer.path = maskPath.cgPath
        centerView.layer.mask = maskLayer
        centerView.delegate = self
        contentView.addSubview(centerView)
    }
    
    //MARK:添加动物子视图到圆盘
    private func rotationCircleCenter(contentOrgin: CGPoint,
                                      contentRadius: CGFloat) {
       
        let scale: CGFloat = 1.48
        
        let viewCount = self.dataArr.count
      
        for i in 0..<viewCount {
            let x = contentRadius * CGFloat(sin(.pi * 2 / Double(viewCount) * Double(i)))
            let y = contentRadius * CGFloat(cos(.pi * 2 / Double(viewCount) * Double(i)))
            
            let view = HomeAnimalView.init(frame: CGRect(x:contentRadius + 0.5 * CGFloat((1 + PROPORTION)) * x - 0.5 * CGFloat((1 - PROPORTION)) * contentRadius, y: contentRadius - 0.5 * CGFloat(1 + PROPORTION) * y - 0.5 * CGFloat(1 - PROPORTION) * contentRadius, width: CGFloat((1 - PROPORTION)) * contentRadius, height: CGFloat((1 - PROPORTION)) * contentRadius))
           
            let centerPoint = view.center
            view.frame.size = CGSize(width: CGFloat((1 - PROPORTION)) * contentRadius / scale , height: CGFloat((1 - PROPORTION)) * contentRadius / scale)
            view.center = centerPoint
            centerView.model = self.dataArr[i]
            view.drawSubView(model: self.dataArr[i])
            // 这个tag判断view是不是在最下方变大状态,非变大状态0,变大为1
            view.tag = 0
            if i == 0{
                self.centerBigAnimalPoint = CGPoint.init(x: view.origin.x + (view.w/2), y: CircleViewY + view.origin.y  + (view.w/2))
                view.transform = view.transform.scaledBy(x: scaleChoose, y: scaleChoose)
                view.tag = 1
                //音频简介，显示音频
                self.voiceUrl = self.dataArr[i].voiceIntro ?? ""
                if !self.voiceUrl.isEmpty {
                    self.showPopVoice()
                }
                view.SelectImage.isHidden = false
            
            }
            if i == 1{
                
                self.secBigAnimalPoint = CGPoint.init(x: view.origin.x + (view.w/2), y: CircleViewY + view.origin.y  + (view.w/2))
            }
            
            contentView.addSubview(view)
            viewArray.append(view)
        }
        
        
       
        //获取中心点和右边第二个点的坐标
        secBigAnimalPoint = CGPoint.init(x: center.x + secBigAnimalPoint.x - centerBigAnimalPoint.x, y: secBigAnimalPoint.y)
        
        centerBigAnimalPoint = CGPoint.init(x: center.x, y:  centerBigAnimalPoint.y)
    }
    


}

//MARK:获得圆盘旋转动物中心角度
extension HomeCircleView {
    func getAnimalCircleRadious(flag:CGFloat) -> CGFloat{
        var lastangle : CGFloat = 0
        var radious1 : CGFloat = 0
        var radious2 : CGFloat = 0
       
        
        let yDistance = centerBigAnimalPoint.y - center.y;
        let xDistance = centerBigAnimalPoint.x - center.x
        let radious =  atan2(yDistance, xDistance)
        
        for i in 0..<viewArray.count {
            let view = viewArray[i]
            let rect = view.convert(view.bounds, to: UIApplication.shared.keyWindow)
            
            let rectMarginX = self.secBigAnimalPoint.x - self.centerBigAnimalPoint.x
            let rectX = rect.origin.x + (rect.width) / 2
            let rectY = rect.origin.y + (rect.width) / 2

            if self.centerBigAnimalPoint.x < rectX && self.centerBigAnimalPoint.y < rectY && self.secBigAnimalPoint.x  > rectX && self.secBigAnimalPoint.y > rectY{
//                ZLog("//右边最后得到的view.origin======\(view.origin)")
                let yDistance = rectY - center.y;
                let xDistance = rectX - center.x
                radious1 =  atan2(yDistance, xDistance)
                
                //右边
                
            }
            if self.centerBigAnimalPoint.x - rectMarginX  < rectX && self.centerBigAnimalPoint.y < rectY && self.centerBigAnimalPoint.x  > rectX && self.secBigAnimalPoint.y > rectY{
                
                let yDistance = rectY - center.y;
                let xDistance = rectX - center.x
                radious2 =  atan2(yDistance, xDistance)
                
                //左边
            }
        }
        if flag > 0{
            lastangle = (abs(radious1)  - abs(radious))
        }else{
            //右滑
            lastangle = abs(radious)  - abs(radious2)
        }
        
//        ZLog("end之后的lastangle======\(lastangle*flag)")
        
        return lastangle*flag
        
    }
    
}
//MARK:拖动手势
extension HomeCircleView {
    
    @objc private func handlePanGesture(_ pan: UIPanGestureRecognizer) {
        let touchPoint:CGPoint = pan.location(in: self)
        let transPoint:CGPoint = pan.translation(in: self)
        let centerPoint:CGPoint = self.center
        
        switch pan.state{
        case .began:
            let yDistance = touchPoint.y - centerPoint.y;
            let xDistance = touchPoint.x - centerPoint.x
            let radious =  atan2(yDistance, xDistance)
            oldRadius = radious
            beginRadius = radious
           
            break
        case .changed:
            let yDistance = touchPoint.y - centerPoint.y;
            let xDistance = touchPoint.x - centerPoint.x
            let radious =  atan2(yDistance, xDistance)
            rotateRadius = radious - oldRadius
            
            oldRadius = radious
            self.rotateCicleAnimal(angle: rotateRadius)
            
            break
        case .ended :
            var flag = 1
            let absX = abs(transPoint.x);
            let absY = abs(transPoint.y);
            if absX > absY  {
                if (transPoint.x<0) {
                    flag = 1//向左滑动
                }else{
                    flag = -1
                    //向右滑动
                }
            }
            let velocity = pan.velocity(in: pan.view)
            let magnitude = sqrtf(Float((velocity.x * velocity.x) + (velocity.y * velocity.y))) //真实速度
            var Duration = 0.1 * magnitude / 200
            Duration = Duration > 2.5 ? 2.5 : Duration
            if Duration > 0.5 {
                let angle = CGFloat.init(-flag) * self.circleAngle * CGFloat.init(Int.init( Duration*5))
                
                UIView.animate(withDuration: TimeInterval(1), animations: {
                    self.rotateCicleAnimal(angle: angle)
                }) { (finish) in
                    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                        
                        self.rotateCicleAnimal(angle: self.getAnimalCircleRadious(flag: CGFloat(flag)))
                    }) { (finish) in
                        self.getFinishBigAnimalView(isShowDelegate: true)
                    }
                }
            }else{
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                    self.rotateCicleAnimal(angle: self.getAnimalCircleRadious(flag: CGFloat(flag)))
                }) { (finish) in
                    self.getFinishBigAnimalView(isShowDelegate: true)
                }
       
            }
           
            
            break
        case .cancelled:
            break
        case .failed:
            break
        case .possible:
            break
        }
        
    }
    
}
//MARK:旋转
extension HomeCircleView {
 
    
    func getFinishBigAnimalView(isShowDelegate:Bool){
        for i in 0..<viewArray.count {
            let view = viewArray[i]
            let rect = view.convert(view.bounds, to: UIApplication.shared.keyWindow)
            let viewW = (rect.width) / 2
            let viewCenterX = rect.origin.x + viewW
            if viewCenterX > self.center.x - viewW && viewCenterX < self.center.x + viewW && rect.origin.y < CircleViewY + rect.height + 20{
                
                
                if view.tag == 0 {
                    view.SelectImage.isHidden = false
                    view.transform = viewArray[i].transform.scaledBy(x: scaleChoose, y: scaleChoose)
                    view.tag = 1
                    contentView.bringSubviewToFront(viewArray[i])
                    centerView.model = self.dataArr[i]
                    if isShowDelegate {
                         self.delegate?.getSelectAnimal?(selectAnimal: Int.init(i%7))
                    }
                    
                    
                    
                    self.voiceUrl = self.dataArr[i].voiceIntro ?? ""
                    
                    if !self.voiceUrl.isEmpty {
                        self.showPopVoice()
                    }else{
                        self.voicePopTip.hide()
                    }
                }
            } else {
                if view.tag == 1 {
                    view.SelectImage.isHidden = true
                    view.transform = view.transform.scaledBy(x: 1/scaleChoose, y: 1/scaleChoose)
                    view.tag = 0
                    contentView.sendSubviewToBack(view)
                    
                }
                
            }
        }
    }
    //MARK:触碰滑动的旋转
    func rotateCicleAnimal(angle:CGFloat)  {
        self.voicePopTip.hide()
        contentView.transform = contentView.transform.rotated(by: angle)
        
        centerView.transform = centerView.transform.rotated(by: -angle)
        for i in 0..<viewArray.count {
            let view = viewArray[i]
            view.transform = view.transform.rotated(by: -angle)
            
        }
    }
    
    func showSVGAPlayerAnimation(name :String){
        for i in 0..<viewArray.count {
            let view = viewArray[i]
            if view.tag == 1{
                let player = SVGAPlayer.init()
                player.frame = CGRect.init(x: ScreenW/2 - playerW/2, y: CircleViewY, width: playerW, height: playerW)
                let window = UIApplication.shared.delegate?.window as? UIWindow
                window?.addSubview(player)
                
                let parser = SVGAParser.init()
                parser.parse(withNamed: name, in: nil, completionBlock: { (videoItem) in
                    player.videoItem = videoItem
                    player.startAnimation()
                }) { (error) in
                    
                }
                player.loops = 1
                player.clearsAfterStop = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    player.stopAnimation()
                    player.isHidden = true
                    player.removeFromSuperview()
                }
            }
        }
    }
}

//MARK:啤酒动画和爱心其他动画加载
extension HomeCircleView : HomeCircleCenterViewDelegate{
    func startAnimation(type: Int) {
        
        if type == 0 {
           self.showSVGAPlayerAnimation(name: "face")
        }else if type == 1 {
            self.showSVGAPlayerAnimation(name: "animal_home_beer1")
            
        }
    }
}

extension HomeCircleView {
     //MARK:弹出动物音频简介视图
    private func  showPopVoice(){
        if #available(iOS 10.0, *) {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        }
        
        let imageView = UIImageView(image: UIImage(named: "homeVoicePlay"))
        imageView.isUserInteractionEnabled = true
        let TapGesture = UITapGestureRecognizer(target: self, action: #selector(self.playVoice))
        imageView.addGestureRecognizer(TapGesture)
        let homeVoice = UIImageView(image: UIImage(named: "homeVoice"))
        let label = UILabel.init(font: UIFont.pingFangTextFont(size: 10), color: ColorGrayColor, alignment: .left)
        label.text = "点击播放"
        let popFrame = CGRect.init(x: ScreenW/2 - imageView.w/2, y: CircleViewY + 20 , width: imageView.frame.width, height: imageView.frame.height)
        
        let customView = UIView(frame:popFrame)
        customView.isUserInteractionEnabled = true
        customView.backgroundColor = UIColor.clear
        imageView.frame = CGRect(x: 0, y: 0, width: imageView.frame.width, height: imageView.frame.height)
        homeVoice.frame = CGRect(x: 20, y: 0, width: homeVoice.size.width, height: homeVoice.size.height)
        homeVoice.centerY = imageView.centerY - 5
        label.frame = CGRect(x: homeVoice.size.width + 22, y: 0, width: imageView.size.width, height: 20)
        label.centerY = imageView.centerY  - 5
        imageView.addSubview(homeVoice)
        imageView.addSubview(label)
        customView.addSubview(imageView)
        voicePopTip.bubbleColor = UIColor.clear
        voicePopTip.shouldDismissOnTap = false
        voicePopTip.shouldDismissOnTapOutside = false
        voicePopTip.frame = popFrame
        let window = UIApplication.shared.delegate?.window as? UIWindow
        voicePopTip.show(customView: customView, direction: .up, in: window!, from: popFrame)
        
    }
    //MARK:播放动物音频简介
    @objc private func playVoice(){
        VoiceAudioUrlPlayer.shared.playAudioUrl(audioUrl: self.voiceUrl)
    }
}




class HomeAnimalView: UIView {
    
    var backImage: UIImageView = {
        let view = UIImageView()
        return view
    }()
    var SelectImage: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = ColorTheme
        view.isHidden = true
        return view
    }()
    var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = false
        return view
    }()
    let popTip = PopTip.init()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.masksToBounds = true
        self.addSubview(backImage)
        self.addSubview(SelectImage)
        self.addSubview(imageView)
        let TapGesture = UITapGestureRecognizer(target: self, action: #selector(self.showPopVoice))
        imageView.addGestureRecognizer(TapGesture)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    func drawSubView(model: HomeAnimalModel) {
        
        self.layer.cornerRadius = self.frame.width / 2
        self.backImage.frame = CGRect(x: 0, y:0 , width: self.frame.width, height: self.frame.width)
        self.SelectImage.frame = CGRect(x: 0, y:0 , width: self.frame.width, height: self.frame.width)
        self.imageView.frame = CGRect(x: 0, y:0 , width: self.frame.width, height: self.frame.width)
        self.backImage.kf.setImage(urlString:  model.headBackImage)
        self.imageView.kf.setImage(urlString:  model.petThumbImage)
    }
     public  var ImagePopVoiceClickBlock : (()->Void)?
    @objc private func  showPopVoice(){
        self.ImagePopVoiceClickBlock?()
        
    }
    
}

