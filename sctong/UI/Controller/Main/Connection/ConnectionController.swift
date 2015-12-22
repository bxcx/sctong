//
//  ConnectionController.swift
//  sctong
//
//  Created by   himi on 15/12/22.
//  Copyright © 2015年 mmmm. All rights reserved.
//

import UIKit

class ConnectionController: UIViewController {

    @IBOutlet weak var layout_new_renmai: HMTouchView!
    @IBOutlet weak var layout_instrastion: HMTouchView!
    
    @IBOutlet weak var layout_my_friend: HMTouchView!
    @IBOutlet weak var layout_my_watch: HMTouchView!
    @IBOutlet weak var layout_my_follow: HMTouchView!
    
    @IBOutlet weak var layout_more_renmai: HMTouchView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        HMTouchView.setOnClickHandler([layout_new_renmai,layout_instrastion,layout_my_friend,layout_my_watch,layout_my_follow,layout_more_renmai]) { (id) -> Void in
            print(id)
        }
    }

}
