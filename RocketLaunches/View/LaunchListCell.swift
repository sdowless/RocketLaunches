//
//  LaunchListCell.swift
//  RocketLaunches
//
//  Created by Stephen Dowless on 1/30/20.
//  Copyright © 2020 Stephan Dowless. All rights reserved.
//

import UIKit

class LaunchListCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var rocketImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func configureCell(withLaunch launch: Launch) {
        guard let imageUrl = launch.rocket.imageURL else { return }
        rocketImageView.loadImage(withUrl: imageUrl)
        nameLabel.text = launch.name
    }
    
}
