//
//  Service.swift
//  RocketLaunches
//
//  Created by Stephen Dowless on 1/30/20.
//  Copyright © 2020 Stephan Dowless. All rights reserved.
//

import Foundation

struct Service {
    static let shared = Service()
    
    private let launchCount = 20
    
    private var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "launchlibrary.net"
        components.path = "/1.4/launch/next/\(launchCount)"
        
        return components.url
    }
    
    
    func fetchLaunches(completion: @escaping(Result<[Launch], Error>) -> Void) {
        guard let url = url else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let launches = try JSONDecoder().decode(Launches.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(launches.launches))
                }
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
}
