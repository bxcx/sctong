//
//  NewsDomain.swift
//  sctong
//
//  Created by   himi on 15/12/22.
//  Copyright © 2015年 mmmm. All rights reserved.
//

import Foundation

struct NewsDomain: HMSerializable ,HMConvertible{

    var errNum: Int = 0
    
    var errMsg: String?
    
    var data: [NewsData]?
    
    static func convertFromData(data: String!) -> (NewsDomain, NSError?) {
        var hm : NewsDomain?
        hm <-- data
        return (hm!,nil)
    }
    
    init(data: [String: AnyObject]) {
        errNum <-- data["errNum"]
        errMsg <-- data["errMsg"]
        self.data <-- data["data"]
    }
    
    //对应data字段，而且可以只取我们需要的字段，不需要全部解析
    struct NewsData: HMSerializable {
        var link: String? //点击跳转的url
        var thumb: String? //缩略图地址
        
        init(data: [String: AnyObject]) {
            link <-- data["link"]
            thumb <-- data["thumb"]
        }
    }
}
