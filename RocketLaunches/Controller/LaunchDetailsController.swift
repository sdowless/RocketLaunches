//
//  LaunchDetailsController.swift
//  RocketLaunches
//
//  Created by Stephen Dowless on 2/3/20.
//  Copyright © 2020 Stephan Dowless. All rights reserved.
//

import UIKit

private let reuseIdentifier = "LaunchDetailsCell"
private let headerIdentifier = "LaunchDetailsHeader"

class LaunchDetailsController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var rocketImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var launch: Launch?
    
    private var launchDetails = [LaunchDetails]() {
        didSet { tableView.reloadData() }
    }
        
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        loadLaunchData()
    }
    
    // MARK: - Helpers
    
    func configureTableView() {
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        
        rocketImageView.layer.cornerRadius = rocketImageView.frame.height / 2
    }
    
    func loadLaunchData() {
        guard let launch = launch else { return }
        rocketImageView.loadImage(withUrl: launch.rocket.imageURL)
        
        if let mission = launch.missions.first {
            let missionDetails = LaunchDetails(imageName: "doc.text",
                                               title: "Mission",
                                               primaryInfo: mission.name,
                                               secondaryInfo: mission.description)
            
            launchDetails.append(missionDetails)
        }
        
        let rocketDetails = LaunchDetails(imageName: "paperplane",
                                          title: "Rocket",
                                          primaryInfo: launch.rocket.name,
                                          secondaryInfo: launch.rocket.familyname)
        
        
        let locationDetails = LaunchDetails(imageName: "mappin.and.ellipse",
                                            title: "Location",
                                            primaryInfo: launch.location.name,
                                            secondaryInfo: launch.location.pads.first?.name ?? "")
        
        launchDetails.append(rocketDetails)
        launchDetails.append(locationDetails)
    }
}

// MARK: - UITableViewDelegate/DataSource

extension LaunchDetailsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launchDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! LaunchDetailsCell
        cell.configure(withDetails: launchDetails[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: headerIdentifier) as? LaunchDetailsHeader
        guard let launch = launch else { return nil }
        header?.configure(withLaunch: launch)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 88
    }
}
