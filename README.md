# sctong
xcode7.2 &amp; swift2.1.1

MainTabBarController中的PlusButtonSubclass需要再添加如下代码：
    class func plusButton() -> AnyObject! {
        let button:PlusButtonSubclass =  PlusButtonSubclass()
        button.setImage(UIImage(named: "icon_middle_add"), forState: UIControlState.Normal)
        button.titleLabel!.textAlignment = NSTextAlignment.Center;
        button.adjustsImageWhenHighlighted = false;
        button.addTarget(button, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        
        //修改下按钮的大小
        button.frame.size.width = 50;
        button.frame.size.height = 50;
        
        return  button
    }
    不然点击事件无法响应。
