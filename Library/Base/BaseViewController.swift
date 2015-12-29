//
//  BaseViewController.swift
//  sctong
//
//  Created by   himi on 15/12/28.
//  Copyright © 2015年 mmmm. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.extendedLayoutIncludesOpaqueBars = false
        self.edgesForExtendedLayout = UIRectEdge.None
        
        if checkParams() {
            loadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    /**
     检查调用本类必需传递的参数条件是否满足
     默认返回true，在需要的类中重写此方法即可
     
     - returns: true为满足
     */
    func checkParams() -> Bool {
        return true
    }
    
    /**
     加载数据，请求接口或者读取本地
     子类可不重写，默认调用初始化界面方法
     */
    func loadData(){
        initUI()
    }
    
    /**
     初始化界面，在这里可以分为几个方法函数来调用
     */
    func initUI(){}
    
    
//    /**
//     检查返回数据是否正确
//     
//     - parameter obj:   result
//     - parameter error: error
//     
//     - returns: true/false
//     */
//    func checkResult(obj:HMConvertible? ,_ error:NSError?) -> Bool{
//        if error != nil {
//            showError(error?.description)
//            return false
//        }
//        if obj?.errNum != 0 {
//            showError(obj?.errMsg)
//            return false
//        }
//        
//        return true
//    }
    
}
