//
//  Refresh.swift
//  zoozoo
//
//  Created by 苹果上的豌豆 on 2019/5/15.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit
import MJRefresh

extension UIScrollView {
    var ZHead: MJRefreshHeader? {
        get { return mj_header }
        set { mj_header = newValue }
    }
    
    var ZFoot: MJRefreshFooter? {
        get { return mj_footer }
        set { mj_footer = newValue }
    }
}

class RefreshHeader: MJRefreshGifHeader {
    override func prepare() {
        super.prepare()
//        YNBaseEngine.shared.FeedbackGenerator()
        setImages([UIImage(named: "arrowUp")!], for: .idle)
        setImages([UIImage(named: "arrowDown")!], for: .pulling)
        var images = [UIImage(named: "loading_1")!]
        
        for i in 1 ..< 26 {
            let str = "loading_" + String.init(i)
            
            images.append(UIImage.init(named: str)!)
        }
        
        
        setImages(images, duration: 1, for: .refreshing)
        
        lastUpdatedTimeLabel.isHidden = true
        stateLabel.isHidden = true
    }
}
class RefreshDiscoverFooter: MJRefreshAutoGifFooter {
    override func prepare() {
        super.prepare()
        setImages([UIImage(named: "loading_1")!], for: .idle)
        setImages([UIImage(named: "loading_1")!], for: .pulling)
        var images = [UIImage(named: "loading_1")!]
        
        for i in 1 ..< 26 {
            let str = "loading_" + String.init(i)
            
            images.append(UIImage.init(named: str)!)
        }
        
        setImages(images, duration: 1, for: .refreshing)
        isRefreshingTitleHidden = true
        stateLabel.isHidden = true
        
    }
    
}
class RefreshAutoHeader: MJRefreshHeader {}

class RefreshFooter: MJRefreshBackNormalFooter {}

class RefreshAutoFooter: MJRefreshAutoFooter {}


class RefreshBackGifFooter: MJRefreshBackGifFooter {
    
    override func prepare() {
        super.prepare()
        backgroundColor = UIColor.clear
        setImages([UIImage(named: "loading_1")!], for: .idle)
        stateLabel.isHidden = true
        refreshingBlock = { self.endRefreshing() }
    }
}

class RefreshTipKissFooter: MJRefreshBackFooter {
    
    lazy var tipLabel: UILabel = {
        let tl = UILabel()
        tl.textAlignment = .center
        tl.textColor = UIColor.lightGray
        tl.font = UIFont.systemFont(ofSize: 14)
        tl.numberOfLines = 0
        return tl
    }()
    
    lazy var imageView: UIImageView = {
        let iw = UIImageView()
        iw.image = UIImage(named: "loading_1")
        return iw
    }()
    
    override func prepare() {
        super.prepare()
        
        backgroundColor = UIColor.clear
        mj_h = 240
        addSubview(tipLabel)
        addSubview(imageView)
    }
    
    override func placeSubviews() {
        tipLabel.frame = CGRect(x: 0, y: 40, width: bounds.width, height: 60)
        imageView.frame = CGRect(x: (bounds.width - 80 ) / 2, y: 110, width: 80, height: 80)
    }
    
    convenience init(with tip: String) {
        self.init()
        refreshingBlock = { self.endRefreshing() }
        tipLabel.text = tip
    }
}



