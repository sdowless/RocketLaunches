//
//  LaunchDetailsHeader.swift
//  RocketLaunches
//
//  Created by Stephen Dowless on 2/3/20.
//  Copyright © 2020 Stephan Dowless. All rights reserved.
//

import UIKit

class LaunchDetailsHeader: UITableViewCell {
    
    @IBOutlet weak var launchNameLabel: UILabel!
    @IBOutlet weak var launchDateLabel: UILabel!
    
    private let formatter = SharedDateFormatter.shared().shortDateFormatter
    
    func configure(withLaunch launch: Launch) {
        launchNameLabel.text = launch.name
        launchDateLabel.text = "Launch Time: \(formatter.string(from: launch.wsstamp))"
    }
    
}
