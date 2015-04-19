//
//  CastTableViewCell.swift
//  tomatoes
//
//  Created by Gabe Kangas on 4/19/15.
//  Copyright (c) 2015 Gabe Kangas. All rights reserved.
//

import UIKit

class CastTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var characterLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
        visualEffectView.frame = bounds
        contentView.insertSubview(visualEffectView, belowSubview: nameLabel)

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
