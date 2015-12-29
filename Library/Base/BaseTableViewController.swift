//
//  BaseTableViewController.swift
//  sctong
//
//  Created by   himi on 15/12/28.
//  Copyright © 2015年 mmmm. All rights reserved.
//

import UIKit
import XWSwiftRefresh

enum LoadAction{
    case loadNew
    case LoadMore
}

class BaseTableViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    /// 默认的CellIdentifier
    var identifier:String = "Cell"
    
    /// 默认行高
    var heightForRowAtIndexPath:CGFloat = 100
    
    var tableView:UITableView!
    
    /// 动作标识
    var action:LoadAction = .loadNew
    
    /// 当前页，如果后台是从0开始那这里就修改为0
    var page:Int = 1
    
    /// 每页加载多少条
    var pageSize:Int = 10
    
    /// 数据源集合
    var dataList:[HMSerializable] = []
    
    override func viewDidLoad() {
        //如果布局中没有tableView，则默认通过代码创建一个全屏的tableView
        if tableView == nil {
            tableView =  UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - (self.navigationController?.navigationBar.frame.height)! - UIApplication.sharedApplication().statusBarFrame.height), style: UITableViewStyle.Plain)
            self.view.addSubview(tableView)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        super.viewDidLoad()
    }
    
    /**
     初始化TableView配置
     
     - parameter nibName:                 自定义Cell的文件名
     - parameter heightForRowAtIndexPath: 行高
     - parameter canLoadRefresh:          是否支持下拉刷新
     - parameter canLoadMore:             是否支持上拉加载

     */
    func initWithParams(nibName:String, heightForRowAtIndexPath:CGFloat, canLoadRefresh:Bool, canLoadMore:Bool){
        
        tableView.registerNib(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier:identifier)
        
        self.heightForRowAtIndexPath = heightForRowAtIndexPath
        
        if canLoadRefresh {
            //添加下拉刷新
            tableView.headerView = XWRefreshNormalHeader(target: self, action: "loadRefresh")
        }
        
        if canLoadMore {
            //添加上拉加载
            tableView.footerView = XWRefreshAutoNormalFooter(target: self, action: "loadMore")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return heightForRowAtIndexPath
    }


     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! BaseTableViewCell

        cell.setContent(tableView, cellForRowAtIndexPath: indexPath, dataList: dataList)

        return cell
    }
    
    /**
     执行刷新
     */
    func loadRefresh(){
        action = .loadNew
        page = 1
        loadData()
    }
    
    /**
     执行加载更多
     */
    func loadMore(){
        action = .LoadMore
        page++
        loadData()
    }
    
    /**
     加载完成
     */
    func loadCompleted(){
        if action == .loadNew {
            tableView.headerView?.endRefreshing()
        } else {
            tableView.footerView?.endRefreshing()
        }
        tableView.reloadData()
    }

}
