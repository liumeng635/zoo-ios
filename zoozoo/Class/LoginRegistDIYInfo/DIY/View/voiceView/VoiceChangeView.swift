//
//  VoiceChangeView.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/5/22.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit


class VoiceChangeView: UIView {
    
     public  var ChooseVoiceChangeClickBlock : ((_ isDone : Bool)->Void)?
    
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: Voicecollection, height: Voicecollection)
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        layout.scrollDirection = .vertical
        
        layout.sectionInset = UIEdgeInsets.init(top: 15, left: 15, bottom: 15, right: 15)
        
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .white
        collection.delegate = self
        collection.dataSource = self
        collection.isScrollEnabled = true
        /// 滚动指示条
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        /// 注册
        collection.register(VoiceChangeCell.self, forCellWithReuseIdentifier: "VoiceChangeCell")
        return collection
    }()
    lazy var cancelBtn : UIButton = {
        
        let Btn = UIButton.init(type: .custom)
        
        Btn.layer.cornerRadius  = 30
        Btn.layer.borderColor = ColorThemeLan.cgColor
        Btn.layer.borderWidth = 1
        Btn.setTitle("重新录制", for: .normal)
        Btn.setTitleColor(ColorThemeLan, for: .normal)
        Btn.titleLabel?.font = UIFont.pingFangTextFont(size: 14)
        Btn.addTarget(self, action: #selector(cancelclick), for: .touchUpInside)
      
        return Btn
        
    }()
    
    
    lazy var sureBtn : UIButton = {
        
        let Btn = UIButton.init(type: .custom)
        Btn.layer.cornerRadius  = 30
        Btn.layer.masksToBounds = true
        Btn.setTitle("确认使用", for: .normal)
        Btn.setTitleColor(.white, for: .normal)
        Btn.titleLabel?.font = UIFont.pingFangTextFont(size: 14)
        Btn.addTarget(self, action: #selector(sureclick), for: .touchUpInside)
       
        return Btn
        
    }()
    
    
    lazy var myvoiceBtn : UIButton = {
        
        let Btn = UIButton.init(type: .custom)
        Btn.layer.cornerRadius  = 30
        Btn.layer.borderColor = ColorThemeLan.cgColor
        Btn.layer.borderWidth = 1
        Btn.setTitle("我的原声", for: .normal)
        Btn.setTitleColor(ColorThemeLan, for: .normal)
        Btn.setTitleColor(UIColor.colorWithHex(hex: 0xFC9A7D), for: .selected)
        Btn.titleLabel?.font = UIFont.pingFangTextFont(size: 14)
        Btn.addTarget(self, action: #selector(myvoiceclick), for: .touchUpInside)
        return Btn
        
    }()
   
    var titles = ["大叔","萝莉","御姐","青年"]
    var pitch = [-7,12,3,5]
    var rate = [0,0,0,12]
    var tempo = [0,0,0,12]
    var dataArr = [VoiceModel]()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
      
        loadData()
        sureBtn.addButtonGradientLayer()
    }
    func loadData(){
        for i in 0..<titles.count {
            let model = VoiceModel.init()
            model.title = titles[i]
            model.pitch = Int32(pitch[i])
            model.rate = Int32(rate[i])
            model.tempo = Int32(tempo[i])
            self.dataArr.append(model)
        }
        
        self.collection.reloadData()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupUI() {
        self.backgroundColor = .white
        self.addSubview(collection)
        self.addSubview(cancelBtn)
        self.addSubview(sureBtn)
        self.addSubview(myvoiceBtn)
        
        collection.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            
            make.height.equalTo(Voicecollection + 30)
        }
        cancelBtn.snp.makeConstraints { (make) in
            make.top.equalTo(collection.snp.bottom).offset(20)
            make.left.equalTo(20)
            
            make.height.equalTo(60)
            make.width.equalTo(VoicebuttonW)
        }
        sureBtn.snp.makeConstraints { (make) in
            make.top.equalTo(cancelBtn.snp.top)
            make.left.equalTo(cancelBtn.snp.right).offset(20)
            
            make.height.equalTo(60)
            make.width.equalTo(VoicebuttonW)
            
            
        }
        myvoiceBtn.snp.makeConstraints { (make) in
            make.top.equalTo(cancelBtn.snp.top)
            make.right.equalTo(-20)
            
            make.height.equalTo(60)
            make.width.equalTo(VoicebuttonW)
            
            
        }
        
    }
}
extension VoiceChangeView {
    @objc private func cancelclick(){
        CWRecorder.shareInstance()?.deleteRecord()
        let path = CWRecorder.shareInstance()?.recordPath
        CWFlieManager.removeFile(path)
      
        CWFlieManager.removeFile(CWFlieManager.soundTouchSavePath(withFileName: path?.docuPath()))
        self.ChooseVoiceChangeClickBlock?(false)
       
        
    }
    @objc private func sureclick(){
        let path = CWRecorder.shareInstance()?.recordPath
       
        if self.myvoiceBtn.isSelected{
            CWFlieManager.removeFile(CWFlieManager.soundTouchSavePath(withFileName: path?.docuPath()))
        }else{
             CWFlieManager.removeFile(path)
        }
        
      
        self.ChooseVoiceChangeClickBlock?(true)
        
    }
    @objc private func myvoiceclick(){
        self.dataArr.forEach({ (voice) in
            voice.isSelected = false
        })
        self.collection.reloadData()
        self.myvoiceBtn.layer.borderColor = UIColor.colorWithHex(hex: 0xFC9A7D).cgColor
        self.myvoiceBtn.isSelected = true
        
        guard let path = CWRecorder.shareInstance()?.recordPath else {
            return
        }
        self.playVoiceChange(path: path)
    }
}
extension VoiceChangeView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArr.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VoiceChangeCell", for: indexPath) as! VoiceChangeCell
        cell.model = self.dataArr[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.myvoiceBtn.layer.borderColor = ColorThemeLan.cgColor
        self.myvoiceBtn.isSelected = false
        self.dataArr.forEach({ (voice) in
            voice.isSelected = false
        })
        let model = self.dataArr[indexPath.row]
        model.isSelected = true
        self.collection.reloadData()
        
        self.playAudioWithPath(model: model)
        
    }
    
    func playAudioWithPath(model : VoiceModel){
        let path = CWRecorder.shareInstance()?.recordPath
        
        let data = NSData.init(contentsOfFile: path!)
        
        let config = MySountTouchConfig.init(sampleRate: 11025, tempoChange: model.tempo  , pitch: model.pitch , rate: model.rate)
        
        
        let soundTouch = SoundTouchOperation.init(target: self, action: #selector(playVoiceChange(path :)), sound:config , soundFile: data as Data?)
        let queue = OperationQueue()
        //设置最大并发数
        queue.maxConcurrentOperationCount = 1
        queue.cancelAllOperations()
        queue.addOperation(soundTouch!)
        
    }
    
    
    @objc private func playVoiceChange(path :String){
       
        CWAudioPlayer.shareInstance()?.playAudio(with: path)
    }
}
class VoiceChangeCell: UICollectionViewCell {
    
   
    lazy var chooseImageView:UIImageView = {
        let ImageView  = UIImageView.init()
        ImageView.image = UIImage.init(named: "Selectedanimals")
        return ImageView
    }()
    lazy var topImageView:UIImageView = {
        let ImageView  = UIImageView.init()
        ImageView.image = UIImage.init(named: "laba")
        return ImageView
    }()
    
    
    
    lazy var contentLab:UILabel = {
        let Lab = UILabel.init()
        Lab.textAlignment = NSTextAlignment.center
        Lab.font = UIFont.pingFangTextFont(size: 12)
        Lab.textColor = .white
        
        return Lab
    }()
    
    
    lazy var backImageView:UIImageView = {
        let ImageView  = UIImageView.init()
        ImageView.image = UIImage.init(named: "recoredvoice")
        ImageView.layer.cornerRadius = 5.0
        ImageView.layer.masksToBounds = true
        return ImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        self.contentView.addSubview(backImageView)
        backImageView.addSubview(topImageView)
        backImageView.addSubview(chooseImageView)
        backImageView.addSubview(contentLab)
        
       
        
        backImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        topImageView.snp.makeConstraints { (make) in
            make.top.equalTo(15)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(15)
        }
        chooseImageView.snp.makeConstraints { (make) in
            make.top.equalTo(5)
            make.right.equalTo(-5)
            make.width.height.equalTo(15)
        }
        contentLab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(20)
            make.top.equalTo(topImageView.snp.bottom).offset(12)
        }
        
        
        
        
    }
   
    public var model:VoiceModel? {
        didSet{
            
            contentLab.text = model?.title
            
            contentLab.isHidden = false
            chooseImageView.isHidden = true
            if model?.isSelected ?? false {
                backImageView.image = UIImage.init(named: "sysvoiceselect")
                chooseImageView.isHidden = false
            }else{
                backImageView.image = UIImage.init(named: "recoredvoice")
                chooseImageView.isHidden = true
            }
        }
    }
    
    
}
