//
//  PraviteAgreementView.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/6/23.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

class PraviteAgreementView: UIView {
    var type = 0
    init(type :Int) {
        super.init(frame: screenFrame)
        self.type = type
        initSubView()
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    lazy var contentView:UIView = {
        let View = UIView.init()
        View.backgroundColor = UIColor.colorWithHex(hex: 0xffffff)
        return View
    }()
    lazy var cancel : UIButton = {
        
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "close")?.render(color: .white), for: .normal)
        button.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
        return button
    }()
    lazy var textView : UITextView = {
        let view = UITextView.init()
        view.layer.masksToBounds = true
        view.layer.cornerRadius  = 20
        view.isEditable = false
        view.backgroundColor = UIColor.white
        view.showsVerticalScrollIndicator = false
        view.contentInset = UIEdgeInsets(top: 0, left: 29, bottom: ScreenW + 30, right: 29)
        return view
    }()
    var contentH : CGFloat {
        return 542  + SafeBottomMargin
    }
    
    func setupLayout() {
        
        
        
        cancel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-(contentH + 10))
            make.width.height.equalTo(40)
        }
        
        textView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(50)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        
        
        
    }
    
    func initSubView() {
        self.frame = CGRect.init(x: 0, y: 0, width: ScreenW, height: ScreenH)
        self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.8)
        self.addTapGesture(target: self, action: #selector(dismissController))
        self.addSubview(contentView)
        contentView.alpha = 0
        
        contentView.frame = CGRect.init(x: 0, y: ScreenH, width: ScreenW, height: contentH)
        
        
        self.addSubview(cancel)
        contentView.addSubview(textView)

        setupLayout()
        
        let corners : UIRectCorner = [.topLeft, .topRight]
        
        let rounded = UIBezierPath(roundedRect: contentView.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: 20, height: 20))
        let shape = CAShapeLayer()
        shape.path = rounded.cgPath
        
        contentView.layer.mask = shape
    }

    
    func show(){
        
        let window = UIApplication.shared.delegate?.window as? UIWindow
        window?.addSubview(self)
        
        if type == 1 {
            textView.attributedText = PraviteText()
        }else{
            textView.attributedText = text()
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.contentView.frame = CGRect.init(x: 0, y: ScreenH - self.contentH, width: ScreenW, height: self.contentH)
            
            self.contentView.alpha = 1
            self.alpha = 1
        }) { (finish) in
            
        }
        
        
        
    }
    @objc func dismissController() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.contentView.frame = CGRect.init(x: 0, y: ScreenH, width: ScreenW, height: self.contentH)
            
            self.contentView.alpha = 0
            self.alpha = 0
        }) { (finish) in
            self.isHidden = true
            self.removeFromSuperview()
        }
        
    }
    
    func text() -> NSMutableAttributedString {
        
        let titleStr = NSMutableAttributedString(string: titleName)
        titleStr.yy_font = UIFont.boldSystemFont(ofSize: 24)
        titleStr.yy_color = ColorTitle
        
        let tipsStr = NSMutableAttributedString(string: tips)
        tipsStr.yy_font = UIFont.pingFangTextFont(size: 14)
        tipsStr.yy_color = ColorDarkGrayTextColor
        //        tipsStr.yy_lineSpacing = 18
        
        let articleTitle1Str = NSMutableAttributedString(string: articleTitle1)
        articleTitle1Str.yy_font = UIFont.pingFangTextFont(size: 14)
        articleTitle1Str.yy_color = ColorTitle
        let article1Str = NSMutableAttributedString(string: article1)
        article1Str.yy_font = UIFont.pingFangTextFont(size: 14)
        article1Str.yy_color = ColorDarkGrayTextColor
        //        article1Str.yy_lineSpacing = 18
        
        let articleTitle2Str = NSMutableAttributedString(string: articleTitle2)
        articleTitle2Str.yy_font = UIFont.pingFangTextFont(size: 14)
        articleTitle2Str.yy_color = ColorTitle
        let article2Str = NSMutableAttributedString(string: article2)
        article2Str.yy_font = UIFont.pingFangTextFont(size: 14)
        article2Str.yy_color = ColorDarkGrayTextColor
        //        article2Str.yy_lineSpacing = 18
        
        let articleTitle3Str = NSMutableAttributedString(string: articleTitle3)
        articleTitle3Str.yy_font = UIFont.pingFangTextFont(size: 14)
        articleTitle3Str.yy_color = ColorTitle
        let article3Str = NSMutableAttributedString(string: article3)
        article3Str.yy_font = UIFont.pingFangTextFont(size: 14)
        article3Str.yy_color = ColorDarkGrayTextColor
        //        article3Str.yy_lineSpacing = 18
        
        let articleTitle4Str = NSMutableAttributedString(string: articleTitle4)
        articleTitle4Str.yy_font = UIFont.pingFangTextFont(size: 14)
        articleTitle4Str.yy_color = ColorTitle
        let article4Str = NSMutableAttributedString(string: article4)
        article4Str.yy_font = UIFont.pingFangTextFont(size: 14)
        article4Str.yy_color = ColorDarkGrayTextColor
        //        article4Str.yy_lineSpacing = 18
        
        let articleTitle5Str = NSMutableAttributedString(string: articleTitle5)
        articleTitle5Str.yy_font = UIFont.pingFangTextFont(size: 14)
        articleTitle5Str.yy_color = ColorTitle
        let article5Str = NSMutableAttributedString(string: article5)
        article5Str.yy_font = UIFont.pingFangTextFont(size: 14)
        article5Str.yy_color = ColorDarkGrayTextColor
        //        article5Str.yy_lineSpacing = 18
        
        let articleTitle6Str = NSMutableAttributedString(string: articleTitle6)
        articleTitle6Str.yy_font = UIFont.pingFangTextFont(size: 14)
        articleTitle6Str.yy_color = ColorTitle
        let article6Str = NSMutableAttributedString(string: article6)
        article6Str.yy_font = UIFont.pingFangTextFont(size: 14)
        article6Str.yy_color = ColorDarkGrayTextColor
        //        article6Str.yy_lineSpacing = 18
        
        let text = NSMutableAttributedString()
        text.append(titleStr)
        text.append(tipsStr)
        text.append(articleTitle1Str)
        text.append(article1Str)
        text.append(articleTitle2Str)
        text.append(article2Str)
        text.append(articleTitle3Str)
        text.append(article3Str)
        text.append(articleTitle4Str)
        text.append(article4Str)
        text.append(articleTitle5Str)
        text.append(article5Str)
        text.append(articleTitle6Str)
        text.append(article6Str)
        return text
    }
    
    /// 禁止textView编辑（代理方法）
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return false
    }
    
    let titleName = "ZOO用户协议\n\n"
    let tips = "特别提示:\n在您的移动装置和/或其他计算装置上下载和使用ZOO官方网站或ZOO软件产品时，即表明您接受本协议条款和条件。ZOO在此特别提醒用户认真阅读、充分理解本《服务协议》（下称《协议》），用户应认真阅读、充分理解本《协议》中各条款，包括免除或者限制ZOO责任的免责条款及对用户的权利禁止或限制条款。请您审慎阅读并选择接受或不接受本《协议》（未成年人应在法定监护人陪同下阅读）。除非您接受本《协议》所有条款，否则您下载或使用本协议所涉相关服务。 您的下载，使用等行为将视为对本《协议》的接受，并同意接受本《协议》各项条款的约束。 本《协议》描述ZOO与用户之间关于“ZOO”服务相关方面的权利义务。“用户”是指下载、使用、浏览本服务的个人或组织。本《协议》可由ZOO随时更新，更新后的协议条款一旦公布即代替原来的协议条款，恕不再另行通知，用户可在本网站查阅最新版协议条款。在ZOO修改《协议》条款后，如果用户不接受修改后的条款，请立即停止使用ZOO提供的服务，用户继续使用ZOO提供的服务将被视为已接受了修改后的协议。\n\n"
    let articleTitle1 = "一. 您使用ZOO服务的权利\n"
    let article1 = "您使用ZOO服务的权利为有限范围内可撤销、不可转让和非独家的个人权利。只要您持续遵守本ZOO用户使用协议的条款（以下称“服务条款”）以及本协议中有关的限制条款，则ZOO将向您提供使用ZOO的软件获取在线移动、网络和互联网联接设备服务，使成员能够建立独特的个人ZOO，通过网络与其他社交平台互相连接。 我们预期ZOO的服务逐步将有重大变化，因此ZOO可能通过向您的移动设备或其他计算装置发送更新信息或通过在ZOO网站上公布更新的条款和条件来更新本服务条款的条款和条件。\n"
    let articleTitle2 = "二. 使用规则\n"
    let article2 = """
1、用户充分了解并同意，ZOO仅为用户提供信息分享、传送及获取的平台，用户必须为自己账号下的一切行为负责，包括您所传送的任何内容以及由此产生的任何结果。用户应对ZOO中的内容自行加以判断，并承担因使用内容而引起的所有风险，包括因对内容的正确性、完整性或实用性的依赖而产生的风险。ZOO无法且不会对因用户行为而导致的任何损失或损害承担责任。
 2、用户在ZOO服务中或通过ZOO服务所传送的任何内容并不反映ZOO的观点或政策，ZOO对此不承担任何责任。
 3、用户充分了解并同意，ZOO是一个基于关联图片与图片之间关联的产品，用户须对在ZOO上的注册信息的真实性、合法性、有效性承担全部责任，用户不得冒充他人；不得利用他人的名义传播任何信息；不得恶意使用注册账号导致其他用户误认；否则ZOO有权立即停止提供服务，并由用户独自承担由此而产生的一切法律责任。
 4、用户须对在ZOO上所传送信息的真实性、合法性、无害性、有效性等全权负责，与用户所传播的信息相关的任何法律责任由用户自行承担，与ZOO无关。
 5、用户在浏览ZOO，部分内容包含一些网站链接。ZOO不负责其他网站的隐私政策或惯例。当链接其他网站时，用户应先阅读该网站上的隐私政策。我们的隐私政策只管辖ZOO所收集的信息。
 6、ZOO保留因业务发展需要，单方面对本服务的全部或部分服务内容在任何时候不经任何通知的情况下变更、暂停、限制、终止或撤销ZOO服务的权利，用户需承担此风险。
 7、ZOO提供的服务中可能包括广告，用户同意在使用过程中显示ZOO和第三方供应商、合作伙伴提供的广告。
 8、对于您在ZOO服务上或通过ZOO服务发布的内容，您传送给其他人的任何材料或信息，以及您与其他人的互动，您将承担全部责任。您声明并保证：您在ZOO服务上或通过ZOO服务发布的内容为您所有，或您有权授予本款所述的许可，和(ii)您在ZOO服务上或通过ZOO服务发布内容未侵犯任何人的隐私权、形象权、版权、合同权或任何其他权利。您同意支付因在ZOO服务上或通过ZOO服务发布任何内容而应向任何人支付的版税、费用和任何其他费用。
 9、用户不得用ZOO服务制作、发布，传播如下内容：
 (1) 反对宪法所确定的基本原则的；
 (2) 危害国家安全，泄露国家秘密，颠覆国家政权，破坏国家统一的；
 (3) 损害国家荣誉和利益的；
 (4) 煽动民族仇恨、民族歧视，破坏民族团结的；
 (5) 破坏国家宗教政策，宣扬邪教和封建迷信的；
 (6) 散布谣言，扰乱社会秩序，破坏社会稳定的；
 (7) 散布淫秽、色情、赌博、暴力、凶杀、恐怖或者教唆犯罪的；
 (8) 侮辱或者诽谤他人，侵害他人合法权益的；
 (9) 含有法律、行政法规禁止的其他内容的信息。\n\n
"""
    let articleTitle3 = "三. ZOO服务的所有权\n"
    let article3 = " ZOO提供的ZOO服务及其内容为ZOO及其关联企业以及我们的许可人所有，受商标法、国际公约和其他知识产权法保护，未经授权不得进行复制和传播。“除非ZOO服务中明示说明，ZOO服务中出现的所有产品或服务名称或者标志均为我们的商标或注册商标。未指明一个产品或服务名称或标志的相关商标并不构成对我们对于该等名称或标志的商标或其他知识产权的放弃。\n\n"
    let articleTitle4 = " 四. 隐私保护\n"
    let article4 = " 用户同意个人隐私信息是指那些能够对用户进行个人辨识或涉及个人通信的信息，包括下列信息：用户真实姓名，身份证号，手机号码，IP地址。而非个人隐私信息是指用户对本服务的操作状态以及使用习惯等一些明确且客观反映在ZOO服务器端的基本记录信息和其他一切个人隐私信息范围外的普通信息；以及用户同意公开的上述隐私信息； 尊重用户个人隐私信息的私有性是ZOO的一贯制度，ZOO将会采取合理的措施保护用户的个人隐私信息，除法律或有法律赋予权限的政府部门要求或用户同意等原因外，ZOO未经用户同意不向除合作单位以外的第三方公开、 透露用户个人隐私信息。 但是，用户在注册时选择同意，或用户与ZOO及合作单位之间就用户个人隐私信息公开或使用另有约定的除外，同时用户应自行承担因此可能产生的任何风险，ZOO对此不予负责。同时，为了运营和改善ZOO的技术和服务，ZOO将可能会自行收集使用或向第三方提供用户的非个人隐私信息，这将有助于ZOO向用户提供更好的用户体验和提高ZOO的服务质量。 用户同意，在使用ZOO服务时也同样受ZOO隐私政策的约束。当您接受本协议条款时，您同样认可并接受ZOO隐私政策的条款。志的商标或其他知识产权的放弃\n\n"
    let articleTitle5 = " 五. 法律责任及免责\n"
    let article5 = """
 1、用户违反本《协议》或相关的服务条款的规定，导致或产生的任何第三方主张的任何索赔、要求或损失，包括合理的律师费，用户同意赔偿ZOO与合作公司、关联公司，并使之免受损害。
 2、用户因第三方如电信部门的通讯线路故障、技术问题、网络、电脑故障、系统不稳定性及其他各种不可抗力原因而遭受的一切损失，ZOO及合作单位不承担责任。
 3、因技术故障等不可抗事件影响到服务的正常运行的，ZOO及合作单位承诺在第一时间内与相关单位配合，及时处理进行修复，但用户因此而遭受的一切损失，ZOO及合作单位不承担责任。
 4、本服务同大多数互联网服务一样，受包括但不限于用户原因、网络服务质量、社会环境等因素的差异影响，可能受到各种安全问题的侵扰，如他人利用用户的资料，造成现实生活中的骚扰；用户下载安装的其它软件或访问的其他网站中含有“特洛伊木马”等病毒，威胁到用户的计算机信息和数据的安全，继而影响本服务的正常使用等等。用户应加强信息安全及使用者资料的保护意识，要注意加强密码保护，以免遭致损失和骚扰。
 5、用户须明白，使用本服务因涉及Internet服务，可能会受到各个环节不稳定因素的影响。因此，本服务存在因不可抗力、计算机病毒或黑客攻击、系统不稳定、用户所在位置、用户关机以及其他任何技术、互联网络、通信线路原因等造成的服务中断或不能满足用户要求的风险。用户须承担以上风险，ZOO不作担保。对因此导致用户不能发送和接受阅读信息、或接发错信息，ZOO不承担任何责任。
 6、用户须明白，在使用本服务过程中存在有来自任何他人的包括威胁性的、诽谤性的、令人反感的或非法的内容或行为或对他人权利的侵犯（包括知识产权）的匿名或冒名的信息的风险，用户须承担以上风险，ZOO和合作公司对本服务不作任何类型的担保，不论是明确的或隐含的，包括所有有关信息真实性、适商性、适于某一特定用途、所有权和非侵权性的默示担保和条件，对因此导致任何因用户不正当或非法使用服务产生的直接、间接、偶然、特殊及后续的损害，不承担任何责任。
 7、ZOO定义的信息内容包括：文字、软件、声音、相片、录像、图表；在广告中全部内容；ZOO为用户提供的商业信息，所有这些内容受版权、商标权、和其它知识产权和所有权法律的保护。所以，用户只能在ZOO和广告商授权下才能使用这些内容，而不能擅自复制、修改、编纂这些内容、或创造与内容有关的衍生产品。
 8、在任何情况下，ZOO均不对任何间接性、后果性、惩罚性、偶然性、特殊性或刑罚性的损害，包括因用户使用ZOO服务而遭受的利润损失，承担责任（即使ZOO已被告知该等损失的可能性亦然）。尽管本协议中可能含有相悖的规定，ZOO对您承担的全部责任，无论因何原因或何种行为方式，始终不超过您在成员期内因使用ZOO而支付给ZOO的费用(如有) 。\n\n
"""
    let articleTitle6 = " 六. 其他条款\n"
    let article6 = """
 1、ZOO郑重提醒用户注意本《协议》中免除ZOO责任和加重用户义务的条款，请用户仔细阅读，自主考虑风险。未成年人应在法定监护人的陪同下阅读本《协议》。以上各项条款内容的最终解释权及修改权归ZOO公司所有。
 2、本《协议》所定的任何条款的部分或全部无效者，不影响其它条款的效力。
 3、本《协议》的版权由ZOO所有，ZOO保留一切解释和修改权利。\n
"""
  
    
    
    func PraviteText() -> NSMutableAttributedString {
        
        let titleStr = NSMutableAttributedString(string: PravitetitleName)
        titleStr.yy_font = UIFont.boldSystemFont(ofSize: 24)
        titleStr.yy_color = ColorTitle
        
        let tipsStr = NSMutableAttributedString(string: Pravitetips)
        tipsStr.yy_font = UIFont.pingFangTextFont(size: 14)
        tipsStr.yy_color = ColorDarkGrayTextColor
        //        tipsStr.yy_lineSpacing = 18
        
        let articleTitle1Str = NSMutableAttributedString(string: PravitearticleTitle1)
        articleTitle1Str.yy_font = UIFont.pingFangTextFont(size: 14)
        articleTitle1Str.yy_color = ColorTitle
        let article1Str = NSMutableAttributedString(string: Pravitearticle1)
        article1Str.yy_font = UIFont.pingFangTextFont(size: 14)
        article1Str.yy_color = ColorDarkGrayTextColor
        //        article1Str.yy_lineSpacing = 18
        
        let articleTitle2Str = NSMutableAttributedString(string: PravitearticleTitle2)
        articleTitle2Str.yy_font = UIFont.pingFangTextFont(size: 14)
        articleTitle2Str.yy_color = ColorTitle
        let article2Str = NSMutableAttributedString(string: article2)
        article2Str.yy_font = UIFont.pingFangTextFont(size: 14)
        article2Str.yy_color = ColorDarkGrayTextColor
        //        article2Str.yy_lineSpacing = 18
        
        let articleTitle3Str = NSMutableAttributedString(string: PravitearticleTitle3)
        articleTitle3Str.yy_font = UIFont.pingFangTextFont(size: 14)
        articleTitle3Str.yy_color = ColorTitle
        let article3Str = NSMutableAttributedString(string: Pravitearticle3)
        article3Str.yy_font = UIFont.pingFangTextFont(size: 14)
        article3Str.yy_color = ColorDarkGrayTextColor
        //        article3Str.yy_lineSpacing = 18
        
        let articleTitle4Str = NSMutableAttributedString(string: PravitearticleTitle4)
        articleTitle4Str.yy_font = UIFont.pingFangTextFont(size: 14)
        articleTitle4Str.yy_color = ColorTitle
        let article4Str = NSMutableAttributedString(string: article4)
        article4Str.yy_font = UIFont.pingFangTextFont(size: 14)
        article4Str.yy_color = ColorDarkGrayTextColor
        //        article4Str.yy_lineSpacing = 18
        
        let articleTitle5Str = NSMutableAttributedString(string: PravitearticleTitle5)
        articleTitle5Str.yy_font = UIFont.pingFangTextFont(size: 14)
        articleTitle5Str.yy_color = ColorTitle
        let article5Str = NSMutableAttributedString(string: Pravitearticle5)
        article5Str.yy_font = UIFont.pingFangTextFont(size: 14)
        article5Str.yy_color = ColorDarkGrayTextColor
        //        article5Str.yy_lineSpacing = 18
        
        let articleTitle6Str = NSMutableAttributedString(string: PravitearticleTitle6)
        articleTitle6Str.yy_font = UIFont.pingFangTextFont(size: 14)
        articleTitle6Str.yy_color = ColorTitle
        let article6Str = NSMutableAttributedString(string: Pravitearticle6)
        article6Str.yy_font = UIFont.pingFangTextFont(size: 14)
        article6Str.yy_color = ColorDarkGrayTextColor
        //        article6Str.yy_lineSpacing = 18
        
        let text = NSMutableAttributedString()
        text.append(titleStr)
        text.append(tipsStr)
        text.append(articleTitle1Str)
        text.append(article1Str)
        text.append(articleTitle2Str)
        text.append(article2Str)
        text.append(articleTitle3Str)
        text.append(article3Str)
        text.append(articleTitle4Str)
        text.append(article4Str)
        text.append(articleTitle5Str)
        text.append(article5Str)
        text.append(articleTitle6Str)
        text.append(article6Str)
        return text
    }
    
    
    let PravitetitleName = "ZOO隐私协议\n\n"
    let Pravitetips = "本隐私政策帮助你了解:\n\n本应用尊重并保护所有使用服务用户的个人隐私权。为了给您提供更准确、更有个性化的服务，本应用会按照本隐私权政策的规定使用和披露您的个人信息。但本应用将以高度的勤勉、审慎义务对待这些信息。除本隐私权政策另有规定外，在未征得您事先许可的情况下，本应用不会将这些信息对外披露或向第三方提供。本应用会不时更新本隐私权政策。 您在同意本应用服务使用协议之时，即视为您已经同意本隐私权政策全部内容。本隐私权政策属于本应用服务使用协议不可分割的一部分。\n\n"
    let PravitearticleTitle1 = "一. 适用范围\n\n"
    let Pravitearticle1 = "在您注册本应用帐号时，您根据本应用要求提供的个人注册信息；在您使用本应用网络服务，或访问本应用平台网页时，本应用自动接收并记录的您的浏览器和计算机上的信息，包括但不限于您的IP地址、浏览器的类型、使用的语言、访问日期和时间、软硬件特征信息及您需求的网页记录等数据；本应用通过合法途径从商业伙伴处取得的用户个人数据。您了解并同意，以下信息不适用本隐私权政策：(a) 您在使用本应用平台提供的搜索服务时输入的关键字信息；(b) 本应用收集到的您在本应用发布的有关信息数据，包括但不限于参与活动、成交信息及评价详情；(c) 违反法律规定或违反本应用规则行为及本应用已对您采取的措施。\n\n"
    let PravitearticleTitle2 = "二. 信息使用\n\n"
    let Pravitearticle2 = """
1、本应用不会向任何无关第三方提供、出售、出租、分享或交易您的个人信息，除非事先得到您的许可，或该第三方和本应用（含本应用关联公司）单独或共同为您提供服务，且在该服务结束后，其将被禁止访问包括其以前能够访问的所有这些资料。
 2、本应用亦不允许任何第三方以任何手段收集、编辑、出售或者无偿传播您的个人信息。任何本应用平台用户如从事上述活动，一经发现，本应用有权立即终止与该用户的服务协议。
 3、为服务用户的目的，本应用可能通过使用您的个人信息，向您提供您感兴趣的信息，包括但不限于向您发出产品和服务信息，或者与本应用合作伙伴共享信息以便他们向您发送有关其产品和服务的信息（后者需要您的事先同意）。
 4、在如下情况下，本应用将依据您的个人意愿或法律的规定全部或部分的披露您的个人信息：

    (1) 经您事先同意，向第三方披露；
    (2) 为提供您所要求的产品和服务，而必须和第三方分享您的个人信息；
    (3) 根据法律的有关规定，或者行政或司法机构的要求，向第三方或者行政、司法机构披露；
    (4) 如您出现违反中国有关法律、法规或者本应用服务协议或相关规则的情况，需要向第三方披露；
    (5) 如您是适格的知识产权投诉人并已提起投诉，应被投诉人要求，向被投诉人披露，以便双方处理可能的权利纠纷；
    (6) 在本应用平台上创建的某一交易中，如交易任何一方履行或部分履行了交易义务并提出信息披露请求的，本应用有权决定向该用户提供其交易对方的联络方式等必要信息，以促成交易的完成或纠纷的解决；
    (7) 其它本应用根据法律、法规或者网站政策认为合适的披露。。\n\n
"""
    let PravitearticleTitle3 = "三. 信息存储和交换\n\n"
    let Pravitearticle3 = " 本应用收集的有关您的信息和资料将保存在本应用及（或）其关联公司的服务器上，这些信息和资料可能传送至您所在国家、地区或本应用收集信息和资料所在地的境外并在境外被访问、存储和展示。\n\n"
    let PravitearticleTitle4 = " 四. Cookie的使用\n\n"
    let Pravitearticle4 = " 在您未拒绝接受cookies的情况下，本应用会在您的计算机上设定或取用cookies ，以便您能登录或使用依赖于cookies的本应用平台服务或功能。本应用使用cookies可为您提供更加周到的个性化服务，包括推广服务。您有权选择接受或拒绝接受cookies。您可以通过修改浏览器设置的方式拒绝接受cookies。但如果您选择拒绝接受cookies，则您可能无法登录或使用依赖于cookies的本应用网络服务或功能。通过本应用所设cookies所取得的有关信息，将适用本政策。\n\n"
    let PravitearticleTitle5 = " 五. 信息安全\n\n"
    let Pravitearticle5 = """
 1、本应用帐号均有安全保护功能，请妥善保管您的用户名及密码信息。本应用将通过对用户密码进行加密等安全措施确保您的信息不丢失，不被滥用和变造。尽管有前述安全措施，但同时也请您注意在信息网络上不存在“完善的安全措施”。
 2、在使用本应用网络服务进行网上交易时，您不可避免的要向交易对方或潜在的交易对方披露自己的个人信息，如联络方式或者邮政地址。请您妥善保护自己的个人信息，仅在必要的情形下向他人提供。如您发现自己的个人信息泄密，尤其是本应用用户名及密码发生泄露，请您立即联络本应用客服，以便本应用采取相应措施。
 \n\n
"""
    let PravitearticleTitle6 = " 六. 本隐私政策的更改\n\n"
    let Pravitearticle6 = """
 1、如果决定更改隐私政策，我们会在本政策中、本公司网站中以及我们认为适当的位置发布这些更改，以便您了解我们如何收集、使用您的个人信息，哪些人可以访问这些信息，以及在什么情况下我们会透露这些信息。
 2、本公司保留随时修改本政策的权利，因此请经常查看。如对本政策作出重大更改，本公司会通过网站通知的形式告知。
 3、本《隐私政策协议》的版权由ZOO所有，ZOO保留一切解释和修改权利。\n
"""
    

}


