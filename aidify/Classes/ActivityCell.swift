//
//  ActivityCell.swift
//  aidify
//
//  Created by salazar on 3/4/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import UIKit

class ActivityCell: UITableViewCell {
    
    @IBOutlet weak var activityDateLabel: UILabel!
    @IBOutlet weak var activityImage: UIImageView!
    @IBOutlet weak var activityTitleLabel: UILabel!
    @IBOutlet weak var activitySubtitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
