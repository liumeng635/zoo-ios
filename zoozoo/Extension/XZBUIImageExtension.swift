//
//  XZBUIImageExtension.swift
//  XZBBaseSwift
//
//  Created by 🍎上的豌豆 on 2018/10/16.
//  Copyright © 2018年 xiao. All rights reserved.
//

import UIKit



extension UIImage {
    
    func drawCircleImage() -> UIImage? {
        let side = min(self.size.width, self.size.height)
        let size = CGSize.init(width: side, height: side)
        let rect = CGRect.init(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
        let context = UIGraphicsGetCurrentContext()
        context?.addPath(UIBezierPath.init(roundedRect: rect, cornerRadius: side).cgPath)
        context?.clip()
        self.draw(in: rect)
        context?.drawPath(using: .fillStroke)
        let output = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return output
    }
    func reSizeImage(reSize:CGSize)->UIImage {
        //UIGraphicsBeginImageContext(reSize);
        UIGraphicsBeginImageContextWithOptions(reSize,false,UIScreen.main.scale);
        
        self.draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage;
    }
    /// EZSE: scales image
   func scaleTo(w: CGFloat, h: CGFloat) -> UIImage {
        let newSize = CGSize(width: w, height: h)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        self.draw(in: CGRect(x: 0, y: 0, width: w, height: h))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    class func resizableImage(imageName: String, edgeInsets: UIEdgeInsets) -> UIImage? {
        
        let image = UIImage(named: imageName)
        if image == nil {
            return nil
        }
        let imageW = image!.size.width
        let imageH = image!.size.height
        
        return image?.resizableImage(withCapInsets: UIEdgeInsets(top: imageH * edgeInsets.top, left: imageW * edgeInsets.left, bottom: imageH * edgeInsets.bottom, right: imageW * edgeInsets.right), resizingMode: .stretch)
    }
    /// EZSE Returns resized image with width. Might return low quality
    public func resizeWithWidth(_ width: CGFloat) -> UIImage {
        let aspectSize = CGSize (width: width, height: aspectHeightForWidth(width))
        
        UIGraphicsBeginImageContext(aspectSize)
        self.draw(in: CGRect(origin: CGPoint.zero, size: aspectSize))
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return img!
    }
    
    /// EZSE Returns resized image with height. Might return low quality
    public func resizeWithHeight(_ height: CGFloat) -> UIImage {
        let aspectSize = CGSize (width: aspectWidthForHeight(height), height: height)
        
        UIGraphicsBeginImageContext(aspectSize)
        self.draw(in: CGRect(origin: CGPoint.zero, size: aspectSize))
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return img!
    }
    
    /// EZSE:
    public func aspectHeightForWidth(_ width: CGFloat) -> CGFloat {
        return (width * self.size.height) / self.size.width
    }
    
    /// EZSE:
    public func aspectWidthForHeight(_ height: CGFloat) -> CGFloat {
        return (height * self.size.width) / self.size.height
    }
    
    /// EZSE: Returns cropped image from CGRect
    public func croppedImage(_ bound: CGRect) -> UIImage? {
        guard self.size.width > bound.origin.x else {
            print("EZSE: Your cropping X coordinate is larger than the image width")
            return nil
        }
        guard self.size.height > bound.origin.y else {
            print("EZSE: Your cropping Y coordinate is larger than the image height")
            return nil
        }
        let scaledBounds: CGRect = CGRect(x: bound.origin.x * self.scale, y: bound.origin.y * self.scale, width: bound.width * self.scale, height: bound.height * self.scale)
        let imageRef = self.cgImage?.cropping(to: scaledBounds)
        let croppedImage: UIImage = UIImage(cgImage: imageRef!, scale: self.scale, orientation: UIImage.Orientation.up)
        return croppedImage
    }
    
    /// EZSE: Use current image for pattern of color
    public func withColor(_ tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height) as CGRect
        context?.clip(to: rect, mask: self.cgImage!)
        tintColor.setFill()
        context?.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    ///EZSE: Returns the image associated with the URL
    public convenience init?(urlString: String) {
        guard let url = URL(string: urlString) else {
            self.init(data: Data())
            return
        }
        guard let data = try? Data(contentsOf: url) else {
            print("EZSE: No image in URL \(urlString)")
            self.init(data: Data())
            return
        }
        self.init(data: data)
    }
    
    ///EZSE: Returns an empty image //TODO: Add to readme
    public class func blankImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 1, height: 1), false, 0.0)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    
    /**
     绘制带有圆弧的图片
     */
    public class func drawCircularIconWithSize(_ Size: CGSize,Radius:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(Size, false, 0.0)
       
        
        //    //获取绘制圆的半径，宽，高的一个区域
        
        //    //使用UIBerierPath路径裁切，注意：先设置裁切路径，再绘制图像。
        let berzierPath = UIBezierPath.init(roundedRect: CGRect.init(x: 0, y: 0, width: Size.width, height: Size.width), cornerRadius: Radius)
        berzierPath.addClip()
        

        //    //从上下文获取当前 绘制成圆形的图片
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    /**
     * 设置图片渲染色
     *
     * @praram color 填充色
     */
    public func render(color : UIColor) -> UIImage{
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
        
        let context = UIGraphicsGetCurrentContext()
        let rect    = CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: self.size)
        context?.setBlendMode(.normal)
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1, y: -1)
        context?.clip(to: rect, mask: self.cgImage ?? UIImage.init().cgImage!)
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? self
    }
    
    public func getScreenSnap() -> UIImage{
        let window = UIApplication.shared.keyWindow!
        
        
        UIGraphicsBeginImageContextWithOptions(window.bounds.size, false, 0)
        
        window.drawHierarchy(in: window.bounds, afterScreenUpdates: false)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? self
    }
    
    public func getShadowLineImage(_ color: UIColor) -> UIImage{
        let rect = CGRect.init(x: 0, y: 0, width: ScreenW, height: 0.5)
        UIGraphicsBeginImageContext(rect.size)
        UIGraphicsGetCurrentContext()?.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()?.fill(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? self
    }
}

extension UIImage {
    
    static func from(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    
   
   
}


