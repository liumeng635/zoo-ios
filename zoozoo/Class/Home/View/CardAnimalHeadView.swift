//
//  CardAnimalHeadView.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/5/29.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit
import AMPopTip

let BigAnimalH : CGFloat = 200 * ScaleW
let BigAnimalW : CGFloat = BigAnimalH * 1.1
let animalH : CGFloat = 150 * ScaleW
let animalW : CGFloat = animalH * 1.1
let animalMargin : CGFloat = 55 * ScaleW
let BottomMargin : CGFloat = 55 * ScaleW
let BottomAnimalH: CGFloat = 80 * ScaleW
let CardBottomH: CGFloat = 100
let BigScale : CGFloat = 1.5
@objc protocol CardAnimalHeadViewDelegate: NSObjectProtocol {
    /** 选中后卡片动物也 轮盘转到动物放大**/
    @objc optional func CardSelectAnimalCircleDiselect(selectAnimal: Int) 
}

class CardAnimalHeadView: UIView {
    weak var delegate: CardAnimalHeadViewDelegate?
    lazy var sun:UIImageView = {
        let view  = UIImageView.init()
        view.image = UIImage.init(named: "saturn")
        view.frame = CGRect(x: 0, y: navigationBarHeight + 20, width: 40, height: 30)
        return view
    }()
    lazy var man:UIImageView = {
        let view  = UIImageView.init()
        view.image = UIImage.init(named: "yuhangyuan")
        view.frame = CGRect(x: ScreenW/2 + 50, y: 0, width: 25, height: 50)
        view.centerY = self.centerY - 50
        return view
    }()
    var backImage: UIImageView = {
        let view = UIImageView()
        return view
    }()
    var animalLeft: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    var animalRight: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    var animal1: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    var animal2: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    var animal3: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    var animal4: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    var animal5: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    var animal6: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    var animal7: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    var BottomAnimal3: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.image = UIImage.init(named: "basebottomSelect")
        return view
    }()
    var BottomAnimal4: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.image = UIImage.init(named: "basebottomNomal")
        return view
    }()
    var BottomAnimal5: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.image = UIImage.init(named: "basebottomNomal")
        return view
    }()
    var BottomAnimal6: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.image = UIImage.init(named: "basebottomNomal")
        return view
    }()
    var BottomAnimal7: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.image = UIImage.init(named: "basebottomNomal")
        return view
    }()
    
    let HollePopTip = PopTip.init()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
       createUI()
    
        
    }
    func createUI(){
        layer.cornerRadius = 8
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 1, height: 3)
        layer.shadowColor = UIColor.darkGray.cgColor
        clipsToBounds = true
        
        createLayout()
        
        addGestureRecognizerClick()
        
        configAnimalAction()
      
    }
    
    
    func createLayout(){
        self.addSubview(backImage)
        self.addSubviews([sun,man])
        self.addSubviews([BottomAnimal3,BottomAnimal4,BottomAnimal5,BottomAnimal6,BottomAnimal7])
        self.addSubviews([animalLeft,animalRight,animal3,animal4,animal5,animal6,animal7])
        
        animalLeft.addSubview(animal1)
        animalRight.addSubview(animal2)
        
        backImage.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        animal3.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-CardBottomH)
            make.width.equalTo(animalW)
            make.height.equalTo(animalH)
        }
        animalLeft.snp.makeConstraints { (make) in
            make.bottom.equalTo(animal3.snp_top).offset(60*ScaleW)
            make.left.equalTo(-BigAnimalW/3)
            make.width.equalTo(BigAnimalW)
            make.height.equalTo(BigAnimalH)
        }
        animalRight.snp.makeConstraints { (make) in
            make.bottom.equalTo(animal3.snp_top).offset(60*ScaleW)
            make.right.equalTo(BigAnimalW/3)
            make.width.equalTo(BigAnimalW*1.2)
            make.height.equalTo(BigAnimalH*1.2)
        }
        animal1.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        animal2.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
       
        
        animal4.snp.makeConstraints { (make) in
            make.right.equalTo(animal3.snp_left).offset(animalMargin + 10*ScaleW)
            make.bottom.equalTo(-CardBottomH + 15*ScaleW)
            make.width.equalTo(animalW*0.85)
            make.height.equalTo(animalH*0.85)
        }
        
        animal5.snp.makeConstraints { (make) in
            make.left.equalTo(animal3.snp_right).offset(-animalMargin - 10*ScaleW)
            make.bottom.equalTo(-CardBottomH + 15*ScaleW)
            make.width.equalTo(animalW*0.85)
            make.height.equalTo(animalH*0.85)
        }
        
        animal6.snp.makeConstraints { (make) in
            make.right.equalTo(animal4.snp_left).offset(animalMargin)
            make.bottom.equalTo(-CardBottomH + 30*ScaleW)
            make.width.equalTo(animalW*0.7)
            make.height.equalTo(animalH*0.7)
        }
        animal7.snp.makeConstraints { (make) in
            make.left.equalTo(animal5.snp_right).offset(-animalMargin)
            make.bottom.equalTo(-CardBottomH + 30*ScaleW)
            make.width.equalTo(animalW*0.7)
            make.height.equalTo(animalH*0.7)
        }
        BottomAnimal3.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(animal3.snp_bottom).offset(-BottomMargin)
            make.width.equalTo(animalW*0.75)
            make.height.equalTo(BottomAnimalH)
        }
        BottomAnimal4.snp.makeConstraints { (make) in
            make.centerX.equalTo(animal4.snp_centerX)
            make.top.equalTo(animal4.snp_bottom).offset(-BottomMargin)
            make.width.equalTo(animalW*0.65)
            make.height.equalTo(BottomAnimalH)
        }
        BottomAnimal5.snp.makeConstraints { (make) in
            make.centerX.equalTo(animal5.snp_centerX)
            make.top.equalTo(animal5.snp_bottom).offset(-BottomMargin)
            make.width.equalTo(animalW*0.65)
            make.height.equalTo(BottomAnimalH)
        }
        BottomAnimal6.snp.makeConstraints { (make) in
            make.centerX.equalTo(animal6.snp_centerX)
            make.top.equalTo(animal6.snp_bottom).offset(-BottomMargin)
            make.width.equalTo(animalW*0.55)
            make.height.equalTo(BottomAnimalH)
        }
        BottomAnimal7.snp.makeConstraints { (make) in
            make.centerX.equalTo(animal7.snp_centerX)
            make.top.equalTo(animal7.snp_bottom).offset(-BottomMargin)
            make.width.equalTo(animalW*0.55)
            make.height.equalTo(BottomAnimalH)
        }
    }
   
    
    public var model:RandomPetsModel? {
        didSet{
            guard let _ = model else {
                return
            }
            self.CircleAnimation(imageView: sun, fromLeft: true)
            self.CircleManAnimation(imageView: man)

            
            backImage.kf.setImage(urlString: model?.starImage)
            
            let animals = [animal3,animal4,animal5,animal6,animal7,animal1,animal2]
           
            for i in 0 ..< animals.count {
                animals[i].kf.setImage(urlString: model?.randomPets[i].petImage ?? "")
            }
            
            
        }
    }
    
    func addGestureRecognizerClick(){
        let animals = [animal3,animal4,animal5,animal6,animal7,animalLeft,animalRight]
        for i in 0 ..< animals.count {
            let animal = animals[i]
            animal.isUserInteractionEnabled = true
            animal.tag = i
             let TapGesture = UITapGestureRecognizer(target: self, action: #selector(self.gotoImageClick(_:)))
            animal.addGestureRecognizer(TapGesture)
            
        }
        
    }
    
    func configAnimalAction(){
        self.animal1.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 6)
        self.animal2.transform = CGAffineTransform(rotationAngle: -(CGFloat.pi / 5))
        self.BasicAnimation(imageView: self.BottomAnimal3)
    }
    
    //MARK:动物点击事件
    @objc private func gotoImageClick(_ gest: UITapGestureRecognizer){
        let index =  gest.view?.tag ?? 0
        self.delegate?.CardSelectAnimalCircleDiselect?(selectAnimal: index)
        showSelectAniaml(index: index)
        
    }
    
    
    
    //MARK:被挑选的动物抖动
    func showSelectAniaml(index : Int){

        let animals = [animal3,animal4,animal5,animal6,animal7,animalLeft,animalRight]
     

        self.entranceScale(view: animals[index], index: index)
        
        
        
        self.reloadImageAnimalsUI(index: index)
        
         //播放动物音频
          VoiceAudioUrlPlayer.shared.playAudioUrl(audioUrl: self.model?.randomPets[index].petVoice ?? "")
        
        
    }
   
    
    //MARK:刷新圆盘闪光UI
    func reloadImageAnimalsUI(index :Int){
        let BottomAnimals = [BottomAnimal3,BottomAnimal4,BottomAnimal5,BottomAnimal6,BottomAnimal7,UIImageView.init(),UIImageView.init()]
        
        for i in 0 ..< BottomAnimals.count{
             BottomAnimals[i].layer.removeAllAnimations()
            if index == i {
                self.BasicAnimation(imageView: BottomAnimals[index])
                BottomAnimals[index].image = UIImage.init(named: "basebottomSelect")
            }else{
                BottomAnimals[i].layer.removeAllAnimations()
                BottomAnimals[i].image = UIImage.init(named: "basebottomNomal")
            }
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
//MARK:各种动画
extension CardAnimalHeadView {
    func CircleManAnimation(imageView :UIImageView){
        
        let num = CGFloat.init(Int(arc4random_uniform(30))+30)
       
        UIView.animate(withDuration: 5, delay: 0, options: .curveLinear, animations: {
             imageView.y = imageView.y - num
        }) { (finish) in
            UIView.animate(withDuration: 5, delay: 0, options: .curveEaseInOut, animations: {
               imageView.x = imageView.x - num*1.5
            }) { (finish) in
                UIView.animate(withDuration: 10, delay: 0, options: .curveLinear, animations: {
                    imageView.y = imageView.y + num*2
                }) { (finish) in
                    UIView.animate(withDuration: 5, delay: 0, options: .curveEaseInOut, animations: {
                        imageView.y = imageView.y - num
                        imageView.x = imageView.x + num*1.5
                    }) { (finish) in
                        self.CircleManAnimation(imageView: imageView)
                    }
                }
            }
        }
    }
    //MARK:循环滚动动画
    func CircleAnimation(imageView :UIImageView,fromLeft :Bool){
        var isLeft = fromLeft
        UIView.animate(withDuration: 22, delay: 0, options: .curveLinear, animations: {
            
            if fromLeft {
                imageView.x = self.bounds.origin.x + ScreenW - imageView.size.width
            }else{
                imageView.x = self.bounds.origin.x
            }
            isLeft = !isLeft
        }) { (finish) in
            
            self.CircleAnimation(imageView: imageView, fromLeft: isLeft)
        }
        

       
        
    }
    
    
    //MARK:闪光灯舞台动画
    func BasicAnimation(imageView :UIImageView){
        let basicAnimation = CABasicAnimation(keyPath: "opacity")
        basicAnimation.fromValue = 1
        basicAnimation.toValue = 0.3
        basicAnimation.duration = 1.2
        basicAnimation.repeatCount = HUGE
        basicAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        imageView.layer.add(basicAnimation, forKey: nil)
        
        
    }
}
extension CardAnimalHeadView {
    
    //MARK:显示动物弹出对话框
    func  showPopTips(direction :String){
        let textArr = ["Hi","Hey","Hello","看这里","你好","你好呀","来啦","我在这","选我吧","带我走","快看我"]
        
        let imageView = UIImageView(image: UIImage(named: "hello\(direction)"))
        
        var popFrame = CGRect.zero
        
        if direction == "Left"{
            popFrame = CGRect.init(x: animalLeft.x + imageView.w + 10*ScaleW , y: animalRight.y + 30*ScaleW , width: imageView.frame.width, height: imageView.frame.height)
        }else{
            popFrame = CGRect.init(x: animalRight.x + imageView.w - 10*ScaleW , y: animalRight.y + 50*ScaleW , width: imageView.frame.width, height: imageView.frame.height)
        }
        
        
        
        let label = UILabel.init(font: UIFont.pingFangTextFont(size: 14), color: ColorGrayTitle, alignment: .center)
        label.text = textArr[Int.init(arc4random() % 11)]
        
        let customView = UIView(frame:popFrame)
        customView.backgroundColor = UIColor.clear
        imageView.frame = CGRect(x: 0, y: 0, width: imageView.frame.width, height: imageView.frame.height)
        label.frame = CGRect(x: imageView.center.x + 5, y: 0, width: 50, height: 15)
        label.center = imageView.center
        
        imageView.addSubview(label)
        customView.addSubview(imageView)
        HollePopTip.bubbleColor = UIColor.clear
        HollePopTip.shouldDismissOnTap = false
        HollePopTip.shouldDismissOnTapOutside = true
        HollePopTip.frame = popFrame
        HollePopTip.show(customView: customView, direction: direction == "Left" ? .right : .left, in: self, from: popFrame)
        
    }
    
    
    
    //MARK:动物出现的动画
    private func entranceScale(view :UIImageView, index :Int) {
        let scale = CGFloat.init(1.05)
        let scaleSmall = CGFloat.init(1.02)
        
        UIView.animate(withDuration: 0.3, animations: {
            view.frame = CGRect.init(x: view.origin.x, y: view.origin.y - 10, width: view.w, height: view.h )
            
            view.transform = view.transform.scaledBy(x: scale, y: scale)
        }) { (finidh) in
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
                view.frame = CGRect.init(x: view.origin.x, y: view.origin.y + 10, width: view.w, height: view.h)
                view.transform = .identity
            }) { (finish) in
                UIView.animate(withDuration: 0.2, animations: {
                    view.frame = CGRect.init(x: view.origin.x, y: view.origin.y - 5, width: view.w , height: view.h )
                    view.transform = view.transform.scaledBy(x: scaleSmall, y: scaleSmall)
                }) { (finidh) in
                    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                        if index == 6 {
                            self.showPopTips(direction: "Right")
                        }else if index == 5{
                            self.showPopTips(direction: "Left")
                        }else{
                            self.HollePopTip.hide()
                        }
                        view.frame = CGRect.init(x: view.origin.x, y: view.origin.y + 5, width: view.w, height: view.h)
                        view.transform = .identity
                    }) { (finish) in
                        
                    }
                }
            }
        }
        
        
    }
}
