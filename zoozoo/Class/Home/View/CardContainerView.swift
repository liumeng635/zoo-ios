//
//  CardContainerView.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/5/29.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

public enum ContainerDragDirection : Int {
    case ContainerDragDefaults
    
    case ContainerDragLeft
    
    case ContainerDragRight
}
@objc protocol CardContainerViewDataSource: NSObjectProtocol {
    /** 数据源个数 **/
    @objc optional func numberOfRowsInCardContainer(container :CardContainerView) -> Int
    /** 显示数据源 **/

    @objc optional  func container(_ container: CardContainerView, viewForRowAt index: Int) -> CardAnimalHeadView
    
}
@objc protocol CardContainerViewDelegate: NSObjectProtocol {
   /** 点击卡片回调 **/
    @objc optional func container(_ container: CardContainerView, didSelectRowAt index: Int)
    /** 拖到最后一张卡片 YES，空，可继续调用reloadData分页数据**/
    @objc optional func container(_ container: CardContainerView, dataSourceIsDisappear isEmpty: Bool ,index: Int)
    /**  当前cardview 是否可以拖拽，默认YES **/
    @objc optional func container(_ container: CardContainerView, canDragForCardView: CardAnimalHeadView) -> Bool

}
class CardContainerView: UIView {
     weak var dataSource: CardContainerViewDataSource?
     weak var delegate: CardContainerViewDelegate?
   
    private var direction = ContainerDragDirection.ContainerDragDefaults
    private var cards: [CardAnimalHeadView] = []
    private var xCenter: CGFloat = 0.0
    private var yCenter: CGFloat = 0.0
    private var originalPoint = CGPoint.zero
    private var cardCenter = CGPoint.zero
    override init(frame: CGRect) {
        super.init(frame: frame)
       
    }

    func addSubViews(){
        self.cards.removeAll()
        let sum = self.dataSource?.numberOfRowsInCardContainer?(container: self) ?? 0
        
        for i in 0 ..< sum {
            let cardView = self.dataSource?.container?(self, viewForRowAt: i)
            
            cardView?.frame = self.frame
            self.cardCenter = self.center
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(_:)))
            cardView?.addGestureRecognizer(panGesture)
            let TapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTapGesture(_:)))
            cardView?.addGestureRecognizer(TapGesture)
            
            self.addSubview(cardView!)
            self.sendSubviewToBack(cardView!)
            self.cards.append(cardView!)
            
        }
        
        
    }

    
    
    
    func showSelectAniaml(index : Int){
        self.cards.first?.showSelectAniaml(index: index)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension CardContainerView{
    
    //MARK:移动卡片
    func panGesturemMoveFinishOrCancle(cardView :CardAnimalHeadView, direction :ContainerDragDirection , scale :CGFloat ,isDisappear :Bool ,index :Int){
        if isDisappear{
            var finishPoint = CGPoint.zero
            if direction == .ContainerDragLeft {
                finishPoint = CGPoint.init(x: -ScreenW, y: -ScreenW/scale + self.cardCenter.y)
            }else if direction == .ContainerDragRight{
                finishPoint = CGPoint.init(x: 2*ScreenW, y: 2 * ScreenW/scale + self.cardCenter.y)
            }else{
                finishPoint = self.originalPoint
            }
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveLinear , .allowUserInteraction], animations: {
                
                cardView.center = finishPoint
            }) { (finished) in
                
                self.delegate?.container?(self, dataSourceIsDisappear: true ,index: index)
                cardView.removeFromSuperview()
                 self.cards.remove(at: index)
            }
           
          
        }else{
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: [], animations: {
                cardView.center = self.originalPoint
                self.transform = CGAffineTransform(rotationAngle: 0)
                
            })
        }
    }
    //拖动手势
    @objc private func handlePanGesture(_ pan: UIPanGestureRecognizer) {
        guard let canEdit  = self.delegate?.container?(self, canDragForCardView: pan.view as! CardAnimalHeadView) else { return}
        if canEdit {
             let handleCardView = pan.view as! CardAnimalHeadView
            xCenter = pan.translation(in: self).x
            yCenter = pan.translation(in: self).y
            switch pan.state{
                
            case .began:
                 originalPoint = self.center
                break
            case .changed:
               
                
                handleCardView.center = CGPoint.init(x: handleCardView.center.x + xCenter, y: handleCardView.center.y + yCenter)
                
               
                
                let angle = (handleCardView.center.x - self.cardCenter.x) / self.cardCenter.x

                handleCardView.transform = CGAffineTransform.init(rotationAngle: angle *  CGFloat(Double.pi / 4 / 12))

                
                pan.setTranslation(.zero, in: self)
                
           
                break
            case .ended :
              
               
                if handleCardView.center.x < self.cardCenter.x {
                    self.direction = .ContainerDragLeft
                }else if handleCardView.center.x > self.cardCenter.x{
                    self.direction = .ContainerDragRight
                }else{
                    self.direction = .ContainerDragDefaults
                }
                
                
                
                 let horizionSliderRate = (handleCardView.center.x - self.cardCenter.x) / self.cardCenter.x
             
                 let moveY = handleCardView.center.y  - self.cardCenter.y
                 let moveX = handleCardView.center.x - self.cardCenter.x
                 self.panGesturemMoveFinishOrCancle(cardView: handleCardView, direction: self.direction, scale: moveX/moveY, isDisappear: abs(horizionSliderRate)>1, index: pan.view?.tag ?? 0)
                 
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
    //手动点击移除
    @objc private func handleTapGesture(_ tap: UITapGestureRecognizer) {
        self.delegate?.container?(self, didSelectRowAt: tap.view?.tag ?? 0)
        
    }
   
}
//MARK:刷新数据
extension CardContainerView{
    public func reloadData(){
        self.removeSubviews()
        self.addSubViews()
    }
}
