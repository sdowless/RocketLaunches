//
//  LaunchListController.swift
//  RocketLaunches
//
//  Created by Stephen Dowless on 1/30/20.
//  Copyright © 2020 Stephan Dowless. All rights reserved.
//

import UIKit

private let reuseIdentifier = "LaunchListCell"

class LaunchListController: UITableViewController {
    
    // MARK: - Properties
    
    private var launches = [Launch]() {
        didSet { tableView.reloadData() }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchLaunchData()
    }
    
    // MARK: - API
    
    func fetchLaunchData() {
        Service.shared.fetchLaunches { result in
            switch result {
            case .success(let launches):
                self.launches = launches
            case .failure(let error):
                self.presentAlertController(withTitle: "Error", message: error.localizedDescription)
            }
        }
    }
    
    // MARK: - Helpers
}

extension LaunchListController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launches.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! LaunchListCell
        cell.textLabel?.text = launches[indexPath.row].name
        return cell
    }
}
