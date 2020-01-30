//
//  Service.swift
//  RocketLaunches
//
//  Created by Stephen Dowless on 1/30/20.
//  Copyright © 2020 Stephan Dowless. All rights reserved.
//

import Foundation

enum APIError: Error, CustomStringConvertible {
    case requestFailed
    case jsonParsingFailure
    case invalidData
    case responseUnsuccessful
    
    var description: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        }
    }
}

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
            
            DispatchQueue.main.async {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .secondsSince1970
                    let launches = try decoder.decode(Launches.self, from: data)
                    completion(.success(launches.launches))
                } catch {
                    completion(.failure(error))
                }
            }            
        }.resume()
    }
}
