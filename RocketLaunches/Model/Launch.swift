//
//  Launch.swift
//  RocketLaunches
//
//  Created by Stephen Dowless on 1/30/20.
//  Copyright © 2020 Stephan Dowless. All rights reserved.
//

import Foundation

struct LaunchDetails {
    let imageName: String
    let title: String
    let primaryInfo: String
    let secondaryInfo: String
}

struct Launch: Decodable {
    let id: Int
    let name: String
    let missions: [Mission]
    let wsstamp: Date
    let westamp: Date
    let rocket: Rocket
    let location: Location
}

struct Location: Decodable {
    let name: String
    let pads: [Pads]
}

struct Pads: Decodable {
    let name: String
}

struct Rocket: Decodable {
    let name: String
    let imageURL: String
    let familyname: String
}

struct Mission: Decodable {
    let name: String
    let description: String
}

struct Launches: Decodable {
    let launches: [Launch]
}
