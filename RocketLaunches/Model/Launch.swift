//
//  Launch.swift
//  RocketLaunches
//
//  Created by Stephen Dowless on 1/30/20.
//  Copyright © 2020 Stephan Dowless. All rights reserved.
//

import Foundation

struct Launch: Decodable {
    let id: Int
    let name: String
}

struct Luanches: Decodable {
    let launches: [Launch]
}
