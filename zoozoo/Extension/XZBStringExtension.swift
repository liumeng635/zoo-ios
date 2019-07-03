//
//  XZBStringExtension.swift
//  XZBBaseSwift
//
//  Created by 🍎上的豌豆 on 2018/10/16.
//  Copyright © 2018年 xiao. All rights reserved.
//

import UIKit
import YYText

extension Int
{
    func hexedString() -> String
    {
        return NSString(format:"%02x", self) as String
    }
}
extension NSData
{
    func hexedString() -> String
    {
        var string = String()
        let unsafePointer = bytes.assumingMemoryBound(to: UInt8.self)
        for i in UnsafeBufferPointer<UInt8>(start:unsafePointer, count: length)
        {
            string += Int(i).hexedString()
        }
        return string
    }
    func MD5() -> NSData
    {
        let result = NSMutableData(length: Int(CC_MD5_DIGEST_LENGTH))!
        let unsafePointer = result.mutableBytes.assumingMemoryBound(to: UInt8.self)
        CC_MD5(bytes, CC_LONG(length), UnsafeMutablePointer<UInt8>(unsafePointer))
        return NSData(data: result as Data)
    }
}
extension String {
    /// swift Base64处理
   
    
    func base64Encoding(plainString:String)->String{

        let plainData = plainString.data(using: String.Encoding.utf8)
        let base64String = plainData?.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        return base64String!
    }
   //解码
    func base64Decoding(encodedString:String)->String{
        let decodedData = NSData(base64Encoded: encodedString, options: NSData.Base64DecodingOptions.init(rawValue: 0))
        let decodedString = NSString(data: decodedData! as Data, encoding: String.Encoding.utf8.rawValue)! as String
        return decodedString
    }
  
}

extension String {
    /*
     *去掉首尾空格
     */
    func removeHeadAndTailSpace() ->String{
        
        let whitespace = NSCharacterSet.whitespaces
        return self.trimmingCharacters(in: whitespace)
    }
    /*
     *去掉首尾空格 包括后面的换行 \n
     */
    func removeHeadAndTailSpacePro() ->String{
        
        let whitespace = NSCharacterSet.whitespacesAndNewlines
        return self.trimmingCharacters(in: whitespace)
    }
    /*
     *去掉所有空格
     */
    func clearBlankString() ->String{
        
        return self.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
    }
    /* 字母、数字、中文正则判断（包括空格）（在系统输入法中文输入时会出现拼音之间有空格，需要忽略，当按return键时会自动用字母替换，按空格输入响应汉字）
    */
    func isInputRuleAndBlank()->Bool{
        let pattern = "^[a-zA-Z\\u4E00-\\u9FA5\\d\\s]*$"
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        let isMatch = pred.evaluate(with: self)
        return isMatch
    }
    /**
     *  过滤字符串中的emoji
     */
    func disable_emoji()->String{
        let regex = try!NSRegularExpression.init(pattern: "[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]", options: .caseInsensitive)
        
        let modifiedString = regex.stringByReplacingMatches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange.init(location: 0, length: self.count), withTemplate: "")
        return modifiedString
    }
    
    func numberOfChars() -> Int {
        var number = 0
        
        guard self.length > 0 else {return 0}
        
        for i in 0...self.length - 1 {
            let c: unichar = (self as NSString).character(at: i)
            
            if (c >= 0x4E00) {
                number += 2
            }else {
                number += 1
            }
        }
        
        return number
    }
    func rangeChars(num :Int = 15) -> String {
        var number = 0
        var str = ""
        guard self.length > 0 else {return str}
        
        for i in 0...self.length - 1 {
            let c: unichar = (self as NSString).character(at: i)
            
            if (c >= 0x4E00) {
                number += 2
                if number >= num {
                    str = self.substring(location: 0, length: i+1)
                    return str
                }
            }else {
                number += 1
                if number >= num {
                    str = self.substring(location: 0, length: i+1)
                    return str
                }
            }
           
        }
        return str
    }
}

extension String {
    /// 计算文本的高度
    func textHeight(font: UIFont, width: CGFloat) -> CGFloat {
        return self.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil).size.height
    }
    /// 计算文本的宽度
    func textWidth(font: UIFont, height: CGFloat) -> CGFloat {
        return self.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil).size.width
    }
    
    func substring(location index:Int, length:Int) -> String {
        if self.count > index {
            let startIndex = self.index(self.startIndex, offsetBy: index)
            let endIndex = self.index(self.startIndex, offsetBy: index + length)
            let subString = self[startIndex..<endIndex]
            return String(subString)
        } else {
            return self
        }
    }
   
    
    //正则验证是否是手机号
    func isPhoneNumber() -> Bool {
       
        let regex = "^1([358][0-9]|4[579]|66|7[0135678]|9[89])[0-9]{8}$"
        let pre = NSPredicate(format: "SELF MATCHES %@",regex)
        return pre.evaluate(with: self)
    }
    
    //正则验证是否是密码规则
    func isPwd() -> Bool {
        let regex = "^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,16}"
        let pre = NSPredicate(format: "SELF MATCHES %@",regex)
        return pre.evaluate(with: self)
        
    }
    
    //正则验证是否是邮箱则
    func validateEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest:NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
    
    // 隐藏电话中间四位
    func kReplaceString(replaceString:String,start:Int,len:Int) -> String{
        
        //使用NSString方法
        return (self as NSString).replacingCharacters(in: NSMakeRange(start, len), with: replaceString)
        
    }
    
    /// 生成随机字符串
    ///
    /// - Parameters:
    ///   - count: 生成字符串长度 默认为9位数
    ///   - isLetter: false=大小写字母和数字组成，true=大小写字母组成，默认为false
    /// - Returns: String
    static func StrRandom(_ count: Int = 9, _ isLetter: Bool = false) -> String {
        
        var ch: [CChar] = Array(repeating: 0, count: count)
        for index in 0..<count {
            
            var num = isLetter ? arc4random_uniform(58)+65:arc4random_uniform(75)+48
            if num>57 && num<65 && isLetter==false { num = num%57+48 }
            else if num>90 && num<97 { num = num%90+65 }
            
            ch[index] = CChar(num)
        }
        let str =  String(cString: ch)
        if str.length > 9 {
            return str.stringCut(end: count)
        }else{
             return str
        }
        
        
    }
   
    func md5() -> String {
        let cStrl = cString(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue));
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 16);
        CC_MD5(cStrl, CC_LONG(strlen(cStrl!)), buffer);
        var md5String = "";
        for idx in 0...15 {
            let obcStrl = String.init(format: "%02x", buffer[idx]);
            md5String.append(obcStrl);
        }
        free(buffer);
        return md5String;
    }
    func MD5() -> String
    {
        let data = (self as NSString).data(using: String.Encoding.utf8.rawValue)! as NSData
        return data.MD5().hexedString()
    }
    func urlScheme(scheme:String) -> URL? {
        if let url = URL.init(string: self) {
            var components = URLComponents.init(url: url, resolvingAgainstBaseURL: false)
            components?.scheme = scheme
            return components?.url
        }
        return nil
    }
    
    static func readJson2DicWithFileName(fileName:String) -> [String:Any] {
        let path = Bundle.main.path(forResource: fileName, ofType: "json") ?? ""
        var dict = [String:Any]()
        do{
            let data = try Data.init(contentsOf: URL.init(fileURLWithPath: path))
            dict = try JSONSerialization.jsonObject(with: data, options:[]) as! [String : Any]
        }catch {
            print(error.localizedDescription)
        }
        return dict
    }
    
    static func format(decimal:Float, _ maximumDigits:Int = 1, _ minimumDigits:Int = 1) ->String? {
        let number = NSNumber(value: decimal)
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = maximumDigits //设置小数点后最多2位
        numberFormatter.minimumFractionDigits = minimumDigits //设置小数点后最少2位（不足补0）
        return numberFormatter.string(from: number)
    }
    
    static func formatCount(count:NSInteger) -> String {
        if count < 10000  {
            return String.init(count)
        } else {
            return (String.format(decimal: Float(count)/Float(10000)) ?? "0") + "w"
        }
    }
    
    
    
    func singleLineSizeWithText(font:UIFont) -> CGSize {
        return self.size(withAttributes: [NSAttributedString.Key.font : font])
    }
    
    func singleLineSizeWithAttributeText(font:UIFont) -> CGSize {
        let attributes = [NSAttributedString.Key.font:font]
        let attString = NSAttributedString(string: self,attributes: attributes)
        let framesetter = CTFramesetterCreateWithAttributedString(attString)
        return CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRange(location: 0,length: 0), nil, CGSize(width: Double.greatestFiniteMagnitude, height: Double.greatestFiniteMagnitude), nil)
    }
    func GetWidthForLabel(fontSize: CGFloat, height: CGFloat = 15) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.width)
    }
    func XZBGetYYLabelHeight(width:CGFloat,LineHeight :CGFloat,font:UIFont) -> CGFloat {
        var height: CGFloat = 0

        let mod = YYTextLinePositionSimpleModifier.init()
        mod.fixedLineHeight = LineHeight

        let container = YYTextContainer.init(size: CGSize.init(width: width, height: CGFloat(MAXFLOAT)))
        container.linePositionModifier = mod
        let str = NSAttributedString.init(string: self)
        let attributedString = NSMutableAttributedString.init(attributedString: str)
        attributedString.yy_font = font

        let TextLayout = YYTextLayout.init(container: container, text: attributedString)

        height =  LineHeight * CGFloat.init(TextLayout?.lines.count ?? 0)

        return height
    }
    
    
   
    
}



extension NSAttributedString {
    
    
    
    
    func multiLineSize(width:CGFloat) -> CGSize {
        
        
        let rect = self.boundingRect(with: CGSize.init(width: width, height: CGFloat(MAXFLOAT)), options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        return CGSize.init(width: rect.size.width, height: rect.size.height)
    }
    
    //图片拼接到文字前面
    
    func appendImageToAttributedString(content: String, font: UIFont, image :UIImage) -> NSMutableAttributedString {
         let attributedString = NSMutableAttributedString(string: content)
        let attachment = NSTextAttachment()
        
        attachment.image = image
        attachment.bounds = CGRect(x: 0, y: -4, width: font.lineHeight, height: font.lineHeight)
        let attributedImageStr = NSMutableAttributedString(attachment: attachment)
        
        attributedImageStr.append(attributedString)
        
        return attributedImageStr
    }
    
    
    
    
}

extension String {
    
    // MARK: 汉字 -> 拼音
    func chineseToPinyin() -> String {
        
        let stringRef = NSMutableString(string: self) as CFMutableString
        // 转换为带音标的拼音
        CFStringTransform(stringRef,nil, kCFStringTransformToLatin, false)
        // 去掉音标
        CFStringTransform(stringRef, nil, kCFStringTransformStripCombiningMarks, false)
        let pinyin = stringRef as String
        
        return pinyin
    }
    
    // MARK: 判断是否含有中文
    func isIncludeChineseIn() -> Bool {
        
        for (_, value) in self.enumerated() {
            
            if ("\u{4E00}" <= value  && value <= "\u{9FA5}") {
                return true
            }
        }
        
        return false
    }
    
    // MARK: 获取第一个字符
    func first() -> String {
        
        let index = self.index(self.startIndex, offsetBy: 1)
        let subString = self[startIndex..<index]
        return String(subString)
        
    }
    
    func replaceLocationCityString() -> String{
        
        return self.replacingOccurrences(of: "市", with: "", options: .literal, range: nil)
        
    }
    
}
extension String {
    
    var length: Int {
        ///更改成其他的影响含有emoji协议的签名
        return self.utf16.count
    }
    
    /// 截取第一个到第任意位置
    ///
    /// - Parameter end: 结束的位值
    /// - Returns: 截取后的字符串
    func stringCut(end: Int) -> String{
        if !(end <= count) { return self }
        let sInde = index(startIndex, offsetBy: end)
        return String(self[..<sInde])
    }
    //返回文件的沙盒目录
    func docuPath() -> String {
        
        let string = self.components(separatedBy: "/").last
        return string ?? ""
    }
    
    
}



