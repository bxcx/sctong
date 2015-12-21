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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.extendedLayoutIncludesOpaqueBars = false
        self.edgesForExtendedLayout = UIRectEdge.None
        
        initBanner()
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
        
        anotherBanner.images = [
            "http://pic9.nipic.com/20100817/4845745_124224113296_2.jpg",
            "http://pic26.nipic.com/20121223/11613623_164837493315_2.jpg",
            "http://pic2.ooopic.com/10/79/67/75b1OOOPIC15.jpg"
        ]
        
        anotherBanner.startRolling()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
