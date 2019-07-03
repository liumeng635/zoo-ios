//
//  DIYVoiceViewController.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/5/24.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

@objc protocol DIYVoiceViewDelegate: NSObjectProtocol {
    /**
     *  获取音频
     *
     *  @param isSourceURLPathVoice     //是否是网络音频和本地录制音频
     *  @param Path            音频路径
     
     */
    @objc optional func getDIYPathVoice(isSourceURLPathVoice: Bool, Path: String )
    
}

class DIYVoiceViewController: BaseViewController ,UICollectionViewDataSource, UICollectionViewDelegate {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: Voicecollection, height: Voicecollection)
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        layout.scrollDirection = .vertical
        
        layout.sectionInset = UIEdgeInsets.init(top: 15, left: 15, bottom: 15, right: 15)
        
        let collection  = UICollectionView.init(frame: CGRect(x:0, y:0, width:ScreenW, height:ScreenH-DIYBackHeight-DIYSegmentH), collectionViewLayout: layout)
        collection.backgroundColor = ColorBackGround
        collection.delegate = self
        collection.dataSource = self
        collection.isScrollEnabled = true
        /// 滚动指示条
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        
        collection.register(VioceAnimalCell.self, forCellWithReuseIdentifier: Identifier)
        return collection
    }()
    
    //MARK:录音视图
    lazy var voiceView : DIYRecordVoiceView = {
        
        
        let voiceView = DIYRecordVoiceView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenW, height: ScreenH-DIYBackHeight-DIYSegmentH))
        voiceView.isHidden = true
        voiceView.ShowRecordVoiceViewBlock = { [unowned self] in
            self.voiceChangeView.isHidden = false
            
        }
        return voiceView
        
    }()
    //MARK:选择变声视图
    lazy var voiceChangeView : VoiceChangeView = {
        
        let voiceChangeView = VoiceChangeView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenW, height: ScreenH-DIYBackHeight-DIYSegmentH))
        voiceChangeView.ChooseVoiceChangeClickBlock = {[unowned self](isDone) in
            self.backChooseDIYView(isDone: isDone)
        }
        voiceChangeView.isHidden = true
        return voiceChangeView
        
    }()
    
    weak var delegateDIYVioceView: DIYVoiceViewDelegate?
    let Identifier       = "VioceAnimalCell"
    var dataArr = [VoiceModel]()
    var vioceTitle : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ColorBackGround
        
        self.view.addSubview(collectionView)
        self.view.addSubview(self.voiceView)
        self.view.addSubview(self.voiceChangeView)
        GetVoiceAnimalList()
    }
    
    

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier, for: indexPath) as! VioceAnimalCell
        let model = self.dataArr[indexPath.row]
        cell.model = model
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.dataArr.forEach({ (voice) in
            voice.isSelected = false
        })
        let model = self.dataArr[indexPath.row]
        model.isSelected = true
        self.collectionView.reloadData()
        
        if model.type == "me"{
            self.voiceView.isHidden = false
            
        }else if model.type == "adverb"{
            self.voiceView.isHidden = false
            deleteVioceFiles()
            
        }else if model.type == "voice"{
            let path = CWFlieManager.getPlaySoundTouchSavePath(withFileName: CWRecorder.shareInstance()?.recordPath.docuPath())
            
            
            CWAudioPlayer.shareInstance()?.playAudio(with: path)
            
            self.delegateDIYVioceView?.getDIYPathVoice?(isSourceURLPathVoice: false, Path: path ?? "")
        }else{
            
            if let url = model.audioPath {
                VoiceAudioUrlPlayer.shared.playAudioUrl(audioUrl: url)
                
                self.delegateDIYVioceView?.getDIYPathVoice?(isSourceURLPathVoice: true, Path: url)
            }
            
            
        }
        
        
        
    }
    
    
    
}
extension DIYVoiceViewController {
    //MARK:选择录音文件之后的刷新collection数据
    func recordVoiceReloadData(){
        self.dataArr.removeFirst()
        let arr = self.dataArr
        self.dataArr.removeAll()
        
        let mymodel = VoiceModel.init()
        mymodel.type = "voice"
        mymodel.title = "我的配音"
        mymodel.isSelected = true
        self.dataArr.append(mymodel)
        arr.forEach({ (voice) in
            self.dataArr.append(voice)
        })
        let model = VoiceModel.init()
        model.type = "adverb"
        model.title = "重新录制"
        self.dataArr.append(model)
        self.collectionView.reloadData()
    }
    //MARK:变声视图和录音视图的消失和显示
    func backChooseDIYView(isDone :Bool){
        if isDone {
            recordVoiceReloadData()
            self.voiceView.isHidden = true
            self.voiceChangeView.isHidden = true
        }else{
            self.voiceChangeView.isHidden = true
            
        }
        
    }
    //MARK:删除音频文件
    func deleteVioceFiles(){
        CWRecorder.shareInstance()?.deleteRecord()
        let path = CWRecorder.shareInstance()?.recordPath
        CWFlieManager.removeFile(path)
        CWFlieManager.removeFile(CWFlieManager.soundTouchSavePath(withFileName: path?.docuPath()))
    }
    //MARK:获取默认音频数据
    func GetVoiceAnimalList(){
        let model = VoiceModel.init()
        model.type = "me"
        model.title = "我来配音"
        self.dataArr.append(model)
        self.collectionView.reloadData()
        DIYAPI.shared.APPDIYSysAudioURL(type: 1,success: { (json) in
            if let response = BaseVoiceModel.deserialize(from: json as? [String:Any]){
                if response.code == 200 {
                    let array = response.data
                    array.forEach({ (voice) in
                        self.dataArr.append(voice)
                    })
                    self.collectionView.reloadData()
                }else{
                    ShowMessageTool.shared.showMessage("请求失败")
                }
            }
            
        }) { (error) in
            
        }
        
        
        
    }
}
class VioceAnimalCell: UICollectionViewCell {
    
    public  var ChooseClickBlock : (()->Void)?
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
    lazy var sysLab:UILabel = {
        let Lab = UILabel.init()
        Lab.textAlignment = NSTextAlignment.center
        Lab.font = UIFont.pingFangTextFont(size: 11)
        Lab.textColor = .white
        
        return Lab
    }()
    lazy var deLab:UILabel = {
        let Lab = UILabel.init()
        Lab.textAlignment = NSTextAlignment.center
        Lab.font = UIFont.pingFangTextFont(size: 9)
        Lab.textColor = .white
        
        return Lab
    }()
    
    lazy var backImageView:UIImageView = {
        let ImageView  = UIImageView.init()
        ImageView.image = UIImage.init(named: "sysvoicenomal")
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
        
        backImageView.addSubview(sysLab)
        backImageView.addSubview(deLab)
        
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
        
        sysLab.snp.makeConstraints { (make) in
            make.top.equalTo(topImageView.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(15)
        }
        deLab.snp.makeConstraints { (make) in
            make.top.equalTo(sysLab.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(15)
        }
    }
    func chooseSelect(){
        if model?.isSelected ?? false{
            backImageView.image = UIImage.init(named: "sysvoiceselect")
            chooseImageView.isHidden = false
        }else{
            backImageView.image = UIImage.init(named: "sysvoicenomal")
            chooseImageView.isHidden = true
        }
    }
    public var model:VoiceModel? {
        didSet{
            guard let _ = model else {
                return
            }
            contentLab.text = model?.title
            if model?.type == "me" {
                backImageView.image = UIImage.init(named: "mevoice")
                topImageView.image = UIImage.init(named: "huatong")
                
                sysLab.isHidden = true
                deLab.isHidden = true
                contentLab.isHidden = false
                chooseImageView.isHidden = true
            }else if model?.type == "adverb"{
                backImageView.image = UIImage.init(named: "mevoice")?.render(color: UIColor.colorWithHex(hex: 0xA8B1C2))
                topImageView.image = UIImage.init(named: "huatong")
                
                sysLab.isHidden = true
                deLab.isHidden = true
                contentLab.isHidden = false
                chooseImageView.isHidden = true
                
            }else if model?.type == "sys" ||  model?.type == "voice"{
                backImageView.image = UIImage.init(named: "sysvoicenomal")
                
                topImageView.image = UIImage.init(named: "laba")
                
                sysLab.isHidden = true
                deLab.isHidden = true
                contentLab.isHidden = false
                chooseImageView.isHidden = true
                chooseSelect()
                
            }else{
                backImageView.image = UIImage.init(named: "sysvoicenomal")
                
                topImageView.image = UIImage.init(named: "laba")
                sysLab.text = model?.title
                deLab.text = model?.useCnt
                sysLab.isHidden = false
                deLab.isHidden = false
                contentLab.isHidden = true
                chooseImageView.isHidden = true
                chooseSelect()
            }
            
        }
    }

}
