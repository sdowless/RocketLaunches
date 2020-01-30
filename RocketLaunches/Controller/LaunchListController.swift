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
    
    // MARK: - Selectors
    
    @objc func handleRefresh() {
        fetchLaunchData()
    }
    
    // MARK: - API
    
    func fetchLaunchData() {        
        Service.shared.fetchLaunches { result in
            switch result {
            case .success(let launches):
                self.launches = launches
                launches.forEach({ print("DEBUG: Image url is \($0.rocket.imageURL)") })
                self.refreshControl?.endRefreshing()
            case .failure(let error):
                self.presentAlertController(withTitle: "Error", message: error.localizedDescription)
                self.refreshControl?.endRefreshing()
            }
        }
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        navigationItem.title = "Launches"
        
        tableView.rowHeight = 80
        tableView.refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
    }
}

// MARK: - UITableViewDataSource

extension LaunchListController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launches.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! LaunchListCell
        cell.configureCell(withLaunch: launches[indexPath.row])
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
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "ShowLaunchDetails" else { return }
        guard let controller = segue.destination as? LaunchDetailController else { return }
        controller.launch = sender as? Launch
    }
}
