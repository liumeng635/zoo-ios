//
//  ChatBaseModel.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/7/1.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

enum ChatFeedShowType {
    case nomal//图文
    case system//系统提示时间文字
    case text //纯文字内容
    case emoji//纯表情
    case education//出题
    case friend//第一次成为好友
}
let ChatBackWidth: CGFloat =  ScreenW - 85 - 30
let image1Width: CGFloat = ChatBackWidth/1.68
let image2Width: CGFloat = (ChatBackWidth - 5) / 2
let image3Width: CGFloat = (ChatBackWidth - 10) / 3

//0普通 1一键喂食 2一键遛弯 3一键教育; 4撒娇 5上传 6提问 7回答问题 8灰体消息 9喂食 10遛弯 11教育 12评论 13点赞 14回复 15早安 16晚安 17首次消息
class ChatBaseModel: NSObject {
    var chatModel : ChatRoomModel = ChatRoomModel.init()
    
    var FeedType : ChatFeedShowType = .nomal
    
     var cellHeight: CGFloat = 0
    
    /// 图片的高度
    var cellPhotoHeight: CGFloat = 0
    
    /// 图文的高度
    var cellNomalHeight: CGFloat = 0
    
    /// 系统提示时间文字
    var cellSystemHeight: CGFloat = 60
    
    /// 纯文字内容高度
    var cellTextHeight: CGFloat = 0
    
    /// 纯表情高度
    var cellEmojiHeight: CGFloat = 80
    
    /// 第一次成为好友高度
    var cellFriendHeight: CGFloat = 50
    
    
    func getcellNomalHeight() {
        var height: CGFloat = 0
        height += 10
        height += 15
        if self.chatModel.content.isEmpty {
           height += self.cellPhotoHeight
            
        }else{
            height += self.cellTextHeight
            height += 10
            height += self.cellPhotoHeight
        }
        height += 15
        height += 10
        self.cellNomalHeight = height
        
    }
    func getcellTextHeight() {
        var height: CGFloat = 0
        
        if self.chatModel.content.isEmpty {
            height += 0
        }else{
             height += self.chatModel.content.XZBGetYYLabelHeight(width: ChatBackWidth, LineHeight: 25, font: UIFont.pingFangTextFont(size: 14))
        }
        self.cellTextHeight = height
        
    }
    func getcellPhotoHeight() {
        var height: CGFloat = 0
       let photosNum = self.chatModel.imgUrls.count
        switch photosNum {
        case 0:
            height += 0
        case 1:
            height += image1Width
        case 2:
            height += image2Width
        case 3:
            height += image3Width
        case 4:
            height += image2Width*2 + 5
        case 5...6:
            height += image3Width*2 + 5
        case 7...9:
            height += image3Width*3 + 10
       
        default:
            height += 0
        }
        self.cellPhotoHeight = height
        
    }
   
    func getType(){
        //0普通 1一键喂食 2一键遛弯 3一键教育; 4撒娇 5上传 6提问(宠物提问) 7回答问题 8灰体消息 9喂食 10遛弯 11教育 12评论 13点赞 14回复 15早安 16晚安 17首次消息
        if self.chatModel.msgType == 8{
            if !self.chatModel.content.isEmpty {
                self.FeedType = .system
            }
            
        }else if self.chatModel.msgType == 17{
            if !self.chatModel.content.isEmpty {
                self.FeedType = .friend
            }
            
        }else if self.chatModel.msgType == 0{
            if self.chatModel.imgUrls.count == 0 {
                self.FeedType = .text
            }else{
                self.FeedType = .nomal
            }
        }else if self.chatModel.msgType == 4{
            if self.chatModel.imgUrls.count > 0 {
                self.FeedType = .emoji
            }
        }else if self.chatModel.msgType == 11{
            if self.chatModel.question?.option.count ?? 0 > 0 {
                self.FeedType = .education
            }
        }else{
            if self.chatModel.imgUrls.count == 0 {
                self.FeedType = .text
            }else{
                self.FeedType = .nomal
            }
        }
        
    }
    func getcellHeight(){
        var height: CGFloat = 0
//        case nomal//图文
//        case system//系统提示时间文字
//        case text //纯文字内容
//        case emoji//纯表情
//        case education//出题
//        case friend//第一次成为好友
        
        switch self.FeedType {
        case .nomal:
            height += self.cellNomalHeight
        case .system:
            height += 60
        case .text:
            if self.chatModel.content.isEmpty {
                height += 0
            }else{
                height += self.cellTextHeight
                height += 30
            }
        case .emoji:
            height += 80
        case .education:
            height += 0
        case .friend:
            height += 50
        
        }
        self.cellHeight = height
    
    }
    
    
    
    init(model :ChatRoomModel){
        super.init()
        self.chatModel = model
        getcellPhotoHeight()
        getType()
        getcellTextHeight()
        getcellNomalHeight()
        getcellHeight()
    }
    
}

