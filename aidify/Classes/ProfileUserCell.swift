//
//  ProfileUserCell.swift
//  aidify
//
//  Created by salazar on 2/4/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import UIKit

class ProfileUserCell: UITableViewCell {
    
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileTitleLabel: UILabel!
    @IBOutlet weak var profileSubtitleLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.profileImage.layer.cornerRadius = 5.0
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
