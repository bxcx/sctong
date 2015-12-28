//
//  HomeController.swift
//  sctong
//
//  Created by   himi on 15/12/19.
//  Copyright © 2015年 mmmm. All rights reserved.
//

import UIKit
import Reindeer
import SnapKit

class HomeController: BaseViewController {
    
    @IBOutlet weak var scrollLayout: UIView!
    
    @IBOutlet weak var circleListLayout: HMTouchView!
    @IBOutlet weak var personListLayout: HMTouchView!
    @IBOutlet weak var priceListLayout: HMTouchView!
    @IBOutlet weak var marketLayout: HMTouchView!
    
    var news:NewsDomain?
    
    override func loadData() {
        //请求地址
        let url = "http://apis.baidu.com/cd_boco/chinanews/testnewsapi"
        //如果需要传参
        let params = ["query":"{'device':'android','catid':1,'pagesize':3,'sid':'11142'}"]
        
        HMRequest<NewsDomain>.get(url, params: params) { (news, error) -> () in
            //请求数据成功后调用
            self.news = news
            self.initUI()
        }
    }
    
    override func initUI() {
        initBanner()
        initLayout()
    }
    
    ///广告位
    func initBanner(){
        
        let anotherBanner = BannerPageViewController()
        var thumbUrls:[AnyObject?] = []
        for data in (news?.data)! {
            thumbUrls.append(data.thumb!)
        }
        anotherBanner.images = thumbUrls
        
        scrollLayout.addSubview(anotherBanner.view)
        anotherBanner.view.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self.scrollLayout)
        }
        
        anotherBanner.interval = 3 //3秒自动切换下一张
        anotherBanner.placeholderImage = UIImage(named: "placeholder") //加载完成前显示的图片
        anotherBanner.setRemoteImageFetche({ (imageView, url, placeHolderImage) -> Void in
            //设置任意图片加载方式
            imageView.kf_setImageWithURL(NSURL(string: url)!, placeholderImage: placeHolderImage)
        })
        anotherBanner.setBannerTapHandler({ (index) -> Void in
            //点击了某一张图片
            print(index)
        })
        
        anotherBanner.startRolling()
        
        
    }
    
    ///商圈、人脉、供应、求购
    func initLayout(){
        HMTouchView.setOnClickHandler([circleListLayout,personListLayout,priceListLayout,marketLayout]) { (id) -> Void in
            print(id)
            
            var vc:UIViewController?
            
            switch(id){
            case "priceListLayout"?:
                vc = PriceListController()
                vc?.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc!, animated: true)
            default:
            
            break;
            }
        }
    }
    
}
