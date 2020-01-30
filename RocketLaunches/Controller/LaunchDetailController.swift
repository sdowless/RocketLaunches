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
    
    var launch: Launch?
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        navigationItem.title = "Launch Details"
    }
}
