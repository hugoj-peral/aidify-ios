//
//  ProfilePunctuationCell.swift
//  aidify
//
//  Created by salazar on 2/4/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import UIKit

class ProfilePunctuationCell: UITableViewCell {

    @IBOutlet weak var profileColorView: UIView!
    @IBOutlet weak var profileTitleLabel: UILabel!
    @IBOutlet weak var profileSubtitleLabel: UILabel!
    @IBOutlet weak var profileDisclosureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.profileColorView.layer.cornerRadius = self.profileColorView.frame.size.width / 2.0
        self.profileColorView.layer.borderColor = UIColor.whiteColor().CGColor
        self.profileColorView.layer.borderWidth = 4.0
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
