//
//  XZBDateExtension.swift
//  xiaohongshu
//
//  Created by 🍎上的豌豆 on 2018/11/28.
//  Copyright © 2018 xiao. All rights reserved.
//

import UIKit

extension Date {
    
    static var formatter : DateFormatter = DateFormatter.init()
    
    static func getCurrentTime() -> String {
        
        let nowDate = Date()
        
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }
    
    /// 时间戳转时间
    ///
    /// - Parameter date: 时间
    /// - Returns: 转换后的格式化时间c字符串
    public static func timeStampChangeDate(_ date:Int) -> String {
        //"yyyy-MM-dd HH:mm"
        
        let timeInterval:TimeInterval = TimeInterval(date)
        let date = Date(timeIntervalSince1970: timeInterval)
        
        formatter.dateFormat = "MM-dd"
        return formatter.string(from: date)
    }
    
    /// Date类型返回字符串
    ///
    /// - parameter date:          date
    /// - parameter withFormatter: 格式化字符串
    ///
    /// - returns:格式化后的字符串
    public static func stringFromDate(_ date:Date ,withFormatter:String) -> String {
        //"yyyy-MM-dd HH:mm"
        let formatter = DateFormatter.init()
        formatter.dateFormat = withFormatter
        return formatter.string(from: date)
    }
    
    /// 字符串转Date类型
    ///
    /// - parameter str:           日期字符串
    /// - parameter withFormatter: 格式化
    ///
    /// - returns: date
    public static func dateFromString(_ str:String ,withFormatter:String) -> Date? {
        let formatter = DateFormatter.init()
        formatter.timeZone = TimeZone.init(secondsFromGMT: 8);
        formatter.dateFormat = withFormatter
        return formatter.date(from: str)
    }
    
    /// 根据日期字符串转化为简短日期
    ///
    /// - parameter dateStr: eg"2018-08-23 14:10:00"
    ///
    /// - returns: 格式化后的日期
    public static func dateFormatterWithString(_ dateStr:String) -> String {
        let dateformatter  = DateFormatter.init();
        dateformatter.dateFormat = "yyyy-MM-dd HH:mm:SS"
        dateformatter.timeZone = TimeZone.current
        let date = dateformatter.date(from: dateStr)
        let sec = date?.timeIntervalSinceNow
        
        guard let s = sec , s < 0.0 else {return ""}
        let second = fabs(s)
        
        let mins = second / 60
        if mins < 1 {
            return "刚刚";
        }
        
        let hour = mins / 60
        if hour < 1 {
            let m = Int(mins) % 60
            return "\(m)分钟前"
        }
        
        let day = hour / 24
        if day < 1 {
            let h = Int(hour) % 24
            return "\(h)小时前"
        }
        
        let month = day / 30
        if month < 1 {
            let d = Int(day) % 30
            return "\(d)天前"
        }
        
        let year = month / 12
        if year < 1 {
            let m = Int(month) % 12
            return "\(m)个月前"
        }
        
        let y = Int(year)
        return "\(y)年前"
    }
    public static func getAgeDateFormatterWithString(_ dateStr:String) -> String {
        if dateStr.isEmpty {
            return ""
        }
        
        let dateformatter  = DateFormatter.init();
        dateformatter.dateFormat = "yyyy-MM-dd"
        dateformatter.timeZone = TimeZone.current
        let date = dateformatter.date(from: dateStr)
        let sec = date?.timeIntervalSinceNow 
        guard let s = sec , s < 0.0 else {return ""}
        let second = fabs(s)
        let year = second/60/60/24/30/12
        if year < 1 {
            return "\(1)"
        }
        
        let y = Int(year)
        return "\(y)"
    }
    
    /// 根据后台时间戳返回几分钟前，几小时前，几天前
    ///
    /// - Parameter timeStamp: 时间戳
    /// - Returns: 格式化后时间字符串
    public static func updateTimeToCurrennTime(timeStamp: Double) -> String {
        //获取当前的时间戳
        let currentTime = Date().timeIntervalSince1970
        //时间戳为毫秒级要 ／ 1000， 秒就不用除1000，参数带没带000
        let timeSta:TimeInterval = TimeInterval(timeStamp)
        //时间差
        let reduceTime : TimeInterval = currentTime - timeSta
        //时间差小于60秒
        if reduceTime < 60 {
            return "刚刚"
        }
        //时间差大于一分钟小于60分钟内
        let mins = Int(reduceTime / 60)
        if mins < 60 {
            return "\(mins)分钟前"
        }
        let hours = Int(reduceTime / 3600)
        if hours < 24 {
            return "\(hours)小时前"
        }
        let days = Int(reduceTime / 3600 / 24)
        if days < 30 {
            return "\(days)天前"
        }
        //不满足上述条件---或者是未来日期-----直接返回日期
        let date = NSDate(timeIntervalSince1970: timeSta)
        let dfmatter = DateFormatter()
        //yyyy-MM-dd HH:mm:ss
        dfmatter.dateFormat="yyyy年MM月dd日 HH:mm:ss"
        return dfmatter.string(from: date as Date)
    }
    
    //MARK: -时间转时间戳函数
    public static func timeToTimeStamp(time: String ,inputFormatter:String) -> Double {
        let dfmatter = DateFormatter()
        //设定时间格式,这里可以设置成自己需要的格式
        dfmatter.dateFormat = inputFormatter
        let last = dfmatter.date(from: time)
        let timeStamp = last?.timeIntervalSince1970
        guard (timeStamp != nil) else {
            return 0
        }
        return timeStamp!
    }
  
}

extension Int {
    
    func NumChangeString() -> String {
        
        if self >= 10000{
            let  nums = Double(self) / 10000
            return String(format: "%.1f", nums) + "w"
        }else if self >= 1000{
            let  nums = Double(self) / 1000
            return String(format: "%.1f", nums) + "k"
        }else{
            
            return String(self)
        }
    }
    
    func NumWanString() -> String {
        
        if self >= 10000{
            let  nums = Double(self) / 10000
            return String(format: "%.1f", nums) + "w"
        }else if self >= 1000{
            let  nums = Double(self) / 1000
            return String(format: "%.1f", nums) + "k"
        }else{
            if self == 0 {
                return ""
            }
            return String(self)
        }
    }
    func NumKMString() -> String {
        
        if self >= 1000{
            let  nums = Double(self) / 1000
            return String(format: "%.1f", nums) + "k"
        }else{
            return String(self)
        }
    }
}

extension Date {
    static func formatTime(timeInterval:TimeInterval) -> String {
        let date = Date.init(timeIntervalSince1970: timeInterval)
        let formatter = DateFormatter.init()
        if date.isToday() {
            if date.isJustNow() {
                return "刚刚"
            } else {
                formatter.dateFormat = "HH:mm"
                return formatter.string(from: date)
            }
        } else {
            if date.isYestoday() {
                formatter.dateFormat = "昨天HH:mm"
                return formatter.string(from: date)
            } else if date.isCurrentWeek() {
                formatter.dateFormat = date.dateToWeekday() + "HH:mm"
                return formatter.string(from: date)
            } else {
                if date.isCurrentYear() {
                    formatter.dateFormat = "MM-dd  HH:mm"
                } else {
                    formatter.dateFormat = "yy-MM-dd  HH:mm"
                }
                return formatter.string(from: date)
            }
        }
    }
    
    func isJustNow() -> Bool {
        let now = Date.init().timeIntervalSince1970
        return fabs(now - self.timeIntervalSince1970) < 60 * 2 ? true : false
    }
    
    func isCurrentWeek() -> Bool {
        let nowDate = Date.init().dateFormatYMD()
        let selfDate = self.dateFormatYMD()
        let calendar = Calendar.current
        let cmps = calendar.dateComponents([.day], from: selfDate, to: nowDate)
        return cmps.day ?? 0 <= 7
    }
    
    func isCurrentYear() -> Bool {
        let calendar = Calendar.current
        let nowComponents = calendar.dateComponents([.year], from: Date.init())
        let selfComponents = calendar.dateComponents([.year], from: self)
        return selfComponents.year == nowComponents.year
    }
    
    func dateToWeekday() -> String {
        let weekdays = ["", "星期天", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"]
        var calendar = Calendar.init(identifier: Calendar.Identifier.gregorian)
        let timeZone = TimeZone.init(identifier: "Asia/Shanghai")
        calendar.timeZone = timeZone!
        let theComponents = calendar.dateComponents([.weekday], from: self)
        return weekdays[theComponents.weekday ?? 0]
    }
    
    func isToday() -> Bool {
        let calendar = Calendar.current
        let nowComponents = calendar.dateComponents([.day, .month, .year], from: Date.init())
        let selfComponents = calendar.dateComponents([.day, .month, .year], from: self)
        return nowComponents.year == selfComponents.year && nowComponents.month == selfComponents.month && nowComponents.day == selfComponents.day
    }
    
    func isYestoday() -> Bool {
        let nowDate = Date.init().dateFormatYMD()
        let selfDate = self.dateFormatYMD()
        let calendar = Calendar.current
        let cmps = calendar.dateComponents([.day], from: selfDate, to: nowDate)
        return cmps.day == 1
    }
    
    func dateFormatYMD() -> Date {
        let fmt = DateFormatter.init()
        fmt.dateFormat = "yyyy-MM-dd"
        let selfStr = fmt.string(from: self)
        return fmt.date(from: selfStr)!
    }
    
    
    //判断是白天还是黑夜（白天为TRUE）
    func dayAndNight() -> Bool {
        let formatter = DateFormatter.init()
        formatter.dateFormat = "HH"
        let str =  formatter.string(from: Date())
        
        let times = (str as NSString).integerValue
        if times > 19 || times < 5 {
            return false
        }else{
            return true
        }
    }
    //判断是是否早安
    func dayMoring() -> Bool {
        let formatter = DateFormatter.init()
        formatter.dateFormat = "HH"
        let str =  formatter.string(from: Date())
        
        let times = (str as NSString).integerValue
        if times > 5 && times < 9 {
            return true
        }else{
            return false
        }
    }
    //判断是是否晚安
    func dayNight() -> Bool {
        let formatter = DateFormatter.init()
        formatter.dateFormat = "HH"
        let str =  formatter.string(from: Date())
        
        let times = (str as NSString).integerValue
        if times > 19 && times < 22 {
            return true
        }else{
            return false
        }
    }
}



//扩展UIDevice
extension UIDevice {
    //获取设备具体详细的型号
    var modelName: String{
        var systemInfo = utsname()
        uname(&systemInfo)
        
        let platform = withUnsafePointer(to: &systemInfo.machine.0) { ptr in
            return String(cString: ptr)
        }
        if platform == "iPhone1,1" { return "iPhone 2G"}
        if platform == "iPhone1,2" { return "iPhone 3G"}
        if platform == "iPhone2,1" { return "iPhone 3GS"}
        if platform == "iPhone3,1" { return "iPhone 4"}
        if platform == "iPhone3,2" { return "iPhone 4"}
        if platform == "iPhone3,3" { return "iPhone 4"}
        if platform == "iPhone4,1" { return "iPhone 4S"}
        if platform == "iPhone5,1" { return "iPhone 5"}
        if platform == "iPhone5,2" { return "iPhone 5"}
        if platform == "iPhone5,3" { return "iPhone 5C"}
        if platform == "iPhone5,4" { return "iPhone 5C"}
        if platform == "iPhone6,1" { return "iPhone 5S"}
        if platform == "iPhone6,2" { return "iPhone 5S"}
        if platform == "iPhone7,1" { return "iPhone 6 Plus"}
        if platform == "iPhone7,2" { return "iPhone 6"}
        if platform == "iPhone8,1" { return "iPhone 6S"}
        if platform == "iPhone8,2" { return "iPhone 6S Plus"}
        if platform == "iPhone8,4" { return "iPhone SE"}
        if platform == "iPhone9,1" { return "iPhone 7"}
        if platform == "iPhone9,2" { return "iPhone 7 Plus"}
        if platform == "iPhone10,1" { return "iPhone 8"}
        if platform == "iPhone10,2" { return "iPhone 8 Plus"}
        if platform == "iPhone10,3" { return "iPhone X"}
        if platform == "iPhone10,4" { return "iPhone 8"}
        if platform == "iPhone10,5" { return "iPhone 8 Plus"}
        if platform == "iPhone10,6" { return "iPhone X"}
        if platform == "iPhone11,2" { return "iPhone XS"}
        if platform == "iPhone11,4" { return "iPhone XS Max (China)"}
        if platform == "iPhone11,6" { return "iPhone XS Max (China)"}
        if platform == "iPhone11,8" { return "iPhone XR"}
        if platform == "iPad1,1" { return "iPad 1"}
        if platform == "iPad2,1" { return "iPad 2"}
        if platform == "iPad2,2" { return "iPad 2"}
        if platform == "iPad2,3" { return "iPad 2"}
        if platform == "iPad2,4" { return "iPad 2"}
        if platform == "iPad2,5" { return "iPad Mini 1"}
        if platform == "iPad2,6" { return "iPad Mini 1"}
        if platform == "iPad2,7" { return "iPad Mini 1"}
        if platform == "iPad3,1" { return "iPad 3"}
        if platform == "iPad3,2" { return "iPad 3"}
        if platform == "iPad3,3" { return "iPad 3"}
        if platform == "iPad3,4" { return "iPad 4"}
        if platform == "iPad3,5" { return "iPad 4"}
        if platform == "iPad3,6" { return "iPad 4"}
        if platform == "iPad4,1" { return "iPad Air"}
        if platform == "iPad4,2" { return "iPad Air"}
        if platform == "iPad4,3" { return "iPad Air"}
        if platform == "iPad4,4" { return "iPad Mini 2"}
        if platform == "iPad4,5" { return "iPad Mini 2"}
        if platform == "iPad4,6" { return "iPad Mini 2"}
        if platform == "iPad4,7" { return "iPad Mini 3"}
        if platform == "iPad4,8" { return "iPad Mini 3"}
        if platform == "iPad4,9" { return "iPad Mini 3"}
        if platform == "iPad5,1" { return "iPad Mini 4"}
        if platform == "iPad5,2" { return "iPad Mini 4"}
        if platform == "iPad5,3" { return "iPad Air 2"}
        if platform == "iPad5,4" { return "iPad Air 2"}
        if platform == "iPad6,3" { return "iPad Pro 9.7"}
        if platform == "iPad6,4" { return "iPad Pro 9.7"}
        if platform == "iPad6,7" { return "iPad Pro 12.9"}
        if platform == "iPad6,8" { return "iPad Pro 12.9"}
        
        if platform == "i386"   { return "iPhone Simulator"}
        if platform == "x86_64" { return "iPhone Simulator"}
        
        return platform
    }
}


