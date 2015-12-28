//
//  BaseTableViewCell.swift
//  sctong
//
//  Created by   himi on 15/12/28.
//  Copyright © 2015年 mmmm. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /**
     设置展示内容
     
     - parameter tableView: tableView
     - parameter indexPath: indexPath
     - parameter dataList:  dataList
     */
    func setContent(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, dataList:[HMSerializable] ){
        //do something
    }

}
