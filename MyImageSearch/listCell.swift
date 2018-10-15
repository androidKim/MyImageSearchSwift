//
//  Cell.swift
//  MyImageSearch
//
//  Created by taejun on 2018. 10. 12..
//  Copyright © 2018년 midas. All rights reserved.
//

import UIKit

class listCell: UITableViewCell
{
    @IBOutlet weak var cellView:UIView!
    @IBOutlet weak var lb_Title: UILabel!
    @IBOutlet weak var iv_Main: UIImageView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    //
    override func prepareForReuse()
    {
        super.prepareForReuse()
        self.iv_Main.image = nil
    }
}
