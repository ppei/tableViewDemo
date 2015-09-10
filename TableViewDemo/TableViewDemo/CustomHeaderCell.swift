//
//  CustomHeaderCell.swift
//  TableViewDemo
//
//  Created by Pei Pei on 2015-09-08.
//  Copyright (c) 2015 Pei Pei. All rights reserved.
//

import UIKit

class CustomHeaderCell: UITableViewCell {


    @IBOutlet weak var headerLabel: UILabel!
   
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //self.tableView.rowHeight = 44.0

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
