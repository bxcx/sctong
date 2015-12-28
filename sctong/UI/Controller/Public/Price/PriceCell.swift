//
//  PriceCell.swift
//  sctong
//
//  Created by   himi on 15/12/28.
//  Copyright © 2015年 mmmm. All rights reserved.
//

import UIKit

class PriceCell: BaseTableViewCell {

    @IBOutlet weak var iv_Photo: UIImageView!
    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var lbl_Desc: UILabel!
    
    override func setContent(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, dataList:[HMSerializable] ){
        let data = dataList[indexPath.row] as! PriceDomain.PriceData.PriceDeal
        lbl_Title.text = data.title
        lbl_Desc.text = data.description
        iv_Photo.kf_setImageWithURL(NSURL(string: data.image!)!)
    }

}
