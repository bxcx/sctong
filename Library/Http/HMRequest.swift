//
//  HMRequest.swift
//  sctong
//
//  Created by   himi on 15/12/22.
//  Copyright © 2015年 mmmm. All rights reserved.
//

import Alamofire

protocol HMConvertible{
    var error:Int { get set }
    var msg:Int { get set }
    static func convertFromData(data:String!) -> (Self,NSError?)
    
}

class HMRequest< T:HMConvertible> {
    
    static func get(url :String, completionHandler:(T?,NSError!) -> ()){
        Alamofire.request(.GET, url).responseString { response in
            let(object, converError) = T.convertFromData(response.result.value)
            completionHandler(object, converError)
        }
    }
    
    static func get(url :String ,params: [String : AnyObject]?, completionHandler:(T?,NSError!) -> ()){
        let headers = ["apikey":"be910c69ec688ba099d0091e19c21033"]
        Alamofire.request(.GET, url, parameters: params, headers:headers).responseString { response in
            let(object, converError) = T.convertFromData(response.result.value)
            completionHandler(object, converError)
        }
    }
    
    static func post(url :String , completionHandler:(T?,NSError?) -> ()){
        post(url, params: Dictionary(), completionHandler: completionHandler)
    }
    
    static func post(url :String , params: Dictionary<String,AnyObject>, completionHandler:(T?,NSError?) -> ()){
        
        //组装log
        if params.count > 0{
            var str:String = "?"
            for param in params {
                str += "\(param.0)=\(param.1)&"
            }
            str = (str as NSString).substringToIndex(str.characters.count-1)
            debugPrint("--------------------post--------------------")
            debugPrint("\(url)\(str)")
        }

        Alamofire.request(.POST, url, parameters: params).responseString { response in
            debugPrint("result:\(response.result.value)")
            
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
            
            let(object, converError) = T.convertFromData(response.result.value)
            completionHandler(object, converError)
        }
    }
    
}