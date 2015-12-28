//
//  PriceListController.swift
//  sctong
//
//  Created by   himi on 15/12/28.
//  Copyright © 2015年 mmmm. All rights reserved.
//

import UIKit

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
        
        HMRequest<PriceDomain>.get(url, params: params) { (price, error) -> () in
            //需要对数据正确性进行判断，演示时我省略了这一步
            //请求数据成功后调用
            if self.action == LoadAction.loadNew {
                self.dataList.removeAll()
            }
            
            for data in (price?.data?.deals)! {
                self.dataList.append(data)
            }

            self.loadCompleted()
        }
    }
}
