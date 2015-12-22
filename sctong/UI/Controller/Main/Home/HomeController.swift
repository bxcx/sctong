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

class HomeController: UIViewController {

    @IBOutlet weak var scrollLayout: UIView!
    
    @IBOutlet weak var circleListLayout: HMTouchView!
    @IBOutlet weak var personListLayout: HMTouchView!
    @IBOutlet weak var priceListLayout: HMTouchView!
    @IBOutlet weak var marketLayout: HMTouchView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.extendedLayoutIncludesOpaqueBars = false
        self.edgesForExtendedLayout = UIRectEdge.None
        
        initBanner()
        initLayout()
    }

    ///广告位
    func initBanner(){

        let anotherBanner = BannerPageViewController()
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
        
        //请求地址
        let url = "http://apis.baidu.com/cd_boco/chinanews/testnewsapi"
        //如果需要传参
        let params = ["query":"{'device':'android','catid':1,'pagesize':3,'sid':'11142'}"]
        
        HMRequest<NewsDomain>.get(url, params: params) { (news, error) -> () in
            print(news)
            
            var thumbUrls:[AnyObject?] = []
            for data in (news?.data)! {
                thumbUrls.append(data.thumb!)
            }
            
            anotherBanner.images = thumbUrls
            anotherBanner.startRolling()
        }
        

    }
    
    func initLayout(){
        HMTouchView.setOnClickHandler([circleListLayout,personListLayout,priceListLayout,marketLayout]) { (id) -> Void in
            print(id)
        }
//        circleListLayout.click { (id) -> Void in
//            print("hello")
//        }
//        personListLayout.click { (id) -> Void in
//            print("hello")
//        }
//        priceListLayout.click { (id) -> Void in
//            print("hello")
//        }
//        marketLayout.click { (id) -> Void in
//            print("hello")
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
