//
//  PainItemTableViewCell.swift
//  FollowUpDoc
//
//  Created by Thiago Heitling on 2016-04-24.
//  Copyright © 2016 Thiago Heitling. All rights reserved.
//

import UIKit

class PainItemTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var intensityLabel: UILabel!
    @IBOutlet weak var painImageView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
