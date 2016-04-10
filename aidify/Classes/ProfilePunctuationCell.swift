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
    @IBOutlet weak var profileDescriptionLabel: UILabel!
    @IBOutlet var profileDescriptionViewConstraint: NSLayoutConstraint!
    @IBOutlet var profileDescriptionBottomConstraint: NSLayoutConstraint!
    @IBOutlet var profileDescriptionTopConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.profileColorView.layer.cornerRadius = self.profileColorView.frame.size.width / 2.0
        self.profileColorView.layer.borderColor = UIColor.whiteColor().CGColor
        self.profileColorView.layer.borderWidth = 4.0
        self.profileDescriptionViewConstraint.constant = 0
        expandCell(false)
    }
    
    func expandCell(expand: Bool) {
        profileDisclosureLabel.text = expand ? "-" : "+"
        profileDescriptionViewConstraint.active = !expand
        profileDescriptionBottomConstraint.active = expand
        profileDescriptionTopConstraint.active = expand
        profileDescriptionTopConstraint.constant = expand ? 4 : 0
        profileDescriptionBottomConstraint.constant = expand ? 4 : 0
        layoutIfNeeded()
    }
}
