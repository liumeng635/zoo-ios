//
//  XZBUIViewExtension.swift
//  XZBBaseSwift
//
//  Created by 🍎上的豌豆 on 2018/10/16.
//  Copyright © 2018年 xiao. All rights reserved.
//

import UIKit


extension UIView {
    public func addSubviews(_ views: [UIView]) {
        views.forEach { [weak self] eachView in
            self?.addSubview(eachView)
        }
    }
    
    public var x: CGFloat {
        get {
            return self.frame.origin.x
        } set(value) {
            self.frame = CGRect(x: value, y: self.y, width: self.w, height: self.h)
        }
    }
    
    
    public var y: CGFloat {
        get {
            return self.frame.origin.y
        } set(value) {
            self.frame = CGRect(x: self.x, y: value, width: self.w, height: self.h)
        }
    }
    
   
    public var w: CGFloat {
        get {
            return self.frame.size.width
        } set(value) {
            self.frame = CGRect(x: self.x, y: self.y, width: value, height: self.h)
        }
    }
    
    
    public var h: CGFloat {
        get {
            return self.frame.size.height
        } set(value) {
            self.frame = CGRect(x: self.x, y: self.y, width: self.w, height: value)
        }
    }
    
    /// XZBUIViewExtension
    public var left: CGFloat {
        get {
            return self.x
        } set(value) {
            self.x = value
        }
    }
    
    /// XZBUIViewExtension
    public var right: CGFloat {
        get {
            return self.x + self.w
        } set(value) {
            self.x = value - self.w
        }
    }
    
    /// XZBUIViewExtension
    public var top: CGFloat {
        get {
            return self.y
        } set(value) {
            self.y = value
        }
    }
    
    /// XZBUIViewExtension
    public var bottom: CGFloat {
        get {
            return self.y + self.h
        } set(value) {
            self.y = value - self.h
        }
    }
    
    /// XZBUIViewExtension
    public var origin: CGPoint {
        get {
            return self.frame.origin
        } set(value) {
            self.frame = CGRect(origin: value, size: self.frame.size)
        }
    }
    
    /// XZBUIViewExtension
    public var centerX: CGFloat {
        get {
            return self.center.x
        } set(value) {
            self.center.x = value
        }
    }
    
    /// XZBUIViewExtension
    public var centerY: CGFloat {
        get {
            return self.center.y
        } set(value) {
            self.center.y = value
        }
    }
    
    /// XZBUIViewExtension
    public var size: CGSize {
        get {
            return self.frame.size
        } set(value) {
            self.frame = CGRect(origin: self.frame.origin, size: value)
        }
    }
    
    /// XZBUIViewExtension
    public func leftOffset(_ offset: CGFloat) -> CGFloat {
        return self.left - offset
    }
    
    /// XZBUIViewExtension
    public func rightOffset(_ offset: CGFloat) -> CGFloat {
        return self.right + offset
    }
    
    /// XZBUIViewExtension
    public func topOffset(_ offset: CGFloat) -> CGFloat {
        return self.top - offset
    }
    
    /// XZBUIViewExtension
    public func bottomOffset(_ offset: CGFloat) -> CGFloat {
        return self.bottom + offset
    }
    
    //TODO: Add to readme
    /// XZBUIViewExtension
    public func alignRight(_ offset: CGFloat) -> CGFloat {
        return self.w - offset
    }
    public func removeSubviews() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
     /// EZSE: Centers view in superview horizontally
    public func centerXInSuperView() {
        guard let parentView = superview else {
            assertionFailure("EZSwiftExtensions Error: The view \(self) doesn't have a superview")
            return
        }
        
        self.x = parentView.w/2 - self.w/2
    }
    /// EZSE: Centers view in superview vertically
    public func centerYInSuperView() {
        guard let parentView = superview else {
            assertionFailure("EZSwiftExtensions Error: The view \(self) doesn't have a superview")
            return
        }
        
        self.y = parentView.h/2 - self.h/2
    }
    
    /// EZSE: Centers view in superview horizontally & vertically
    public func centerInSuperView() {
        self.centerXInSuperView()
        self.centerYInSuperView()
    }
}

extension UIView {
   
   
    
   
    public func setScale(x: CGFloat, y: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DScale(transform, x, y, 1)
        self.layer.transform = transform
    }
    
    public func setCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    public func addShadow(offset: CGSize, radius: CGFloat, color: UIColor, opacity: Float, cornerRadius: CGFloat? = nil) {
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.shadowColor = color.cgColor
        if let r = cornerRadius {
            self.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: r).cgPath
        }
    }
    public func addBorder(width: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        layer.masksToBounds = true
    }
    
    public func drawCircle(fillColor: UIColor, strokeColor: UIColor, strokeWidth: CGFloat) {
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.w, height: self.w), cornerRadius: self.w/2)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = strokeWidth
        self.layer.addSublayer(shapeLayer)
    }
    public func drawStroke(width: CGFloat, color: UIColor) {
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.w, height: self.w), cornerRadius: self.w/2)
        let shapeLayer = CAShapeLayer ()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        self.layer.addSublayer(shapeLayer)
    }
    
    public func toImage () -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0.0)
        drawHierarchy(in: bounds, afterScreenUpdates: false)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    //UIView 转化为 UIImage
    public func convertToImage() -> UIImage{
        
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0)
        var image = UIImage()
        if let context = UIGraphicsGetCurrentContext(){
            self.layer.render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext()!
        }
        UIGraphicsEndImageContext()
        return image
    }
    //UIView 转化为 UIImage
    public func convertToDIYImage(image :UIImage) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(image.size, false, 0)
        image.draw(in: CGRect.init(x: 0, y: 0, width: image.size.width, height: image.size.height))
        var newImage = UIImage()
        if let context = UIGraphicsGetCurrentContext(){
            self.layer.render(in: context)
            newImage = UIGraphicsGetImageFromCurrentImageContext()!
        }
        UIGraphicsEndImageContext()
        return newImage
    }
}

extension UIView{
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        self.layer.add(animation, forKey: nil)
    }
    
    public func curViewController() -> UIViewController{
        
        var next = self.next
        
        repeat{
            if next?.isKind(of: UIViewController.self) ?? false {
                return next as? UIViewController ?? UIViewController.init()
            }
            next = next?.next
        }while (next != nil)
        
        return UIViewController.init();
    }
    
    public func curTableView() -> UITableView {
        var next = self.next
        
        repeat{
            if next?.isKind(of: UITableView.self) ?? false {
                return next as? UITableView ?? UITableView.init()
            }
            next = next?.next
        }while (next != nil)
        
        return UITableView.init()
    }
    
    public func curCollectionView() -> UICollectionView {
        var next = self.next
        
        repeat{
            if next?.isKind(of: UICollectionView.self) ?? false {
                return next as? UICollectionView ?? UICollectionView.init()
            }
            next = next?.next
        }while (next != nil)
        
        return UICollectionView.init()
    }
    public func needShadow(need : Bool){
        
        if need {
            self.layer.shadowOpacity = 1.0
            self.layer.shadowColor   = ColorBackGround.cgColor
            self.layer.shadowOffset  = CGSize.init(width: -2, height: 2)
            self.layer.shadowRadius  = 3.0
        }else{
            self.layer.shadowRadius  = 0.0
        }
        
    }
    public func addTapGesture(tapNumber: Int = 1, target: AnyObject, action: Selector) {
        let tap = UITapGestureRecognizer(target: target, action: action)
        tap.numberOfTapsRequired = tapNumber
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }
    
    
    
    
}
extension UIView {
    public func XZBCuruntView() -> UIViewController  {
        var rootViewController: UIViewController?
        for window in UIApplication.shared.windows where !window.isHidden {
            if let windowRootViewController = window.rootViewController {
                rootViewController = windowRootViewController
                break
            }
        }
        return self.XZBCurunt(of: rootViewController)!
    }
    /// Returns the top most view controller from given view controller's stack.
    public func XZBCurunt(of viewController: UIViewController?) -> UIViewController? {
        // presented view controller
        if let presentedViewController = viewController?.presentedViewController {
            return self.XZBCurunt(of: presentedViewController)
        }
        
        // UITabBarController
        if let tabBarController = viewController as? UITabBarController,
            let selectedViewController = tabBarController.selectedViewController {
            return self.XZBCurunt(of: selectedViewController)
        }
        
        // UINavigationController
        if let navigationController = viewController as? UINavigationController,
            let visibleViewController = navigationController.visibleViewController {
            return self.XZBCurunt(of: visibleViewController)
        }
        
        // UIPageController
        if let pageViewController = viewController as? UIPageViewController,
            pageViewController.viewControllers?.count == 1 {
            return self.XZBCurunt(of: pageViewController.viewControllers?.first)
        }
        
        // child view controller
        for subview in viewController?.view?.subviews ?? [] {
            if let childViewController = subview.next as? UIViewController {
                return self.XZBCurunt(of: childViewController)
            }
        }
        
        return viewController
    }
}
extension UITableView{
    
    func XZBReloadData(){
        
        let y = self.contentOffset.y
        self.reloadData()
        self.layoutIfNeeded()
        DispatchQueue.main.async(execute: {
            [unowned self] in
            if self.contentSize.height > y {
                self.contentOffset = CGPoint.init(x:self.contentOffset.x,y:y)
            }
        })
    }
}

extension UIView {

    /// 部分圆角
    ///
    /// - Parameters:
    ///   - corners: 需要实现为圆角的角，可传入多个
    ///   - radii: 圆角半径
    func corner(byRoundingCorners corners: UIRectCorner, radii: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
}


// UIView 渐变色 , UIView及其子类都可以使用，比如UIButton、UILabel等。
//
// Usage:
// myButton.gradientColor(CGPoint(x: 0, y: 0.5), CGPoint(x: 1, y: 0.5), [UIColor(hex: "#FF2619").cgColor, UIColor(hex: "#FF8030").cgColor])
extension UIView {
    // MARK: 添加渐变色图层
    public func gradientStringDIYColor(colorsString : String) {
        var colors = colorsString.components(separatedBy: ",")
        if colors.count != 2 {
            let str = "#8330E1,#7DA8F7"
            colors = str.components(separatedBy: ",")
        }
        // 外界如果改变了self的大小，需要先刷新
        layoutIfNeeded()
        var gradientLayer: CAGradientLayer!
        removeGradientLayer()
        
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.layer.bounds
        gradientLayer.startPoint = CGPoint(x: 1, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.colors = [UIColor.init(hexString: colors[0]).cgColor, UIColor.init(hexString: colors[1])
            .cgColor]
        gradientLayer.cornerRadius = self.layer.cornerRadius
        gradientLayer.masksToBounds = true
        // 渐变图层插入到最底层，避免在uibutton上遮盖文字图片
        self.layer.insertSublayer(gradientLayer, at: 0)
        self.backgroundColor = UIColor.clear
     
        self.layer.masksToBounds = true
    }
    
    // MARK: 添加渐变色图层
    public func gradientColor(_ startPoint: CGPoint = CGPoint(x: 0, y: 0), _ endPoint: CGPoint = CGPoint(x: 1, y: 1), _ colors: [Any]) {
        
        guard startPoint.x >= 0, startPoint.x <= 1, startPoint.y >= 0, startPoint.y <= 1, endPoint.x >= 0, endPoint.x <= 1, endPoint.y >= 0, endPoint.y <= 1 else {
            return
        }
        
        // 外界如果改变了self的大小，需要先刷新
        layoutIfNeeded()
        
        var gradientLayer: CAGradientLayer!
        
        removeGradientLayer()
        
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.layer.bounds
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.colors = colors
        gradientLayer.cornerRadius = self.layer.cornerRadius
        gradientLayer.masksToBounds = true
        // 渐变图层插入到最底层，避免在uibutton上遮盖文字图片
        self.layer.insertSublayer(gradientLayer, at: 0)
        self.backgroundColor = UIColor.clear
        self.layer.masksToBounds = true
    }
    
    // MARK: 移除渐变图层
    // （当希望只使用backgroundColor的颜色时，需要先移除之前加过的渐变图层）
    public func removeGradientLayer() {
        if let layers = self.layer.sublayers {
            for layer in layers {
                if layer.isKind(of: CAGradientLayer.self) {
                    layer.removeFromSuperlayer()
                }
            }
        }
    }
    public func addGradientLayer(
        start: CGPoint = CGPoint(x: 0, y: 0.5), //渐变起点
        end: CGPoint = CGPoint(x: 1, y: 0.5), //渐变终点
        colors: [CGColor] ) {
        layoutIfNeeded()
        var gradientLayer: CAGradientLayer!
        removeGradientLayer()
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.layer.bounds
        gradientLayer.startPoint = start
        gradientLayer.endPoint = end
        gradientLayer.colors = colors
        gradientLayer.cornerRadius = self.layer.cornerRadius
        gradientLayer.masksToBounds = true
        // 渐变图层插入到最底层，避免在uibutton上遮盖文字图片
        self.layer.insertSublayer(gradientLayer, at: 0)
        self.backgroundColor = UIColor.clear
        
        self.layer.masksToBounds = true
        
    }
    public func addButtonGradientLayer()
        {
       
            // 外界如果改变了self的大小，需要先刷新
            layoutIfNeeded()
            
            var gradientLayer: CAGradientLayer!
            
            removeGradientLayer()
            
            gradientLayer = CAGradientLayer()
            gradientLayer.frame = self.layer.bounds
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
            gradientLayer.colors = [UIColor.colorWithHex(hex: 0x685FD5).cgColor, UIColor.colorWithHex(hex: 0xA435FC).cgColor]
            gradientLayer.cornerRadius = self.layer.cornerRadius
            gradientLayer.masksToBounds = true
            // 渐变图层插入到最底层，避免在uibutton上遮盖文字图片
            self.layer.insertSublayer(gradientLayer, at: 0)
            self.backgroundColor = UIColor.clear
           
            self.layer.masksToBounds = true
        
    }
    
    public func addBackViewGradientLayer()
    {
        
        // 外界如果改变了self的大小，需要先刷新
        layoutIfNeeded()
        
        var gradientLayer: CAGradientLayer!
        
        removeGradientLayer()
        
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.layer.bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.colors = [UIColor.colorWithHex(hex: 0x685FD5).cgColor, UIColor.colorWithHex(hex: 0xA435FC).cgColor]
        gradientLayer.cornerRadius = self.layer.cornerRadius
        gradientLayer.masksToBounds = true
        self.layer.insertSublayer(gradientLayer, at: 0)
        self.backgroundColor = UIColor.clear
        
        self.layer.masksToBounds = true
        
    }
    
}

//  抖动视图
extension UIView {
    /// 抖动方向
    ///
    /// - horizontal: 水平抖动
    /// - vertical:   垂直抖动
    public enum ShakeDirection: Int {
        case horizontal
        case vertical
    }
    
    /// ZHY 扩展UIView增加抖动方法
    ///
    /// - Parameters:
    ///   - direction:  抖动方向    默认水平方向
    ///   - times:      抖动次数    默认2次
    ///   - interval:   每次抖动时间 默认0.1秒
    ///   - offset:     抖动的偏移量 默认2个点
    ///   - completion: 抖动结束回调
    public func shakeView(direction: ShakeDirection = .horizontal, times: Int = 2, interval: TimeInterval = 0.1, offset: CGFloat = 2, completion: (() -> Void)? = nil) {
        
        //设置一下重复动画平移的两个变换
        var firstTransform: CGAffineTransform? = nil
        var lastTransform:  CGAffineTransform? = nil
        
        //判断下方向
        switch direction {
        case .horizontal:
            firstTransform = CGAffineTransform(translationX: offset, y: 0)
            lastTransform  = CGAffineTransform(translationX: -offset, y: 0)
            
        case .vertical:
            firstTransform = CGAffineTransform(translationX: 0, y: offset)
            lastTransform  = CGAffineTransform(translationX: 0, y: -offset)
        }
        
        //这是开始的变换
        self.transform = firstTransform!
        
        //options: [.repeat, .autoreverse] 表示重复加动画回路
        UIView.animate(withDuration: interval, delay: 0, options: [.repeat, .autoreverse], animations: {
            //重复次数就是我们的times呗
            UIView.setAnimationRepeatCount(Float(times))
            
            //  开始变换完了，就改个变换方式咯
            self.transform = lastTransform!
            
        }) { (complet) in
            
            UIView.animate(withDuration: interval, animations: {
                self.layer.setAffineTransform(CGAffineTransform.identity)
            }, completion: { (complet) in
                completion?()
            })
        }
    }
}

extension  UIView{
    public func viewController()->UIViewController? {
        var nextResponder: UIResponder? = self
        repeat {
            nextResponder = nextResponder?.next
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
        } while nextResponder != nil
        return nil
    }
}



extension UIViewController {
    public class func runtimeReplaceAlert() {
//        DispatchQueue.zone(token: "UIAlertController") {
//
//        }
        
        let originalSelector = #selector(self.present(_:animated:completion:))
        let swizzledSelector = #selector(self.noAlert_present(_:animated:completion:))
        
        let originalMethod = class_getInstanceMethod(self, originalSelector)
        let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
        
        let didAddMethod = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!))
        
        if didAddMethod{
            class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
        }else{
            if originalMethod != nil {
                method_exchangeImplementations(originalMethod!, swizzledMethod!)
            }
        }
    }
    
    @objc fileprivate func noAlert_present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Swift.Void)? = nil) {
        //判断是否是alert弹窗
        if viewControllerToPresent.isKind(of: UIAlertController.self) {
            print("title: \(String(describing: (viewControllerToPresent as? UIAlertController)?.title))")
            print("message: \(String(describing: (viewControllerToPresent as? UIAlertController)?.message))")
            
            // 换图标时的提示框的title和message都是nil，由此可特殊处理
            let alertController = viewControllerToPresent as? UIAlertController
            if alertController?.title == nil && alertController?.message == nil {
                //是更换icon的提示
                changeAction()
                return
            } else {
                //其他的弹框提示正常处理
                noAlert_present(viewControllerToPresent, animated: flag, completion: completion)
            }
        }
        noAlert_present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
    func changeAction(){
        ShowMessageTool.shared.showMessage("图标更换成功")
        
    }
}
