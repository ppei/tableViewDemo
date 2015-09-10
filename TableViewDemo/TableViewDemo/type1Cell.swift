//
//  type1Cell.swift
//  TableViewDemo
//
//  Created by Pei Pei on 2015-09-08.
//  Copyright (c) 2015 Pei Pei. All rights reserved.
//

import UIKit

class type1Cell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
