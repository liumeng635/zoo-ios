//
//  HttpTool.swift
//  zoozoo
//
//  Created by 苹果上的豌豆 on 2019/5/15.
//  Copyright © 2019 YiNain. All rights reserved.
//

import UIKit
import Alamofire



let NetworkStatesChangeNotification:String = "NetworkStatesChangeNotification"

typealias UploadProgress = (_ percent:CGFloat) -> Void
typealias HttpSuccess = (_ data:[String:Any]) -> Void
typealias HttpFailure = (_ error:NSError) -> Void

class HttpTool: NSObject {
    private static let reachabilityManager = { () -> NetworkReachabilityManager in
        let manager = NetworkReachabilityManager.init()
        return manager!
    }()
    
    private static let sessionManager = { () -> SessionManager in
        let manager = SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 10
        return manager
    }()
    
    static var defaultHeaders: [String: String] {
        return [
            "Authorization": GlobalDataStore.shared.currentUser.key,
            "version": CurrentVersion,
            "source": SOURCE,
            "imei": BaseConfig.shared.UDID,
            "deviceInfo": BaseConfig.shared.Device,
            "Content-Type": "application/json"
        ]
    }
    
}
extension HttpTool {
    static func loginReload(data:[String:Any]){
        
        let code:Int = data["code"] as! Int
        if(code == 501) {
            ShowMessageTool.shared.showMessage("登录失效，请重新登录")
            GlobalDataStore.shared.currentUser.uid = "0"
             GlobalDataStore.shared.currentUser.isLogin = 0
            GlobalDataStore.shared.currentUser.saveToLocal()
            BaseEngine.shared.goHomeVC()    
        }
        
    }
    
    static func GetLocalJsonData(JsonPath:String, success:@escaping HttpSuccess, failure:@escaping HttpFailure) {
        let path = Bundle.main.path(forResource: JsonPath, ofType: "json")
        let url = URL(fileURLWithPath: path ?? "")
        // 带throws的方法需要抛异常
        do {
          
            let json = try Data(contentsOf: url)
            let jsonData:Any = try JSONSerialization.jsonObject(with: json, options: JSONSerialization.ReadingOptions.mutableContainers)
            if  let jsonData = jsonData as? [String:Any]{
                success(jsonData)
                
            }
            
            
        } catch let error as Error? {
            
            failure(error! as NSError)
        }
        
    }
   
    
    //MARK:-  get 请求
    static func getRequest(urlPath:String,  parameters : [String:Any]?, success:@escaping HttpSuccess, failure:@escaping HttpFailure) {
        let contentTypes: Set = ["application/json", "text/json", "text/plain","text/html", "text/javascript"]

        sessionManager.request(urlPath, method: HTTPMethod.get, parameters: parameters, encoding: URLEncoding.default, headers: self.defaultHeaders)
            .validate(contentType: contentTypes)
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success:
                    let data:[String:Any] = response.result.value as! [String:Any]
                    self.loginReload(data: data)
                   ZLog(data)
                   
                   success(data)
                    break
                case .failure(let error):
                    ZLog(error)
                    let err:NSError = error as NSError
                    failure(err)
                    
                }
            })
    }
    //MARK:-  post请求  from 表单
    static func postRequest(urlPath:String,  parameters : [String:Any]?, success:@escaping HttpSuccess, failure:@escaping HttpFailure) {
        let contentTypes: Set = ["application/json", "text/json", "text/plain","text/html", "text/javascript"]
        sessionManager.request(urlPath, method: HTTPMethod.post, parameters: parameters, encoding: URLEncoding.queryString, headers: self.defaultHeaders)
            .validate(contentType: contentTypes)
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success:
                    let data:[String:Any] = response.result.value as! [String:Any]
                    self.loginReload(data: data)
                    ZLog(data)
                    success(data)
                    break
                case .failure(let error):
                    ZLog(error)
                    let err:NSError = error as NSError
                    failure(err)
                    
                }
            })
    }
    
    

    
    //MARK:-  post请求
    static func postBodyRequest(urlPath:String,  parameters : [String:Any]?, success:@escaping HttpSuccess, failure:@escaping HttpFailure) {
        let contentTypes: Set = ["application/json"]
        sessionManager.request(urlPath, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: self.defaultHeaders)
            .validate(contentType: contentTypes)
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success:
                    let data:[String:Any] = response.result.value as! [String:Any]
                    self.loginReload(data: data)
                    ZLog(data)
                    success(data)
                    break
                case .failure(let error):
                    ZLog(error)
                    let err:NSError = error as NSError
                    failure(err)

                }
            })
    }

    
    //MARK:-  公共请求
    static func PublicRequest(urlPath:String, method: HTTPMethod = .put, parameters : [String:Any]?, success:@escaping HttpSuccess, failure:@escaping HttpFailure) {
        let contentTypes: Set = ["application/json", "text/json", "text/plain","text/html", "text/javascript"]
        sessionManager.request(urlPath, method: method, parameters: parameters, encoding: URLEncoding.queryString, headers: self.defaultHeaders)
            .validate(contentType:  contentTypes)
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success:
                    let data:[String:Any] = response.result.value as! [String:Any]
                    self.loginReload(data: data)
                    success(data)
                    break
                case .failure(let error):
                    ZLog(error)
                    let err:NSError = error as NSError
                    failure(err)
                    
                }
            })
    }
    
}
//Reachability Extension
extension HttpTool {
    static func startMonitoring() {
        reachabilityManager.startListening()
        reachabilityManager.listener = { status in
            NotificationCenter.default.post(name:Notification.Name(rawValue: NetworkStatesChangeNotification), object: status)
        }
    }
    
    static func networkStatus() ->NetworkReachabilityManager.NetworkReachabilityStatus {
        return reachabilityManager.networkReachabilityStatus
    }
    
    static func isNotReachableStatus(status:Any?) -> Bool {
        let netStatus = status as! NetworkReachabilityManager.NetworkReachabilityStatus
        return netStatus == .notReachable
    }
}

