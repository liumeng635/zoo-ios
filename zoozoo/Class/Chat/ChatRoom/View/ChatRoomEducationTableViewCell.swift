//
//  ChatRoomEducationTableViewCell.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/7/2.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class ChatRoomEducationTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        self.initSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    
    public var model : ChatRoomModel? {
        
        didSet{
            guard let model = model else {
                return
            }
            
        }
    }
    
    //MARK:- Method
    private func initSubViews(){
        self.backgroundColor = ColorBackGround
      
    }
}
