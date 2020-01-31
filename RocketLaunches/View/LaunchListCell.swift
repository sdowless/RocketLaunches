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
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    // MARK: - Helpers
    
    func configureCell(withLaunch launch: Launch) {
        rocketImageView.layer.cornerRadius = rocketImageView.frame.height / 2
        
        rocketImageView.loadImage(withUrl: launch.rocket.imageURL)
        missionCountLabel.text = "Missions: \(launch.missions.count)"
        startDateLabel.text = "Launch Window: \(dateFormatter.string(from: launch.wsstamp))"
        startDateLabel.text! += " - \(dateFormatter.string(from: launch.westamp))"
        nameLabel.text = launch.name
    }
}
