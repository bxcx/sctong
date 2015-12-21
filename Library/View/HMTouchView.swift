//
//  HMTouchView.swift
//  sctong
//
//  Created by   himi on 15/12/21.
//  Copyright © 2015年 mmmm. All rights reserved.
//

import UIKit

class HMTouchView: UIView {
    
    /// 点击回调
    private var clickhandler:((id:String?) -> Void)?
    /// 原本背景色
    private var originalColor:UIColor?
    
    /**
     为View添加点击事件，id即StoryBroad中设置的Restoration ID
     
     - parameter handler: 点击后触发的回调
     */
    func click(handler:((id:String?) -> Void)? ){
        originalColor = self.backgroundColor
        if handler != nil {
            self.clickhandler = handler
            //为View添加手势，触发clickAction
            let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "clickAction")
            self.addGestureRecognizer(tapGesture)
        }
    }
    
    func clickAction(){
        //执行一个改变背景的动画，你甚至可以做一个比较酷炫的翻转、旋转、放大缩小等
        UIView.animateWithDuration(0.3, delay:0.01,
            options:UIViewAnimationOptions.TransitionNone, animations:
            {
                ()-> Void in
                //self.layer.setAffineTransform(CGAffineTransformMakeRotation(90)) //旋转
                //这里我们只做一个普通的变色效果
                self.backgroundColor = UIColor(red:227/255.0, green:227/255.0, blue:227/255.0, alpha:1.0)
            },
            completion:{
                (finished:Bool) -> Void in
                UIView.animateWithDuration(0.3, animations:{
                    ()-> Void in
                    //self.layer.setAffineTransform(CGAffineTransformIdentity) //恢复
                    //恢复为原本的颜色
                    self.backgroundColor = self.originalColor
                    //动画结束，执行回调
                    self.clickhandler?(id:(self.restorationIdentifier))
                })
        })
    }
    
    /**
     一次性为多个View设置点击事件
     
     - parameter views:   view集合
     - parameter handler: 回调
     */
    class func setOnClickHandler(views:[HMTouchView]?, handler:((id:String?) -> Void)? ){
        for view in views! {
            view.click(handler)
        }
    }
    
}
