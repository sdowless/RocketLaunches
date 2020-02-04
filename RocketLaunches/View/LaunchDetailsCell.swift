//
//  LaunchDetailsCell.swift
//  RocketLaunches
//
//  Created by Stephen Dowless on 2/3/20.
//  Copyright © 2020 Stephan Dowless. All rights reserved.
//

import UIKit

class LaunchDetailsCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    func configure(withDetails details: LaunchDetails) {
        iconImageView.image = UIImage(systemName: details.imageName)
        detailTitleLabel.text = details.title
        titleLabel.text = details.primaryInfo
        subtitleLabel.text = details.secondaryInfo
    }
    
}
