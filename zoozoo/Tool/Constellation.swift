//
//  Constellation.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/6/14.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

struct Constellation {
    
    private enum ConstellationType:String {
        case 白羊座, 金牛座, 双子座, 巨蟹座, 狮子座, 处女座,
        天秤座, 天蝎座, 射手座, 摩羯座, 水瓶座, 双鱼座
    }
    
    private static let constellationDict:[ConstellationType :String] = [.白羊座: "3.21-4.19",
                                                                        .金牛座: "4.20-5.20",
                                                                        .双子座: "5.21-6.21",
                                                                        .巨蟹座: "6.22-7.22",
                                                                        .狮子座: "7.23-8.22",
                                                                        .处女座: "8.23-9.22",
                                                                        .天秤座: "9.23-10.23",
                                                                        .天蝎座: "10.24-11.22",
                                                                        .射手座: "11.23-12.21",
                                                                        .摩羯座: "12.22-1.19",
                                                                        .水瓶座: "1.20-2.18",
                                                                        .双鱼座: "2.19-3.20"]
    
    /// 日期 -> 星座
    ///   - parameter date: 日期
    ///   - returns:  星座名称
    public static func calculateWithDate(dateStr: String) -> String? {
        if dateStr.isEmpty{
            return "摩羯座"
        }
        let dateformatter  = DateFormatter.init();
        dateformatter.dateFormat = "yyyy-MM-dd"
        dateformatter.timeZone = TimeZone.current
        let date = dateformatter.date(from: dateStr)!
        
        let timeInterval = date.timeIntervalSince1970
        let OneDay:Double = 86400
        
        let currConstellation = constellationDict.filter {
            
            let timeRange = getTimeRange(date: date, timeRange: $1)
            let startTime = timeRange.0
            let endTime = timeRange.1 + OneDay
            
            return timeInterval > startTime && timeInterval < endTime
        } // 摩羯座这家伙跨年必定不满足
        
        return currConstellation.first?.key.rawValue ?? "摩羯座"
    }
    
    /// f.获取开始、结束时间
    private static func getTimeRange(date:Date, timeRange: String) -> (TimeInterval, TimeInterval) {
        
        /// f.1 获取当前年份
        func getCurrYear(date:Date) -> String {
            
            let dm = DateFormatter()
            dm.dateFormat = "yyyy."
            let currYear = dm.string(from: date)
            return currYear
        }
        
        /// f.2 日期转换当前时间戳
        func toTimeInterval(dateStr: String) -> TimeInterval? {
            
            let dm = DateFormatter()
            dm.dateFormat = "yyyy.MM.dd"
            
            let date = dm.date(from: dateStr)
            let interval = date?.timeIntervalSince1970
            
            return interval
        }
        
        let timeStrArr = timeRange.components(separatedBy: "-")
        let dateYear = getCurrYear(date: date)
        let startTimeStr = dateYear + timeStrArr.first!
        let endTimeStr = dateYear + timeStrArr.last!
        
        let startTime = toTimeInterval(dateStr: startTimeStr)!
        let endTime = toTimeInterval(dateStr: endTimeStr)!
        
        return (startTime, endTime)
    }
}
