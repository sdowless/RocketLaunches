//
//  LaunchDetailController.swift
//  RocketLaunches
//
//  Created by Stephen Dowless on 1/30/20.
//  Copyright © 2020 Stephan Dowless. All rights reserved.
//

import UIKit

class LaunchDetailController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var rocketImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var missionNameLabel: UILabel!
    @IBOutlet weak var missionDetailLabel: UILabel!
    @IBOutlet weak var rocketNameLabel: UILabel!
    @IBOutlet weak var rocketDetailLabel: UILabel!
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var locationDetailLabel: UILabel!
    
    var launch: Launch?
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        loadLaunchData()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .systemGroupedBackground
        rocketImageView.layer.cornerRadius = rocketImageView.frame.height / 2
    }
    
    func loadLaunchData() {
        guard let launch = launch else { return }
        guard let mission = launch.missions.first else { return }
        
        rocketImageView.loadImage(withUrl: launch.rocket.imageURL)
        nameLabel.text = launch.name
        missionNameLabel.text = mission.name
        missionDetailLabel.text = mission.description
        rocketNameLabel.text = launch.rocket.name
        locationNameLabel.text = launch.location.name
        locationDetailLabel.text = launch.location.pads.first?.name
    }
}
