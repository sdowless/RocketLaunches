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
        configureUI()
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
    
    func configureUI() {
        navigationItem.title = "Launches"
    }
}

// MARK: - UITableViewDataSource

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

// MARK: - UITableViewDelegate

extension LaunchListController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let launch = launches[indexPath.row]
        performSegue(withIdentifier: "ShowLaunchDetails", sender: launch)
    }
}

// MARK: - Navigation

extension LaunchListController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ShowLaunchDetails" else { return }
        guard let controller = segue.destination as? LaunchDetailController else { return }
        controller.launch = sender as? Launch
    }
}
