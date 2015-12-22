//
//  PersonalController.swift
//  sctong
//
//  Created by   himi on 15/12/22.
//  Copyright © 2015年 mmmm. All rights reserved.
//

import UIKit

class PersonalController: UITableViewController {

    @IBOutlet weak var layout_collection: HMTouchView!
    @IBOutlet weak var layout_business: HMTouchView!
    @IBOutlet weak var layout_active: HMTouchView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //即可去掉顶部间隙
        self.tableView.tableHeaderView = UIView(frame:CGRectMake(0, 0, 0, 0.5))
        
        //增加点击效果
        HMTouchView.setOnClickHandler([layout_collection,layout_business,layout_active]) { (id) -> Void in
            print(id)
        }
    }

}
