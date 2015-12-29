//
//  HMRequest.swift
//  sctong
//
//  Created by   himi on 15/12/22.
//  Copyright © 2015年 mmmm. All rights reserved.
//

import UIKit
import Alamofire
import Haneke

protocol HMConvertible{
    var errNum:Int { get set }
    var errMsg:String? { get set }
    static func convertFromData(data:String!) -> (Self,NSError?)
    
}

class HMRequest< T:HMConvertible> {

    /**
     通用请求方法
     
     - parameter method:            OPTIONS, GET, HEAD, POST, PUT, PATCH, DELETE, TRACE, CONNECT
     - parameter url:               url
     - parameter cache:             是否需要缓存 可选
     - parameter params:            params 可选
     - parameter headers:           headers 可选
     - parameter completionHandler: 回调
     */
    static func go(method: Alamofire.Method, _ url: String, cache: Bool = false, params: [String: AnyObject]? = Dictionary(), headers: [String: String]? = nil, completionHandler:(T?,NSError?) -> ()){
        
        //拼装带参数的URL地址，在控制台输出并根据它设置缓存
        let fullUrl = getFullURL(url, params)
        debugPrint("---------\(method)---------")
        debugPrint(fullUrl)
//        ColorLog.red("---------\(method)---------")
//        ColorLog.green(fullUrl)
        
        if cache {
            let stringCache = Haneke.Shared.stringCache
            stringCache.fetch(key: fullUrl).onSuccess { (value) -> () in
                    print("cache")
                    let(object, converError) = T.convertFromData(value)
                    completionHandler(object, converError)
                }.onFailure { (error) -> () in
                    req(method,url,cache: cache,params: params,headers: headers,completionHandler: completionHandler)
            }
        } else {
            req(method,url,cache: cache,params: params,headers: headers,completionHandler: completionHandler)
        }
        
        
    }
    
    private static func req(method: Alamofire.Method, _ url: String, cache: Bool = false, params: [String: AnyObject]? = Dictionary(), headers: [String: String]? = nil, completionHandler:(T?,NSError?) -> ()){
        
        Alamofire.request(method, url, parameters: params,headers: headers).responseString { response in
            // TODO:对请求失败的封装，待后期完善
            if response.result.isFailure {
                var domain:String?
                switch response.result.error?.domain{
                case NSURLErrorDomain?:
                    domain = "网络不佳"
                default :
                    domain = "未知错误"
                }
                
                let error = NSError(domain: domain!, code: (response.result.error?.code)!, userInfo: nil)
                completionHandler(nil, error)
                return
            }

            debugPrint(response.result.value as String!)
//            ColorLog.cyan(response.result.value as String!)

            let(object, converError) = T.convertFromData(response.result.value)
            if cache && checkResult(object, converError, nil) {
                let stringCache = Haneke.Shared.stringCache
                stringCache.set(value: response.result.value!, key: getFullURL(url,params))
            }
            
            completionHandler(object, converError)
        }
        
    }
    
    private static func getFullURL(url: String, _ params: [String: AnyObject]? = Dictionary()) -> String {
        var fullUrl = ""
        //组装url
        if params?.count > 0{
            var str:String = "?"
            for param in params! {
                str += "\(param.0)=\(param.1)&"
            }
            str = (str as NSString).substringToIndex(str.characters.count-1)
            fullUrl = url + str
        }

        return fullUrl
    }
    
    
    /**
     检查返回数据是否正确
     
     - parameter obj:   result
     - parameter error: error
     
     - returns: true/false
     */
    static func checkResult(obj:HMConvertible? ,_ error:NSError?, _ vc: UIViewController?) -> Bool{
        if error != nil {
            if vc != nil {
//                ColorLog.red(error?.domain)
                vc?.showError(error?.domain)
            }
            return false
        }
        if obj?.errNum != 0 {
            if vc != nil {
//                ColorLog.red(obj?.errMsg)
                vc?.showError(obj?.errMsg)
            }
            return false
        }
        
        return true
    }
    
    
}