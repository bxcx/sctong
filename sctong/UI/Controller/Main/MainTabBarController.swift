//
//  MainTabBarController.swift
//  sctong
//
//  Created by   himi on 15/12/19.
//  Copyright © 2015年 mmmm. All rights reserved.
//

import UIKit

class MainTabBarController: CYLTabBarController  {
    
    //以后新项目开发的话，只需要修改这4个集合里的内容即可
    
    //StoryBoard的名称
    let StoryName = ["Home","Connection","Message","Personal"]
    //标题
    let Title = ["首页","人脉","消息","我的"]
    //选中时的图片
    let SelectedImage = ["tab_5th_h","tab_2nd_h","tab_4th_h","tab_3rd_h"]
    //未选中时的图片
    let Image = ["tab_5th_n","tab_2nd_n","tab_4th_n","tab_3rd_n"]
    
    /**
     经过我再次封装，这个方法可以直接不需要理会，后面我们继续扩展，以后就不需要再写viewDidLoad的方法了
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var tabBarItemsAttributes: [AnyObject] = []
        var viewControllers:[AnyObject] = []
        
        for i in 0 ... Title.count - 1 {
            let dict: [NSObject : AnyObject] = [
                CYLTabBarItemTitle: Title[i],
                CYLTabBarItemImage: Image[i],
                CYLTabBarItemSelectedImage: SelectedImage[i]
            ]
            let vc = UIStoryboard(name: StoryName[i], bundle: nil).instantiateInitialViewController()
            
            tabBarItemsAttributes.append(dict)
            viewControllers.append(vc!)
        }
        
        self.tabBarItemsAttributes = tabBarItemsAttributes
        self.viewControllers = viewControllers
    }
    
}

class PlusButtonSubclass : CYLPlusButton,CYLPlusButtonSubclassing{
    
    class func plusButton() -> AnyObject! {
        let button:PlusButtonSubclass =  PlusButtonSubclass()
        button.setImage(UIImage(named: "icon_middle_add"), forState: UIControlState.Normal)
        button.titleLabel!.textAlignment = NSTextAlignment.Center;
        button.adjustsImageWhenHighlighted = false;
        button.addTarget(button, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        
        return  button
    }
    
    //点击事件
    func buttonClicked(sender:CYLPlusButton)
    {
        print("hello mm")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 控件大小,间距大小
        let imageViewEdge   = self.bounds.size.width * 0.6;
        let centerOfView    = self.bounds.size.width * 0.5;
        let labelLineHeight = self.titleLabel!.font.lineHeight;
        //        let verticalMarginT = self.bounds.size.height - labelLineHeight - imageViewEdge;
        //        let verticalMargin  = verticalMarginT / 2;
        
        // imageView 和 titleLabel 中心的 Y 值
        //        _  = verticalMargin + imageViewEdge * 0.5;
        let centerOfTitleLabel = imageViewEdge  + labelLineHeight + 2;
        
        //imageView position 位置
        self.imageView!.bounds = CGRectMake(0, 0, 36, 36);
        self.imageView!.center = CGPointMake(centerOfView, 0)//centerOfImageView * 2 );
        
        //title position 位置
        self.titleLabel!.bounds = CGRectMake(0, 0, self.bounds.size.width, labelLineHeight);
        self.titleLabel!.center = CGPointMake(centerOfView, centerOfTitleLabel);
    }
}
