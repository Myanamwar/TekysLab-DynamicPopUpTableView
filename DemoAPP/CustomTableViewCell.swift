//
//  CustomTableViewCell.swift
//  DemoAPP
//
//  Created by apple on 05/01/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
     // MARK:- Outlets
    @IBOutlet var customBaseView: UIView!
    @IBOutlet var titleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        customBaseView.layer.borderWidth = 1
        customBaseView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
