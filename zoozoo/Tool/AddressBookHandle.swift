//
//  AddressBookHandle.swift
//  zoozoo
//
//  Created by 🍎上的豌豆 on 2019/6/16.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit

import Contacts

public class AddressBookModel {
    
    
    
    /// 联系人姓名
    public var userName: String = ""
    
    /// 联系人电话数组,一个联系人可能存储多个号码
    public var cellphone: String = ""
    
    /// 联系人头像
    public var headerImage: UIImage = UIImage.init()
    
}

/// 一个联系人信息模型的闭包
public typealias AddressBookModelClosure = (_ model: AddressBookModel)->()
/// 授权失败的闭包
public typealias AuthorizationFailure = ()->()

class AddressBookHandle: NSObject {
  
    
    func getAddressBookDataSource(addressBookModel success: AddressBookModelClosure, authorizationFailure failure: AuthorizationFailure) {
        
        // 1.获取授权状态
        let status = CNContactStore.authorizationStatus(for: CNEntityType.contacts)
        // 2.如果没有授权,先执行授权失败的闭包后return
        if status != CNAuthorizationStatus.authorized {
            failure()
            return
        }
        
        // 3.获取联系人
        // 3.1.创建联系人仓库
        let store = CNContactStore.init()
        
        // 3.2.创建联系人的请求对象
        // keys决定能获取联系人哪些信息,例:姓名,电话,头像等
        let fetchKeys = [CNContactFormatter.descriptorForRequiredKeys(for: CNContactFormatterStyle.fullName),CNContactPhoneNumbersKey,CNContactThumbnailImageDataKey] as [Any]
        let fetchRequest = CNContactFetchRequest.init(keysToFetch: fetchKeys as! [CNKeyDescriptor]);
        
        // 3.请求获取联系人
        var contacts = [CNContact]()
        do {
            try store.enumerateContacts(with: fetchRequest, usingBlock: { ( contact, stop) -> Void in
                contacts.append(contact)
            })
            
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
        // 3.1遍历联系人
        for contact in contacts {
             let model = AddressBookModel()
            // 遍历一个人的所有电话号码
            for labelValue in contact.phoneNumbers {
               
                // 获取联系人全名
                model.userName = CNContactFormatter.string(from: contact, style: CNContactFormatterStyle.fullName) ?? "无名氏"
                let phoneNumber = labelValue.value
                
                model.cellphone = phoneNumber.stringValue.replacingOccurrences(of: "-", with: "")
                model.cellphone = model.cellphone.replacingOccurrences(of: " ", with: "")
               
                // 将联系人模型回调出去
                
                success(model)
                
            }
            
        }
        
    }
    
    
}
