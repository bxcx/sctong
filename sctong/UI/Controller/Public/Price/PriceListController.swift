//
//  PriceListController.swift
//  sctong
//
//  Created by   himi on 15/12/28.
//  Copyright © 2015年 mmmm. All rights reserved.
//

import UIKit
import Haneke
import Alamofire

class PriceListController: BaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initWithParams("PriceCell", heightForRowAtIndexPath: 70, canLoadRefresh: true, canLoadMore: true)
    }
    
    override func loadData() {
        //请求地址 借用百度糯米来演示一下
        let url = "http://apis.baidu.com/baidunuomi/openapi/searchdeals"
        
        var params:[String:AnyObject] = Dictionary()
        params.updateValue("800010000", forKey: "city_id")//城市ID 成都
        params.updateValue("\(page)", forKey: "page")
        params.updateValue("\(pageSize)", forKey: "page_size")
        
        let headers = ["apikey":"be910c69ec688ba099d0091e19c21033"]
        
        HMRequest<PriceDomain>.go(.GET,url, cache: true, params: params, headers:headers ) { (price, error) -> () in
            
            if HMRequest<PriceDomain>.checkResult(price, error, self) {
                //请求数据成功后调用
                if self.action == LoadAction.loadNew {
                    self.dataList.removeAll()
                }
                
                for data in (price?.data?.deals)! {
                    self.dataList.append(data)
                }
            } else {
                self.page--
            }
            
            self.loadCompleted()
        }
    }
}
