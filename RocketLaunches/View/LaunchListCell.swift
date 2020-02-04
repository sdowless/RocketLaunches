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
    @IBOutlet weak var missionCountLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    
    private let formatter = SharedDateFormatter.shared().shortDateFormatter
    
    // MARK: - Helpers
    
    func configureCell(withLaunch launch: Launch) {
        rocketImageView.layer.cornerRadius = rocketImageView.frame.height / 2
                
        rocketImageView.loadImage(withUrl: launch.rocket.imageURL)
        missionCountLabel.text = "Missions: \(launch.missions.count)"
        startDateLabel.text = "Launch Window: \(formatter.string(from: launch.isostart))"
        startDateLabel.text! += " - \(formatter.string(from: launch.isoend))"
        nameLabel.text = launch.name
    }
}
