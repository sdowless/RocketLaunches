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
    let missions: [Mission]
}

struct Mission: Decodable {
    let id: Int
    let name: String
    let description: String
}

struct Launches: Decodable {
    let launches: [Launch]
}
