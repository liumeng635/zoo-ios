//
//  BaseConstants.swift
//  zoozoo
//
//  Created by 苹果上的豌豆 on 2019/5/15.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit
import Kingfisher
import KingfisherWebP

let ScreenW = UIScreen.main.bounds.width
let ScreenH = UIScreen.main.bounds.height
let screenFrame:CGRect = UIScreen.main.bounds
let isIPhoneX = (ScreenW == 375 && ScreenH == 812 || ScreenW == 414 && ScreenH == 896  ? true : false)
let statusBarH : CGFloat  = (isIPhoneX ? 34 :20)
let SafeBottomMargin : CGFloat = (isIPhoneX ? 34 : 0)
let navigationBarHeight : CGFloat = isIPhoneX ? 88 : 64
let tabBarHeight : CGFloat = isIPhoneX ? 49 + 34 : 49
let ScreenScale = ScreenW/ScreenH
let ScaleW = UIScreen.main.bounds.size.width / 414
let kMenuWidth = UIScreen.main.bounds.width * 0.82

let DIYImageHeight: CGFloat =  ScreenW/1.1
let DIYBackHeight: CGFloat =  ScreenH*0.61
let DIYSegmentH: CGFloat =  44
let VoicebuttonW : CGFloat = (ScreenW - 80)/3
let Voicecollection : CGFloat = (ScreenW - (15*5))/4

let itemWH = ((ScreenW - 30 - 12)/3)

//MARK: print
func ZLog<T>(_ message: T, file: String = #file, function: String = #function, lineNumber: Int = #line) {
    #if DEBUG
    let fileName = (file as NSString).lastPathComponent
    print("[\(fileName):funciton:\(function):line:\(lineNumber)]- \(message)")
    #endif
}





//MARK: Color
let ColorTheme       = UIColor.colorWithHex(hex: 0x6760D4)
let ColorChatBack = UIColor.colorWithHex(hex: 0x6760D4, alpha: 0.18)
let ColorLine     = UIColor.colorWithHex(hex: 0xF8F8F8)
let ColorMargin     = UIColor.colorWithHex(hex: 0xE8E9ED)
let ColorWhite     = UIColor.colorWithHex(hex: 0xFFFFFF)
let ColorSystemGray     = UIColor.colorWithHex(hex: 0xBBBBBB)
let ColorBackGround      = UIColor.colorWithHex(hex: 0xF8F8F8)
let ColorTitle   = UIColor.colorWithHex(hex: 0x171B1E)
let ColorLargeTitle   = UIColor.colorWithHex(hex: 0x222222)
let ColorThemeLan   = UIColor.colorWithHex(hex: 0x6760D4)
let ColorBlackTitle   = UIColor.colorWithHex(hex: 0x666666)
let ColorGrayTitle   = UIColor.colorWithHex(hex: 0x555555)
let ColorDarkGrayTextColor = UIColor.colorWithHex(hex: 0x999999)
let ColorLightTitleColor = UIColor.colorWithHex(hex: 0xCECECE)
let ColorGrayColor = UIColor.colorWithHex(hex: 0xB6B6B6)
let ColorCharmColor = UIColor.colorWithHex(hex: 0x15988C)
let ColorCancleColor = UIColor.colorWithHex(hex: 0xFC9A7D)
let ColorTabbarColor = UIColor.colorWithRGB(r: 153, g: 153, b: 153)
let ColorBlue   = UIColor.colorWithHex(hex: 0x0BD2CF)
let ColorNavigationBar   = UIColor.colorWithHex(hex: 0x171B1E)
let ColorNums   = UIColor.colorWithHex(hex: 0xEF724D)
let ColorDianColor = UIColor.colorWithHex(hex: 0xFF4141)
let ColorNoAnimalColor = UIColor.colorWithHex(hex: 0xB5AFDC)
let ColorSegmentSelTitle = UIColor.colorWithHex(hex: 0x6760D4)
let ColorSegmentTitle = UIColor.colorWithHex(hex: 0xB6B6B6)
let ColorSegmentback = UIColor.colorWithRGBA(r:248.0, g: 248.0, b: 248.0, alpha: 1.0)
let ColorNormalAnimalBack = UIColor.colorWithRGBA(r:232.0, g: 239.0, b: 248.0, alpha: 1.0)
let ColorOrange   = UIColor.colorWithRGBA(r:252.0, g: 154.0, b: 125.0, alpha: 1.0)
let ColorDIYTopBtn   = UIColor.colorWithRGBA(r: 23, g: 27, b: 30, alpha: 0.25)


let  ColorMineTableTitle  = UIColor.colorWithHex(hex: 0x55555)
let  ColorMineTableContent = UIColor.colorWithRGBA(r: 182, g: 182, b: 182, alpha: 1)
let  ColorMineAlertPhone = UIColor.colorWithRGBA(r: 232, g: 233, b: 237, alpha: 1)
let  ColorMinePolicyLine = UIColor.colorWithRGBA(r: 204, g: 204, b: 204, alpha: 1)
let  ColorMinePolicyTitle   = UIColor.colorWithRGBA(r: 23, g: 27, b: 30, alpha: 1)



//MARK: Kingfisher
extension Kingfisher where Base: ImageView {
    @discardableResult
    public func setImage(urlString: String?, placeholder: Placeholder? = UIImage(named: "imageplaceholder")) -> RetrieveImageTask {
        return setImage(with: URL(string: urlString?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""),
                        placeholder: placeholder,
                        options:[.processor(WebPProcessor.default), .cacheSerializer(WebPSerializer.default),.transition(.fade(0.2))])
    }
    
    
}

extension Kingfisher where Base: UIButton {
    @discardableResult
    public func setImage(urlString: String?, for state: UIControl.State, placeholder: UIImage? = UIImage(named: "imageplaceholder")) -> RetrieveImageTask {
        return setImage(with: URL(string: urlString?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""),
                        for: state,
                        placeholder: placeholder,
                        options: [.processor(WebPProcessor.default), .cacheSerializer(WebPSerializer.default),.transition(.fade(0.2))])
        
    }
}
