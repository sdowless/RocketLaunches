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
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - API
    
    func fetchLaunchData() {
        
    }
    
    // MARK: - Helpers
}

extension LaunchListController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! LaunchListCell
        return cell
    }
}
