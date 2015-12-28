//
//  PriceDomain.swift
//  sctong
//
//  Created by   himi on 15/12/28.
//  Copyright © 2015年 mmmm. All rights reserved.
//

import Foundation

struct PriceDomain: HMSerializable ,HMConvertible{
    
    var error: Int = 0
    
    var msg: Int = 0
    
    var data: PriceData?
    
    static func convertFromData(data: String!) -> (PriceDomain, NSError?) {
        var hm : PriceDomain?
        hm <-- data
        return (hm!,nil)
    }
    
    init(data: [String: AnyObject]) {
        error <-- data["error"]
        msg <-- data["msg"]
        self.data <-- data["data"]
    }
    
    struct PriceData: HMSerializable {
        var total: String? //点击跳转的url
        var deals: [PriceDeal]? //缩略图地址
        
        init(data: [String: AnyObject]) {
            total <-- data["total"]
            deals <-- data["deals"]
        }
        
        //可以只取我们需要的字段，不需要全部解析
        struct PriceDeal: HMSerializable {
            var image: String?
            var title: String?
            var description: String?
            
            init(data: [String: AnyObject]) {
                image <-- data["image"]
                title <-- data["title"]
                description <-- data["description"]
            }
        }
    }
    
}