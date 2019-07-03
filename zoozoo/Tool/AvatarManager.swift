//
//  AvatarManager.swift
//  zoozoo
//
//  Created by 你猜 on 2019/5/28.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit
import Photos
import AVFoundation
import CropViewController
import Qiniu

///系统版本号
let SystemVersion = (UIDevice.current.systemVersion as NSString).doubleValue

class AvatarManager: NSObject {

    static let sharedManager = AvatarManager()
    
    fileprivate var parentViewController: UIViewController!
    
    var completionBlock: ((_ imageUrl: String) -> Void)?
  
    let uploadManage = QNUploadManager()
    var option : QNUploadOption!
    ///UIImagePickerController对象
    lazy var imagePicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.delegate = AvatarManager.sharedManager
        return picker
    }()
    
    ///创建相册、拍照选择弹框
    func showWith(parentViewController: UIViewController, completion: @escaping ((_ imageUrl: String) -> Void)) {
        self.parentViewController = parentViewController
        completionBlock = completion
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIDevice.isIpad() ? .alert : .actionSheet)
        alert.addAction(UIAlertAction(title: "拍照", style: .default, handler: { (cancelAction) in
            self.takePhoto()
        }))
        alert.addAction(UIAlertAction(title: "手机相册", style: .default, handler: { (confirmAction) in
            self.openPhotoLibrary()
        }))
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        parentViewController.present(alert, animated: true, completion: nil)
    }
    
    ///打开相册
    func openPhotoLibrary() {
        photoLibraryAuthorizationStatus()
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            imagePicker.delegate = self
            imagePicker.navigationBar.isTranslucent = false
            parentViewController.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    ///拍照
    func takePhoto() {
        cameraAuthorizationStatus()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            parentViewController.present(imagePicker, animated: true, completion: nil)
        } else {
            ShowMessageTool.shared.showMessage("该手机不支持")
        }
    }
    
    ///相册访问权限
    func photoLibraryAuthorizationStatus() {
        if SystemVersion < 11 {
            let status = PHPhotoLibrary.authorizationStatus()
            if status == .restricted || status == .denied {
                //无权限
                //提示前往授权
                statusAlertWith(message: "请打开设置-隐私-照片以允许访问设备相册") {
                    if UIApplication.shared.canOpenURL(URL(string: UIApplication.openSettingsURLString)!) {
                        UIApplication.shared.openURL(URL(string: UIApplication.openSettingsURLString)!)
                    }
                }
                return
            }
        }
    }
    
    ///相机访问权限
    func cameraAuthorizationStatus() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        if status == .restricted || status == .denied {
            //无权限
            //提示前往授权
            statusAlertWith(message: "请打开设置-隐私-照片以允许访问设备相机") {
                if UIApplication.shared.canOpenURL(URL(string: UIApplication.openSettingsURLString)!) {
                    UIApplication.shared.openURL(URL(string: UIApplication.openSettingsURLString)!)
                }
            }
            return
        }
    }
    
    func statusAlertWith(message: String?, completion: @escaping (() -> Void)) {
        let alert = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "前往设置", style: .default, handler: { (confirmAction) in
            completion()
        }))
        parentViewController.present(alert, animated: true, completion: nil)
    }
    
}

extension AvatarManager: UINavigationControllerDelegate, UIImagePickerControllerDelegate ,CropViewControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage) else { return }
        
        let cropController = CropViewController(croppingStyle: .default, image: image)
        cropController.delegate = self
        cropController.resetButtonHidden = true
        cropController.rotateButtonsHidden = true
        cropController.aspectRatioPickerButtonHidden = true
        cropController.aspectRatioLockDimensionSwapEnabled = true
        cropController.aspectRatioLockEnabled = true
        cropController.toolbar.cancelTextButton.setTitleColor(UIColor.white, for: .normal)
        cropController.toolbar.doneTextButton.setTitleColor(UIColor.white, for: .normal)
        
        cropController.aspectRatioPreset = CropViewControllerAspectRatioPreset.presetSquare
        picker.pushViewController(cropController, animated: true)
        
        
       
    }
    
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        self.GetAPPQiNiuTokenUpImage(img: image)
        parentViewController.dismiss(animated: true, completion: nil)
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - QiNiuToken
    // MARK: - 上传DIY形象图片
    func GetAPPQiNiuTokenUpImage(img :UIImage){
        let urlStr = BaseUrlPath + RequestGetPublicTokenUrl
        
        HttpTool.getRequest(urlPath: urlStr, parameters: nil, success: { (json) in
           
            let code = json["code"] as? Int
            if code == 200 {
                if let Token = json["data"] as? String{
                    let Imagekey = GlobalDataStore.shared.currentUser.uid + UUID().uuidString + ".png"
                    self.uploadManage?.put(img.pngData(), key: Imagekey, token:Token, complete: { (info, key, resp) in
                        if info?.statusCode == 200 {
                            
                            let imageURL = "\(BaseImageURL)\(key ?? "")"
                           
                            if self.completionBlock != nil {
                                self.completionBlock!(imageURL)
                            }
                            ShowMessageTool.shared.showMessage("头像上传成功")
                        }else{
                            ShowMessageTool.shared.showMessage("头像上传失败")
                        }
                    }, option: self.option)
                }
                
            }else{
                ShowMessageTool.shared.showMessage("头像上传失败")
            }
        }) { (error) in
            ShowMessageTool.shared.showMessage("头像上传失败")
        }
        
        
    }
}

extension UIDevice {
    ///判断iPad设备
    class func isIpad() -> Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    ///判断iPhone设备
    class func isIphone() -> Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    
}
